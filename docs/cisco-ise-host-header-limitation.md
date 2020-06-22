# Cisco ISE Host Header Limitation

Cisco ISE is still not supporting HTTP 1.1 when looking up OCSP and therefore can't connect to a general SCEPman instance running on Azure App Services. The error message may look like this:

![](.gitbook/assets/cisco-ocsp-error.jpg)

Cisco is currently investigating future enhancements but for the time being you can use an [Azure Application Gateway](https://azure.microsoft.com/en-us/services/application-gateway/) to provide an instance of SCEPman not requiring a Host Header.

This documentation is a quick introduction to the basic steps required to create such an Application Gateway. Please forgive the rudimentary form.

Create an Azure Application Gateway for SCEPman

1\) Create a new Application Gateway

![](.gitbook/assets/screen-shot-2019-10-18-at-17.12.40.png)

2\) Provide the necessary basic information

![](.gitbook/assets/screen-shot-2019-10-18-at-17.13.55.png)

3\) Create a new static public IP address

![](.gitbook/assets/screen-shot-2019-10-18-at-17.14.19.png)

4\) Create a new Backend Pool

![](.gitbook/assets/screen-shot-2019-10-18-at-17.14.55.png)

5\) Add a routing rule for HTTP

![](.gitbook/assets/screen-shot-2019-10-18-at-17.15.36.png)

![](.gitbook/assets/screen-shot-2019-10-18-at-17.15.56.png)

5b\) Add a new HTTP Setting with Host Header \(your SCEPman public FQDN\)

![](.gitbook/assets/screen-shot-2019-10-18-at-17.16.21.png)

![](.gitbook/assets/screen-shot-2019-10-18-at-17.16.34.png)

6\) Add a routing rule for HTTPS

{% hint style="info" %}
Important: This step requires an HTTPS web server certificate.
{% endhint %}

![](.gitbook/assets/screen-shot-2019-10-18-at-17.17.34.png)

![](.gitbook/assets/screen-shot-2019-10-18-at-17.17.44.png)

6b\) Add a new HTTPS Setting with Host Header \(your SCEPman public FQDN\)

![](.gitbook/assets/screen-shot-2019-10-18-at-17.18.37.png)

![](.gitbook/assets/screen-shot-2019-10-18-at-17.18.47%20%281%29.png)

7\) Confirm Routing Rules

![](.gitbook/assets/screen-shot-2019-10-18-at-17.18.56.png)

8\) Finalize

![](.gitbook/assets/screen-shot-2019-10-18-at-17.19.13.png)
