# Static-AAD Validation

{% hint style="warning" %}
SCEPman Enterprise customers only
{% endhint %}

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).
{% endhint %}

## AppConfig:StaticAADValidation:Enabled

_Linux: AppConfig\_\_StaticAADValidation\_\_Enabled_

{% hint style="info" %}
Applicable to version 2.2 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates from Other MDM systems, similarly to the static endpoint, but the certificates' lifetimes are bound to AAD objects (users or devices). The certificate subject has to include an AAD device ID or the Subject Alternative Name must include a user's UPN, just like for Intune certificates.

* **True**: SCEPman listens at the additional SCEP server endpoint with the path `/static/aad`. Use in conjunction with [AppConfig:StaticAADValidation:RequestPassword](staticaad-validation.md#appconfig-staticaadvalidation-requestpassword).&#x20;
* **False** (default): SCEPman does not issue AAD-bound certificates for Other MDM systems.

## AppConfig:StaticAADValidation:DefaultEkus

_Linux: AppConfig\_\_StaticAADValidation\_\_DefaultEkus_

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** Oids of the extended key usages (EKUs) that are added to the certificate if the Static AAD endpoint is used. The Oids are separated by a comma, semicolon, or space. The default is Client Authentication (1.3.6.1.5.5.7.3.2)

**Description:** If a certificate request does not contain any EKUs, SCEPman adds the EKUs defined in this setting to the certificate. If [AppConfig:UseRequestedKeyUsages](../certificates.md#appconfig-userequestedkeyusages) is set to _false_, the EKUs defined in this setting will be added to the certificate even if the certificate request contains EKUs.

## AppConfig:StaticAADValidation:DefaultKeyUsage

_Linux: AppConfig\_\_StaticAADValidation\_\_DefaultKeyUsage_

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** EncipherOnly|CrlSign|KeyCertSign|KeyAgreement|DataEncipherment|_KeyEncipherment_|NonRepudiation|_DigitalSignature_|DecipherOnly (defaults are in _italic_)

**Description:** If a certificate request does not contain a Key Usage, SCEPman adds the Key Usage defined in this setting to the certificate. If [AppConfig:UseRequestedKeyUsages](../certificates.md#appconfig-userequestedkeyusages) is set to _false_, the Key Usage defined in this setting will be added to the certificate even if the certificate request contains a Key Usage.

## AppConfig:StaticAADValidation:RequestPassword

_Linux: AppConfig\_\_StaticAADValidation\_\_RequestPassword_

{% hint style="info" %}
Applicable to version 2.2 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that a Other MDM system must include in every SCEP request to acquire a certificate. Only used if [AppConfig:StaticAADValidation:Enabled](staticaad-validation.md#appconfig-staticaadvalidation-enabled) is set to _true_.

We recommend defining this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--StaticAADValidation--RequestPassword_.

## AppConfig:StaticAADValidation:ValidityPeriodDays

_Linux: AppConfig\_\_StaticAADValidation\_\_ValidityPeriodDays_

{% hint style="info" %}
Applicable to version 2.2 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global [ValidityPeriodDays](../certificates.md#appconfig-validityperioddays) for the Static-AAD endpoint.

## AppConfig:StaticAADValidation:EnableCertificateStorage

_Linux: AppConfig\_\_StaticAADValidation\_\_EnableCertificateStorage_

{% hint style="info" %}
Applicable to version 2.3 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the Static-AAD endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them manually. Additionally, certificates are revoked automatically if the corresponding AAD object is disabled or deleted. If set to _false_ or not set, SCEPman will not store issued certificates and the certificates are visible only in the logs or if the SCEP client stores them somewhere.
