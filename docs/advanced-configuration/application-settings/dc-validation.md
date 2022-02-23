# DC Validation

## AppConfig:DCValidation:Enabled

{% hint style="info" %}
Applicable to version 1.6 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request Kerberos server certificates for your on-premises Domain Controllers. See [Domain Controller Certificates](../../certificate-deployment/other-1/domain-controller-certificates.md) for details.

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/dc`. Use in conjunction with AppConfig:DCValidation:RequestPassword. **False** (default): SCEPman does not issue certificates for Domain Controllers.

## AppConfig:DCValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.6 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _String_

**Description:** A challenge password that the Domain Controllers must include in every SCEP request to acquire a certificate. Only used if AppConfig:DCValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--DCValidation--RequestPassword_.

## AppConfig:DCValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Domain Controller endpoint. For example, you may define a low value like 10 days here and reduce the validity of Domain Controller certificates, while still having a long validity for your client certificates.
