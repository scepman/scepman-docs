# Change CA Subject

{% hint style="warning" %}
By changing the CA Subject, you must issue a new Root CA and deploy it to all users, AND deploy all client/device certificates again. The old certificates are then no longer valid.
{% endhint %}

If you do not have a problem with that please follow the steps below to change the CA subject

* Navigate to your SCEPman App Service configuration
* Change the CN value of the setting [`AppConfig:KeyVaultConfig:RootCertificateConfig:Subject`](../../advanced-configuration/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-subject) to the new subject name you want
* It is also recommended to change the value of the setting [`AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName`](../../advanced-configuration/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-certificatename) to the new subject name, however, this is only visible in Azure KeyVault and not on the certificate itself.

{% hint style="info" %}
The name does not appear in the certificate itself and is only a reference to the CA certificate within Azure Key Vault. As it is part of the URL, there are name restrictions, like limitations to alphanumeric characters, numbers, and dashes. **Spaces are not allowed**
{% endhint %}

* After changing both values, save and restart the App Service
* Navigate to your SCEPman homepage and issue a new RootCA as described [here](../../scepman-deployment/first-run-root-cert.md)
* Download the new RootCA and upload it to your Profile, then re-deploy the client certificates again to get the new subject
