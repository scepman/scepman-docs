# Renewal Script

We are currently in the process of developing scripts that utilise an endpoint in the SCEPman REST API to facilitate the renewal of SCEPman-issued certificates using mTLS (mutual TLS). This endpoint creates an identical certificate to the one you have elected to renew, however with an expiry date `ValidityPeriod` days in the future (this will depend on your [configuration](https://docs.scepman.com/advanced-configuration/application-settings/certificates#appconfig-validityperioddays)).

### Prerequisites

In order to make use of this endpoint, you must set the following application settings on the SCEPman app service.

* [AppConfig:DbCSRValidation:Enabled](../../scepman-configuration/optional/application-settings/dbcsr-validation.md#appconfig-dbcsrvalidation-enabled) = true
* AppConfig:DbCSRValidation:AllowRenewals = true
* AppConfig:DbCSRValidation:ReenrollmentAllowedCertificateTypes = Static

Further, configure your SCEPman App Service to accept mTLS client certificates. In the Configuration blade of the Settings section, switch the Client certificate mode in Incoming client certificates from Ignore to Optional.

<figure><img src="../../.gitbook/assets/image (75).png" alt=""><figcaption></figcaption></figure>

Do not set the Client certificate mode to Require or Allow, as that would break normal operation of SCEPman on the SCEP endpoints!

## Bash Script (Linux)

The script can be found [here](https://github.com/scepman/csr-request/tree/dev-interactive/enroll-certificate).

This script was developed with the aim to facilitate automatic renewal of certificates with devices that lack MDM compatibility (particularly Linux devices). If this script were to be run regularly using Linux's Cron or Anacron utilities, it could allow for the automatic renewal of certificates on Linux devices.

### Considerations

* This script does not encrypt the generated keys (this requires passphrase input, so encryption has been omitted to allow for automatic renewal.)
* If you are renewing passphrase-protected certificates from Certificate Master, you will need to input this passphrase in order to renew them.

### Parameters for the script

1. SCEPman instance URL
2. Certificate to be renewed (name of PEM encoded certificate file)
3. Private key of certificate to be renewed (name of PEM encoded key file)
4. Root certificate (name of PEM encoded certificate file)
5. Renewal threshold (# of days): certificate will only renew if expiring in this or less many days

### Example command

```
sh renewcertificate.sh https://your-scepman-domain.net/ cert.pem cert.key root.pem 10
```

In order to facilitate automatic certificate renewal, you could use Linux's Cron utility to run this script regularly. This will cause the certificate to be renewed automatically once the current date is within the threshold number of days specified in the command. The below command will set up a cron job to run the command daily (if the system is powered on) and a cron job to run the command on reboot.

```
(crontab -l ; echo @daily /path/to/renewcertificate.sh https://your-scepman-domain.net/ /path/to/cert.pem /path/to/cert.key /path/to/root.pem 10 ; echo @reboot /path/to/renewcertificate.sh https://your-scepman-domain.net/ /path/to/cert.pem /path/to/cert.key /path/to/root.pem 10) | crontab -
```

Since commands run by Cron will not necessarily be run from the directory that the script/certificates are in, it is important to provide the absolute paths to the script/certificates.

## Powershell Cmdlet (Windows)

This [cmdlet ](https://github.com/scepman/scepclient/blob/ScriptESTRenewal/RenewSCEPmanCerts.ps1)(`RenewSCEPmanCerts`) locates certificates issued by SCEPman in either the user or machine certificate stores and renews them using mTLS.&#x20;

### Parameters

<table><thead><tr><th width="270">Parameter</th><th width="107">Optional?</th><th>Description</th></tr></thead><tbody><tr><td><code>-AppServiceUrl</code></td><td>No</td><td>The URL of your SCEPman app service.</td></tr><tr><td>-<code>User</code> or <code>-Machine</code></td><td>No</td><td>Specifies whether you would like to renew certificates from the user or machine store. One of these must be specified. (note that to edit the machine store you must run the command as admin).</td></tr><tr><td><code>-FilterString</code></td><td>Yes</td><td>Will only renew certificates whose Subject field contains the filter string.</td></tr><tr><td><code>-ValidityThresholdDays</code></td><td>Yes</td><td>Will only renew certificates that are within this number of days of expiry (default value is 30).</td></tr></tbody></table>

### Example command

```powershell
RenewSCEPmanCerts -AppServiceUrl "https://scepman-appservice.net/" -User -ValidityThresholdDays 100 -FilterString "certificate"
```

### Cmdlet for finding certificates

This cmdlet finds certificates using another cmdlet called `GetScepmanCerts` which takes the same parameters. You can make use of this cmdlet on its own to make sure you're finding the right certificates before renewing them. You can add the flag `-InformationAction Continue` so that this cmdlet will print the relevant information about these certificates to the output stream.
