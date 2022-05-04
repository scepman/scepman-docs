# TLS Server Certificate PKCS#12

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.1** or above.
{% endhint %}

You can manually generate an X.509 client certificates including a private key via the SCEPman Certificate Master Web UI.

This allows you to enroll certificates to smaller numbers of client devices that aren't managed in any MDM system. Generated certificates will have the Extended Key Usage extension Client Authentication and no Subject Alternative Name (SAN). Additionally, you can only generate 2048 bit RSA keys. RSA is supported by virtually all applications and [NIST considers 2048 bit as safe for authentication usage until 2030](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-57pt1r5.pdf).

Navigate to _New Client Certificate_ in the SCEPman Certificate Master top menu. Enter a Subject CN for the certificate. Hit _Submit_ once you have entered all domain names and the browser will automatically download the certificate with private key in PKCS#12/PFX format after the certificate was issued a few seconds later. The PKCS#12 file is encrypted with the password shown on the screen. You can import the PKCS#12 directly to the system where it is needed using the password.

Some systems can import a certificate with private key, but do not accept PKCS#12. You can convert the PKCS#12 file to other formats using standard tools like OpenSSL. For example, if your target system requires a PEM file with the certificate and private key, you may use this command:

```shell
openssl pkcs12 -in INFILE.p12 -out OUTFILE.crt
```
