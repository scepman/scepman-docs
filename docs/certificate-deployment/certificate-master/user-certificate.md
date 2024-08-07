# User Certificate

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version 2.4 or above
{% endhint %}

You can manually generate X.509 user certificates including a private key via the SCEPman Certificate Master Web UI. Those certificates can be used in various certificate-based authentication (CBA) scenarios, for smart cards and email signatures. By default, generated certificates will have the EKU **Client Authentication** and a Subject Alternative Name (SAN) set to a UPN-type property where the value matches the UPN provided in the UI.

To generate a new User Certificate, navigate to **New User Certificate** in the SCEPman Certificate Master top menu. Enter a UPN for the certificate and select the required EKUs. Hit **Submit** and the browser will automatically download the certificate with the private key in PKCS#12/PFX format after the certificate is issued a few seconds later. The PKCS#12 file is encrypted with the password shown on the screen. You can import the PKCS#12 directly to the system where it is needed using the password.

{% hint style="success" %}
Be aware that once you navigate away from this page, the password will no longer be accessible.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (42).png" alt=""><figcaption><p>Certificate Master - New User Certificate</p></figcaption></figure>

## YubiKey

Perform below steps to enroll a smart card certificate to your YubiKey device.

### Checklist: Prerequisites

* [ ] _Mandatory_ - Access to Certificate Master and a suitable role (`Admin.Full` , `Request.All`,`Request.User`)
* [ ] _Mandatory_ - Access to a YubiKey device with a free smart card slot
* [ ] _Mandatory_ - YubiKey Manager is installed

### Steps

1. Open the Certificate Master web portal and click on the **+** icon
2. Select **New User Certificate**
3. Specify the **UPN** as per your requirements
4. Set the **Key Length** to **2048** bits (YubiKey currently does not support 4096-bit keys).
5. &#x20;Select **PKCS#12** as **Download file format**
6.  Select **Client Authentication** and **Smart card Logon** from the **Extended Key Usages**\


    <figure><img src="../../.gitbook/assets/image (10).png" alt=""><figcaption></figcaption></figure>
7. Before clicking **Submit**, ensure to take temporary note of the **Password** as it will be required when importing the certificate to the YubiKey.
8. Open the YubiKey Manager
9.  Navigate to **Applications** **>** **PIV** and click **Configure Certificates**\


    <figure><img src="../../.gitbook/assets/image (44).png" alt=""><figcaption></figcaption></figure>
10. Select **Authentication (Slot 9a)** and click **Import**
11. Upload the certificate that was previously generated from Certificate Master and provide the **Password**.
12. Set a **Management key** and click **OK**\


    <figure><img src="../../.gitbook/assets/image (45).png" alt=""><figcaption></figcaption></figure>
