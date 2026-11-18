---
description: Issue SCEPman certificates through supported third-party MDM solutions.
---

# Other MDM Solutions

Issue certificates through MDM systems other than Microsoft Intune and Jamf Pro. SCEPman uses a shared [SCEP challenge password](https://www.rfc-editor.org/rfc/rfc8894.html#name-challengepassword-shared-se) to authenticate certificate requests.

{% hint style="warning" %}
The challenge password protects every certificate request. Store it securely. Never expose it to end-user devices.
{% endhint %}

### Choose an endpoint

Choose the endpoint that matches your MDM integration.

| Endpoint       | Use when                                                                                                                                                               |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Static-AAD** | Your MDM integrates with Microsoft Entra ID. User certificates can use [automatic revocation](../manage-certificates/#automatic-revocation) when the user is disabled. |
| **Static**     | Your MDM does not require Entra ID integration. This endpoint supports most third-party MDM solutions.                                                                 |

### Configure SCEPman

Add the settings for your chosen endpoint in **SCEPman App Service** → **Environment Variables**. Save the settings, then **restart** the App Service.

{% tabs %}
{% tab title="Static-AAD" %}
|                                                                                                                   Setting                                                                                                                   | Description                                                                                                                                                                                                                              |                     Value                    |
| :-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                                    [AppConfig:StaticAADValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enabled)                                   | Enable Static-AAD validation                                                                                                                                                                                                             | _**true**_ to enable, _**false**_ to disable |
|                            [AppConfig:StaticAADValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-requestpassword)                           | <p>Authenticates certificate signing requests.<br><br><strong>Recommendation:</strong> Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure Key Vault</a>.</p> |      _generate a 32-character password_      |
|       <p><a href="../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-validityperioddays">AppConfig:StaticAADValidation:ValidityPeriodDays</a></p><p>(optional)</p>       | Certificate validity in days                                                                                                                                                                                                             |                      365                     |
| <p><a href="../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage">AppConfig:StaticAADValidation:EnableCertificateStorage</a></p><p>(optional)</p> | Store issued certificates for Certificate Master                                                                                                                                                                                         | _**true**_ to enable, _**false** to disable_ |
{% endtab %}

{% tab title="Static" %}
|                                                                                                   Setting                                                                                                  | Description                                                                                                                                                                                                                              |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                        [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                       | Enable Static validation                                                                                                                                                                                                                 | _**true**_ to enable, _**false**_ to disable |
|                [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)               | <p>Authenticates certificate signing requests.<br><br><strong>Recommendation:</strong> Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure Key Vault</a>.</p> |      _generate a 32-character password_      |
|       [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)       | Certificate validity in days                                                                                                                                                                                                             |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store issued certificates for Certificate Master                                                                                                                                                                                         | _**true**_ to enable, _**false** to disable_ |
{% endtab %}
{% endtabs %}

### Set up your MDM

Deploy the SCEPman root certificate first. Configure the selected SCEP endpoint and the same challenge password in your MDM.

<table data-view="cards"><thead><tr><th>MDM</th><th data-card-target data-type="content-ref">Guide</th></tr></thead><tbody><tr><td><i class="fa-apple">:apple:</i> Addigy</td><td><a href="addigy.md">addigy.md</a></td></tr><tr><td><i class="fa-apple">:apple:</i> Iru</td><td><a href="kandji-1.md">kandji-1.md</a></td></tr><tr><td><i class="fa-apple">:apple:</i> Mosyle</td><td><a href="mosyle.md">mosyle.md</a></td></tr><tr><td><i class="fa-mobile-screen">:mobile-screen:</i> SOTI MobiControl</td><td><a href="soti-mobicontrol.md">soti-mobicontrol.md</a></td></tr></tbody></table>

### Protect the challenge password

If your MDM acts as the SCEP client, it generates the key pair and delivers the certificate and private key to the device. The challenge password remains between the MDM and SCEPman.

Some MDMs relay SCEP messages between the device and SCEPman. In this model, the device receives the challenge password. A compromised device could expose the password and request unauthorized certificates.

Protect the challenge password wherever it is stored or transmitted. Restrict access to the MDM configuration and rotate the password if exposure is suspected.
