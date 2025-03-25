# Certificates

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [Application Settings](./).
{% endhint %}

## AppConfig:AddMicrosoftAADExtensions

{% hint style="info" %}
Applicable to version 2.0 and above
{% endhint %}

**Value:** _true_ (default) or _false_

**Description:** Shall certificates have the extensions 1.2.840.113556.5.14 (AAD Tenant ID) and 1.2.840.113556.1.5.284.2 (AAD Device ID)?

## AppConfig:AddSidExtension

{% hint style="info" %}
Applicable to version 2.5 and above
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** This setting determines whether certificates can have the extension 1.3.6.1.4.1.311.25.2 (user's Security Identifier (SID)). This extension is required to mitigate [Certifried attacks](../../other/troubleshooting/certifried.md) if certificates are used for on-prem AD user authentication.

If this is set to false, SCEPman will never issue certificates with this extension. If this is set to true, SCEPman may issue certificates with this extension in two cases:

First, when enrolling user certificates via Intune and the user's AAD object contains a SID in the attribute _OnPremisesSecurityIdentifier_. If the user's AAD object does not contain a SID, for example if it is a cloud-only user, SCEPman will not issue a certificate with this extension. The same applies to the [static-aad endpoint](scep-endpoints/staticaad-validation.md).

Second, when enrolling user certificates through other SCEP endpoints and the CSR already contains the extension. Examples are the Static SCEP endpoint and manual certificate requests through Certificate Master.

## AppConfig:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _Integer_

**Description:**\
The maximum number of days that an issued certificate is valid. By default, this setting is set to **730 days**. If the setting is not available (older installations of SCEPman) the validity period is **200 days**. SCEPman never issues certificates with a longer validity than the value defined here. There are ways to reduce validity for specific certificates, though.

You can configure shorter validity periods in each SCEP profile in Intune as described in the [Microsoft documentation](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-scep-configure#modify-the-validity-period-of-the-certificate-template).

{% hint style="warning" %}
iOS/iPadOS and macOS devices ignore the configuration of the validity period via Intune. Therefore you need to configure this setting in SCEPman if you want to have another validity periods than 200 days for your iOS/iPadOS and macOS devices. Please read [ios.md](../../certificate-management/microsoft-intune/ios.md "mention") for further details where we recommend an higher value.
{% endhint %}

You can also configure **shorter** validity periods for each SCEP endpoint. By default, the following values are set for each endpoint:

| Endpoint           | Parameter                                     | Validity in days     |
| ------------------ | --------------------------------------------- | -------------------- |
| Intune             | AppConfig:IntuneValidation:ValidityPeriodDays | 365                  |
| Jamf               | \<Not set>                                    | 730 (global setting) |
| Static             | \<Not set>                                    | 730 (global setting) |
| Certificate Master | \<Not set>                                    | 730 (global setting) |

Below image depicts how SCEPman limits the certificate validity period; first on a per-endpoint level and globally afterwards.

<figure><img src="../../.gitbook/assets/SCEPman Certificate Validity.jpg" alt=""><figcaption></figcaption></figure>

## AppConfig:ConcurrentSCEPRequestLimit

{% hint style="info" %}
Applicable to version 1.8 and above
{% endhint %}

**Value:** Positive _Integer_

**Default:** 50

**Description:** When more SCEP requests arrive at SCEPman, it takes longer for each request to finish. At high request frequencies, e.g. immediately after assigning a SCEP configuration profile to a large number of devices, processing the requests may take so long that the requests time out. The clients will retry their failed requests, which may keep the request frequency above the critical overload level.

With this setting, SCEPman will work only on this number of SCEP requests in parallel. If there are more requests, SCEPman returns HTTP 329 (Too Many Requests). Intune-based clients will retry certificate issuance again later in this case, so usually no request is lost. This ensures that SCEPman can finish requests on time and has a chance to work off the queue.

The optimal setting depends on the performance of the App Service Plan. As a rule of thumb, 12 is a good limit for a single instance on an S1 App Service Plan. Note that setting a too low value may prevent automatic out-scaling, as it may reduce resource usage to a value below the thresholds.

## AppConfig:ValidityClockSkewMinutes

{% hint style="info" %}
Applicable to version 1.8 and above
{% endhint %}

**Value:** Positive _Integer_

**Default:** 1440

**Description:** When SCEPman issues a certificate, it will not be valid exactly from the time of issuance, but already a few minutes earlier (default is 10). This is because the client's clock may run slower than SCEPman's and then assume that the certificate is not yet valid. Some platforms immediately discard invalid certificates, even if they became valid a few seconds later.

Starting with version 1.8, you can configure the number of minutes that certificates are pre-dated. If you have issues with clocks on clients running late, you may increase this value.

## AppConfig:UseRequestedKeyUsages

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** Shall certificates have the Key Usage and Extended Key Usage (EKU) extensions filled as requested or shall SCEPman define them?

**True:** The Key Usage and Extended Key Usage extensions in the certificates are defined by the MDM solution.\
**False:** Key Usage is always _Key Encipherment_ + _Digital Signature_. Extended Key Usage is always _Client Authentication_.

{% hint style="warning" %}
iOS/iPadOS devices do not support customized Extended Key Usages (even if configured in the Intune profile and [#appconfig-userequestedkeyusages](certificates.md#appconfig-userequestedkeyusages "mention") set to **True**). So, their certificates will always have _Client Authentication_ as Extended Key Usage.
{% endhint %}
