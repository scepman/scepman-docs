# DC Validation

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).
{% endhint %}

## AppConfig:DCValidation:Enabled

_Linux: AppConfig\_\_DCValidation\_\_Enabled_

**Value:** _true_ or _false_ (default)

**Description:** This setting helps you to request Kerberos server certificates for your on-premises Domain Controllers. See [Domain Controller Certificates](../../../certificate-management/domain-controller-certificates.md) for details.

* **True**: SCEPman listens at the additional SCEP server endpoint with the path `/dc`. Use in conjunction with [AppConfig:DCValidation:RequestPassword](dc-validation.md#appconfig-dcvalidation-requestpassword).&#x20;
* **False** (default): SCEPman does not issue certificates for Domain Controllers.

## AppConfig:DCValidation:RequestPassword

_Linux: AppConfig\_\_DCValidation\_\_RequestPassword_

**Value:** _String_

**Description:** A challenge password that the Domain Controllers must include in every SCEP request to acquire a certificate. Only used if AppConfig:DCValidation:Enabled is set to _true_.

We recommend defining this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--DCValidation--RequestPassword_.

## AppConfig:DCValidation:ValidityPeriodDays

_Linux: AppConfig\_\_DCValidation\_\_ValidityPeriodDays_

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Domain Controller endpoint. For example, you may define a low value like 10 days here and reduce the validity of Domain Controller certificates, while still having a long validity for your client certificates.

## AppConfig:DCValidation:EnableCertificateStorage

_Linux: AppConfig\_\_DCValidation\_\_EnableCertificateStorage_

{% hint style="info" %}
Applicable to version 2.3 and above
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the DC endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them. If set to _false_, SCEPman will not store issued certificates and the certificates are visible only in the logs or if the SCEP client stores them somewhere. If this is not set, the behavior depends on the global setting [AppConfig:EnableCertificateStorage](../basics.md#appconfig-enablecertificatestorage).
