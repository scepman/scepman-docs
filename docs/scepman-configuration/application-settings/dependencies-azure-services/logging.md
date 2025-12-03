# Logging

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).

Applicable to version 2.4 and above
{% endhint %}

## AppConfig:LoggingConfig:DataCollectionEndpointUri

_Linux: AppConfig\_\_LoggingConfig\_\__&#x44;ataCollectionEndpointUri

{% hint style="info" %}
Logging via DCE is possible in version 3.0 and above
{% endhint %}

**Value:** Uri

**Description:**

The data collection endpoint Uri is the target SCEPman sends its logs to. This utilizes the default DCE of the Data Collection Rule that is created automatically in a standard deployment.

## AppConfig:LoggingConfig:RuleId

_Linux: AppConfig\_\_LoggingConfig\_\__&#x52;uleId

{% hint style="info" %}
Logging via DCE is possible in version 3.0 and above
{% endhint %}

**Value:** String

**Description:**

This is the unique identifier of the Data Collection Rule to be used by SCEPman.

## AppConfig:LoggingConfig:WorkspaceId

_Linux: AppConfig\_\_LoggingConfig\_\_WorkspaceId_

**Value:** Guid

**Description:**

The WorkspaceID of your Log Analytics Workspace (shown in the Overview of the workspace). This is a required setting if you want to use Azure Monitor, together with SharedKey.

## AppConfig:LoggingConfig:SharedKey

_Linux: AppConfig\_\_LoggingConfig\_\_SharedKey_

**Value:** String

**Description:**

Use one of the two keys for the Log Analytics Workspace. They are displayed if you access your SCEPman Log Analytics Workspace and navigate to Settings/Agents, where you can unfold the "Log Analytics agent instructions" section. Use either the Primary or the Secondary key.

This is a required setting if you want to use Azure Monitor, together with WorkspaceId.

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

**Value:** _Trace_, _Debug_, _Info_, _Warn_, _Error_, or _Fatal_

**Description:**

The minimum log level to be logged. The default is 'Info'. Only log entries with a log level equal or higher than the configured log level will be logged.

Note that if you configure this setting to 'Trace' or 'Debug', log output might contain personal data like UPNs or IP addresses of users. If you want to avoid personal data in the log output, you should configure this setting to 'Info' or higher.

## AppConfig:LoggingConfig:AzureEventHubConnectionString

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubConnectionString_

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.5 and above
{% endhint %}

**Value:** String

**Description:**

The connection string to your Azure Event Hub. If you want to use Azure Event Hub, you must either configure this setting or [AppConfig:LoggingConfig:AzureEventHubServiceUri](logging.md#appconfig-loggingconfig-azureeventhubserviceuri). If you use AzureEventHubConnectionString, it must include the authentication information.

## AppConfig:LoggingConfig:AzureEventHubName

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubName_

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.5 and above
{% endhint %}

**Value:** String

**Description:**

The name of your Azure Event Hub. This is a required setting if you want to use Azure Event Hub.

## AppConfig:LoggingConfig:AzureEventHubPartitionKey

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubPartitionKey_

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.5 and above
{% endhint %}

**Value:** String

**Description:**

The partition key of your Azure Event Hub. Setting this is optional. If you don't set this, this defaults to '0'.

## AppConfig:LoggingConfig:AzureEventHubServiceUri

_Linux: AppConfig\_\_LoggingConfig\_\_AzureEventHubServiceUri_

{% hint style="info" %}
Logging to Azure Event Hub with Managed Identity is possible in version 2.8 and above
{% endhint %}

**Value:** String

Description: The Service URI of the Azure Event Hub. If you want to use Azure Event Hub, you must either configure this setting or [AppConfig:LoggingConfig:AzureEventHubConnectionString](logging.md#appconfig-loggingconfig-azureeventhubconnectionstring). If you use AzureEventHubServiceUri, SCEPman/Certificate Master will authenticate with its Managed Identity to the Azure Event Hub Service.
