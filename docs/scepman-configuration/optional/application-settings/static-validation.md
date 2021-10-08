# Static Validation

## AppConfig:StaticValidation:Enabled

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates from [3rd-party MDM systems](../../../certificate-deployment/other-1/static-certificates.md) \(i.e. other than Intune and JAMF\).

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/static`. Use in conjunction with AppConfig:StaticValidation:RequestPassword. **False** \(default\): SCEPman does not issue certificates for 3rd-party MDM systems \(i.e. other than Intune and JAMF\).

## AppConfig:StaticValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that a 3rd-party MDM system must include in every SCEP request to acquire a certificate. Only used if AppConfig:StaticValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--StaticValidation--RequestPassword_.

## AppConfig:StaticValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Static endpoint. For example, you may define a low value like 10 days here and reduce the validity of certificates issued over the static endpoint, while still having a long validity for your regular client certificates.



