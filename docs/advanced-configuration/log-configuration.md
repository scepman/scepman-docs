# Log Configuration

## Log configuration

Newer SCEPman installations (version 2.4 and later) automatically create a Log Analytics Workspace during deployment and log into Azure Monitor. If you have an older installation, you can follow the steps below to enable this logging feature.

### Enable Logging to Azure Monitor

{% hint style="info" %}
The **default retention** period for data stored in a Log Analytics Table is **30 days**. In case a different retention period is required, adjust the configuration of the Table "SCEPman\_CL" accordingly.
{% endhint %}

1. Create a Log Analytics workspace (Microsoft Guide [Create a Log Analytics workspace](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-create-workspace#create-a-workspace)). You can also use an existing one.
2. Add the settings described in the [logging article](application-settings/logging.md).

## KQL Query Examples

### See Issues with your SCEPman Instance

```kusto
SCEPman_CL |
where Level == "Warn" or Level == "Error" or Level == "Fatal"
```
