# Intermediate CA

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

If you want to use another Root CA as a primary authority, you can create an intermediate CA certificate to operate SCEPman as a Subordinate Certification Authority. You can create the correct certificate direct in Azure Key Vault and download the CSR for signing with your Root CA. The signed request can be uploaded and merged into Azure Key Vault. This article guides you through the necessary steps in detail.



## Key Vault Permissions

You need to grant access to the Azure Key Vault to your user account to create the CSR and merge the Intermediate CA certificate. The way of assigning the permissions depends on the access configuration of your Key Vault:

{% tabs %}
{% tab title="Azure RBAC" %}
1. Navigate to your Azure Key Vault in the Azure Portal
2. Click on **Access control (IAM)** in the left navigation pane.
3. Click on **Role assignments** and add a new role assignment

<figure><img src="../.gitbook/assets/image (34).png" alt=""><figcaption><p>Add a new role assignment to your Key Vault</p></figcaption></figure>

4. Select the **Key Vault Certificate Officer** role and click **Next**

<figure><img src="../.gitbook/assets/image (35).png" alt=""><figcaption></figcaption></figure>

5. Now search and add your AAD admin account in the **Members** section and continue to assign the role

After adding the role assignment, your Azure AD account is permitted to create a CSR and upload the certificate.
{% endtab %}

{% tab title="Vault Access Policies" %}
1. Navigate to your Azure Key Vault in the Azure Portal
2. Click on **Access policies** in the left navigation pane.
3. Click on **Create** and choose the **Certificate Management** template, then next

<figure><img src="../.gitbook/assets/2023-06-14 16_20_43-IntermediateCert.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/2023-06-14 16_23_37-IntermediateCert.png" alt=""><figcaption></figcaption></figure>

4. Now search and add your AAD admin account in the **Principal** section, then next, next, and create

<figure><img src="../.gitbook/assets/2023-06-14 17_06_33-.png" alt=""><figcaption></figcaption></figure>

After adding the permissions, your Azure AD account is permitted to create a CSR and upload the certificate.
{% endtab %}
{% endtabs %}



## Open Key Vault Networking to the Admin System

If you are using a [Private Endpoint](../architecture/private-endpoints.md) for Key Vault, you need to add an exception that allows the client to access the Key Vault on a network level. If you are not using a Private Endpoint, you can skip this part.

* Go to Azure Key Vault in the Azure Portal.
* Navigate to the Networking blade under Settings.
* Switch to "Allow public access from specific virtual networks and IP addresses" if you have currently selected "Disable public access".
* Add the IP address of the client on which you want to [run the SCEPman PowerShell module later on](intermediate-certificate.md#creating-intermediate-ca-certificate-with-the-scepman-powershell-module). If you are using the Azure Cloud Shell and [it is connected to a VNET](https://learn.microsoft.com/en-us/azure/cloud-shell/vnet/overview), you can add this VNET. Otherwise, the easiest way is to temporarily allow the Cloud Shell's Public IP address, since strong authentication protects your Key Vault. You might use a command like `(Invoke-WebRequest -UseBasicParsing -uri "http://ifconfig.me/ip").Content` to find the session's public IP address.

## Update Azure App Service Settings

The next step is to update the Azure App Service configuration to match the subject name of the intermediate CA you will create in the next step.

1. Navigate to your Azure App Service
2. Click on **Environment variables** in the left navigation pane
3. In **Application settings,** you must edit the following settings:
   1. `AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName`\
      Change this to a preferred common name (CN) for your intermediate CA.
   2. `AppConfig:KeyVaultConfig:RootCertificateConfig:Subject`\
      Only change the CN value of the subject name to match the common name used above.
4. Click on **Apply and Confirm.**
5. Restart the Azure **App Service** to apply the changes then navigate to your SCEPman URL.

{% hint style="warning" %}
Please be aware that the CertificateName variable will directly correspond to the certificate object that will be created in the Azure Key Vault. You can therefore only use certificate names that contain alphanumeric characters and dashes&#x20;
{% endhint %}

<figure><img src="../.gitbook/assets/image (1) (1) (1) (2).png" alt=""><figcaption></figcaption></figure>

## Creating Intermediate CA Certificate with the SCEPman PowerShell Module

You can use the SCEPman PowerShell module version 1.9 and later to create a CSR for an Intermediate CA certificate. You can install the latest version of the module from PowerShell Gallery with the following command:

```powershell
Install-Module -Name SCEPman -Scope CurrentUser -Force
```

Then, you can tell the module the name of your organization to appear in the certificate:

```powershell
Reset-IntermediateCaPolicy -Organization "My Organization"
```

Configure the subject of your intermediate CA to match the one you have used above in `AppConfig:KeyVaultConfig:RootCertificateConfig:Subject` (optionally, you can modify some additional settings to control the CSR content):

{% code lineNumbers="true" %}
```
$policy = Get-IntermediateCaPolicy
$policy.policy.x509_props.subject = "CN=YOUR_CN_FROM_ABOVE,OU=YOUR_TENANT_ID,O=YOUR_ORGANIZATION"
# change some additional settings of $policy
Set-IntermediateCaPolicy -Policy $policy
```
{% endcode %}

Finally, you can create the CSR with the following command (or a similar one according to your environment):

```powershell
New-IntermediateCA -SCEPmanAppServiceName "app-scepman-example" -SearchAllSubscriptions 6>&1
```

The command will output the CSR that you submit to your Root CA for signing.

## Issue the Intermediate CA Certificate

Now, submit your CSR to your Root CA and retrieve your issued Intermediate CA Certificate. Save the certificate on disk (.cer), so in the next step, you can upload and merge it with the private key in Azure Key Vault.

### Special Steps for an ADCS Enterprise Root CA

If you are using Active Directory Certificate Services as an AD-integrated Root CA and hence must choose a Certificate Template, it must include the following Key Usages: "CRLSign", "DigitalSignature", "KeyEncipherment", and "KeyCertSign". KeyEncipherment is missing in the default template "Subordinate Certificate Authority", and furthermore cannot be selected on new templates. Please see below for a solution if you run into this problem. **This does not apply to Stand-alone Root CAs**, aka Offline Root CAs, as they take the Key Usages correctly from the CSR.

#### Outline

You can Duplicate the SubCA Template or use it as required. Then you just issue a certificate with the template based on the CSR. This certificate will have _the wrong Key Usage_ (0x86). Afterwards, you re-sign the certificate with an adapted Key Usage extension using `certutil -sign`.

#### Step by step

1. Request and issue a SubCA certificate.
2. Export the new SubCA certificate to a file (e.g. c:\temp\SubCA.cer) on the Root CA. Choose **Base-64 encoded X.509** format.
3. Create a file "extfile.txt" with the contents shown below to the Root CA (e.g. c:\temp\extfile.txt).
4. Start command line and execute: `certutil -sign "c:\temp\SubCA.cer" "c:\temp\SubCAwithKeyEncipher.cer" @c:\temp\extfile.txt`
5. The certificate SubCAwithKeyEncipher.cer now contains the requested key usage (0xA6). The thumbprint (signature) has changed, but the serial number hasn't.
6. The list of issued certificates in ADCS contains the old certificate. Since the serial number hasn't changed, you can manage the new certificate using the old handle, e.g. revoking the old certificate will revoke the new certificate. If you dislike this, you can delete the old certificate entry using `certutil -deleterow` and then import the new certificate using `certutil -importcert`.

#### extfile.txt

```
[Extensions]
2.5.29.15=AwIBpg==
Critical=2.5.29.15
```

## Upload the Intermediate CA Certificate

1. In Azure Key Vault, click on your certificate and press **Certificate Operation**
2. Now you can see the options **Download CSR** and **Merge Signed Request**

![](<../.gitbook/assets/screenshot-2020-10-19-at-16.01.18 (13).png>)

1. Click on **Merge Signed Request** and upload your Intermediate CA Certificate. After you have uploaded the signed request, you can see the valid certificate in your Azure Key Vault in the area **Completed**

{% hint style="warning" %}
The Intermediate CA Certificate must be in PEM format (Base64-encoded). If you use the binary DER format, you will see an error message that says "Property x5c has invalid value X5C must have at least one valid item" in the details.
{% endhint %}

## Verify CA Suitability

On the SCEPman Status page, you can see the new configuration and download the new intermediate CA certificate to deploy this via Endpoint Manager.

Please check whether the CA certificate fulfills all requirements by visiting your SCEPman Homepage. Check what the homepage says next to "CA Suitability". If, for example, it says _CA Certificate is missing Key Usage "Key Encipherment"_, you should go back to step [Issue the Intermediate CA Certificate](intermediate-certificate.md#issue-the-intermediate-ca-certificate) and correct the certificate issuance.

## Intermediate CAs and Intune SCEP Profiles

On the Android platform, the SCEP Configuration Profiles in Intune must reference the Root CA, not the Intermediate CA. Otherwise, the configuration profile fails. For Windows, it is the other way around: The SCEP Configuration Profiles in Intune must reference the Intermediate CA, not the Root CA. For iOS and macOS, we have no conclusive information whether one or the other way is better.
