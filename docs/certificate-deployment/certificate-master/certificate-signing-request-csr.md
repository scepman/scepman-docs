# Certificate Signing Request (CSR)

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="info" %}
This feature requires version **2.0** or above
{% endhint %}

You can submit a Certificate Signing Request (CSR) in PKCS#10 or CMS format via the SCEPman Certificate Master Web UI. Certificate Master is enabled for all new installations of SCEPman 2.0 or newer. If you upgrade from SCEPman 1.x, you must [complete the post-installation configuration](../../scepman-deployment/permissions/post-installation-config.md) before you can use Certificate Master. For both fresh installations and upgrades, before you can access SCEPman Certificate Master, you need to [assign the permissions](../../scepman-deployment/permissions/post-installation-config.md#granting-the-rights-to-request-certificates-via-the-certificate-master-website) to the AAD account used for certificate submission.

Many appliances, web services, and tools offer the option to generate a key pair and a Certificate Signing Request (CSR). The CSR is similar to an X.509 certificate, but lacks the signature of a CA. It does contain a Subject and may contain X.509 extensions like Key Usages, Extended Key Usages, or Basic Constraints. A CA may modify or add any of these properties when issuing a certificate based on a CSR. As an alternative to the CSR, you may [generate a certificate including the private key ](tls-server-certificate-pkcs-12.md)with Certificate Master as well.

When submitting a CSR via SCEPman Certificate Master, the Subject is carried over as is to the certificate. The following extensions are carried over:

* Subject Alternative Names (SANs)
* Key Usage
* Extended Key Usage

SCEPman discards any other extensions from the CSR. Some extensions are added to every certificate like Basic Constraints (denoting that it is a leaf certificate), Authority Information Access (AIA), Authority Key Identifier, and Subject Key Identifier.

If you have a CSR at hand, navigate to **Submit CSR** in the SCEPman Certificate Master top menu. You can copy and paste the CSR in PEM format (i.e. text) into the text box, or drag and drop the CSR file in binary or PEM format into the grey area at the bottom. You may use the Browse link as well to select a CSR file in binary and PEM format. When using the text box, you have to hit the Submit button afterward to issue the certificate, while uploading a CSR file immediately issues the certificate. Your browser will download the certificate in DER-encoded format.

<figure><img src="../../.gitbook/assets/image (40).png" alt=""><figcaption><p>Certificate Master - Submit CSR</p></figcaption></figure>
