---
title: Static environment variables
---

Use the setting names for your App Service operating system.

{% tabs %}
{% tab title="Linux" %}
Linux App Services use double underscores (`__`) instead of colons.

| Setting                                                                                                                                                                                                          | Description                                                               | Value                                    |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------------- |
| [AppConfig\_\_StaticValidation\_\_Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                                              | Enable Static validation                                                  | **true** to enable, **false** to disable |
| [AppConfig\_\_StaticValidation\_\_RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)                              | Authenticates certificate requests. Store this secret in Azure Key Vault. | Generate a 32-character password         |
| [AppConfig\_\_StaticValidation\_\_ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)             | Certificate validity in days                                              | 365                                      |
| [AppConfig\_\_StaticValidation\_\_EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store issued certificates for Certificate Master                          | **true**                                 |
{% endtab %}

{% tab title="Windows" %}
Windows App Services use colons (`:`) in setting names.

| Setting                                                                                                                                                                                                    | Description                                                               | Value                                    |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ---------------------------------------- |
| [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                                              | Enable Static validation                                                  | **true** to enable, **false** to disable |
| [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)                              | Authenticates certificate requests. Store this secret in Azure Key Vault. | Generate a 32-character password         |
| [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)             | Certificate validity in days                                              | 365                                      |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store issued certificates for Certificate Master                          | **true**                                 |
{% endtab %}
{% endtabs %}
