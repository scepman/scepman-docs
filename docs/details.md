# Details

## What is SCEP?

Usually when it is necessary to deploy certificates to (mobile) devices [Simple Certificate Enrollment Protocol](https://www.rfc-editor.org/rfc/rfc8894.html) (SCEP) is the first choice. But what is SCEP? SCEP is an [Internet draft](https://en.wikipedia.org/wiki/Internet\_Draft) standard protocol. An Internet draft contains technical specifications and technical information. Internet drafts are often published as a [Request for Comments](https://en.wikipedia.org/wiki/Request\_for\_Comments).

SCEP is originally developed by Cisco. The core mission of SCEP is the deployment of certificates to network devices without any user interactions. With the help of SCEP, network devices can request certificates on their own.

## What is SCEPman?

If you use SCEP in a 'traditional way' you need a number of on-premises components. Microsoft Intune [allows third-party certificate authorities (CA)](https://docs.microsoft.com/en-us/intune/certificate-authority-add-scep-overview) to issue and validate certificates using SCEP.

To get rid of the on-premises components we developed SCEPman.

{% hint style="warning" %}
SCEPman issues certificates that are **intended for authentication and transport encryption**. That said, you can deploy user and device certificates used for network authentication, WiFi, VPN, RADIUS and similar services.

**You may** use SCEPman for transactional **digital signatures** i.e. for S/MIME signing in Microsoft Outlook. If you plan to use the certificates for message signing you need to add the corresponding extended key usages in the Intune profile configuration. Please keep in mind, that SCEPman certificates are trusted in your organization only. SCEPman does not issue publicly trusted certificates.

**Do not** use SCEPman **for email-encryption** i.e. for S/MIME mail encryption in Microsoft Outlook (without a separate technology for key management). The nature of **the SCEP protocol does not include a mechanism to backup or archive private key material.** If you would use SCEP for email-encryption you may lose the keys to decrypt the messages at a later time.
{% endhint %}

For more details about the technical certificate workflow and the third-party certification authority SCEP integration, click [here](https://docs.microsoft.com/en-us/intune/certificate-authority-add-scep-overview#overview).

### SCEPman Workflow

Here's an overview about the SCEPman workflow. The first figure shows the certificate issuance and the second figure shows the certificate validation.

Process of certificate issuance:

![](<../.gitbook/assets/Overview1 (2).png>)

Process of certificate validation during certificate-based authentication:

![](<../.gitbook/assets/Overview2 (2).png>)

### SCEPman Features

SCEPman is an Azure Web App with the following features:

* A SCEP interface that is compatible with the Intune [SCEP API](https://docs.microsoft.com/en-us/intune/certificate-authority-add-scep-overview) in particular.
* SCEPman provides certificates signed by a CA root key stored in **Azure Key Vault**.
* SCEPman contains an **OCSP responder** (see below) to provide certificate validity in real-time. A certificate is valid if its corresponding **Azure Active Directory (Azure AD)** device or user exists and is enabled.
* A full replacement of Legacy PKI.

SCEPman creates the CA root certificate during the initial installation. However, if for whatever reason an alternative CA key material shall be used it is possible to replace this CA key and certificate with your own in Azure Key Vault. For example, if you want to use a Sub CA certificate signed by an existing internal Root CA.

SCEPman issues device and user certificates that are compatible with Intune's internally used authentication certificates. They contain Intune's extensions determining the tenant and the machine. Additionally, when using device certificates, the tenant ID and machine ID are stored in the certificate subject alternative names to allow a RADIUS server, like [RADIUS-as-a-Service](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/glueckkanja-gabag.radiusaas-transactable-prod), to use these certificates for authentication.

### SCEPman OCSP (Online Certificate Status Protocol)

The [Online Certificate Status Protocol (OCSP)](https://en.wikipedia.org/wiki/Online\_Certificate\_Status\_Protocol) is an Internet protocol which is in use to determine the state of a certificate.

Usually, an OCSP client sends a status request to an OCSP responder. An OCSP responder verifies the validity of a certificate based on revocation state or other mechanisms. In comparison to a certificate revocation list (CRL), an OCSP is always up-to-date and the response is available within seconds. A CRL has the disadvantage that it is based on a database that must refresh manually and may weight a lot of data. Read a detailed comparison of these revocations mechanisms [in an article in our company blog](https://www.glueckkanja-gab.com/blog/security/certificates/scepman/2023/05/certificate-revocation-en/).
