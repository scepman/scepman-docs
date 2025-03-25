# Windows Server

{% hint style="info" %}
Applicable to SCEPman version 2.9 and above
{% endhint %}

The cmdlet `Update-CertificateViaEST` (contained in the SCEPman powershell module) locates certificates issued by SCEPman in either the user or machine certificate stores and renews them using mTLS. Note that this cmdlet (unlike other parts of the powershell module) can only be used on Windows devices.&#x20;

### Parameters

This cmdlet has two parameter sets, `Direct`, which allows you to pass in a certificate directly and renew it, and `Search` which searches the My store for SCEPman issued certificates and renews them. The parameters included in these sets are detailed below:

#### Direct

<table><thead><tr><th width="270">Parameter</th><th width="107">Optional?</th><th>Description</th></tr></thead><tbody><tr><td><code>-AppServiceUrl</code></td><td>Yes</td><td>The URL of your SCEPman app service.</td></tr><tr><td><code>-Certificate</code></td><td>No</td><td>Certificate object that is to be renewed</td></tr></tbody></table>

Example command:

```powershell
 $cert = Get-Item -Path "Cert:\CurrentUser\My\1234567890ABCDEF1234567890ABCDEF12345678"
 Update-CertificateViaEST -AppServiceUrl "https://scepman.contoso.de/" -Certificate $cert
```

#### Search

<table><thead><tr><th width="270">Parameter</th><th width="107">Optional?</th><th>Description</th></tr></thead><tbody><tr><td><code>-AppServiceUrl</code></td><td>Yes</td><td>The URL of your SCEPman app service.</td></tr><tr><td>-<code>User</code> or <code>-Machine</code></td><td>No</td><td>Specifies whether you would like to renew certificates from the user or machine store. One of these must be specified. (note that to edit the machine store you must run the command as admin).</td></tr><tr><td><code>-FilterString</code></td><td>Yes</td><td>Will only renew certificates whose Subject field contains the filter string.</td></tr><tr><td><code>-ValidityThresholdDays</code></td><td>Yes</td><td>Will only renew certificates that are within this number of days of expiry (default value is 30).</td></tr><tr><td><code>-AllowInvalid</code></td><td>Yes</td><td>If specified, the cmdlet will also renew invalid (expired) certificates.</td></tr></tbody></table>

Example command:

```powershell
Update-CertificateViaEST -AppServiceUrl "https://scepman.contoso.de/" -User -ValidityThresholdDays 100 -FilterString "certificate"
```

