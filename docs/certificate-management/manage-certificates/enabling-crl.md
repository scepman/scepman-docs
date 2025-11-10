---
description: >-
  A Certificate Revocation List (CRL) is a record that contains certificates
  that have been explicitly revoked.
---

# Enabling CRL

{% hint style="danger" %}
You do **NOT** need to enable CRL for SCEPman. By default, SCEPman uses OCSP for revocation.
{% endhint %}

SCEPman primarily relies on OCSP to check a certificates' revocation status as OCSP allows for real time revocation, making it the ideal protocol for dynamic working environments. In contrast, CRL operates on scheduled updates, limiting its effectiveness in time-sensitive scenarios.

However, CRL continues to be useful for legacy systems and application or as a fallback when OCSP is not available.

{% hint style="warning" %}
The CRL will not contain certificates that have been auto-revoked, only certificates that have been explicitly revoked in the Certificate Master
{% endhint %}

{% stepper %}
{% step %}
### Navigate to your Environment Variables

Azure > App Services > SCEPman App Service (not Certificate Master) > Settings > Environment Variables

<figure><img src="../../.gitbook/assets/image (107).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Add Environment Variables&#x20;

Add the following Environment Variables:

<table><thead><tr><th width="247">Setting</th><th width="291">Description</th><th>Value</th></tr></thead><tbody><tr><td><a href="../../scepman-configuration/application-settings/crl.md#appconfig-crl-requesttoken">AppConfig:CRL:RequestToken</a></td><td><p>Defines the URL of the CRL. The CRL is available in both DER and PEM</p><p><br><strong>DER</strong>: https://<em>yourscepman</em>.azurewebsites.net/crl/<strong>{RequestToken}</strong></p><p></p><p><strong>PEM:</strong> https://yourscepman.azurewebsites.net/crl/pem/<strong>{RequestToken}</strong><br><br>Example: https://<em>yourscepman</em>.azurewebsites.net/crl/12345678</p></td><td>24 character <em>string</em></td></tr><tr><td><a href="../../scepman-configuration/application-settings/crl.md#appconfig-crl-source">AppConfig:CRL:Source</a></td><td>Connects the CRL to your Azure Storage account</td><td>Storage</td></tr><tr><td><a href="../../scepman-configuration/application-settings/crl.md#appconfig-crl-addcdp">AppConfig:CRL:AddCdp</a></td><td>Adds a CRL Distribution Point to issued certificates</td><td>true</td></tr><tr><td><a href="../../scepman-configuration/application-settings/crl.md#appconfig-crl-validitydays">AppConfig:CRL:ValidityDays</a></td><td>The numbers of days that an issued CRL is valid</td><td><em>Floating Point</em><br>Example <em>0.1</em> days = 2.4 hours</td></tr></tbody></table>

<figure><img src="../../.gitbook/assets/image (105).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Apply Environment Variables

Press Apply after Environment Variables have been added.&#x20;

<figure><img src="../../.gitbook/assets/image (106).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../../.gitbook/assets/image (108).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Restart SCEPman App Service

New Environment Variables are applied after the SCEPman App Service is restarted

<figure><img src="../../.gitbook/assets/image (109).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Test CRL

Navigate to your CRL using the previously set Request Token in the format of https://_yourscepman_.azurewebsites.net/crl/**{RequestToken}**

<figure><img src="../../.gitbook/assets/image (110).png" alt=""><figcaption></figcaption></figure>

If setup correctly, your CRL will be downloaded:

<figure><img src="../../.gitbook/assets/image (111).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Use CRL with Applications or Systems

Once enabled, ensure your applications or systems are configured to check the CRL during certificate validation to prevent the use of revoked certificates. Some systems allow CRL as a fallback option in the case OCSP is unavailable

Other systems **only** allow CRL for revocation such as CBA for Entra, please see our guide here:&#x20;

{% content-ref url="../../scepman-deployment/deployment-guides/scenarios/certificate-based-authentication-for-entra-id.md" %}
[certificate-based-authentication-for-entra-id.md](../../scepman-deployment/deployment-guides/scenarios/certificate-based-authentication-for-entra-id.md)
{% endcontent-ref %}
{% endstep %}
{% endstepper %}
