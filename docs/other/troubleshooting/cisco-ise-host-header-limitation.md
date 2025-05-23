# Cisco ISE Host Header Limitation

Both Cisco ISE as well as Aruba ClearPass (only up to and including **ClearPass 6.9.5**) do not support HTTP 1.1 when looking up OCSP and do not send a host header in their OCSP request. This is likely because OpenSSL up to version 1.0.2, which seems to be used in the backend, [required an extra parameter to send the host header for OCSP requests](https://github.com/openssl/openssl/issues/1986), while OpenSSL 1.1.0 released in August 2016 does that automatically. Therefore, they cannot connect to a general SCEPman instance running on Azure App Services. The error message may look like this:

![](<../../.gitbook/assets/cisco-ocsp-error (18).jpg>)

Cisco is currently investigating future enhancements but for the time being you can use an [Azure Application Gateway](https://azure.microsoft.com/en-us/services/application-gateway/) to provide an instance of SCEPman not requiring a Host Header.

The following instructions outline the steps required to create an Azure Application Gateway for SCEPman:

## 1) Create a new Application Gateway

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.12.40 (5).png>)

## 2) Provide the necessary basic information

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.13.55 (4).png>)

## 3) Create a new static public IP address

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.14.19 (10).png>)

## 4) Create a new Backend Pool and point it to your SCEPman App Service

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.14.55 (9).png>)

{% hint style="info" %}
In the Geo-Redundant scenario, you must add both SCEPman app services to the backend pool.
{% endhint %}

## 5) Add a routing rule for HTTP

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.15.36 (4).png>)

![](../../.gitbook/assets/Replace5.png)

## 5b) Add a new HTTP Setting with Host Header (your SCEPman public FQDN)

{% hint style="warning" %}
Around the beginning of June, Microsoft introduced a bug in Azure Application Gateway that prevents adding a host header to host-header-free requests when "Pick host name from backend target" is selected. We recommended "Pick host name from backend target" in a previous version of this documentation, but this does no longer work. As a workaround, choose "Override with specific domain name" as depicted below and insert the name of your SCEPman App Service, e.g. _contoso-scepman.azurewebsites.net_.
{% endhint %}

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.16.21 (9).png>)

![](../../.gitbook/assets/Replace5b2.png)

## 6) Optional: Add a routing rule for HTTPS

{% hint style="warning" %}
This step requires an HTTPS web server certificate.
{% endhint %}

{% hint style="info" %}
The use of HTTP without TLS is not a security vulnerability; PKI-based resources are commonly published via HTTP without TLS, as the TLS handshake may require access to these resources. Using TLS would create a chicken-and-egg problem where the TLS handshake requires access to the PKI resources and access to the PKI resources requires a TLS handshake. Therefore, these PKI resources including the protocols SCEP and OCSP employ their own encryption and/or signatures where it is required.
{% endhint %}

![](../../.gitbook/assets/Replace61.png)

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.17.44 (10).png>)

## 6b) Add a new HTTPS Setting with Host Header (your SCEPman public FQDN)

<figure><img src="../../.gitbook/assets/2024-06-06 16_52_56-.png" alt=""><figcaption></figcaption></figure>

![](../../.gitbook/assets/Replace62.png)

## 7) Confirm Routing Rules

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.18.56 (5).png>)

## 8) Finalize the Application Gateway configuration

![](<../../.gitbook/assets/screen-shot-2019-10-18-at-17.19.13 (10).png>)

## 9) Configure the DNS name for the IP

Then, add a DNS name for the Gateway:

1. Open the IP Address resource
2. Add a name of your choice as DNS name label

![](../../.gitbook/assets/ip-address.png)

Optional: You can add a CNAME entry for the DNS name in your own DNS server.

{% hint style="info" %}
In Geo-Redundant scenario, you can still use the SCEPman custom domain URL (which points to the traffic manager) and the Application Gateway URL in Cisco ISE as an OCSP responder.
{% endhint %}

{% hint style="info" %}
OCSP responder URL would be: `http://<Application-Gateway-URL>/ocsp`

**Note:** The OCSP responder URL should be HTTP not HTTPS, see [here](../security-faq.md#id-21.-can-https-only-be-enabled)
{% endhint %}

## Intune/JAMF configuration

You may still use the App Service's URL instead of the Azure Application Gateway's in the Intune configuration. If you do this, the clients communicate directly with the App Service. You must configure the Azure Application Gateway's URL in Cisco ISE, as only this URL supports HTTP 1.0 requests.
