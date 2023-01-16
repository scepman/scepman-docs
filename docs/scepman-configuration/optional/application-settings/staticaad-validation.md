# Static Validation

## AppConfig:StaticAADValidation:Enabled

{% hint style="info" %}
Applicable to version 2.2 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates from 3rd-party MDM systems, similarly to the static endpoint, but the certificates' lifetimes are bound to AAD objects (users or devices). The certificate subject has to include an AAD device ID or the Subject Alternative Name must include a user's UPN, just like for Intune certificates.

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/static/aad`. Use in conjunction with AppConfig:StaticAADValidation:RequestPassword. **False** (default): SCEPman does not issue AAD-bound certificates for 3rd-party MDM systems.

## AppConfig:StaticAADValidation:RequestPassword

{% hint style="info" %}
Applicable to version 2.2 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that a 3rd-party MDM system must include in every SCEP request to acquire a certificate. Only used if AppConfig:StaticAADValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--StaticAADValidation--RequestPassword_.

## AppConfig:StaticAADValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 2.2 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the StaticAAD endpoint.

## AppConfig:StaticAADValidation:EnableCertificateStorage

{% hint style="info" %}
Applicable to version 2.3 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the StaticAAD endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them manually. Additionally, certificates are revoked automatically if the corresponding AAD object is disabled or deleted. If set to _false_ or not set, SCEPman will not be store issued certificates and the certificates are visible only in the logs or if the SCEP client stores them somewhere.