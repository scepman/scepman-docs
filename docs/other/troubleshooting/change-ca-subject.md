# Change CA Subject

{% hint style="warning" %}
By changing the CA Subject, you must issue a new Root CA and deploy it to all users, AND deploy all client/device certificates again. The old certificates are then no longer valid.
{% endhint %}

If you do not have a problem with that please follow the steps below to change the CA subject

* Navigate to your SCEPman App Service configuration
* Change the CN value of the setting `AppConfig:KeyVaultConfig:RootCertificateConfig:Subject` to the new subject name you want
* It is also recommended to change the value of the setting `AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName` to the new subject name, however, this is only visible in Azure KeyVault and not on the certificate itself.
* After changing both values, save and restart the App Service
* Navigate to your SCEPman homepage and issue a new RootCA as described [here](../../scepman-configuration/first-run-root-cert.md)
* Download the new RootCA and upload it to your Profile, then re-deploy the client certificates again to get the new subject
