# Sub CA Certificate

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.4** or above
{% endhint %}

In some use cases, you may need to issue a Sub CA of SCEPman RootCA (e.g. for a firewall to inspect TLS traffic), in this form, you can manually generate a Sub CA with **Server Authentication** as EKU. The PKCS#12 file is encrypted with the password shown on the screen. You can import the PKCS#12 directly to the system where it is needed using the password.

{% hint style="success" %}
Be aware that once you navigate away from this page, the password will no longer be accessible.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (38).png" alt=""><figcaption><p>Certificate Master - New Sub CA Certificate</p></figcaption></figure>
