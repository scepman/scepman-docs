# General

## How can I programmatically query the Storage Account Table?

For some use cases, it might be necessary to query the storage account table directly. This can be done manually using the [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) or programmatically using the [Azure Storage Rest API](https://docs.microsoft.com/en-us/rest/api/storageservices/query-entities). Assign the `Storage Table Data Reader` role to the account you are using. Here is an example of a query that returns all certificates in the Storage Account expiring in the next 30 days:

```powershell
$SCEPManStorageAccountName = "stgscepmanabc"  # Insert your SCEPman Storage Account name here
$expiresBefore = (Get-Date).AddDays(30).ToString("yyyy-MM-ddTHH:mm:ssZ")  # Find all certificates that expire before this date
$now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")                        # and                   that expire after this date

$certificatesJson = az storage entity query --table-name Certificates --account-name $SCEPManStorageAccountName --auth-mode login --filter "ExpirationDate lt datetime'$expiresBefore' and ExpirationDate gt datetime'$now' and Revoked eq false"
$certificates = $certificatesJson | ConvertFrom-Json

$certificates.items | Select-Object -Property Subject,Requester,ExpirationDate,FQDNs
```

The Azure CLI must be installed on the machine where the query is run, and it must be logged on to the right account and subscription. This is automatically the case for an Azure Cloud Shell.

If you are using a [Private Endpoint ](../../architecture/private-endpoints.md)for the Storage Account, you need to add your client's IP address to the exception list in the Networking pane of the Storage Account.

## How to restrict public access to the SCEPman homepage?

The SCEPman homepage does not include any sensitive information, and attackers cannot leverage the available data for malicious purposes.&#x20;

However, If you prefer to hide the homepage from public access, you can do it using the setting [AppConfig setting: AnonymousHomePageAccess](../../scepman-configuration/optional/application-settings/basics.md#appconfig-anonymoushomepageaccess)

Please ensure to restart the SCEPman _App Service_ after adding the setting.

## How to change SCEPman RootCA Subject?

{% hint style="warning" %}
By changing the CA Subject, you must issue a new Root CA and deploy it to all users, AND deploy all client/device certificates again. The old certificates are then no longer valid.
{% endhint %}

If you do not have a problem with that please follow the steps below to change the CA subject

* Navigate to your SCEPman App Service configuration
* Change the CN value of the setting [`AppConfig:KeyVaultConfig:RootCertificateConfig:Subject`](../../scepman-configuration/optional/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-subject) to the new subject name you want
* It is also recommended to change the value of the setting [`AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName`](../../scepman-configuration/optional/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-certificatename) to the new subject name, however, this is only visible in Azure KeyVault and not on the certificate itself.

{% hint style="info" %}
The name does not appear in the certificate itself and is only a reference to the CA certificate within Azure Key Vault. As it is part of the URL, there are name restrictions, like limitations to alphanumeric characters, numbers, and dashes. **Spaces are not allowed**
{% endhint %}

* After changing both values, save and restart the App Service
* Navigate to your SCEPman homepage and issue a new RootCA as described [here](../../scepman-configuration/first-run-root-cert.md)
* Download the new RootCA and upload it to your Profile, then re-deploy the client certificates again to get the new subject

## How to view SCEP certificates in Intune?

In order to view SCEPman issued certificates in Intune, navigate to certificates in Intune Monitor module:

**Intune -> Devices -> Monitor -> Certificates**

![](<../../.gitbook/assets/2022-07-26 11_38_54-Window.png>)

There you will find a list of all issued certificates with details like device name, user name, thumbprint, serial number, subject name, issuance date, expiry date, and certificate status.

For a more comprehensive view of the certificates along with additional actions, review the certificates in [Certificate Master.](../../certificate-deployment/certificate-master/)



## What's the expiry of the SCEPman Root CA? Can it be extended/renewed?

The SCEPman Root CA has an expiry of 10 years. Once expired, SCEPman will have to be re-deployed, however this is not necessarily a bad thing as it has the advantage that the new root will live up to the security standards (key size, algorithms) that are relevant at that time in the future.
