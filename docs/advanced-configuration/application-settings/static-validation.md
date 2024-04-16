# Static Validation

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](./).
{% endhint %}

## AppConfig:StaticValidation:Enabled

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates from [3rd-party MDM systems](../../certificate-deployment/static-certificates/) (i.e. other than Intune and JAMF).

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/static`. Use in conjunction with AppConfig:StaticValidation:RequestPassword. **False** (default): SCEPman does not issue certificates for 3rd-party MDM systems (i.e. other than Intune and JAMF).

## AppConfig:StaticValidation:DefaultEkus

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** Oids of the extended key usages (EKUs) that are added to the certificate if the Jamf endpoint is used. The Oids are separated by a comma, semicolon, or space. The default is Client Authentication (1.3.6.1.5.5.7.3.2)

**Description:** If a certificate request does not contain any EKUs, SCEPman adds the EKUs defined in this setting to the certificate. If AppConfig:UseRequestedKeyUsages is set to _false_, the EKUs defined in this setting will be added to the certificate even if the certificate request contains EKUs.

## AppConfig:StaticValidation:DefaultKeyUsage

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** EncipherOnly|CrlSign|KeyCertSign|KeyAgreement|DataEncipherment|*KeyEncipherment*|NonRepudiation|*DigitalSignature*|DecipherOnly (defaults are in *italic*)

**Description:** If a certificate request does not contain a Key Usage, SCEPman adds the Key Usage defined in this setting to the certificate. If AppConfig:UseRequestedKeyUsages is set to _false_, the Key Usage defined in this setting will be added to the certificate even if the certificate request contains a Key Usage.

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

## AppConfig:StaticValidation:EnableCertificateStorage

{% hint style="info" %}
Applicable to version 2.3 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the static endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them. If set to _false_, SCEPman will not store issued certificates and the certificates are visible only in the logs or if the SCEP client stores them somewhere. If this is not set, the behavior depends on the global setting AppConfig:EnableCertificateStorage.
