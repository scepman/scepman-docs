# Renewal Script

{% hint style="warning" %}
SCEPman Enterprise Edition Only
{% endhint %}

With the help of the scripts in this article, you can utilise an endpoint in the SCEPman REST API to renew SCEPman-issued certificates using mTLS (mutual TLS). This endpoint creates an identical certificate to the one you have elected to renew, however with an expiry date `ValidityPeriod` days in the future (this will depend on your [configuration](https://docs.scepman.com/advanced-configuration/application-settings/certificates#appconfig-validityperioddays)).

### Prerequisites

In order to make use of this endpoint, you must set the following application settings on the SCEPman app service.

* [AppConfig:DbCSRValidation:Enabled](../../scepman-configuration/optional/application-settings/dbcsr-validation.md#appconfig-dbcsrvalidation-enabled) = true
* [AppConfig:DbCSRValidation:AllowRenewals](../../scepman-configuration/optional/application-settings/dbcsr-validation.md#appconfig-dbcsrvalidation-allowrenewals) = true
* [AppConfig:DbCSRValidation:ReenrollmentAllowedCertificateTypes](../../scepman-configuration/optional/application-settings/dbcsr-validation.md#appconfig-dbcsrvalidation-reenrollmentallowedcertificatetypes) = Static

Further, configure your SCEPman App Service to accept mTLS client certificates. In the Configuration blade of the Settings section, switch the Client certificate mode in Incoming client certificates from Ignore to Optional.

<figure><img src="../../.gitbook/assets/image (75).png" alt=""><figcaption></figcaption></figure>

Do not set the Client certificate mode to Require or Allow, as that would break normal operation of SCEPman on the SCEP endpoints!

## Bash Script (Linux)

The scripts can be found [here](https://github.com/scepman/csr-request/tree/dev-interactive/enroll-certificate).

These scripts were developed with the aim to facilitate automatic renewal of certificates with devices that lack MDM compatibility (particularly Linux devices). If this script were to be run regularly using Linux's Cron or Anacron utilities, it could allow for the automatic renewal of certificates on Linux devices.

### Considerations

* This script does not encrypt the generated keys (this requires passphrase input, so encryption has been omitted to allow for automatic renewal.)
* If you are renewing passphrase-protected certificates from Certificate Master, you will need to input this passphrase in order to renew them.

### Renewal script

This script will renew the specified certificate using mTLS if it exists.

#### Parameters

1. SCEPman instance URL
2. Certificate to be renewed (name of PEM encoded certificate file)
3. Private key of certificate to be renewed (name of PEM encoded key file)
4. Root certificate (name of PEM encoded certificate file)
5. Renewal threshold (# of days): certificate will only renew if expiring in this or less many days

#### Example command

```
sh renewcertificate.sh https://scepman.contoso.de/ cert.pem cert.key root.pem 10
```

### Enroll + Renewal script&#x20;

The enrollment and renewal script will create a certificate if one of the specified name doesn't exist in the specified directory, and if it does exist, will renew the specified certificate using mTLS.

#### Parameters

1. SCEPman instance URL
2. API scope of SCEPman-api app registration
3. Desired name of certificate
4. Directory where certificate is to be installed
5. Directory where private key is to be installed
6. Root certificate (name of PEM encoded certificate file)
7. Renewal threshold (# of days): certificate will only renew if expiring in this or less many days

#### Example command

```nasm
bash enrollcertificate.sh https://scepman.contoso.de/ api://123guid cert-name cert-directory key-directory root.pem
```

## Powershell Cmdlet (Windows)

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

