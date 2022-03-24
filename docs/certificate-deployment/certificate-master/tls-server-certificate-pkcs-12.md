# TLS Server Certificate PKCS#12

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.0** or above.
{% endhint %}

You can generate an X.509 certificate including a private key via the SCEPman Certificate Master Web UI. Certificate Master is enabled for all new installations of SCEPman 2.0 or newer. If you upgrade from SCEPman 1.x, you must [complete the post-installation configuration](../../scepman-configuration/post-installation-config.md) before you can use Certificate Master. For both fresh installations and upgrades, before you can access SCEPman Certificate Master, you need to [assign the permissions](../../scepman-configuration/post-installation-config.md#granting-the-rights-to-request-certificates-via-the-certificate-master-website) to the AAD account used for certificate submission.

This option allows you to easily generate a TLS Server Certificate for multiple domain names.

SCEPman 2.0 allows only the generation of TLS Server Certificates using this method, i.e. certificates with Extended Key Usage extension Server Authentication. Additionally, you can only generate 2048 bit RSA keys. RSA is supported by virtually all applications and [NIST considers 2048 bit as safe for authentication usage until 2030](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf).

Navigate to _New Certificate_ in the SCEPman Certificate Master top menu. Enter all Fully Qualified Domain Names (FQDNs) that the certificate shall be valid for separated by commas, semicolons, or line breaks. These entries will be added as DNS entries to the Subject Alternative Names extension of the certificate. Hit _Submit_ once you have entered all domain names and the browser will automatically download the certificate with private key in PKCS#12/PFX format after the certificate was issued a few seconds later. The PKCS#12 file is encrypted with the password shown on the screen. You can import the PKCS#12 directly to the system where it is needed using the password.

Some systems can import a certificate with private key, but do not accept PKCS#12. You can convert the PKCS#12 file to other formats using standard tools like OpenSSL. For example, if your target system requires a PEM file with the certificate and private key, you may use this command:

```shell
openssl pkcs12 -in INFILE.p12 -out OUTFILE.crt
```
