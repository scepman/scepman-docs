# Microsoft Entra ID (Azure AD)

## AppConfig:AuthConfig:ApplicationId

_Linux: AppConfig\_\_AuthConfig\_\_ApplicationId_

The Application (client) ID from your Microsoft Entra ID (Azure AD) App registration (SCEPman-CertMaster). This setting is configured during the setup.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:SCEPmanAPIScope

_Linux: AppConfig\_\_AuthConfig\_\_SCEPmanAPIScope_

This value comes from the Microsoft Entra ID (Azure AD) app registration. It is used to authenticate against SCEPman and authorize the CSR submissions.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:TenantId

_Linux: AppConfig\_\_AuthConfig\_\_TenantId_

The Tenant ID in Microsoft Entra ID (Azure AD). This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:ManagedIdentityEnabledOnUnixTime

_Linux: AppConfig\_\_AuthConfig\_\_ManagedIdentityEnabledOnUnixTime_

The time as Unix epoch when the required permissions to the Managed Identity were granted. SCEPman Certificate Master acquires a token using the Managed Identity only after a short delay (60 seconds in SCEPman 2.0) after this time, because only then do the roles in the token reflect the correct permissions added by the CMDlet. The tokens are cached [for 24 hours with no way to force refresh the cache](https://docs.microsoft.com/en-us/azure/app-service/overview-managed-identity?tabs=portal%2Cdotnet#configure-target-resource), so if you added a permission after SCEPman Certificate Master has acquired a token, you need to wait up to 24 hours until Certificate Master can use this new permission.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}
