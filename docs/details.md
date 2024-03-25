# Details

## What is SCEP?

Usually when it is necessary to deploy certificates to (mobile) devices, [Simple Certificate Enrollment Protocol](https://www.rfc-editor.org/rfc/rfc8894.html) (SCEP) is the first choice. But what is SCEP? SCEP is an [Internet draft](https://en.wikipedia.org/wiki/Internet\_Draft) standard protocol. An Internet draft contains technical specifications and technical information. Internet drafts are often published as a [Request for Comments](https://en.wikipedia.org/wiki/Request\_for\_Comments).

SCEP is originally developed by Cisco. The core mission of SCEP is the deployment of certificates to network devices without any user interactions. With the help of SCEP, network devices can request certificates on their own.

## What is SCEPman?

If you use SCEP in a 'traditional way' you need a number of on-premises components. Microsoft Intune and [other Mobile Device Management (MDM)](use-cases.md#mdm-solutions) solutions [allow third-party certificate authorities (CA)](https://docs.microsoft.com/en-us/intune/certificate-authority-add-scep-overview) to issue and validate certificates using SCEP.

To get rid of the on-premises components we developed SCEPman.

{% hint style="warning" %}
SCEPman issues certificates that are **intended for authentication and transport encryption**. That said, you can deploy user and device certificates used for network authentication, WiFi, VPN, RADIUS and similar services.

**You may** use SCEPman for transactional **digital signatures** i.e. for S/MIME signing in Microsoft Outlook. If you plan to use the certificates for message signing you need to add the corresponding extended key usages in the Intune profile configuration. Please keep in mind that SCEPman certificates are trusted in your organization only. SCEPman does not issue publicly trusted certificates.

**Do not** use SCEPman **for email-encryption** i.e. for S/MIME mail encryption in Microsoft Outlook (without a separate technology for key management). The nature of **the SCEP protocol does not include a mechanism to backup or archive private key material.** If you would use SCEP for email-encryption you may lose the keys to decrypt the messages at a later time.
{% endhint %}

### SCEPman Workflow

Here's an overview about the SCEPman workflow when using Intune as MDM solution (the flows are similar for other MDM solutions). The first figure shows the certificate issuance and the second figure shows the certificate validation.

Process of certificate issuance:

![](<.gitbook/assets/Overview1 (2).png>)

Process of certificate validation during certificate-based authentication:

![](<.gitbook/assets/Overview2 (2).png>)

### SCEPman Features

SCEPman is an Azure Web App with the following features:

* A SCEP interface that is compatible with the Intune [SCEP API](https://docs.microsoft.com/en-us/intune/certificate-authority-add-scep-overview) in particular.
* SCEPman provides certificates signed by a CA root key stored in **Azure Key Vault**.
* SCEPman contains an **OCSP responder** (see below) to provide [certificate validity / auto-revocation](certificate-deployment/manage-certificates.md#automatic-revocation) in real-time
* A full replacement of Legacy PKI in many scenarios.

SCEPman creates the CA root certificate during the initial installation. However, if for whatever reason an alternative CA key material shall be used it is possible to replace this CA key and certificate with your own in Azure Key Vault. For example, if you want to use a Sub CA certificate signed by an existing internal Root CA.

#### Certificate Master

Certificate Master allows [Enterprise Edition](editions.md#edition-comparison) customers to (manually) issue certificates in scenarios where an automatic enrollment via SCEP / MDM is not possible. Common examples are the issuance of [TLS server certificates](certificate-deployment/certificate-master/tls-server-certificate-pkcs-12.md) or user certificates for [smart cards / YubiKeys](certificate-deployment/certificate-master/user-certificate.md). Furthermore, with Certificate Master, administrators can [manage](certificate-deployment/manage-certificates.md) any certificate issued by SCEPman, whether they were automatically enrolled through SCEP via Intune, Jamf, 3rd party MDMs, EST, the [Enrollment REST API](certificate-deployment/api-certificates.md) or manually via Certificate Master UI itself.

{% content-ref url="certificate-deployment/certificate-master/" %}
[certificate-master](certificate-deployment/certificate-master/)
{% endcontent-ref %}

### SCEPman OCSP (Online Certificate Status Protocol)

The [Online Certificate Status Protocol (OCSP)](https://en.wikipedia.org/wiki/Online\_Certificate\_Status\_Protocol) is an Internet protocol which is in use to determine the state of a certificate.

Usually, an OCSP client sends a status request to an OCSP responder. An OCSP responder verifies the validity of a certificate based on revocation state or other mechanisms. In comparison to a certificate revocation list (CRL), that SCEPman supports as well, an OCSP response is always up-to-date and the response is available within seconds. A CRL has the disadvantage that it is based on a database that must refresh manually and may weigh a lot of data. Read a detailed comparison of these revocations mechanisms[ in an article in our company blog.](https://www.glueckkanja.com/blog/products/2023/05/certificate-revocation-en/)
