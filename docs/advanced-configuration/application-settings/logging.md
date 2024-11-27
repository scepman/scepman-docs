# Logging

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](./).

Applicable to version 2.4 and above
{% endhint %}

## AppConfig:LoggingConfig:WorkspaceId

**Value:** Guid

**Description:**

The WorkspaceID of your Log Analytics Workspace (shown in the Overview of the workspace). This is a required setting if you want to use Azure Monitor, together with SharedKey.

## AppConfig:LoggingConfig:SharedKey

**Value:** String

**Description:**

Use one of the two keys for the Log Analytics Workspace. They are displayed if you access the Log Analytics Workspace on portal.azure.com and navigate to Settings/Agents, where you can unfold the "Log Analytics agent instructions" section. Use either the Primary or the Secondary key.

This is a required setting if you want to use Azure Monitor, together with WorkspaceId.

## AppConfig:LoggingConfig:AzureOfferingDomain

**Value:** String

**Description:**

If the workspace is not in the Global Azure Cloud, you can configure the offering domain here. The default is 'azure.com'.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:LoggingConfig:LogLevel

**Value:** _Trace_, _Debug_, _Info_, _Warn_, _Error_, or _Fatal_

**Description:**

The minimum log level to be logged. The default is 'Info'. Only log entries with a log level equal or higher than the configured log level will be logged.

Note that if you configure this setting to 'Trace' or 'Debug', log output might contain personal data like UPNs or IP addresses of users. If you want to avoid personal data in the log output, you should configure this setting to 'Info' or higher.

## AppConfig:LoggingConfig:AzureEventHubConnectionString

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.5 and above
{% endhint %}

**Value:** String

**Description:**

The connection string to your Azure Event Hub. If you want to use Azure Event Hub, you must either configure this setting or AppConfig:LoggingConfig:AzureEventHubServiceUri. If you use AzureEventHubConnectionString, it must include the authentication information.

## AppConfig:LoggingConfig:AzureEventHubName

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.5 and above
{% endhint %}

**Value:** String

**Description:**

The name of your Azure Event Hub. This is a required setting if you want to use Azure Event Hub.

## AppConfig:LoggingConfig:AzureEventHubPartitionKey

{% hint style="info" %}
Logging to Azure Event Hub is possible in version 2.5 and above
{% endhint %}

**Value:** String

**Description:**

The partition key of your Azure Event Hub. Setting this is optional. If you don't set this, this defaults to '0'.

## AppConfig:LoggingConfig:AzureEventHubServiceUri

{% hint style="info" %}
Logging to Azure Event Hub with Managed Identity is possible in version 2.8 and above
{% endhint %}

**Value:** String

Description: The Service URI of the Azure Event Hub. If you want to use Azure Event Hub, you must either configure this setting or AppConfig:LoggingConfig:AzureEventHubConnectionString. If you use AzureEventHubServiceUri, SCEPman/Certificate Master will authenticate with its Managed Identity to the Azure Event Hub Service.
