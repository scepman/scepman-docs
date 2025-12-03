# Log Management

### Enable Logging to Azure Monitor

Since version 3.0, SCEPman, as well as the Certificate Master, will utilize Microsofts Log Ingestion API to write logs to Azure Monitor. This uses a concept of a Log Analytics Workspace to hold the data and allow analyzation as well as a Data Collection Rule that interfaces between the App Service and the log storage. This allows for a more modern approach including RBAC based permissions for SCEPman to access the LAW.

The creation of the Log Analytics Workspace as well as the configuration of the Data Collection Rule is automatically done by running `Complete-SCEPmanInstallation` of the SCEPman PowerShell module.

{% hint style="info" %}
The **default retention** period for data stored in a Log Analytics Table is **30 days**. In case a different retention period is required, adjust the configuration of the Table "SCEPman\_CL" accordingly.
{% endhint %}

#### Reenabling Data Collector API

If, for any reason, you want to reinstate the previous API to be used you can do so by removing the Log Ingestion related app service variables and again add the ones to be used by the Data Collector API.

Variables to be **removed**:

* [AppConfig:LoggingConfig:DataCollectionEndpointUri](https://app.gitbook.com/o/-LhPlvZ6dc8XcqY7tdZw/s/-LoGejQeUQcw7lqnQ3WX/~/edit/~/changes/787/scepman-configuration/application-settings/dependencies-azure-services/logging#appconfig-loggingconfig-datacollectionendpointuri)
* [AppConfig:LoggingConfig:RuleId](https://app.gitbook.com/o/-LhPlvZ6dc8XcqY7tdZw/s/-LoGejQeUQcw7lqnQ3WX/~/edit/~/changes/787/scepman-configuration/application-settings/dependencies-azure-services/logging#appconfig-loggingconfig-ruleid)

Variables to be added:

* [AppConfig:LoggingConfig:WorkspaceId](https://app.gitbook.com/o/-LhPlvZ6dc8XcqY7tdZw/s/-LoGejQeUQcw7lqnQ3WX/~/edit/~/changes/787/scepman-configuration/application-settings/dependencies-azure-services/logging#appconfig-loggingconfig-workspaceid)
* [AppConfig:LoggingConfig:SharedKey](https://app.gitbook.com/o/-LhPlvZ6dc8XcqY7tdZw/s/-LoGejQeUQcw7lqnQ3WX/~/edit/~/changes/787/scepman-configuration/application-settings/dependencies-azure-services/logging#appconfig-loggingconfig-sharedkey)

SCEPman will automatically pick up the settings after a restart and will utilize the Data Collector API again.

## KQL Query Examples

### See Issues with Your SCEPman Instance

```kusto
SCEPman_CL
| where Level == "Warn" or Level == "Error" or Level == "Fatal"
```

### Number of Issued Certificates by Endpoint in the Selected Time Frame

{% hint style="success" %}
This query is guaranteed to work with SCEPman 2.8 and future versions. Changes to SCEPman that make this query unusable will be considered Breaking Changes.
{% endhint %}

```kusto
SCEPman_CL
| where Level == "Info" and Message startswith_cs "Issued a certificate with serial number"
| project Message, RequestBase = trim_end('/', replace_string(replace_regex(RequestUrl, "(/pkiclient\\.exe)?(\\?operation=PKIOperation(&message=.+)?)?", ""),"certsrv/mscep/mscep.dll","intune"))
| summarize IssuanceCount = count() by Endpoint = extract("/([a-zA-Z]+)$", 1, RequestBase)
```

Starting with SCEPman 2.8, there is always exactly one Info level log entry whose log message starts with "Issued a certificate with serial number " per issued certificate, followed by its serial number. However, due to the unsolvable [Two Armies Problem](https://en.wikipedia.org/wiki/Two_Generals'_Problem), it can happen that the created certificate never reaches the requester or some other type of error prevents the actual enrollment. Likewise, in case of severe errors, it can happen that a log entry exists without corresponding database entry or vice versa.

### Distinct Certificates with OCSP Check

```kusto
let map_certtype = datatable(serial_start:string, readable:string)
[
  "40", "Intune Device",
  "41", "Intune Device",
  "42", "Intune Incompliant Device",
  "50", "Static",
  "51", "Static",
  "60", "Intune User",
  "61", "Intune User",
  "64", "Jamf User",
  "65", "Jamf User",
  "6C", "Jamf User on Device",
  "6D", "Jamf User on Device",
  "70", "Domain Controller",
  "7C", "Jamf User on Computer",
  "7D", "Jamf User on Computer",
  "54", "Jamf Computer",
  "55", "Jamf Computer",
  "44", "Jamf Device",
  "45", "Jamf Device"
];
SCEPman_CL
| where LogCategory == "Scepman.Server.Controllers.OcspController" and Level == "Info"
| where Message startswith_cs "OCSP Response"
| project serial = extract("Serial Number ([A-F0-9]+)", 1, Message)
| distinct serial
| extend serial_start = substring(serial,0,2)
| join kind=leftouter map_certtype on serial_start
| summarize count() by (readable)
```
