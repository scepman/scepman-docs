# Enrollment REST API

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](../../../advanced-configuration/application-settings/).

Applicable to version 2.3.689 and above

SCEPman Enterprise Edition only
{% endhint %}

## AppConfig:DbCSRValidation:Enabled

**Value:** _true_ or _false_ (default)

**Description:** This is a REST API endpoint that custom scripts and processes can use. See [our article on how to use the REST API](../../../certificate-deployment/api-certificates/) for details.

## AppConfig:DbCSRValidation:ValidityPeriodDays

**Value:** Positive Integer

**Description:** This setting further reduces the global ValidityPeriodDays for the REST API endpoint. For example, you may define a value like 365 days here and set the global AppConfig:ValidityPeriodDays to 730. Then, certificates issued through the API will have one year validity, while certificates issued through other endpoints may be valid up to two years.

Additionally, you can include an extension in your PKCS#10 requests to enroll certificates with a specific individual validity that is lower than the one configured here.

## AppConfig:DbCSRValidation:AllowRenewals

**Value:** _true_ or _false_ (default)

**Description:** This allows using the EST "simplereenroll" endpoint, enabling [certificate renewal using mTLS](https://docs.scepman.com/certificate-deployment/api-certificates/api-enrollment#id-2.-app-service-settings). It works only for certificate types added to AppConfig:DbCSRValidation:ReenrollmentAllowedCertificateTypes.

## AppConfig:DbCSRValidation:ReenrollmentAllowedCertificateTypes

**Value:** Comma-separated list of certificate types from this list:

* DomainController
* Static
* IntuneUser
* IntuneDevice
* JamfUser
* JamfUserWithDevice
* JamfUserWithComputer
* JamfDevice
* JamfComputer

**Description:** You can use the simplereenroll endpoint for certificates of the types specified in this setting. If you do not specifiy any value, it defaults to no types, i.e. you cannot use the simplereenroll endpoint.

For example, if you wanted to renew certificates issued manually through Certificate Master, you would specify `Static`. If you also want to renew Domain Controller certificates, you would specify `DomainController,Static`.
