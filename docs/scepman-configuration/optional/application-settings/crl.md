# Certificates

## AppConfig:CRL:RequestToken

{% hint style="info" %}
Applicable to version 2.3.689 and above
{% endhint %}

**Value:** A secret string

**Description:** If you set this value to anything that is not an empty string, you can download a Certificate Revocation List (CRL) from SCEPman. The URL of the CRL is https://scepman.contoso.de/crl/{RequestToken}, where scepman.contoso.de is the domain of your SCEPman instance and {RequestToken} is the token configured here.

The CRL is currently empty with no revoked certificates. Thus, attackers possessing a revoked certificate who gain access to the CRL might use it to try and convince a party that their revoked certificate is actually not revoked, because it is not in the list. Therefore, you should treat the RequestToken as a secret and generally only enable this feature if you require it. You should use the CRL only where it is not possible to use the superior OCSP. Keep in mind that network equipment like proxies might log the URL of the CRL.

## AppConfig:CRL:ValidityDays

**Value:** _Integer_

**Description:** The number of days that an issued CRL is valid. By default, this setting is set to **30 days**.