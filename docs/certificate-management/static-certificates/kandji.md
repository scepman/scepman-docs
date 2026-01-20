---
description: >-
  Issue certificates in Addigy by connecting SCEPman as an External CA. Devices
  will be able to obtain certificates using SCEPman's static interface and a
  challenge password enrolled.
---

# Addigy

SCEPman can be integrated with [Addigy](https://addigy.com/) as an External Certificate Authority (CA) using SCEPman's static interface. With a configured challenge password, enrolled devices will be able to request and obtain certificates.

For more general information about other MDM solutions and SCEPman integration, please check [here](./).

## Enable Addigy Integration

Integration of SCEPman can be easily enabled via the following environment variables on SCEPman App Service:

{% hint style="info" %}
You can differentiate between the SCEPman App Service and the Certificate Master by looking for the App Service **without** the "-cm" in its name
{% endhint %}

|                                                                                                   Setting                                                                                                  | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                        [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                       | Enable 3rd-party validation                                                                                                                                                                                                                                                                             | _**true**_ to enable, _**false**_ to disable |
|                [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)               | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|       [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)       | Days certificates issued via Addigy are valid                                                                                                                                                                                                                                                           |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |

{% hint style="warning" %}
After adding or editing SCEPman configuration parameters, you need to restart the App Service.
{% endhint %}

## Addigy Configuration

### SCEPman Root Certificate

As a first step, SCEPman root certificate must be deployed. To do so, download the RootCA certificate via the SCEPman website:

![SCEPman Website](<../../.gitbook/assets/image-2 (10).png>)

Now convert the .cer root certificate to PEM format in order to upload it to Addigy. You can use the following OpenSSL command for that:

```
openssl x509 -inform der -in scepman-root.cer -out SCEPman-Root-Certificate.pem
```

In Addigy, navigate to **Profiles** and create a new MDM profile, choose **Certificates - (PKCS12)** as Profile Type to upload SCEPman RootCA and upload the PEM format file.

<figure><img src="../../.gitbook/assets/image (5) (1).png" alt=""><figcaption></figcaption></figure>

### SCEP Profile

The second step is to create a new **SCEP Profile** for device certificate deployment as below:

* **Payload Name:** Choose a name for the profile, this will appear as a certificate profile on the client.
* **URL**: The static SCEP endpoint of SCEPman that you configured in a previous step, you can get it from SCEPman homepage, see below:

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

* **Challenge**: Is required to authenticate CSR requests sent to SCEPman's static SCEP interface. It must match the [value](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword) of the setting _AppConfig:StaticValidation:RequestPassword_ that you previously configured.
* Enable the **"Proxy SCEP Requests"** option
* Choose "Signing & Encryption" for **Key Usage**
* Fill out the rest as shown in the screenshots below

<figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (3) (1) (1).png" alt=""><figcaption></figcaption></figure>

After successfully creating both the Root CA and Device Certificate profiles, apply them to your policy to deploy the configuration to assigned devices.

For more information, please check [Addigy's documentation.](https://support.addigy.com/hc/en-us/articles/4403542430739-Deploying-Certificates)
