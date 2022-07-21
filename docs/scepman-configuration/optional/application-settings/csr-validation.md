# CSR Validation

{% hint style="info" %}
Applicable to version 2.0 and above

SCEPman Enterprise Edition only
{% endhint %}

## AppConfig:DirectCSRValidation:Enabled

**Value:** _true_ or _false_

**Description:** This endpoint is required for the Certificate Master component. You must set this to _true_ to use Certificate Master. Only Certificate Master is allowed to submit requests via this endpoint.

## AppConfig:DirectCSRValidation:ValidityPeriodDays

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the CSR endpoint. For example, you may define a value like 365 days here and set the global AppConfig:ValidityPeriodDays to 730. Then, certificates issued through Certificate Master will have one year validity, while certificates issued through other endpoints may be valid up to two years.

Usually, though, you will not configure anything here and instead reduce the validity for other endpoints, because server certificates from internal PKIs usually have a longer validity then client certificates.