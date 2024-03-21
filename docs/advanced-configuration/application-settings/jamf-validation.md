# Jamf Validation

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](./).
{% endhint %}

## AppConfig:JamfValidation:Enabled

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates via the [Jamf](https://github.com/scepman/scepman-docs/tree/6358a93fe3c35dd51ae9501a385049ad1c8feb0b/docs/certificate-deployment/jamf/general.md) MDM system.

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/jamf`. Use in conjunction with AppConfig:JamfValidation:RequestPassword. **False** (default): SCEPman does not issue certificates for Jamf.

## AppConfig:JamfValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password (max 32 characters) that Jamf must include in every SCEP request to acquire a certificate. Only used if AppConfig:JamfValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--JamfValidation--RequestPassword_.

## AppConfig:JamfValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Jamf endpoint.

## AppConfig:JamfValidation:URL

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** The root URL of your Jamf instance. If you use Jamf Cloud, this will probably look like `https://your-instance.jamfcloud.com/`.

## AppConfig:JamfValidation:APIUsername

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** The name of a service account in Jamf that SCEPman uses to authenticate on your Jamf instance. SCEPman needs the following permissions to query for computers, devices, and users:

* Computers -> Read
* Mobile Devices -> Read
* Users -> Read

## AppConfig:JamfValidation:APIPassword

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** The password of the service account configured in AppConfig:JamfValidation:APIUsername.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--JamfValidation--APIPassword_.

{% hint style="info" %}
If you set this setting as a Secret in the Key Vault, you do not need to add the **AppConfig:JamfValidation:APIPassword** to SCEPman configuration anymore.
{% endhint %}

## AppConfig:JamfValidation:EnableCertificateStorage

{% hint style="info" %}
Applicable to version 2.3 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the Jamf endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them manually. Additionally, certificates are revoked automatically if the corresponding Jamf object is deleted. If set to _false_ or not set, SCEPman will not store issued certificates and the certificates are visible only in the logs or if the SCEP client stores them somewhere.
