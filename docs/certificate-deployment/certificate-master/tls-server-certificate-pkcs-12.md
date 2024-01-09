# TLS Server Certificate

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.0** or above
{% endhint %}

You can generate X.509 server certificates including a private key via the SCEPman Certificate Master Web UI. This option allows you to easily generate a TLS certificate for multiple domain names. These certificates can then be used for web servers to enable communication via HTTPS or directory servers to enable LDAPS. Furthermore, they can be used on Active Directory Domain Controllers, but for Domain Controllers, you also have the option to issue special [Domain Controller Certificates](../domain-controller-certificates.md), which in turn can be used for LDAPS.

To issue a new server certificate, navigate to **New Server Certificate** in the SCEPman Certificate Master top menu. Enter all Fully Qualified Domain Names (FQDNs) that the certificate shall be valid for separated by commas, semicolons, or line breaks. These entries will be added as DNS entries to the Subject Alternative Names extension of the certificate. Hit **Submit** once you have entered all domain names and the browser will automatically download the certificate with the private key in PKCS#12/PFX format after the certificate was issued a few seconds later. The PKCS#12 file is encrypted with the password shown on the screen. You can import the PKCS#12 directly to the system where it is needed using the password.

Optionally, for mutual authentication scenarios (e.g. mTLS), you can select to include the **Client Authentikation** EKU in the certificate.

{% hint style="success" %}
Be aware that once you navigate away from this page, the password will no longer be accessible.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (34).png" alt=""><figcaption><p>Certificate Master - New Server Certificate</p></figcaption></figure>

Some systems can import a certificate with the private key, but do not accept PKCS#12. You can convert the PKCS#12 file to other formats using standard tools like OpenSSL. For example, if your target system requires a PEM file with the certificate and private key, you may use this command:

```shell
openssl pkcs12 -in INFILE.p12 -out OUTFILE.crt
```
