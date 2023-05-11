# Log configuration

Newer SCEPman installations automatically create a Log Analytics Workspace during deployment and log into Azure Monitor. If you have an older installation, you can follow the steps below to enable logging.

## Enable Logging to Azure Monitor

1. Create a Log Analytics workspace (Microsoft Guide [Create a Log Analytics workspace](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-create-workspace#create-a-workspace)). You can also use an existing one.
2. Add the settings described in the [logging article](application-settings/logging.md).

# KQL Query Examples

<!-- ## How many certificates were issued in the last 24 hours?

```kusto
SCEPman_CL |
where TimeGenerated > ago(24h) |
where Message contains "has been issued"
``` -->

## See Issues with SCEPman

```kusto
SCEPman_CL |
where Level == "Warn" or Level == "Error" or Level == "Fatal"
```
