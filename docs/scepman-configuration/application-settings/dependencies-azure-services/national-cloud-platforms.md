# National Cloud Platforms

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).
{% endhint %}

If you want to run SCEPman in a government / national cloud environment like GCC High, GCC DoD, or 21ViaNet, you have to alter some settings. If you run SCEPman in the standard Azure environment, just leave these settings empty to use the defaults. The following settings provide you the means to configure cloud-specific URLs and values if you are not using the standard Azure environment.

See also the [Logging configuration](../../application-settings-1/logging.md#appconfig-loggingconfig-azureofferingdomain) if you want to log to a Log Analytics Workspace in a different cloud environment.

## AppConfig:AzureCloudConfig:AzureADEndpoint

_Linux: AppConfig\_\_AzureCloudConfig\_\_AzureADEndpoint_

**Value:** URL as string

**Description:**\
This is the AAD logon URL. It defaults to `https://login.microsoftonline.com`.

For GCC High, use `https://login.microsoftonline.us`. For 21Vianet, use `https://login.partner.microsoftonline.cn`.

## AppConfig:AzureCloudConfig:AzureADGraphEndpoint

_Linux: AppConfig\_\_AzureCloudConfig\_\_AzureADGraphEndpoint_

**Value:** URL as string

**Description:**\
This is the AAD Graph URL. It defaults to `https://graph.windows.net/`.

You may not need to configure this if you let SCEPman use only Microsoft Graph.

## AppConfig:AzureCloudConfig:AzureADGraphVersion

_Linux: AppConfig\_\_AzureCloudConfig\_\_AzureADGraphVersion_

**Value:** string

**Description:**\
The version of AAD Graph to use. It defaults to `1.6`.

## AppConfig:AzureCloudConfig:MSGraphEndpoint

_Linux: AppConfig\_\_AzureCloudConfig\_\_MSGraphEndpoint_

**Value:** URL as string

**Description:**\
The URL of Microsoft Graph. It defaults to `https://graph.microsoft.com`.

For GCC High, use `https://graph.microsoft.us`. For GCC DoD, use `https://dod-graph.microsoft.us`. For 21Vianet, use `https://microsoftgraph.chinacloudapi.cn`.

## AppConfig:AzureCloudConfig:KeyVaultEndpoint

_Linux: AppConfig\_\_AzureCloudConfig\_\_KeyVaultEndpoint_

**Value:** URL as string

**Description:**\
The URL of Azure Key Vaults. It defaults to `https://vault.azure.net`.

For GCC High, use `https://vault.usgovcloudapi.net`. For 21Vianet, use `https://vault.azure.cn`.

## AppConfig:AzureCloudConfig:ManagementEndpoint

_Linux: AppConfig\_\_AzureCloudConfig\_\_ManagementEndpoint_

**Value:** URL as string

**Description:**\
The URL of the Intune API. It defaults to `https://api.manage.microsoft.com`.

For GCC High, use `https://api.manage.microsoft.us`.

## AppConfig:AzureCloudConfig:IntuneAppId

_Linux: AppConfig\_\_AzureCloudConfig\_\_IntuneAppId_

**Value:** Guid as string

**Description:**\
The well-known Intune App ID. It defaults to `0000000a-0000-0000-c000-000000000000`.
