# Certificate Master Connection

{% hint style="info" %}
Applicable to version 2.0 and above

SCEPman Enterprise Edition only
{% endhint %}

## AppConfig:CertificateStorage:TableStorageEndpoint

This defines which Table Storage Endpoint to use for checking manual certificate revocations. If you remove this setting, SCEPman will not use the database for revocation checks.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:CertMaster:URL

**Value:** The URL of your SCEPman Certificate Master App Service

**Description:** Your Certificate Master service is linked to on the SCEPman Homepage using the URL configured here. The SCEPman PowerShell module also uses this value during updates or re-configurations to link together SCEPman and its corresponding Certificate Master instance.

## AppConfig:DirectCSRValidation:Enabled

**Value:** _true_ or _false_

**Description:** This endpoint is required for the Certificate Master component. You must set this to _true_ to use Certificate Master. Only Certificate Master is allowed to submit requests via this endpoint.

## AppConfig:DirectCSRValidation:ValidityPeriodDays

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the CSR endpoint. For example, you may define a value like 365 days here and set the global AppConfig:ValidityPeriodDays to 730. Then, certificates issued through Certificate Master will have one year validity, while certificates issued through other endpoints may be valid up to two years.

Usually, though, you will not configure anything here and instead reduce the validity for other endpoints, because server certificates from internal PKIs usually have a longer validity then client certificates.