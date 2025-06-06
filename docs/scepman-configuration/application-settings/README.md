# SCEPman Settings

The section describes additional settings for the behavior of SCEPman. All of these are optional, though, and we recommend just start with the defaults.

Settings can be added or changed manually if needed. Some changes can harm your service. Please carefully read all information about a setting before changing.

For each Setting, you can choose whether you want to define the setting in the App Service Configuration or in Azure Key Vault. If you define the same setting in both places, Azure Key Vault takes precedence.

## Convenient Configuration in the App Service Configuration

<figure><img src="../../.gitbook/assets/Screenshot 2024-03-18 130123 (1).jpg" alt=""><figcaption></figcaption></figure>

We recommend defining settings in the App Service Configuration except for passwords.

## Linux Configuration

All existing settings are available for both Windows and Linux App Services.

When configuring Environment Variables for Linux, colons must be replaced with two underscores.&#x20;

For example, a Windows App Service accepts _AppConfig:LicenseKey_, while a Linux App Service accepts _AppConfig\_\_LicenseKey._

## Secure Configuration in Azure Key Vault

Especially for sensitive information, you can also configure settings as Secrets in Azure Key Vault. You must first grant edit rights to Secrets in the Azure Key Vault associated with your SCEPman instance to an administrator account. Then, you can use this administrator account to define new Secrets.

**Remark:** Use double dashes instead of colons in configuration names! For example, instead of _AppConfig:DCValidation:RequestPassword_, the Secret must be named _AppConfig--DCValidation--RequestPassword_.

We recommend using this type of configuration only for sensitive information.

## List of Settings

{% content-ref url="basics.md" %}
[basics.md](basics.md)
{% endcontent-ref %}

{% content-ref url="certificates.md" %}
[certificates.md](certificates.md)
{% endcontent-ref %}

{% content-ref url="scep-endpoints/intune-validation.md" %}
[intune-validation.md](scep-endpoints/intune-validation.md)
{% endcontent-ref %}

{% content-ref url="scep-endpoints/jamf-validation.md" %}
[jamf-validation.md](scep-endpoints/jamf-validation.md)
{% endcontent-ref %}

{% content-ref url="scep-endpoints/dc-validation.md" %}
[dc-validation.md](scep-endpoints/dc-validation.md)
{% endcontent-ref %}

{% content-ref url="scep-endpoints/static-validation.md" %}
[static-validation.md](scep-endpoints/static-validation.md)
{% endcontent-ref %}

{% content-ref url="scep-endpoints/static-validation.md" %}
[static-validation.md](scep-endpoints/static-validation.md)
{% endcontent-ref %}

{% content-ref url="csr-validation.md" %}
[csr-validation.md](csr-validation.md)
{% endcontent-ref %}

{% content-ref url="dependencies-azure-services/azure-ad.md" %}
[azure-ad.md](dependencies-azure-services/azure-ad.md)
{% endcontent-ref %}

{% content-ref url="dependencies-azure-services/azure-keyvault.md" %}
[azure-keyvault.md](dependencies-azure-services/azure-keyvault.md)
{% endcontent-ref %}

{% content-ref url="dependencies-azure-services/national-cloud-platforms.md" %}
[national-cloud-platforms.md](dependencies-azure-services/national-cloud-platforms.md)
{% endcontent-ref %}
