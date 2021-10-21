# Certificates

## AppConfig:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _Integer_

**Description:**\
The maximum number of days that an issued certificate is valid. By default, this setting is not available and the validity period is **200 days**. SCEPman never issues certificates with a longer validity than the value defined here. There are ways to reduce validity for specific certificates, though.

You can configure shorter validity periods in each SCEP profile in Intune as described in the [Microsoft documentation](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-scep-configure#modify-the-validity-period-of-the-certificate-template).

{% hint style="warning" %}
iOS and macOS devices ignore the configuration of the validity period via Intune. Therefore you need to configure this setting in SCEPman if you want to have shorter validity periods than 200 days for your iOS and macOS devices.
{% endhint %}

You can also configure shorter validity periods for each SCEP endpoint. These can never exceed the validity defined in this global setting, though!

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

**Default:** 10

**Description:** When SCEPman issues a certificate, it will not be valid exactly from the time of issuance, but already a few minutes earlier (default is 10). This is because the client's clock may run slower than SCEPman's and then assume that the certificate is not yet valid. Some platforms immediately discard invalid certificates, even if they became valid a few seconds later.

Starting with version 1.8, you can configure the number of minutes that certificates are pre-dated. If you have issues with clocks on clients running late, you may increase this value.

## AppConfig:UseRequestedKeyUsages

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** **True:** The Key Usage and Extended Key Usage extensions in the certificates are defined by the MDM solution.\
**False:** Key Usage is always Key Encipherment + Digital Signature. Extended Key Usage is always _Client Authentication_.

{% hint style="warning" %}
iOS devices do not support customized Extended Key Usages. Their certificates will always have _Client Authentication_ as Extended Key Usage.
{% endhint %}