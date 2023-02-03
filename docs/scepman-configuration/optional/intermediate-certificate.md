# Intermediate Certificate

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

If you want to use another Root CA as primary authority, you can create an intermediate CA certificate. You can create the correct certificate direct in Azure Key Vault and download the CSR for signing with your Root CA. The signed request can be uploaded and merged into the Azure Key Vault.

## Key Vault Access Policy

You need to grant an Azure AD App and your user account access to the Azure Key Vault. Note that the Azure AD App is different to the Azure App Service! In a SCEPman installation without Intermediate CA, you usually do not have to grant permission to the Azure AD App, but here it is required!

1. Navigate to your Azure Key Vault in the Azure Portal
2. Click on **Access policies** in the left navigation pane.
3. Click on **Add Access Policy**

![](<../../../.gitbook/assets/screenshot-2020-10-19-at-15.23.16 (1).png>)

1. Click **Configure from template (optional)** and choose **Certificate Management**.
2. Now you must select a principal by clicking on **None selected** and search for your Azure AD App Registration.
3. To close the dialog press **Select** and then press **Add**.

![](<../../../.gitbook/assets/screenshot-2020-10-19-at-15.34.16 (1).png>)

Now repeat this for your own user account:

1. Click on **Add Access Policy** again.
2. Again, click **Configure from template (optional)** and choose **Certificate Management**.
3. Select a principal by clicking on **None selected**. But this time, search for your own administrative user account.
4. Close the dialog with **Select** and **Add**.

![](<../../../.gitbook/assets/screenshot-2020-10-19-at-15.35.28 (8).png>)

1. To save your new access policies you must click on **Save** in the upper left corner of the window.

After saving this access policies successfully, your Azure AD app is permitted to create a CSR and your user account is permitted to upload the certificate.

## Creating Intermediate CA Certificate via API

You must create the certificate via the Key Vault API. This is because not all flags and features are available via UI and native PowerShell CMDlets. Add values for the six parameters TenantID, ApplicationID, ApplicationKey, KeyVaultName, NewCertName, and CompanyName to the following PowerShell script. [Create a new Application Secret](../azure-app-registration.md#azure-app-registration-client-secret) to use as ApplicationKey in your Azure AD App registration with minimum lifetime.

```
###################################################################################
#                                                                                 #
# PowerShell Script to generate a CSR for a SCEPman Intermediate CA certificate   #
#                                                                                 #
###################################################################################

# Version: 2021-07-09
# Authors: Aaron Navratil and GKGAB contributors
# License: Unlicense (https://unlicense.org/)
# Source: https://docs.scepman.com/scepman-configuration/optional/intermediate-certificate

$config = @{
    TenantID = "" # <GUID> of your Azure AD Tenant
    ApplicationID = "" # <GUID> -> the Application (Client) ID of your Azure App Registration
    ApplicationKey = "" # Client secret from you Azure App Registration
    KeyVaultName = "" # Name of your Azure Key Vault ressource
    NewCertName =  "" # Name of your new Intermediate CA certificate. Use Letters, Numbers, and/or spaces.
    CompanyName = "" # Your Company Name. Use Letters, Numbers, and/or spaces.
}

$body = [ordered]@{
    grant_type = "client_credentials"
    client_id = $config.ApplicationID
    client_secret = $config.ApplicationKey
    scope = "https://vault.azure.net/.default"
}

$TokenResponse = Invoke-RestMethod https://login.microsoftonline.com/$($config.TenantID)/oauth2/v2.0/token -Method Post -Body $body -UseBasicParsing

$AuthHeader = @{Authorization = $TokenResponse.token_type + " " + $TokenResponse.access_token}

$CertBody = @"
{
  "policy": {
    "key_props": {
      "exportable": true,
      "kty": "RSA",
      "key_size": 2048,
      "reuse_key": false
    },
    "secret_props": {
      "contentType": "application/x-pkcs12"
    },
    "x509_props": {
      "subject": "O=$($config.CompanyName), OU=$($config.TenantID), CN=$($config.NewCertName)",
      "ekus": [
        "2.5.29.37.0",
        "1.3.6.1.5.5.7.3.2",
        "1.3.6.1.5.5.7.3.1",
        "1.3.6.1.5.5.7.3.9"
      ],
      "key_usage": [
        "cRLSign",
        "digitalSignature",
        "keyCertSign",
        "keyEncipherment"
      ],
      "validity_months": 120,
      "basic_constraints": {
          "ca": true
      }
    },
    "lifetime_actions": [
      {
        "trigger": {
          "lifetime_percentage": 80
        },
        "action": {
          "action_type": "EmailContacts"
        }
      }
    ],
    "issuer": {
      "name": "Unknown",
      "cert_transparency": false
    }
  }
}
"@

# https://docs.microsoft.com/en-us/rest/api/keyvault/create-certificate/create-certificate#uri-parameters
$CertReq = Invoke-RestMethod https://$($config.KeyVaultName).vault.azure.net/certificates/$($config.NewCertName -replace "[^A-Za-z0-9-]", "-")/create?api-version=7.2 -Method Post -Body $CertBody -ContentType "application/json" -Headers $AuthHeader -UseBasicParsing

$CSRText = @"
-----BEGIN CERTIFICATE REQUEST-----
$([regex]::Matches($CertReq.csr, "[^\s]{1,64}").value -join "`n")
-----END CERTIFICATE REQUEST-----
"@

$CSRText

Write-Host -ForegroundColor Cyan @"
After Signing the CSR use the values of:

$($config.NewCertName -replace '[^A-Za-z0-9]', "-") in AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName
and 
CN=$($config.NewCertName), OU=$($config.TenantID), O=$($config.CompanyName) in AppConfig:KeyVaultConfig:RootCertificateConfig:Subject
"@
```

## Issue the Intermediate CA Certificate

Now, submit your CSR to your Root CA and retrieve your issued Intermediate CA Certificate. Save the certificate on disk ((.cer)), so in the next step, you can upload and merge it with the private key in Azure Key Vault.

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
2. **\*\*Now you can see the options** Download CSR **and** Merge Signed Request\*\*

![](<../../../.gitbook/assets/screenshot-2020-10-19-at-16.01.18 (11).png>)

1. Click on **Merge Signed Request** and upload your Intermediate CA Certificate. After you have uploaded the signed request, you can see the valid certificate in your Azure Key Vault in the area **Completed**

## Update Azure App Service Settings

The last step is to update the Azure App Service which runs the SCEPman with the new certificate information.

1. Navigate to you Azure App Service
2. Click on **Configuration** in the left navigation pane
3. In **Application settings** you must edit the following settings:

AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName AppConfig:KeyVaultConfig:RootCertificateConfig:Subject

1. As value you must insert your new certificate name and the new subject name.
2. To complete this step, you must click on **Save** in the upper left part.

![](<../../../.gitbook/assets/screenshot-2020-10-19-at-16.06.40 (1).png>)

Please restart the Azure App Service and then navigate to your SCEPman URL. On the SCEPman Status page you can see the new configuration and download the new intermediate CA certificate to deploy this via Endpoint Manager.

Please check whether the CA certificate fulfills all requirement by visiting your SCEPman Homepage. Check what the homepage says next to "CA Suitability". If, for example, it says _CA Certificate is missing Key Usage "Key Encipherment"._, you should go back to step [Issue the Intermediate CA Certificate](intermediate-certificate.md#issue-the-intermediate-ca-certificate) and correct the certificate issuance.

## Intermediate CAs and Intune SCEP Profiles

On the Android platform, the SCEP Configuration Profiles in Intune must reference the Root CA, not the Intermediate CA. Otherwise, the configuration profile fails. For Windows, it is the other way around: The SCEP Configuration Profiles in Intune must reference the Intermediate CA, not the Root CA. For iOS and macOS, we have no conclusive information wheter one or the other way is better.
