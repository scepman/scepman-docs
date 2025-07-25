---
description: >-
  Issue certificates in Kandji by connecting SCEPman as an External CA. Devices
  will be able to obtain certificates using SCEPman's static interface and a
  challenge password enrolled.
---

# Kandji

SCEPman can be connected to [Kandji](https://www.kandji.io/) as an External CA via SCEPman's static interface, and a challenge password enrolled devices will be able to obtain certificates.

For more general information about other MDM solutions and SCEPman integration, please check [here](./).

## Enable Kandji Integration

Integration of SCEPman can be easily enabled via the following environment variables on SCEPman App Service:

{% hint style="info" %}
You can differentiate between the SCEPman App Service and the Certificate Master by looking for the App Service **without** the "-cm" in its name
{% endhint %}

|                                                                                                   Setting                                                                                                  | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                        [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                       | Enable 3rd-party validation                                                                                                                                                                                                                                                                             | _**true**_ to enable, _**false**_ to disable |
|                [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)               | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|       [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)       | Days certificates issued via Kandji are valid                                                                                                                                                                                                                                                           |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |

{% hint style="warning" %}
After adding or editing SCEPman configuration parameters, you need to restart the App Service.
{% endhint %}

## Kandji Configuration

### SCEPman Root Certificate

As a first step, you must deploy SCEPman's root certificate. Download this CA certificate via the SCEPman website:

![SCEPman Website](<../../.gitbook/assets/image-2 (10).png>)

In Kandji, navigate to **Library** on the left navigation bar and add a **Certificate Library Item** to your Blueprint.

<figure><img src="../../.gitbook/assets/2023-03-09 12_51_21-Window.png" alt=""><figcaption><p>Configure a Certificate Payload</p></figcaption></figure>

To upload the certificate, first select **PKCS #1-formatted certificate** under **Certificate type**, secondly provide an optional name, upload your SCEPman CA certificate, and eventually save it.

<figure><img src="../../.gitbook/assets/2023-03-09 14_21_12-KandjiSCEPmanRootCA.png" alt=""><figcaption><p>Adding the SCEPman Root CA Certificate</p></figcaption></figure>

### SCEP Profile

The second step is to add a **SCEP Profile** to your **Blueprint**. Therefore, add a new **SCEP Library Item** and configure it as below:

* **URL**: The static SCEP endpoint of SCEPman you configured [above](kandji-1.md#enable-kandji-integration)
* **Name:** An optional SAN attribute
* **Challenge**: Is required to authenticate CSR requests sent to SCEPman's static SCEP interface. It must match the [value](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword) you have configured [above](kandji-1.md#enable-kandji-integration).
* **Fingerprint:** Optional CA fingerprint. It is highly recommended to configure this value as it provides an additional level of security. You can find it on your SCEPman website as **CA Thumbprint**.
* **Subject:** Optional subject name. **CN=$PROFILE\_UUID** will be automatically added from Kandji as default common name. Kandji allows you to add multiple CNs.

{% hint style="warning" %}
We have seen cases where macOS and iOS had problems in auto-selecting client certificates for network authentication purposes where more than two CNs were added.
{% endhint %}

* **Key Size:** 2048
* **Key Usage:** Both, signing and encryption

For more information, please check [Kandji's documentation](https://support.kandji.io/support/solutions/articles/72000559782-scep-profile).

<figure><img src="../../.gitbook/assets/2023-03-09 14_43_19-Kandji.png" alt=""><figcaption><p>Adding a SCEP Profile</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/2023-03-09 14_50_23-Kandji.png" alt=""><figcaption><p>SCEP Profile Configuration</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/2023-03-09 14_51_22-Kandji.png" alt=""><figcaption><p>SCEP Profile Configuration</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/2023-03-09 14_52_52-Kandji.png" alt=""><figcaption><p>SCEP Profile Configuration</p></figcaption></figure>

### Deployment Status

After saving the certificate or SCEP profile, switch to **Status** to check the deployment status on **Blueprints** assigned devices.

<figure><img src="../../.gitbook/assets/2023-03-09 15_12_40-Kandji.png" alt=""><figcaption><p>Deployment Status</p></figcaption></figure>
