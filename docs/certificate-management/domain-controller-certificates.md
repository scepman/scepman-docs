# Domain Controller Certificates

{% hint style="info" %}
This feature requires version **1.6** or above.
{% endhint %}

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

You can use SCEPman to issue Kerberos authentication certificates to your domain controllers. This allows your AAD or hybrid-joined devices to authenticate seamlessly when accessing on-premises resources. This can be used to implement the **Hybrid Key trust for Windows Hello for Business**. The SCEPman will replace the requirement of a **Public key infrastructure**. Details can be found [here](https://docs.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-hybrid-key-trust-prereqs)

## Root CA without Enhanced Key Usage (EKU) Extension

**This feature has new requirements to the Root CA.**\
If you are updating from an earlier version as **1.6** you must generate a **new** Root CA.\
To support Kerberos authentication certificates the CA certificate must contain either no Enchanced Key Usage (EKU) extension or it must include Kerberos Authentication and Smart Card Logon.

If you are starting with SCEPman **1.6** and generating the Root CA with our SCEPman, you can skip the following steps.\
Otherwise please follow this guide to generate a new Root CA.

{% hint style="warning" %}
If you generate a new CA certificate you must update your Intune policies and deploy the new Root CA and new User and Device certificates!
{% endhint %}

1. Navigate to your **Key Vault**
2. Check if your User Account is added to the **Access policies** with all certificate permissions
3. Go to **Certificates**, select your CA certificate and click on **Delete**
4. After you have successful deleted the CA certificate you must click on **Manage deleted certificates**
5. Select your CA certificate, that you have deleted in Step 3 and click on **Purge** (Keep in mind that after you have purged the certificate you cannot restore it!)
6. Now restart your SCEPman App Services
7. Once your App Services are restarted open the SCEPman Dashboard by navigating to your SCEPman URL
8. You can see the section **Config issues**, please follow the steps in this section.
9. After you have generated the new CA certificate you can check the CA suitability in the SCEPman Dashboard.

CA Suitability on SCEPman Dashboard:

![](<../.gitbook/assets/2022-05-27 11_09_46-Window.png>)

## Configuration Changes to the SCEPman Service

To enable the feature, you must add two application settings in your SCEPman service. In the current implementation we use a pre-shared key (password) for DC requests.\
**Please generate a new key/password and store it somewhere safe.** (you will need it in the following steps and later, on the domain Controllers)

1. Navigate to **App Services**
2. Then choose your SCEPman app
3. Next under **Settings** click **Environment variables**
4. Select Add
5. Type **AppConfig:DCValidation:Enabled** as Name
6. Type **true** as Value
7. Confirm with **OK**
8. Select **Add** again
9. Type **AppConfig:DCValidation:RequestPassword** as Name
10. Type your **key/password**, that you have generated earlier, as Value
11. Confirm with **OK**
12. Save the application settings

## Trust the CA certificate in the Domain for Kerberos Authentication

Certificates used for Kerberos authentication need to be trusted within the AD domain as authentication CA certificates. Please download the CA certificate from the SCEPman Dashboard. If you stored the file as `scepman-root.cer`, you can publish the SCEPman CA certificate (be it a Root CA or an Intermediate CA) with the following command with an account that has Enterprise Administrator rights:

```
certutil -f -dsPublish scepman-root.cer NTAuthCA
```

Analogously, execute the following command to push the Root CA certificate (i.e. the SCEPman CA certificate or in case SCEPman is an Intermediate CA, the Root CA for the SCEPman CA certificate chain) to the Trusted Root certificate store for all machines in the AD Forest:

```
certutil -f -dsPublish scepman-root.cer RootCA
```

Afterwards, the CA certificate is generally trusted in AD and especially trusted for Kerberos Authentication. However, it takes some time (in default configuration up to 8 hours) until all devices receive this configuration. You may speedup this process on any machine by executing `gpupdate /force`, e.g. on the domain controllers.

This ensures that the DC certificates are trusted within the domain. They are also trusted on all Intune-managed devices in the scope of a Trusted Certificate profile distributing the Root CA certificate. It can be necessary to distribute the Root CA manually to other services like appliances or cloud services to make the DC certificates trusted for all systems.

## Installation on the Client

Then you must download our Open Source SCEP client software [SCEPClient](https://github.com/scepman/scepclient/releases). Releases with the suffix _-framework_ use .NET Framework 4.6.2, which is pre-installed on Windows Server 2016 and compatible with newer versions. Other releases require the .NET Core Runtime to be installed on the target systems.

Execute the following command in an elevated command prompt on a domain controller to receive a Domain Controller certificate from SCEPman:

```
ScepClient.exe newdccert https://your-scepman-domain/dc RequestPassword
```

You must add the SCEPman URL in the previous command but keep the path `/dc`. Replace `RequestPassword` with the secure key/password you generated earlier.

The request password is encrypted with SCEPman's CA certificate, so only SCEPman can read it. Domain Controller certificates are only issued with the correct request password.

### Automated Certificate Renewal

{% hint style="warning" %}
The above command requests a new DC certificate whether or not there already is a valid certificate. See the following Section to learn how to renew certificates only if the existing certificate is about to expire.
{% endhint %}

For a fully automated renewal of certificates, you should distribute ScepClient to **all** your domain controllers, together with the PowerShell script [enroll-dc-certificate.ps1](https://github.com/scepman/scepclient/blob/Core31/enroll-dc-certificate.ps1). Add a Scheduled task that executes the following command in a SYSTEM context (adapt the URL and request password):

```
powershell -ExecutionPolicy RemoteSigned -File c:\scepman\enroll-dc-certificate.ps1 -SCEPURL https://your-scepman-domain/dc -SCEPChallenge RequestPassword -LogToFile
```

Please make sure that the PowerShell script resides in the same directory as SCEPClient.exe and its additional dependencies.

![Configuring the execution action in the Scheduled Task](<../.gitbook/assets/image (17).png>)

This checks for existing DC certificates in the machine store. Only if there are no suitable certificates with at least 30 days validity, it uses ScepClient.exe to request a new DC certificate from SCEPman. If you want to modify the 30-day-threshold, use the -ValidityThresholdDays parameter of the PowerShell script.

The script writes a continuous log file to the directory where it is stored. If you do not want this log file, leave out the `-LogToFile` parameter. You can instead redirect the Information, Error, and/or Debug streams into files (e.g. `6>logfile.txt 2>&1`).

For WHfB, all DCs running version 2016 or newer need a Kerberos Authentication certificate. Older DCs forward authentication requests to newer DCs, thus they do not necessarily require a Kerberos Authentication certificate. It is a best practice, though, to supply them with certificates, too.

### Phase-out of an Existing Internal PKI

Please ensure that Internal PKIs do not enroll DC certificates (Certificate Templates "Domain Controller", "Domain Controller Authentication", and "Kerberos Authentication") in parallel with SCEPman. Otherwise, the DCs might use the DC certificate from the Internal PKI, which is considered untrusted if e.g. the CDP is unreachable. The SCEPman DC certificate can be used for all purposes for which the certificates of the above-mentioned templates can be used for, e.g. Kerberos authentication and LDAPS.

The easiest way to accomplish this, is to stop the internal CAs issuing certificates for the templates "Domain Controller", "Domain Controller Authentication", and "Kerberos Authentication". In the Certification Authority MMC Snap-In, delete these templates from the list of issued templates of each Internal CA. Then, delete already issued certificates from the Internal CA from your Domain Controllers' "MY" Stores (`certlm.msc` and navigate to Personal). Even after a `gpupdate /force`, no new DC certificate from the Internal PKI should appear in the DC's Personal store.
