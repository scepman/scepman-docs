# Split-Tenancy

## Overview <a href="#overview" id="overview"></a>

SCEPman can be configured to be operated from an Azure tenant different to the Azure/Intune tenant to whose users and/or devices it issues certificates to. This approach is called **split-tenancy** and is especially **helpful for MSPs** that would like to consolidate Azure infrastructure costs across their customers while maintaining a dedicated backend and unique CA for each of those customers.

Split-tenancy comes along with a **major disadvantage**: [Managed Identities](../post-installation-config.md) can no longer be used. This means authentication against the Graph API (Azure AD and Intune) is again handled using an App registration and Client secret, which has to be managed (by the MSP) as it expires.

In the following, we refer to the hosting tenant as **home tenant** and to the customer tenant as **target tenant**.

## Configuration Steps

To configure **SCEPman** and **Certificate Master** for split-tenancy, please follow these steps:

1. Perform a standard deployment of SCEPman/Certificate Master as described in our [Getting Started Guide](../../scepman-deployment/deployment-guides/).
2. Create an **App registration** in the **target tenant** as described here: [Azure App Registration](../../scepman-deployment/permissions/azure-app-registration.md). This **App registration** will allow SCEPman to access the Azure AD and Intune directories in the **target tenant**.

{% hint style="warning" %}
The **client secret** generated as part of this **App registration** has an expiry and must be renewed before it expires. Please set a reminder for the renewal.
{% endhint %}

### SCEPman

3. Navigate to the SCEPman **App service** and then to "Settings" --> "Configuration". Locate the following parameters and **delete** them:

* `AppConfig:AuthConfig:ManagedIdentityEnabledForWebsiteHostname`
* `AppConfig:AuthConfig:ManagedIdentityEnabledOnUnixTime`
* `AppConfig:AuthConfig:ManagedIdentityPermissionLevel`

4. **Rename** the following settings (**do not change their values**):

* `AppConfig:AuthConfig:ApplicationId` --> `AppConfig:AuthConfig:HomeApplicationId`
* `AppConfig:AuthConfig:TenantId` --> `AppConfig:AuthConfig:HomeTenantId`

5. **Create** the following new application settings:

| Name                                  | Value                                                                                           |
| ------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `AppConfig:AuthConfig:ApplicationId`  | GUID of the **App registration** that was created before.                                       |
| `AppConfig:AuthConfig:TenantId`       | Tenant ID of the **target tenant**.                                                             |
| `AppConfig:AuthConfig:ApplicationKey` | **Value** of the **Client secret** that was created as part of the **App registration** before. |

6. Restart the SCEPman **App service**.

### Certificate Master

7. Navigate to the Certificate Master **App service** and then to "Settings" --> "Configuration".
8. Now you have two options:
   1. You want users from your **home tenant** to log in to Certificate Master and issue certificates, which includes guest users in your home tenant, e.g. from your target tenant. If that is the case, rename the following settings (**do not change their values**):
      * `AppConfig:AuthConfig:TenantId` --> `AppConfig:AuthConfig:HomeTenantId`
      * `AppConfig:AuthConfig:ApplicationId` --> `AppConfig:AuthConfig:HomeApplicationId`
   2. You want users from your **target tenant** to log in to Certificate Master and issue certificates, which includes guest users in your target tenant, e.g. from your home tenant. If that is what you wish, do the following:
      * Open a **PowerShell** or **Azure Cloud Shell** in your **target tenant** and run the following commands:\
        \
        `Install-Module SCEPman -Scope CurrentUser -Force`\
        `Register-SCEPmanCertMaster -CertMasterBaseURL <url>`\
        `\` Use the URL like 'https://certmaster.scepman.contoso.de/' for `<url>`.
      * The **CMDlet** will output an **Application Id** and a **Tenant Id** (that of the **target tenant**). Enter these two values as `AppConfig:AuthConfig:HomeApplicationId` and `AppConfig:AuthConfig:HomeTenantId` in your Certificate Master settings.
      * Now **create** the following new application settings, possibly overriding the existing ones, with the same values as in SCEPman:

| Name                                  | Value                                                                                                                                                                                                                            |
| ------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AppConfig:AuthConfig:ApplicationId`  | GUID of the **App registration** that was created before.                                                                                                                                                                        |
| `AppConfig:AuthConfig:TenantId`       | Tenant ID of the **target tenant**.                                                                                                                                                                                              |
| `AppConfig:AuthConfig:ApplicationKey` | <p><strong>Value</strong> of the <strong>Client secret</strong> that was created as part of the <strong>App registration</strong> before.<br>You can create a separate new Client secret for Certificate Master if you want.</p> |

9. Restart the SCEPman Certificate Master **App service**.

As an overview, here are the accounts used by **Certificate Master** and what they are used for:

| Account                                               | What is it used for?                                                                                                                                                               | Condition                                                                 |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| Managed Identity                                      | <ul><li>Authorize CSRs submitted to SCEPman</li><li>Access to the Storage Account</li></ul>                                                                                        | No alternatives                                                           |
| App Registration with App ID from `ApplicationId`     | Certificate Master accesses Microsoft Graph in this context to see which certificates have been enrolled via Intune                                                                | If `ApplicationKey` is not present, the Managed Identity is used instead. |
| App Registration with App ID from `HomeApplicationId` | Users authenticate **to** this application. It should be in the tenant where users accessing Certificate Master reside (but guest users from other tenants can also be authorized) | If `HomeApplicationId` is not present, `ApplicationId` is used instead.   |
