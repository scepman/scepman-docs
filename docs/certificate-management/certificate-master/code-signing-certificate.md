# Code Signing Certificate

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version 2.4 or above
{% endhint %}

You can manually generate X.509 code signing certificates including a private key via the SCEPman Certificate Master Web UI.

This form will generate a code signing certificate based on the provided information and download it in the selected file format. The certificate can be used for code signing purposes, ensuring the integrity and authenticity of software or code by associating it with a trusted entity.&#x20;

To generate a new Code Signing Certificate, navigate to **New code signing Certificate** in the SCEPman Certificate Master top menu. Enter a Subject CN for the certificate. Hit **Submit** and the browser will automatically download the certificate with the private key in PKCS#12/PFX format after the certificate is issued a few seconds later. The PKCS#12 file is encrypted with the password shown on the screen.&#x20;

{% hint style="success" %}
Be aware that once you navigate away from this page, the password will no longer be accessible.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (37).png" alt=""><figcaption><p>Certificate Master - New Code Signing Certificate</p></figcaption></figure>
