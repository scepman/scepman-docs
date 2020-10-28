# Domain Controller Certificates

You can use SCEPman to issue Kerberos authentication certificates to your domain controllers. This allows your AAD or hybrid-joined devices to authenticate seamlessly when accessing on-premises resources.

{% hint style="warning" %}
Work in progress...!
{% endhint %}

{% hint style="info" %}
This feature requires version 1.6 or above \(currently beta\).

Furthermore, your CA certificate must contain either no Enhanced Key Usage \(EKU\) extension or it must include Kerberos Authentication and Smart Card Logon. This is automatically supported when generating the CA certificate with version 1.6 or above, but CA certificates generated with previous version do not support it. Version 1.6.415 and above tell you on the SCEPman homepage under CA Suitability whether DC certificates are supported.
{% endhint %}

## Configuration Changes to the SCEPman Service

To enable this setting you must add two application settings in your SCEPman service:

1. Navigate to **App Services**
2. Then choose your SCEPman app
3. Next under **Settings** click **Configuration**
4. Select **New application setting**
5. Type **AppConfig:DCValidation:Enabled** as Name
6. Type **true** as Value
7. Confirm with **OK**
8. Select **New application setting** again
9. Type **AppConfig:DCValidation:RequestPassword** as Name
10. Choose a secure password for the Value and store it somewhere safe \(you will need it later on the domain Controllers\)
11. Confirm with **OK**
12. Save the application settings

## Trust the CA certificate in the Domain for Kerberos Authentication

Certificates used for Kerberos authentication need to be trusted within the AD domain as authentication CA certificates. Please download the CA certificate from the SCEPman home page. If you stored the file as `scepman-root.cer`, you can publish the root CA certificate with the following command with an account that has Enterprise Administrator rights:

```text
certutil -f -dsPublish scepman-root.cer NTAuthCA
```

Analogously, execute the following command to push the SCEPman CA certificate to the Trusted Root certificate store for all machines in the AD Forest:

```text
certutil -f -dsPublish scepman-root.cer RootCA
```

Afterwards, the CA certificate is generally trusted in AD and especially trusted for Kerberos Authentication.

## Installation on the Client

Then you must download our SCEP client software SCEPClientCore (please ask the support for download while it is in Beta). It requires .NET Core 3.1 to be installed on the target systems.

Execute the following command in an elevated command prompt on a domain controller to receive a Domain Controller certificate from SCEPman:

```text
ScepClient.exe newdccert https://your-scepman-domain/dc RequestPassword
```

You must add the SCEPman URL in the previous command, but keep the path `/dc`. Replace `RequestPassword` with the secure password you chose in step 9.

Note that we recommend to use HTTPS with TLS encryption, but it is not required to keep the request password secret. The request password is encrypted with SCEPman's CA certificate, so only SCEPman can read it, whether or not you use HTTPS. Domain Controller certificates are only issued with the correct request password.

{% hint style="warning" %}
The above command requests a new DC certificate whether or not there already is a valid certificate. See the following Section to learn how to renew certificates only if the existing certificate is about to expire.
{% endhint %}

### CA certificate Renewal

For a fully automated renewal of certificates, you should distribute ScepClient to all of your domain controllers, together with the PowerShell script `enroll-dc-certificate.ps1`. Add a Scheduled task that executes the following command in a SYSTEM context:

```text
powershell c:\scepman\enroll-dc-certificate.ps1 -SCEPURL https://your-scepman-domain/dc -SCEPChallenge RequestPassword -ValidityThreshold (New-TimeSpan -Days 30)
```

This checks for existing DC certificates in the machine store. Only if there are no suitable certificates with at least 30 days validity, it uses ScepClient.exe to request a new DC certificate from SCEPman.