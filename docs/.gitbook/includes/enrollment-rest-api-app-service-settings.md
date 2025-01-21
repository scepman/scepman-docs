---
title: Enrollment REST API - App Service Settings
---

### Configuration

_Required for certificate renewal_

Configure your SCEPman App Service to accept mTLS client certificates. In the Configuration blade of the Settings section, verify that the Client certificate mode in Incoming client certificates is set to _**Optional**_.

<figure><img src="../assets/image (75).png" alt=""><figcaption></figcaption></figure>

Do not set the Client certificate mode to Require or Allow, as that would break normal operation of SCEPman on the SCEP endpoints!



### Environment Variables

In order to make use of this scenario, you must set the following Environment Variables on the SCEPman app service.

### [AppConfig:DbCSRValidation:Enabled](https://docs.scepman.com/advanced-configuration/application-settings/dbcsr-validation#appconfig-dbcsrvalidation-enabled)

_Required for certificate enrollment and renewal_

Set this variable to _**true**_ to enable the validation of certificate signing requests (CSRs).

### [AppConfig:DbCSRValidation:AllowRenewals](https://docs.scepman.com/advanced-configuration/application-settings/dbcsr-validation#appconfig-dbcsrvalidation-allowrenewals)

_Required for certificate renewal_

Set this variable to _**true**_ to enable certificate renewals.

### [AppConfig:DbCSRValidation:ReenrollmentAllowedCertificateTypes](https://docs.scepman.com/advanced-configuration/application-settings/dbcsr-validation#appconfig-dbcsrvalidation-reenrollmentallowedcertificatetypes)

_Required for certificate renewal_

Set this variable to a comma separated list of certificate types that you want to allow the renewal. See the linked variable documentation for a list of possible certificate types.

Example: _**Static,IntuneUser,IntuneDevice**_
