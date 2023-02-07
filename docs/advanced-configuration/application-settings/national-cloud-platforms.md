# National Cloud platforms

{% hint style="info" %}
Applicable to version 2.0 and above
{% endhint %}

If you want to run SCEPman in a cloud environment like GCC High, GCC DoD, or 21ViaNet, you have to alter some settings. If you run SCEPman in the standard Azure environment, just leave these settings empty to use the defaults. The following settings provide you the means to configure cloud-specific URLs and values if you are not using the standard Azure environment.

## AppConfig:AzureCloudConfig:AzureADEndpoint

**Value:** URL as string

**Description:**\
This is the AAD logon URL. It defaults to `https://login.microsoftonline.com`.

For GCC High, use `https://login.microsoftonline.us`.

## AppConfig:AzureCloudConfig:AzureADGraphEndpoint

**Value:** URL as string

**Description:**\
This is the AAD Graph URL. It defaults to `https://graph.windows.net/`.

You may not need to configure this if you let SCEPman use only Microsoft Graph.

## AppConfig:AzureCloudConfig:AzureADGraphVersion

**Value:** string

**Description:**\
The version of AAD Graph to use. It defaults to `1.6`.

## AppConfig:AzureCloudConfig:MSGraphEndpoint

**Value:** URL as string

**Description:**\
The URL of Microsoft Graph. It defaults to `https://graph.microsoft.com`.

For GCC High, use `https://graph.microsoft.us`. For GCC DoD, use `https://dod-graph.microsoft.us`. For 21Vianet, use `https://microsoftgraph.chinacloudapi.cn`.

## AppConfig:AzureCloudConfig:KeyVaultEndpoint

**Value:** URL as string

**Description:**\
The URL of Azure Key Vaults. It defaults to `https://vault.azure.net`.

For GCC High, use `https://vault.usgovcloudapi.net`.

## AppConfig:AzureCloudConfig:ManagementEndpoint

**Value:** URL as string

**Description:**\
The URL of the Intune API. It defaults to `https://api.manage.microsoft.com`.

For GCC High, use `https://api.manage.microsoft.us`.

## AppConfig:AzureCloudConfig:IntuneAppId

**Value:** Guid as string

**Description:**\
The well-known Intune App ID. It defaults to `0000000a-0000-0000-c000-000000000000`.
