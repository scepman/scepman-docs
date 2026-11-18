---
title: Static-AAD environment variables
---

Use the setting names for your App Service operating system.

{% tabs %}
{% tab title="Linux" %}
Linux App Services use double underscores (`__`) instead of colons.

| Setting                                                                                                                                                                                                                   | Description                                                               | Value                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------------- |
| [AppConfig\_\_StaticAADValidation\_\_Enabled](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enabled)                                              | Enable Entra-bound validation                                             | **true** to enable, **false** to disable |
| [AppConfig\_\_StaticAADValidation\_\_RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-requestpassword)                              | Authenticates certificate requests. Store this secret in Azure Key Vault. | Generate a 32-character password         |
| [AppConfig\_\_StaticAADValidation\_\_ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-validityperioddays) (optional)             | Certificate validity in days                                              | 365                                      |
| [AppConfig\_\_StaticAADValidation\_\_EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage) (optional) | Store issued certificates and enable automatic revocation                 | **true**                                 |
{% endtab %}

{% tab title="Windows" %}
Windows App Services use colons (`:`) in setting names.

| Setting                                                                                                                                                                                                             | Description                                                               | Value                                    |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------------- |
| [AppConfig:StaticAADValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enabled)                                              | Enable Entra-bound validation                                             | **true** to enable, **false** to disable |
| [AppConfig:StaticAADValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-requestpassword)                              | Authenticates certificate requests. Store this secret in Azure Key Vault. | Generate a 32-character password         |
| [AppConfig:StaticAADValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-validityperioddays) (optional)             | Certificate validity in days                                              | 365                                      |
| [AppConfig:StaticAADValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage) (optional) | Store issued certificates and enable automatic revocation                 | **true**                                 |
{% endtab %}
{% endtabs %}
