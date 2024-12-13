# OCSP

## AppConfig:OCSP:UseAuthorizedResponder

{% hint style="info" %}
Applicable to version 2.9 and above
{% endhint %}

**Value:** _true_ or _false_ (default)

**Description:** If this is set to _false_ or not set, the CA certificate will sign OCSP Responses. It is the simpler approach.

If it is set to _true_, SCEPman will dynamically issue an [Authorized Responder certificate](https://datatracker.ietf.org/doc/html/rfc6960#section-4.2.2.2) to sign OCSP Responses. This Authorized Responders has a short validity and a new certificate will be issued automatically whenever needed. The certificate along with its private key will be held in memory only, so there is no need for SCEPman administrators to manage the Authorized Responders certificate. This reduces the dependency on Key Vault, improving response times and availability, and is one method to avoid the [Key Vault throttling limit](https://learn.microsoft.com/en-us/azure/key-vault/general/service-limits) that might otherwise affect larger SCEPman installation (> \~50k users).

## AppConfig:OCSP:AuthorizedResponderValidityHours

{% hint style="info" %}
Applicable to version 2.9 and above
{% endhint %}

**Value:** Floating point value (_24.0_ as default)

**Description:** This is only applicable if you enable the Authorized OCSP Responder by setting UseAuthorizedResponder to _true_. This value determines the expiration date of the Authorized OCSP Responder certificate. By default, it expires one day after issuance. Note that due to the setting [AppConfig:ValidityClockSkewMinutes](../../scepman-configuration/optional/application-settings/certificates.md#appconfig-validityclockskewminutes), the issuance date is back-dated and therefore the actual validity is usually two days (one into the past, one into the future).

## AppConfig:OCSP:CacheTimeOutSecondsIfDeviceExists

**Value:** Integer (_600_ as default)

**Description:** This is the validity in seconds of OCSP Responses for valid certificates. Technically, an OCSP Response can be re-used within its validity if no [OCSP Nonce](https://datatracker.ietf.org/doc/html/rfc6960#section-4.4.1) is used, e.g. by a proxy or an internal SCEPman cache. On some systems like Windows, the OCSP Response is stored in a client cache for its validity period, and when checking for a certificate's validity, a new OCSP Request will only be send when there is no valid OCSP Response already in the cache.

Therefore, the value determines the maximum delay between a certificate revocation and when a system caching an OCSP response actually treats a certificate as revoked. A lower number might increase the number of OCSP requests and therefore the load on SCEPman.

## AppConfig:OCSP:CacheTimeOutSecondsIfDeviceIsDisabled

**Value:** Integer (_300_ as default)

**Description:** This is the validity in seconds of OCSP Responses for disabled certificates, i.e. that have the _On Hold_ revocation status. These certificate are revoked, but could become valid again. Examples are device certificates for devices that are disabled in Entra Id, or user certificates for [users with a high user risk score](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-userriskcheck).

The setting has no influence on permanently revoked certificates. Their OCSP response have long validities, as their revocation status cannot change anymore.

Therefore, the value determines the maximum delay between restoring a certificate's validity (e.g. by enabling a device in Entra ID) and effectively cancelling the revocation on a system caching an OCSP response.