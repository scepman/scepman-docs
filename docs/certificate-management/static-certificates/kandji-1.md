---
description: Issue certificates in Iru by connecting SCEPman as an External CA.
---

# Iru (formerly Kandji)

SCEPman can be connected to [Iru](https://www.iru.com/) as an External CA with a challenge password, enabling enrolled devices to obtain certificates.

For more general information about other MDM solutions and SCEPman integration, please check [here](./).

{% stepper %}
{% step %}
### Enable Iru integration

Integration of SCEPman can be easily enabled via the following environment variables on SCEPman App Service:

{% hint style="success" %}
If Iru Entra sync is enabled, use [staticaad-validation.md](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md "mention"). It binds certificates to Entra objects and supports automatic revocation when those objects are disabled or deleted.

Use Static validation only when Entra sync is unavailable. Configure your selected endpoint in [#choose-an-endpoint](./#choose-an-endpoint "mention").
{% endhint %}

{% hint style="info" %}
You can differentiate between the SCEPman App Service and the Certificate Master by looking for the App Service **without** the "-cm" in its name
{% endhint %}

<details>

<summary>Static-AAD validation</summary>

Use these settings when Iru Entra sync is enabled.

{% include "../../.gitbook/includes/static-aad-environment-variables.md" %}

</details>

<details>

<summary>Static validation</summary>

Use these settings when Iru Entra sync is unavailable.

Use the setting names for your App Service operating system.

{% tabs %}
{% tab title="Linux" %}
Linux App Services use double underscores (`__`) instead of colons.

|                                                                                                      Setting                                                                                                     | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                        [AppConfig\_\_StaticValidation\_\_Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                       | Enable 3rd-party validation                                                                                                                                                                                                                                                                             | _**true**_ to enable, _**false**_ to disable |
|                [AppConfig\_\_StaticValidation\_\_RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)               | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|       [AppConfig\_\_StaticValidation\_\_ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)       | Days certificates issued via Iru are valid                                                                                                                                                                                                                                                              |                      365                     |
| [AppConfig\_\_StaticValidation\_\_EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |
{% endtab %}

{% tab title="Windows" %}
Windows App Services use colons (`:`) in setting names.

|                                                                                                   Setting                                                                                                  | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                        [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                       | Enable 3rd-party validation                                                                                                                                                                                                                                                                             | _**true**_ to enable, _**false**_ to disable |
|                [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)               | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|       [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)       | Days certificates issued via Iru are valid                                                                                                                                                                                                                                                              |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |
{% endtab %}
{% endtabs %}

</details>

{% hint style="warning" %}
After adding or editing SCEPman configuration parameters, you need to restart the App Service.
{% endhint %}
{% endstep %}

{% step %}
### Deploy the SCEPman root certificate

As a first step, you must deploy SCEPman's root certificate. Download this CA certificate via the SCEPman website:

![SCEPman Website](../../.gitbook/assets/image-2.png)

In Iru, navigate to **Library** on the left navigation bar and add a **Certificate Library Item** to your Blueprint.

<figure><img src="../../.gitbook/assets/2023-03-09 12_51_21-Window.png" alt=""><figcaption><p>Configure a Certificate Payload</p></figcaption></figure>

To upload the certificate, first select **PKCS #1-formatted certificate** under **Certificate type**, secondly provide an optional name, upload your SCEPman CA certificate, and eventually save it.

<figure><img src="../../.gitbook/assets/2023-03-09 14_21_12-KandjiSCEPmanRootCA.png" alt=""><figcaption><p>Adding the SCEPman Root CA Certificate</p></figcaption></figure>
{% endstep %}

{% step %}
### Create the SCEP profile

The second step is to add a **SCEP Profile** to your **Blueprint**. Therefore, add a new **SCEP Library Item** and configure it as below:

* **URL**: Use the SCEP endpoint that matches your selected validation method. Use `/static/aad` for Static-AAD validation, or `/static` for Static validation.
* **Name:** An optional SAN attribute
* **Challenge**: Is required to authenticate CSR requests. It must match the request password configured for [#appconfig-staticaadvalidation-requestpassword](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-requestpassword "mention") or [#appconfig-staticvalidation-requestpassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword "mention").
* **Fingerprint:** Optional CA fingerprint. It is highly recommended to configure this value as it provides an additional level of security. You can find it on your SCEPman website as **CA Thumbprint**.
* **Subject:** Optional subject name. **CN=$PROFILE\_UUID** will be automatically added from Iru as default common name. Iru allows you to add multiple CNs.

{% hint style="info" %}
Static-AAD validation requires the certificate subject to include an Entra device ID, or its SAN to include a user's UPN.
{% endhint %}

{% hint style="warning" %}
Occasionally macOS and iOS had problems auto-selecting client certificates for network authentication purposes when more than two CNs are added.
{% endhint %}

* **Key Size:** 2048
* **Key Usage:** Both, signing and encryption

For more information, please check [Iru's documentation](https://support.kandji.io/support/solutions/articles/72000559782-scep-profile).

<figure><img src="../../.gitbook/assets/2023-03-09 14_43_19-Kandji.png" alt=""><figcaption><p>Adding a SCEP Profile</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/2023-03-09 14_50_23-Kandji.png" alt=""><figcaption><p>SCEP Profile Configuration</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/2023-03-09 14_51_22-Kandji.png" alt=""><figcaption><p>SCEP Profile Configuration</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/2023-03-09 14_52_52-Kandji.png" alt=""><figcaption><p>SCEP Profile Configuration</p></figcaption></figure>
{% endstep %}

{% step %}
### Check deployment status

After saving the certificate or SCEP profile, switch to **Status** to check the deployment status on **Blueprints** assigned devices.

<figure><img src="../../.gitbook/assets/2023-03-09 15_12_40-Kandji.png" alt=""><figcaption><p>Deployment Status</p></figcaption></figure>
{% endstep %}
{% endstepper %}
