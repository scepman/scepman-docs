# Static Validation

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).
{% endhint %}

## AppConfig:StaticValidation:Enabled

_Linux: AppConfig\_\_StaticValidation\_\_Enabled_

**Value:** _true_ or _false_ (default)

**Description:** This setting helps you to request certificates from [Other MDM systems](../../../certificate-management/static-certificates/) (i.e. other than Intune and JAMF).

* **True**: SCEPman listens at the additional SCEP server endpoint with the path `/static`. Use in conjunction with AppConfig:StaticValidation:RequestPassword.&#x20;
* **False** (default): SCEPman does not issue certificates for Other MDM systems (i.e. other than Intune and JAMF).

## AppConfig:StaticValidation:DefaultEkus

_Linux: AppConfig\_\_StaticValidation\_\_DefaultEkus_

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** Oids of the extended key usages (EKUs) that are added to the certificate if the Static endpoint is used. The Oids are separated by a comma, semicolon, or space. The default is Client Authentication (1.3.6.1.5.5.7.3.2)

**Description:** If a certificate request does not contain any EKUs, SCEPman adds the EKUs defined in this setting to the certificate. If [AppConfig:UseRequestedKeyUsages](../certificates.md#appconfig-userequestedkeyusages) is set to _false_, the EKUs defined in this setting will be added to the certificate even if the certificate request contains EKUs.

## AppConfig:StaticValidation:DefaultKeyUsage

_Linux: AppConfig\_\_StaticValidation\_\_DefaultKeyUsage_

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** EncipherOnly|CrlSign|KeyCertSign|KeyAgreement|DataEncipherment|_KeyEncipherment_|NonRepudiation|_DigitalSignature_|DecipherOnly (defaults are in _italic_)

**Description:** If a certificate request does not contain a Key Usage, SCEPman adds the Key Usage defined in this setting to the certificate. If [AppConfig:UseRequestedKeyUsages](../certificates.md#appconfig-userequestedkeyusages) is set to _false_, the Key Usage defined in this setting will be added to the certificate even if the certificate request contains a Key Usage.

## AppConfig:StaticValidation:RequestPassword

_Linux: AppConfig\_\_StaticValidation\_\_RequestPassword_

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that Other MDM system must include in every SCEP request to acquire a certificate. Only used if [AppConfig:StaticValidation:Enabled](static-validation.md#appconfig-staticvalidation-enabled) is set to _true_.

We recommend defining this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--StaticValidation--RequestPassword_.

## AppConfig:StaticValidation:ValidityPeriodDays

_Linux: AppConfig:StaticValidation:ValidityPeriodDays_

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global [ValidityPeriodDays](../certificates.md#appconfig-validityperioddays) for the Static endpoint. For example, you may define a low value like 10 days here and reduce the validity of certificates issued over the static endpoint, while still having a long validity for your regular client certificates.

## AppConfig:StaticValidation:EnableCertificateStorage

_Linux: AppConfig\_\_StaticValidation\_\_EnableCertificateStorage_

{% hint style="info" %}
Applicable to version 2.3 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the static endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them. If set to _false_, SCEPman will not store issued certificates and the certificates are visible only in the logs or if the SCEP client stores them somewhere. If this is not set, the behavior depends on the global setting [AppConfig:EnableCertificateStorage](../basics.md#appconfig-enablecertificatestorage).

## AppConfig:StaticValidation:AllowRenewals <a href="#appconfig-dbcsrvalidation-allowrenewals" id="appconfig-dbcsrvalidation-allowrenewals"></a>

**Value:** _true_ or _false_ (default)

**Description:** This allows using the _RenewalReq_ operation on this SCEP endpoint. It works only for certificate types added to _AppConfig:StaticValidation:ReenrollmentAllowedCertificateTypes_.

This operation can be used with the [SCEPmanClient ](https://github.com/scepman/scepmanclient)PowerShell module.

## AppConfig:StaticValidation:ReenrollmentAllowedCertificateTypes <a href="#appconfig-dbcsrvalidation-reenrollmentallowedcertificatetypes" id="appconfig-dbcsrvalidation-reenrollmentallowedcertificatetypes"></a>

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

**Description:** You can use the SCEP endpoint for renewals of certificates of the types specified in this setting. If you do not specify any value, it defaults to no types.

For example, if you wanted to renew certificates issued manually through Certificate Master, you would specify `Static`. If you also want to renew Domain Controller certificates, you would specify `DomainController,Static`.
