# Certificates

For a general comparison of techniques to control certificate validity, have a look into [our blog article](https://www.glueckkanja-gab.com/blog/security/certificates/scepman/2023/05/certificate-revocation-en/).

## AppConfig:CRL:RequestToken

{% hint style="info" %}
Applicable to version 2.3 and above
{% endhint %}

**Value:** A secret string

**Description:** If you set this value to anything that is not an empty string, you can download a Certificate Revocation List (CRL) from SCEPman. The URL of the CRL is https://scepman.contoso.de/crl/{RequestToken}, where scepman.contoso.de is the domain of your SCEPman instance and {RequestToken} is the token configured here.

The CRL currently does not contain all revoked certificates. Thus, attackers possessing a revoked certificate who gain access to the CRL might use it to try and convince a party that their revoked certificate is actually not revoked, because it is not in the list. Therefore, you should treat the RequestToken as a secret and generally only enable this feature if you require it. You should use the CRL only where it is not possible to use the superior OCSP. Keep in mind that network equipment like proxies might log the URL of the CRL.

## AppConfig:CRL:Source

{% hint style="info" %}
Applicable to version 2.4 and above
{% endhint %}

**Value:** *None* (default) or *Storage*

**Description:** If you set this value to *None*, the generated CRL will contain no revoked certificates at all. If you set this value to *Storage*, the CRL will contain all manually revoked certificates that are stored in the Azure Storage.

Certificates that are automatically revoked via OCSP will not be included in the CRL. For example, if you disable a device, the device's certificate will be automatically revoked via OCSP. However, the certificate will not be included in the CRL.

## AppConfig:CRL:ValidityDays

**Value:** _Floating Point Number_

**Description:** The number of days that an issued CRL is valid. If nothing is configured, CRLs will be valid for **0.1 days** = 2.4 hours (SCEPman 2.4 and newer) or **30 days** (SCEPman 2.3).