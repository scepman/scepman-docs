# Manage Certificates

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.3** or above.
{% endhint %}

SCEPman Certificate Master lets you search, inspect, and manage the certificates that your SCEPman PKI has issued. It uses two different databases as backend:

* A data table in the Azure Storage Account deployed with SCEPman, and
* Intune's database of issued certificates.

Depending on whether you enrolled a certificate via the Intune MDM or through other means (e.g. [manually with Certificate Master](../certificate-deployment/certificate-master/) or for [Domain Controllers](../certificate-deployment/domain-controller-certificates.md)), you should search in the one table or the other. You can reach both of them via the navigation bar on the left hand side of the Certificate Master web UI.

{% hint style="info" %}
It takes up to 6 hours after enrolling a certificate via Intune until it appears in the list of Intune certificates due to delays in the Intune API.
{% endhint %}

## Storing Certificate Metadata in the Certificate Database

SCEPman 2.3 and above allow storing certificates issued via one of the SCEP endpoints or via the REST endpoint in the Storage Account. This can be configured per endpoint:

* [Jamf](../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-enablecertificatestorage)
* [Static](../advanced-configuration/application-settings/static-validation.md#appconfig-staticvalidation-enablecertificatestorage)
* [Static-AAD](../advanced-configuration/application-settings/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage)
* [DC](../advanced-configuration/application-settings/dc-validation.md#appconfig-dcvalidation-enablecertificatestorage)

Only certificates issued after enabling this setting will be stored in the database, and can be found and revoked manually! Manual revocation is an addition to the automatic revocation feature of SCEPman. For example, if you enable certificate storage for Jamf, a certificate will become invalid if either the corresponding object in Jamf is deleted or if you manually revoke the certificate in Certificate Master.

## Search for Certificates in the Certificate Database

If you are in the Manage Certificates view in Certificate Master, you will see a table of certificates and some filtering options above the table.

Texts entered into the **Search Box** filters certificates with a full-text search in everything shown in the UI, e.g. the certificate serial number, thumbprint, Subject, Subject Alternative Names, and the original requester of the certificate.

For the remaining filters, there is the standard view that suits most use cases and allows quick and intuitive selection of filters. If you want to view a more specific set of certificates, you can enable the **advanced filter** to see additional filter options.

The **Type of certificate** filter is only visible when the advanced filter option is enabled. It allows to show certificates of specific types, which primarily determines to which type of MDM entity their validity is bound to:

* _Static_ certificate have no automatic revocation. These are certificates issued via the [Static SCEP Endpoint](../certificate-deployment/static-certificates/) or via [Certificate Master](../certificate-deployment/certificate-master/).
* [Domain Controllers](../certificate-deployment/domain-controller-certificates.md) receive certificates of type _DC_.
* _User_ certificates are bound to AAD or Jamf user objects. If these objects are disabled or deleted, or the AAD User Risk is too high, the corresponding certificate will become invalid.
* _Device_ certificatee are bound to AAD or Intune device objects or to Jamf computer or device objects. Deleting or disabling these objects automatically revokes these certificates. If enabled, certificates of this type also become temporarily revoked if the linked directory object get incompliant.

The **Validity status** filter lets you display only certificates whose ValidTo date lies in the past (_Expired_), that have been _revoked_ manually, or that are within its validity range and not manually revoked (_Valid_). Automatic revocation does not count for this filter, e.g. a device certificate whose device was deleted in AAD, but not manually revoked will show up only if you select Valid (or Any), although it is actually revoked and cannot be used.

{% hint style="info" %}
The _Revoked Intune Certificates_ table in Certificate Master is only relevant if you manually revoke Intune-issued certificates or if Intune has revoked the certificates, for example, due to a pending wipe or other conditions.

This table does not display the automatic revocation status based on our object binding mechanism.
{% endhint %}

You can also filter for the channel the the certificate was enrolled over with the filter **Source of the certificate request**. The specific settings have the following meanings.

* _Certificate Master_ comprised the certificates manually issued via the Certificate Master web UI.
* _REST_ are the certificates enrolled via the [SCEPman REST API](../certificate-deployment/api-certificates.md).
* _SCEP_ are all certificates issued over one of the SCEP endpoints, but only if the certificate storage has been enabled on this SCEP endpoint. It also includes certificates that have been enrolled over Intune AND manually revoked.
* _SCEP (Generic)_ are certificates enrolled via the SCEP endpoints Static, Static-AAD, and Domain Controller. This is and advanced filter and is selectable only when advanced filter is enabled.
* _SCEP (Jamf)_ are certificates enrolled via the Jamf MDM. This is and advanced filter and is selectable only when advanced filter is enabled.

## Manual versus Automatic Revocation

SCEPman uses different sources of revocation information to determine whether a certificate is valid when an OCSP request arrives. The tables in Certificate Master only show the status of manual revocation and not other sources. Therefore, a certificate may be shown as valid in the table, although it is actually considered revoked, for example because the corresponding device was deleted in Intune. These are the revocation options by type:

* **All** certificates can be revoked manually in Certificate Master.
* **User** certificates enrolled through the **Intune** or **Static-AAD** SCEP endpoints are revoked automatically if the corresponding user object is deleted or disabled in AAD.
* **User** certificates enrolled through the **Intune** or **Static-AAD** SCEP endpoints can be [revoked automatically if the sign-in risk of the user exceeds a configured threshold](../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationuserriskcheck).
* **Device** certificates with **AAD Device ID** enrolled through the **Intune** or **Static-AAD** SCEP endpoint are revoked automatically if the corresponding device object is deleted or disabled in AAD.
* **Device** certificates with **Intune Device ID** enrolled through the **Intune** or **Static-AAD** SCEP endpoint are revoked automatically if the corresponding device object is deleted in Intune or if the device is wiped or retired unless this is [unconfigured](../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationrevokecertificatesonwipe).
* **Device** certificates of any kind enrolled through the **Intune** or **Static-AAD** SCEP endpoint [can be revoked automatically if the corresponding device object becomes incompliant](../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationcompliancecheck).
* **User** and **Device** certificates enrolled through the **Intune** or **Static-AAD** SCEP endpoint [can be revoked automatically](../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationdevicedirectory) if [Intune decides to revoke](https://learn.microsoft.com/en-us/mem/intune/protect/remove-certificates) the certificate.
* **User**, **Device**, and **Computer** certificates enrolled through the **Jamf** SCEP endpoint are revoked automatically if the corresponding object is deleted in Jamf.
