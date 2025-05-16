# Device Certificate

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.1** or above
{% endhint %}

You can manually generate X.509 client certificates including a private key via the SCEPman Certificate Master Web UI.

This allows you to enroll certificates to smaller numbers of client devices that aren't managed in any MDM system. Generated certificates will have the EKU **Client Authentication** and no Subject Alternative Name (SAN).

### Issuing a Client Certificate

1. To generate a new Device Certificate, navigate to **Device** in the SCEPman Certificate Master menu.&#x20;
2. Enter a Subject CN for the certificate.&#x20;
3. Hit **Submit** and the browser will automatically download the certificate with the private key in PKCS#12/PFX format after the certificate is issued a few seconds later. The PKCS#12 file is encrypted with the password shown on the screen. You can import the PKCS#12 directly to the system where it is needed using the password.

{% hint style="warning" %}
Be aware that once you navigate away from this page, the password will no longer be accessible.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (87).png" alt=""><figcaption><p>Certificate Master - New Client Certificate</p></figcaption></figure>

Some systems can import a certificate with the private key, but do not accept PKCS#12. You can convert the PKCS#12 file to other formats using standard tools like OpenSSL. For example, if your target system requires a PEM file with the certificate and private key, you may use this command:

```shell
openssl pkcs12 -in INFILE.p12 -out OUTFILE.crt
```
