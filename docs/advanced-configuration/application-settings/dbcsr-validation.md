# REST API

{% hint style="info" %}
Applicable to version 2.3.689 and above

SCEPman Enterprise Edition only
{% endhint %}

## AppConfig:DbCSRValidation:Enabled

**Value:** _true_ or _false_

**Description:** This is a REST API endpoint that custom scripts and processes can use. See [our article on how to use the REST API](../../certificate-deployment/api-certificates.md) for details.

## AppConfig:DbCSRValidation:ValidityPeriodDays

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the REST API endpoint. For example, you may define a value like 365 days here and set the global AppConfig:ValidityPeriodDays to 730. Then, certificates issued through the API will have one year validity, while certificates issued through other endpoints may be valid up to two years.

Additionally, you can include an extension in your PKCS#10 requests to enroll certificates with a specific individual validity that is lower than the one configured here.
