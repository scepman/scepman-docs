# Basics

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](../../../advanced-configuration/application-settings/).
{% endhint %}

## AppConfig:AnonymousHomePageAccess

**Value:** _true_ or _false_

**Description:**\
When not configured or set to **true**, anyone on the internet knowing the app service's URL can access the SCEPman Homepage and see status information like the SCEPman version and whether SCEPman is up and running (except if you prevent this with a firewall). We consider this non-sensitive information, but if you want to hide it, set this to **false**. Then, the homepage is deactivated for browser access and this information is not visible anymore.

## AppConfig:BaseUrl

**Value:** _App Service Name_ or [https://customcname.domain.com](https://customcname.domain.com)

**Description:**\
This defines the public OCSP endpoint URL for the certificates. By default, the value contains the **App Service Name**. If you want to use a [Custom Domain](../custom-domain.md), you need to change this value.

## AppConfig:LicenseKey

**Value:** _empty_ **or** _license key_

**Description:**\
If you are using a trial deployment or the community edition this field leaves empty. After you purchased the Enterprise Edition you will receive a license key from us, then you can insert this key into this setting.

## AppConfig:RemoteDebug

**Value:** _true_ or _false_

**Description:**\
You can send Debug log information to a cloud-based monitoring solution of our company for support reasons. This can speed up support cases. You can activate and deactivate this feature by changing the value to **true** or **false**.

{% hint style="info" %}
Do not forget to restart SCEPman App Service after enabling and saving the setting.
{% endhint %}

## AppConfig:CertificateStorage:TableStorageEndpoint

This defines which Table Storage Endpoint to use for checking manual certificate revocations. If you remove this setting, SCEPman will not use the database for revocation checks.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:EnableCertificateStorage

{% hint style="info" %}
Applicable to version 2.8 and above
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_ and when this setting is not explictly overriden with _false_ for the specific endpoint. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them manually. Additionally, certificates are revoked automatically depending on the specific SCEP endpoint used for enrollment. If set to _false_ or not set, SCEPman will only store issued certificates for those endpoints where certificate storage has been explicitly enabled. If a certificate is not stored, they are visible only in the logs or if the SCEP client stores them somewhere.

## AppConfig:SCEPResponseEncryptionAlgorithm

The algorithm used to encrypt SCEP responses. Reasonable values include "2.16.840.1.101.3.4.1.42" for AES-256-CBC (the default) and "2.16.840.1.101.3.4.1.2" for AES-128-CBC.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## WEBSITE\_RUN\_FROM\_PACKAGE

This setting points to the Application Artifacts that will be loaded by starting the App Service.\
Please have a look at these instructions: [Application Artifacts](../../../advanced-configuration/application-artifacts.md#change-artifacts).
