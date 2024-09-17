# Renewal Script

We are currently in the process of developing scripts that utilise an endpoint in the SCEPman REST API to facilitate the renewal of SCEPman-issued certificates using mTLS (mutual TLS).

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

## Powershell Script (Windows)

Coming soon...
