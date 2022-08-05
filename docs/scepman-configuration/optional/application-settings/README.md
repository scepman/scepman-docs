# Application Settings

The section describes additional settings for the behavior of SCEPman. All of these are optional, though, and we recommend just start with the defaults.

Settings can be added or changed manually if needed. Some changes can harm your service. Please carefully read all information about a setting before changing.

For each Setting, you can choose whether you want to define the setting in the App Service Configuration or in Azure Key Vault. If you define the same setting in both places, Azure Key Vault takes precedence.

## Convenient Configuration in the App Service Configuration

On your **App Service** navigate to **Configuration** and then you find this under **Application settings**. Use the setting names as described below.

We recommend defining settings in the App Service Configuration except for passwords.

![](<../../../../.gitbook/assets/2021-08-02-10\_14\_03-posteingang-eyad.hamed-glueckkanja-gab.com-outlook (1).png>)

## Secure Configuration in Azure Key Vault

{% hint style="info" %}
This feature requires version **1.7** or above.
{% endhint %}

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

{% content-ref url="intune-validation.md" %}
[intune-validation.md](intune-validation.md)
{% endcontent-ref %}

{% content-ref url="jamf-validation.md" %}
[jamf-validation.md](jamf-validation.md)
{% endcontent-ref %}

{% content-ref url="dc-validation.md" %}
[dc-validation.md](dc-validation.md)
{% endcontent-ref %}

{% content-ref url="static-validation.md" %}
[static-validation.md](static-validation.md)
{% endcontent-ref %}

{% content-ref url="csr-validation.md" %}
[csr-validation.md](csr-validation.md)
{% endcontent-ref %}

{% content-ref url="azure-ad.md" %}
[azure-ad.md](azure-ad.md)
{% endcontent-ref %}

{% content-ref url="azure-keyvault.md" %}
[azure-keyvault.md](azure-keyvault.md)
{% endcontent-ref %}

{% content-ref url="national-cloud-plattforms.md" %}
[national-cloud-plattforms.md](national-cloud-plattforms.md)
{% endcontent-ref %}
