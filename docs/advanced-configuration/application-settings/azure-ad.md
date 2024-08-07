# Microsoft Entra ID (Azure AD)

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](./).
{% endhint %}

## AppConfig:AuthConfig:ApplicationId

The [Application (client) ID](../../scepman-deployment/permissions/azure-app-registration.md#basic-app-registration-application-id) from your Microsoft Entra ID (Azure AD) App registration. This setting is configured during the setup.

{% hint style="warning" %}
Please do not mix this up with the "Client Secret ID". We need the "Application (client) ID", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:ApplicationKey

The [Application Key (client secret **value**)](../../scepman-deployment/permissions/azure-app-registration.md#azure-app-registration-client-secret) from your Microsoft Entra ID (Azure AD) App registration. This setting is configured during the setup of a SCEPman 1.x version. SCEPman 2.x usually does not use this setting and instead relies on [Managed Identity authentication](../../scepman-deployment/permissions/post-installation-config.md).

{% hint style="warning" %}
Please do not mix this up with the "Client Secret **ID**". We need the "Client Secret **Value**", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:TenantId

The Microsoft Entra ID (Azure AD) Tenant ID. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:HomeTenantId

When running SCEPman in a different tenant than Intune, this specifies the Id of the tenant hosting the SCEPman Azure resource, while AppConfig:AuthConfig:TenantId specifies the tenant of Intune. In this case, you cannot use the more convenient [authentication based on Managed Identities](../../scepman-deployment/permissions/post-installation-config.md), but must use authentication using [an Azure App Registration and a Client Secret](../../scepman-deployment/permissions/azure-app-registration.md).

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:HomeApplicationId

This setting is only used for situations where SCEPman runs in a different tenant than Intune. The HomeApplicationId specifies the application ID of your `scepman-api` app registration in the tenant where the SCEPman an Certificate Master App Services run. AppConfig:AuthConfig:ApplicationId and AppConfig:AuthConfig:ApplicationKey specify the application ID and Client Secret Value, respectively, of the app registration in the tenant where Intune runs.

{% hint style="warning" %}
Please do not mix this up with the "Client Secret ID". We need the "Application (client) ID", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:ManagedIdentityEnabledOnUnixTime

{% hint style="info" %}
Applicable to version 2.0 and above
{% endhint %}

The time as Unix epoch when the required permissions to the Managed Identity were granted. SCEPman acquires a token using the Managed Identity only after a short delay (60 seconds in SCEPman 2.0) after this time, because only then do the roles in the token reflect the correct permissions added by the CMDlet. The tokens are cached [for 24 hours with no way to force refresh the cache](https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=portal%2Cdotnet#configure-target-resource), so if you added a permission after SCEPman has acquired a token, you need to wait up to 24 hours until SCEPman can use this new permission.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:SCEPResponseEncryptionAlgorithm

The algorithm used to encrypt SCEP responses. Reasonable values include "2.16.840.1.101.3.4.1.42" for AES-256-CBC (the default) and "2.16.840.1.101.3.4.1.2" for AES-128-CBC.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}
