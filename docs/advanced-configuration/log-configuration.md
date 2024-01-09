# Log Configuration

{% hint style="info" %}
Applicable to SCEPman Certificate Master version 2.4 and above
{% endhint %}

## Log configuration

Newer SCEPman installations (version 2.4 and later) automatically create a Log Analytics Workspace during deployment and log into Azure Monitor. If you have an older installation, you can follow the steps below to enable this logging feature.

### Enable Logging to Azure Monitor

{% hint style="info" %}
The **default retention** period for data stored in a Log Analytics Table is **30 days**. In case a different retention period is required, adjust the configuration of the Table "SCEPman\_CL" accordingly.
{% endhint %}

1. Create a Log Analytics workspace (Microsoft Guide [Create a Log Analytics workspace](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-create-workspace#create-a-workspace)). You can also use an existing one.
2. Add the settings AppConfig:LoggingConfig:WorkspaceId and AppConfig:LoggingConfig:SharedKey described in the [section on Logging settings](application-settings/logging.md). Do this for each of your SCEPman instances (these are more than one for geo-redundancy or if you have multiple deployment slots) and your Certificate Master App Service.

## KQL Query Examples

### See Issues with Your SCEPman Instance

```kusto
SCEPman_CL
| where Level == "Warn" or Level == "Error" or Level == "Fatal"
```

### Number of Issued Certificates by Endpoint in the Selected Time Frame

```kusto
SCEPman_CL
| where LogCategory_s == "Scepman.Core.CertificationAuthority.KeyVaultCA" and Level == "Info"
| project Message, RequestBase = trim_end('/', replace_string(replace_regex(RequestUrl_s, "(/pkiclient\\.exe)?(\\?operation=PKIOperation(&message=.+)?)?", ""),"certsrv/mscep/mscep.dll","intune"))
| summarize IssuanceCount = count() by Endpoint = extract("/([a-zA-Z]+)$", 1, RequestBase)
```

### OCSP Requests by Type of Certificate

```kusto
let map_certtype = datatable(serial_start:string, readable:string)
[
  "40", "Intune Device",
  "50", "Static",
  "60", "Intune User",
  "64", "Jamf User",
  "54", "Jamf Computer",
  "55", "Jamf Computer",
  "44", "Jamf Device"
];
SCEPman_CL
| where LogCategory_s == "Scepman.Server.Controllers.OcspController" and Level == "Info"
| where Message startswith_cs "OCSP Response"
| project serial = extract("Serial Number ([A-F0-9]+)", 1, Message)
| distinct serial
| extend serial_start = substring(serial,0,2)
| summarize count() by (serial_start)
| join kind=leftouter map_certtype on serial_start
```
