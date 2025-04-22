# Microsoft Entra ID (Azure AD)

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).
{% endhint %}

## AppConfig:AuthConfig:ApplicationId

_Linux: AppConfig\_\_AuthConfig\_\_ApplicationId_

The [Application (client) ID](../../../scepman-deployment/permissions/azure-app-registration.md#basic-app-registration-application-id) from your Microsoft Entra ID (Azure AD) App registration. This setting is configured during the setup.

{% hint style="warning" %}
Please do not mix this up with the "Client Secret ID". We need the "Application (client) ID", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:ApplicationKey

_Linux: AppConfig\_\_AuthConfig\_\_ApplicationKey_

The [Application Key (client secret **value**)](../../../scepman-deployment/permissions/azure-app-registration.md#azure-app-registration-client-secret) from your Microsoft Entra ID (Azure AD) App registration. This setting is configured during the setup of a SCEPman 1.x version. SCEPman 2.x usually does not use this setting and instead relies on [Managed Identity authentication](../../post-installation-config.md).

{% hint style="warning" %}
Please do not mix this up with the "Client Secret **ID**". We need the "Client Secret **Value**", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:TenantId

_Linux: AppConfig\_\_AuthConfig\_\_TenantId_

The Microsoft Entra ID (Azure AD) Tenant ID. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:HomeTenantId

_Linux: AppConfig\_\_AuthConfig\_\_HomeTenantId_

When running SCEPman in a different tenant than Intune, this specifies the Id of the tenant hosting the SCEPman Azure resource, while [AppConfig:AuthConfig:TenantId](azure-ad.md#appconfig-authconfig-tenantid) specifies the tenant of Intune. In this case, you cannot use the more convenient [authentication based on Managed Identities](../../post-installation-config.md), but must use authentication using [an Azure App Registration and a Client Secret](../../../scepman-deployment/permissions/azure-app-registration.md).

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:HomeApplicationId

_Linux: AppConfig\_\_AuthConfig\_\_HomeApplicationId_

This setting is only used for situations where SCEPman runs in a different tenant than Intune. The HomeApplicationId specifies the application ID of your `scepman-api` app registration in the tenant where the SCEPman and Certificate Master App Services run. [AppConfig:AuthConfig:ApplicationId](azure-ad.md#appconfig-authconfig-applicationid) and [AppConfig:AuthConfig:ApplicationKey](azure-ad.md#appconfig-authconfig-applicationkey) specify the application ID and Client Secret Value, respectively, of the app registration in the tenant where Intune runs.

{% hint style="warning" %}
Please do not mix this up with the "Client Secret ID". We need the "Application (client) ID", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:ManagedIdentityEnabledOnUnixTime

_Linux: AppConfig\_\_AuthConfig\_\_ManagedIdentityEnabledOnUnixTime_

The time as Unix epoch when the required permissions to the Managed Identity were granted. SCEPman acquires a token using the Managed Identity only after a short delay (60 seconds in SCEPman 2.0) after this time, because only then do the roles in the token reflect the correct permissions added by the CMDlet. The tokens are cached [for 24 hours with no way to force refresh the cache](https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=portal%2Cdotnet#configure-target-resource), so if you added a permission after SCEPman has acquired a token, you need to wait up to 24 hours until SCEPman can use this new permission.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}
