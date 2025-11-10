---
description: >-
  Automatic certificate revocation in Microsoft Intune or Jamf Pro via OCSP
  using SCEPman.
---

# Revocation

SCEPman offers several ways to manage and revoke a certificate. The available options depend on

* whether the certificate was automatically enrolled via an MDM solution or whether it was generated via the [Certificate Master UI](../certificate-master/) / [Enrollment REST API](../api-certificates/),
* the MDM system that is used for (automatic) enrollment, and
* the configuration of SCEPman.

Below section provides an overview of the different management options and revocation mechanisms and under which circumstances they are available.

## Automatic Revocation

{% hint style="info" %}
Only available when **Microsoft Intune** and/or **Jamf Pro** are used as MDM solution(s) for certificate enrollment. Alternatively, it is available with any 3rd party MDM that is able to sync device and/or user objects with Microsoft Entra ID (Azure AD) (i.e. [Static AAD Validation](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md) can be used).
{% endhint %}

{% hint style="success" %}
Supported on **OCSP**.
{% endhint %}

### Background

Automatic revocation is **always active** and enables convenient certificate lifecycle management by linking each certificate to a directory object such as a user or device identity. Through this object binding mechanism, SCEPman can infer the revocation status based on certain lifecycle characteristics of the object is has been linked to. The mapping from the object's lifecycle state to the certificate's revocation state is implemented to match best practices from years of security and endpoint management experience.&#x20;

The binding between directory object (user or device) and certificate is established by introducing appropriate variables in the SCEP profile for the Subject Name or Subject Alternative Name properties. Upon receiving a Certificate Signing Request (CSR) from an MDM-managed client, SCEPman identifies the bound object and encodes this information into the serial number of the certificate before returning it to the client. It is the serial number that is transmitted to SCEPman's OCSP responder during certificate validation, allowing SCEPman to decode the object information, perform a search of the appropriate directory, and finally make a revocation status decision.

### Revocation Behavior

{% hint style="success" %}
In any of the below scenarios, revocation can be considered to be effective immediately, once the bound object's state has changed. Please note that local caching of OCSP responses on the client may suggest otherwise.
{% endhint %}

{% hint style="warning" %}
During testing, please consider that deleting/removing a device from the respective directory/MDM solution is an irreversible operation that will require you to re-enroll the device afterwards.
{% endhint %}

<table><thead><tr><th width="262">Bound Object</th><th>Delete from Directory</th><th>Disable in Directory</th><th>Optional </th></tr></thead><tbody><tr><td>Intune Device <code>{{DeviceId}}</code></td><td><strong>Delete</strong>, <a href="https://learn.microsoft.com/en-us/mem/intune/remote-actions/devices-wipe#wipe"><strong>Wipe</strong></a><strong>*</strong>, <a href="https://learn.microsoft.com/en-us/mem/intune/remote-actions/devices-wipe#retire"><strong>Retire</strong></a><strong>*</strong>: <em>permanent revocation</em></td><td>Not available</td><td><ul><li><a href="../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-compliancecheck"><strong>Intune Device Compliance</strong></a>: <em>reversible revocation</em></li><li><a href="https://docs.scepman.com/advanced-configuration/application-settings/intune-validation#appconfig-intunevalidation-devicedirectory"><strong>Endpoint List</strong></a>: <em>permanent revocation</em></li></ul></td></tr><tr><td>Entra (Azure AD) Device<br><code>{{AAD_Device_ID}}</code><br></td><td><strong>Delete</strong>: <em>permanent revocation</em></td><td><strong>Disable</strong>: <em>reversible revocation</em></td><td><ul><li><a href="../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-compliancecheck"><strong>Entra (Azure AD) Device Compliance</strong></a>: <em>reversible revocation</em></li><li><a href="https://docs.scepman.com/advanced-configuration/application-settings/intune-validation#appconfig-intunevalidation-devicedirectory"><strong>Endpoint List</strong></a>: <em>permanent revocation</em></li></ul></td></tr><tr><td>Entra (Azure AD) User<br><code>{{UserPrincipalName}}</code></td><td><strong>Delete</strong>: <em>permanent revocation</em></td><td><strong>Disable</strong>: <em>reversible revocation</em></td><td><ul><li><a href="../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-waitforsuccessnotificationresponse"><strong>User Risk</strong></a>: <em>reversible revocation</em></li><li><a href="https://docs.scepman.com/advanced-configuration/application-settings/intune-validation#appconfig-intunevalidation-devicedirectory"><strong>Endpoint List</strong></a>: <em>permanent revocation</em></li></ul></td></tr><tr><td><a href="../jamf/computers.md">Jamf Computer</a><br><code>CN=$JSSID,OU=computers</code></td><td><strong>Delete</strong>: <em>permanent revocation</em></td><td>Not available</td><td>Not available</td></tr><tr><td><a href="../jamf/devices.md">Jamf Device</a><br><code>CN=$JSSID,OU=devices</code></td><td><strong>Delete</strong>: <em>permanent revocation</em></td><td>Not available</td><td>Not available</td></tr><tr><td><a href="../jamf/users.md#user-certificates-on-computers">Jamf User on Computer</a><br><code>CN=$JSSID,OU=users-on-computers</code><br></td><td><ul><li><strong>Delete (Computer)</strong>: <em>permanent revocation</em></li><li><strong>Delete (User)</strong>: <em>permanent revocation</em></li></ul></td><td>Not available</td><td>Not available</td></tr><tr><td><a href="../jamf/users.md#user-certificates-on-devices">Jamf User on Device</a><br><code>CN=$JSSID,OU=users-on-devices</code></td><td><ul><li><strong>Delete (Device)</strong>: <em>permanent revocation</em></li><li><strong>Delete (User)</strong>: <em>permanent revocation</em></li></ul></td><td>Not available</td><td>Not available</td></tr></tbody></table>

\*: Ensure during wipe, that "Wipe device, but keep enrollment state and associated user account" is **disabled**. Revocation is only immediate if [AppConfig:IntuneValidation:RevokeCertificatesOnWipe](../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-revokecertificatesonwipe) is set to true (default).

## Manual Revocation

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.3** or above.
{% endhint %}

{% hint style="success" %}
Supported on **OCSP** and [**CRL**](../../scepman-configuration/application-settings/crl.md).
{% endhint %}

### Background

Manual revocation is available for any certificate issued by SCEPman - regardless of whether it was automatically enrolled via MDM, manually issued via the Certificate Master, or deployed via the Enrollment REST API. Manual revocation is useful when automatic revocation is not available or when automatic revocation paths are not sufficient to meet specific requirements.

To facilitate manual revocation, SCEPman needs to store certain metadata of the certificates it issues. While this is the case by default for certificates issued via the Certificate Master UI and the Enrollment REST API, it is not the case for other certificate types. Therefore, please ensure to review the [relevant settings](./#storing-certificate-metadata-in-the-certificate-database) depending on your requirements.&#x20;

Keep reading to learn how manual revocation is handled leveraging Certificate Master and its search and filtering options.

### Certificate Master

SCEPman Certificate Master lets you search, inspect, and manage the certificates that your SCEPman PKI has issued:

{% content-ref url="../certificate-master/manage-certificates.md" %}
[manage-certificates.md](../certificate-master/manage-certificates.md)
{% endcontent-ref %}

## Automatic versus Manual Revocation

SCEPman uses different sources of revocation information to determine whether a certificate is valid when an OCSP request arrives. Furthermore, SCEPman's revocation logic follows an **or-ed approach**, which means if any revocation source deems the certificate to be invalid, it will be reported as revoked. There is no precedence from automatic over manual revocation or vice versa.&#x20;

Please note, that the tables in Certificate Master only show the status of manual revocation and not other sources. Therefore, a certificate may be shown as valid in the table, although it is actually considered revoked, for example because the corresponding device was deleted in Intune (automatic revocation).&#x20;

## Further Reading

* Information on how to test (automatic) revocation and troubleshoot certificate validity in some of the above scenarios can be found [here](../../other/troubleshooting/general.md#problems-with-the-validity-of-certificates).
* General Information on Azure and M365 device directories can be found [here](../../scepman-configuration/device-directories.md).
