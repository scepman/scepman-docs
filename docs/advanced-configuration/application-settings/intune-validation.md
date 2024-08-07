# Intune Validation

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](./).
{% endhint %}

## AppConfig:IntuneValidation:ComplianceCheck

{% hint style="warning" %}
**Experimental Setting** - Applicable to version 1.7 and above

SCEPman Enterprise Edition only

Before version 1.9, due to delayed compliance state evaluation during enrollment this feature breaks Windows Autopilot enrollment. After certificate deployment the immediately following OCSP check will return '**not valid**' during enrollment time and the Autopilot process will not succeed.

With version 1.9 and above, clients receive an "Ephemeral Bootstrap Certificate" during the enrollment phase that is later replaced with a regular client certificate, as soon as the client becomes compliant.

With version 2.5 and above, you can alternatively configure a grace period during which the device is always considered compliant with the setting ComplianceGracePeriodMinutes.
{% endhint %}

**Value:** _Always_ or _Never_ (default)

**Description:** When SCEPman receives an OCSP request, SCEPman can optionally check the device compliance state. When set to **Always** SCEPman will query the device compliance state and the OCSP result can only be GOOD if the device is also marked as compliant in Azure AD.

Setting this to **Never** will disable the compliance check.

## AppConfig:IntuneValidation:ComplianceGracePeriodMinutes

{% hint style="info" %}
Applicable to version 2.5 and above SCEPman Enterprise Edition only
{% endhint %}

**Value:** _Integer_ (default: 0)

**Description:** Immediately after enrollment, devices are often not yet compliant in Intune. This setting defines a grace period in minutes during which the device is considered compliant, even if it is not yet. If the device is not compliant after the grace period, the certificate is revoked. This prevents the problem of a Windows device that is just enrolling and needs to successfully complete the SCEP profile in order to finish Windows Autopilot enrollment, but will become compliant in Intune only some time later.

It is an alternative to using Ephemeral Bootstrap Certificates. If you configure any value above 0, SCEPman will never issue Ephemeral Bootstrap Certificates.

This setting is only effective if [ComplianceCheck](intune-validation.md#appconfig-intunevalidation-compliancecheck) is set to _Always_.

## AppConfig:IntuneValidation:DeviceDirectory

{% hint style="info" %}
Applicable to version 2.0 and above
{% endhint %}

**Value:** String

Available options:

* `AAD`\
  (default for SCEPman 2.0)
* `Intune`
* `AADAndIntune`
* `AADAndIntuneOpportunistic`\
  (default for SCEPman 2.1 or newer)
* `AADAndIntuneAndEndpointlist`\
  (available in SCEPman 2.2 and newer)

**Description:** Determines where to look up devices on OCSP requests for device certificates. The corresponding directory is queried for a device matching the device ID written to the certificate's subject CN field. The certificate is valid only if the device exists. For **`AAD`**, it must also be enabled (Intune doesn't support disabling devices). If the ComplianceCheck is activated, the device must also be compliant. If nothing is configured and for SCEPman 1.9 and before, `AAD` is used.

Hence, you must configure the Intune configuration profile for devices accordingly. \{{AAD\_Device\_ID\}} is the AAD device ID, while \{{DeviceID\}} is the Intune device ID.

For **`AADAndIntune`**, both directories are queried in parallel. In this case, it is sufficient that the device exists in one of the two directories. This setting enables migrating from one setting to the other when there are still valid certificates for both types of directories. It also supports cases where you configure platforms differently. It can also be used as a workaround for iOS or Android devices that receive an Intune ID instead of an AAD ID, because they are not fully AAD-joined at the time of certificate enrollment.

If you have upgraded from SCEPman 1.x to SCEPman 2.x and you are still using [an App Registration for SCEPman permissions](../../scepman-deployment/permissions/azure-app-registration.md), SCEPman lacks the permissions to query Intune for devices. Thus, you are limited to the `AAD` option. The option **`AADAndIntuneOpportunistic`** checks whether the permissions to query Intune have been granted to SCEPman. If they are there, this works like `AADAndIntune`. If they are not there, this behaves like `AAD`.

The value **`AADAndIntuneAndEndpointlist`** works just like `AADAndIntune`, but additionally queries [Intune's list of issued certificates](https://endpoint.microsoft.com/#view/Microsoft\_Intune\_DeviceSettings/DevicesMonitorMenu/\~/certificateReport). If Intune [triggered the revocation of a certificate](https://learn.microsoft.com/en-us/mem/intune/protect/remove-certificates#scep-certificates), this will make the certificate revoked in SCEPman.

{% embed url="https://www.youtube.com/watch?v=K0SK0BtoBUQ" %}
SCEPman 2.0: Certificate Validation
{% endembed %}

## AppConfig:IntuneValidation:RevokeCertificatesOnWipe

{% hint style="info" %}
Applicable to version 2.1 and above.
{% endhint %}

**Value:** _true_ (default) or _false_

**Description:** This setting extends validation of devices when using the Intune Device ID. If it is enabled, SCEPman evaluates the Management State property of an Intune Device when its device certificate is validated. If the state indicates one of the following values, the certificate is revoked:

* RetirePending
* RetireFailed
* WipePending
* WipeFailed
* Unhealthy
* DeletePending
* RetireIssued
* WipeIssued

Especially, this means that when an administrator triggers a Wipe or Retire for a device, the certificate will be revoked immediately. Even if the device is shutdown or offline and therefore the action cannot be performed on the device, the certificate is not valid anymore.

## AppConfig:IntuneValidation:UntoleratedUserRisks

{% hint style="warning" %}
**Experimental Setting** - Applicable to version 2.2 and above. Requires permission _IdentityRiskyUser.Read.All_ assigned by SCEPman PS module version 1.7 and above.

SCEPman Enterprise Edition only
{% endhint %}

**Value:** Comma-separated list of User Risk Levels, e.g. _Low_, _Medium_, _High_.

**Description:** This setting only has an effect if you set [UserRiskCheck](intune-validation.md#appconfig-intunevalidation-userriskcheck) to _Always_. Certificates of users with risk levels in this list will be considered invalid.

Example: You define `Medium,High` for this setting. A user has Risk Level _Low_. The user's certificate is valid and the certificate can be used to connect to the corporate VPN. Then, a risk event increases the User Risk Level to _Medium_. The user tries to connect to the VPN, but does not succeed, because the VPN Gateway checks the validity of the certificate in real-time and SCEPman responds that it is revoked.

## AppConfig:IntuneValidation:UserRiskCheck

{% hint style="warning" %}
**Experimental Setting** - Applicable to version 2.2 and above. Requires permission _IdentityRiskyUser.Read.All_ assigned by SCEPman PS module version 1.7 and above.

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _Always_ or _Never_ (default)

**Description:** When SCEPman receives an OCSP request for a certificate issued to an Intune user, SCEPman can optionally check the [user risk level](https://docs.microsoft.com/en-us/azure/active-directory/identity-protection/concept-identity-protection-risks#user-linked-detections). When set to **Always** SCEPman will query the user risk state and the OCSP result can only be GOOD if the user's risk is not in the list of [UntoleratedUserRisks](intune-validation.md#appconfig-intunevalidation-untolerateduserrisks).

Setting this to **Never** will disable the user risk check.

## AppConfig:IntuneValidation:WaitForSuccessNotificationResponse

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ (default) or _false_

**Description:** After a certificate was successfully issued, SCEPman sends a notification about the certificate to Intune. Microsoft recommends to wait for the response in its specification. However, some instances show long delays resulting in timeouts occasionally. Therefore **True** is the default.

Setting this to **False** makes SCEPman return the issued certificate before Intune answers to the notification. This is against the letters of the specification, but increases performance and avoids timeouts in instances where this issue arises.

## AppConfig:IntuneValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Intune endpoint.

## AppConfig:IntuneValidation:EnableCertificateStorage

{% hint style="info" %}
Applicable to version 2.7 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** When requesting certificates via the Intune endpoint, SCEPman stores those requested certificates in the Storage Account in Azure if this is set to _true_. This will make the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them manually. Additionally, certificates are revoked automatically when the associated Entra or Intune object goes into an invalid state as specified by the other settings (like being disabled or deleted). If set to _false_, SCEPman will not store issued certificates and the certificates are visible only in the logs or in the classic Intune view on Certificate Master or the Intune portal. If this is not set, the behavior depends on the global setting [AppConfig:EnableCertificateStorage](basics.md#appconfig-enablecertificatestorage).
