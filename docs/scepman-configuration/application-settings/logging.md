# Logging

{% hint style="info" %}
Applicable to version 2.4 and above
{% endhint %}

## AppConfig:LoggingConfig:WorkspaceId

_Linux: AppConfig\_\_LoggingConfig\_\_WorkspaceId_

**Value:** Guid

**Description:**

The WorkspaceID of your Log Analytics Workspace (shown in the Overview of the workspace). This is a required setting if you want to use Azure Monitor together with [SharedKey](logging.md#appconfig-loggingconfig-sharedkey).

{% hint style="warning" %}
This logging method is deprecated and Microsoft has announced to retire this logging API. Switch to AppConfig:LoggingConfig:DataCollectionEndpointUri and AppConfig:LoggingConfig:RuleId instead, as described in the [Log Management](../../azure-configuration/log-configuration.md) article.
{% endhint %}

## AppConfig:LoggingConfig:SharedKey

_Linux: AppConfig\_\_LoggingConfig\_\_SharedKey_

**Value:** String

**Description:**

Use one of the two keys for the Log Analytics Workspace. They are displayed if you access the Log Analytics Workspace on portal.azure.com and navigate to Settings/Agents, where you can unfold the "Log Analytics agent instructions" section. Use either the Primary or the Secondary key.

This is a required setting if you want to use Azure Monitor, together with WorkspaceId.

{% hint style="warning" %}
This logging method is deprecated and Microsoft has announced to retire this logging API. Switch to AppConfig:LoggingConfig:DataCollectionEndpointUri and AppConfig:LoggingConfig:RuleId instead, as described in the [Log Management](../../azure-configuration/log-configuration.md) article.
{% endhint %}

{% hint style="info" %}
SCEPman Certificate Master does not support storing configuration values in Key Vault in the same way that the SCEPman core component does. There is a generic way to store App Service settings in Key Vault, though, which [Mika Berglund](https://mikaberglund.com/store-your-app-service-configuration-settings-in-azure-key-vault/) describes in his blog. In short, you must add Secrets-Get permission to the Certificate Master Managed Identity and, for the SharedKey, you would use `@Microsoft.KeyVault(SecretUri=https://YOURKEYVAULTNAMEHERE.vault.azure.net/secrets/appconfig--loggingconfig--sharedkey/)` as value for AppConfig:LoggingConfig:SharedKey.
{% endhint %}

## AppConfig:LoggingConfig:DataCollectionEndpointUri

_Linux: AppConfig\_\_LoggingConfig\_\_DataCollectionEndpointUri_

**Value:** String

**Description:**

Used in conjunction with AppConfig:LoggingConfig:RuleId to log to a Log Analytics Workspace, authenticating with the Managed Identity of the App Service.

This is the URI of the Data Collection Endpoint (DCE) of Azure Monitor.

## AppConfig:LoggingConfig:RuleId

_Linux: AppConfig\_\_LoggingConfig\_\_RuleId_

**Value**: String

**Description:**

Used in conjunction with AppConfig:LoggingConfig:DataCollectionEndpointUri to log to a Log Analytics Workspace, authenticating with the Managed Identity of the App Service.

This setting is the immutable Id of the Data Collection Rule (DCR) resource.

## AppConfig:LoggingConfig:AzureOfferingDomain

_Linux: AppConfig\_\_LoggingConfig\_\_AzureOfferingDomain_

**Value:** String

**Description:**

If the workspace is not in the Global Azure Cloud, you can configure the offering domain here. The default is 'azure.com'.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:LoggingConfig:LogLevel

_Linux: AppConfig\_\_LoggingConfig\_\_LogLevel_

**Value:** Trace, Debug, Info, Warn, Error, Fatal

**Description:**

The minimum log level to be logged. The default is 'Info'. Only log entries with a log level equal or higher than the configured log level will be logged.

Note that if you configure this setting to 'Trace' or 'Debug', log output might contain personal data like UPNs or IP addresses of users. If you want to avoid personal data in the log output, you should configure this setting to 'Info' or higher.

## AppConfig:LoggingConfig:AzureEventHubConnectionString

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubConnectionString_

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.7 and above
{% endhint %}

**Value:** String

**Description:**

The connection string to your Azure Event Hub. This is a required setting if you want to use Azure Event Hub.

## AppConfig:LoggingConfig:AzureEventHubName

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubName_

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.7 and above
{% endhint %}

**Value:** String

**Description:**

The name of your Azure Event Hub. This is a required setting if you want to use Azure Event Hub.

## AppConfig:LoggingConfig:AzureEventHubPartitionKey

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubPartitionKey_

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.7 and above
{% endhint %}

**Value:** String

**Description:**

The partition key of your Azure Event Hub. Setting this is optional. If you don't set this, this defaults to '0'.
