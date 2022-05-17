# Intune Validation

## AppConfig:IntuneValidation:ComplianceCheck

{% hint style="warning" %}
**Experimental Setting** - Applicable to version 1.7 and above.

SCEPman Enterprise Edition only

Before version 1.9, due to delayed compliance state evaluation during enrollment this feature breaks Windows Autopilot enrollment. After certificate deployment the immediate following OCSP check will return '**not valid**' during enrollment time and the Autopilot process will not succeed.

With version 1.9 and above, clients receive an "Ephemeral Bootstrap Certificate" during the enrollment phase that is later replaced with a regular client certificate, as soon as the client becomes compliant.
{% endhint %}

**Value:** _Always_ or _Never_

**Description:** When SCEPman receives an OCSP request, SCEPman can optionally check the device compliance state. When set to **Always** SCEPman will query the device compliance state and the OCSP result can only be GOOD if the device is also marked as compliant in Azure AD.

Settting this to **Never** will disable the compliance check.

## AppConfig:IntuneValidation:DeviceDirectory

{% hint style="info" %}
Applicable to version 2.0 and above
{% endhint %}

**Value:** _AAD_ (default for SCEPman 2.0), _Intune_, _AADAndIntune_, or _ADDAndIntuneOpportunistic_ (applies to version 2.1 and above and default for these versions)

Determines where to look up devices on OCSP requests for device certificates. The corresponding directory is queried for a device matching the device ID written to the certificate's subject CN field. The certificate is valid only if the device exists. For _AAD_, it must also be enabled (Intune doesn't support disabling devices). If the ComplianceCheck is activated, the device must also be compliant. If nothing is configured and for SCEPman 1.9 and before, _AAD_ is used.

Hence, you must configure the Intune configuration profile for devices accordingly. \{{AAD\_Device\_ID\}} is the AAD device ID, while \{{DeviceID\}} is the Intune device ID.

For _AADAndIntune_, both directories are queried in parallel. In this case, it is sufficient that the device exists in one of the two directories. This setting enables migrating from one setting to the other when there are still valid certificates for both types of directories. It also supports cases where you configure platforms differently. It can also be used as a workaround for iOS or Android devices that receive an Intune ID instead of an AAD ID, because they are not fully AAD-joined at the time of certificate enrollment.

If you have upgraded from SCEPman 1.x to SCEPman 2.x and you are still using [an App Registration for SCEPman permissions](../../azure-app-registration.md), SCEPman lacks the permissions to query Intune for devices. Thus, you are limited to the _AAD_ option. The option _ADDAndIntuneOpportunistic_ checks whether the permissions to query Intune have been granted to SCEPman. If they are there, this works like _AADAndIntune_. If they are not there, this behaves like _AAD_.

{% embed url="https://www.youtube.com/watch?v=K0SK0BtoBUQ" %}
SCEPman 2.0: Certificate Validation
{% endembed %}

## AppConfig:IntuneValidation:WaitForSuccessNotificationResponse

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** After a certificate was successfully issued, SCEPman sends a notification about the certificate to Intune. Microsoft recommends to wait for the response in its specification. However, some instances show long delays resulting in timeouts occasionally. Therefore **True** is the default.

Setting this to **False** makes SCEPman return the issued certificate before Intune answers to the notification. This is against the letters of the specification, but increases performance and avoids timeouts in instances where this issue arises.

## AppConfig:IntuneValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Intune endpoint.
