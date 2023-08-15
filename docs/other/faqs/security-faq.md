---
category: Other
title: Security FAQ
order: 2
description: >-
  This chapter shall provide a brief overview of the data that SCEPman is
  processing and how this data is protected against unauthorized access. It
  applies to SCEPman 2.2.
---

# Security & Privacy

## Data Processing and Permissions

### 1. Which data is processed by SCEPman?

SCEPman processes X.509 certificates using the SCEP and OCSP protocols. Each device certificate must contain a unique device identifier. Additionally, for user certificates, we recommend to configure the following values as part of the certificate:

* Username
* Email
* UPN
* Device identifier

SCEP and OCSP rely on HTTP, e.g. the following data is visible to SCEPman:

* Client IP Address + Port
* User agent (operating system & browser information)

### 2. Which data is persistently stored by/on behalf of SCEPman and how?

#### SCEPman Core Service

SCEPman's core services are provided by a stateless web application that does not store any data, except for the configuration.

1. Configuration
   * Configuration data always contains the SCEPman CA public/private key pair and certificate, which is securely stored in Azure Key Vault.
   * Additionally, configuration data may contain secrets such as static SCEP challenges or passwords dependent. The purpose of those parameters is explained in the SCEPman documentation.
   * All configuration parameters can be stored in Azure Key Vault.
2.  Logging

    Based on the customer's configuration of SCEPman, logging may be activated. Dependent on the customer's logging verbosity settings, the logs may contain any data that SCEPman processes. The customer configures the log storage location.
3.  PaperTrail

    SCEPman always sends a limited amount of **non-personal** data to our PaperTrail account. This data is used for

    * Licensing purposes
    * Quality assurance (e.g. monitoring exceptions globally helps us to recognize general and widespread issues quickly, so that we can offer solutions to our clients fast, preventing expensive service outages).

    By default, SCEPman does **not send any personal data** to our PaperTrail account.

    Depending on the logging settings, debug and other information is forwarded to glueckkanja-gab AG's PaperTrail account. Our support engineers may request to [activate](../../scepman-configuration/optional/application-settings.md#appconfig-remotedebug) `(AppConfig:RemoteDebug -> true)` the remote debugging feature from the customer admin in support of troubleshooting inquiries. In such cases, information on the certificate request may be sent to our PaperTrail account, possibly (the customer decides what information is part of the certificate) containing personal data such as:

    * Username
    * Email
    * UPN
    * Device identifier

    We periodically delete **all** logged data at an interval of

    * 1 year (PaperTrail)

#### SCEPman Certificate Master

If you are using Certificate Master additional data will be stored.

An Azure Storage Account stores all certificates that were issued via the Certificate Master component including the requester (Azure AD UPN), the certificate revocation status and reason. _We never store the private key_, which is only available as a one-time download.

### 3. Where (geographically) does SCEPman process and store data?

By design, SCEPman is realized as an Azure App (solution-template-based), i.e. it is deployed into the customer's Azure tenant. As such data sovereignty in terms of the data center's geo-location is within the customer's hands and preference.

#### PaperTrail

PaperTrail is an external logging service of which the location cannot be configured by the customer.

The entirety of Papertrail's systems are located inside the United States of America. Data is processed by Softlayer and stored in AWS.

Softlayer in the US – region DAL08 AWS region us-east-1

### 4. Which tenant permissions does the admin have to consent to?

SCEPman leverages Managed Identities to implement a secure permission model in your Azure tenant.

#### Intune

1. Intune `scep_challenge_provider`:\
   \
   With this permission SCEPman may forward the certificate request to Intune and verify that the certificate request originates from Intune, where the latter adds an additional layer of security.\\
2. Microsoft Graph `Directory.Read.All`:\
   \
   With this permission, SCEPman may consult with AAD in order to check if the user or device certificate is originating from an authorized user or device. For details, refer to [SCEPman Docs](../../scepman-deployment/permissions/azure-app-registration.md#azure-app-registration-api-permissions).\\
3. Microsoft Graph `DeviceManagementManagedDevices.Read.All` and `DeviceManagementConfiguration.Read.All`:\
   \
   With these permissions, SCEPman requests the list of issued certificates via Intune when using the [EndpointList revocation feature](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory).\\
4. Microsoft Graph `IdentityRiskyUser.Read.All`:\
   \
   This permission allows SCEPman to automatically [revoke user certificates if the AAD User Risk exceeds a configured threshold](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-userriskcheck).

#### JAMF

1. Read permissions on users, computers and devices\
   \
   With these permissions, SCEPman may consult with JAMF in order to check if the user or device certificate is originating from an authorized user or device.

#### Certificate Master

1. Microsoft Graph `User.Read` (per App Registration):\
   \
   With this permission, Certificate Master determines who manually requests or revokes a certificate.\\
2. Micrsoft Graph `DeviceManagementManagedDevices.Read.All` and `DeviceManagementConfiguration.Read.All` (as Managed Identity):\
   \
   With these permissions, Certificate Master requests the list of issued certificates via Intune. Administrators can review and manually revoke these certificates.

### 5. What data is made available by granting the consent(s) from 4.?

While the below consents make data available to SCEPman, SCEPman does not process this data except for the existence of the corresponding objects and their status (enabled, disabled, compliant).

#### Intune

1. Intune `scep_challenge_provider`:
   * None
2. Microsoft Graph `Directory.Read.All`:
   * Allows SCEPman to read data in your organization's directory, such as users, groups and apps, without a signed-in user (see [Microsoft Docs](https://docs.microsoft.com/en-us/graph/permissions-reference#directory-permissions)).

#### JAMF

1. Read permissions on users, computers and devices
   * Allows SCEPman to read data about users and devices managed in JAMF.

#### Certificate Master

1. Microsoft Graph `User.Read`:
   * Allows Certificate Master to read the basic user profile of the logged-in identity (see [Microsoft Docs](https://docs.microsoft.com/en-us/graph/permissions-reference#user-permissions)).

### 6. Which externally accessible endpoints does SCEPman expose?

1. SCEP-endpoint(s)
   * Invoked for SCEP-requests
   * Based on the configuration, SCEPman may expose several SCEP-endpoints for Intune, JAMF, DCs, generic 3rd-party MDMs
2. OCSP-endpoint
   * Invoked for OCSP-requests
3. SCEPman homepage
   * Displays SCEPman's basic status information publicly (no secrets)
   * Read-only
   * Can be disabled via configuration
4. SCEPman probe-endpoint
   * Health Checks: Integrated App Service Health Check, Traffic Manager probing, Application Gateway probing
5. Certificate Master web portal
   * Manually issue server certificates and sign CSRs
   * Manually revoke certificates issued via the Certificate Master
   * View list of manually issued certificates
6. Certificate Master probe-endpoint
   * Health Checks: Integrated App Service Health Check
7. SCEPman API
   * Allows Certificate Master to request certificates from SCEPman's core service.

### 7. How are the endpoints from 6. protected?

1. SCEP-endpoint(s)
   * Intune: Protected via Intune Challenge API ([Microsoft Docs](https://docs.microsoft.com/en-us/mem/intune/protect/scep-libraries-apis))
   * JAMF, DCs, generic 3rd party MDMs: Protected with a static SCEP-challenge. Configurable by the customer. May be stored in Azure Key Vault.
2. OCSP-endpoint
   * No protection required
3. SCEPman homepage
   * No protection but can be disabled
4. SCEPman probe-endpoint
   * No protection
5. Certificate Master web portal
   * Azure AD integrated authentication
6. Certificate Master probe-endpoint
   * No protection
7. SCEPman API
   * Azure AD integrated authentication

## Identity

### 8. What authorization schemes are used to gain access to SCEPman?

* Administrative access is realized through AAD authentication via the Azure Portal.
* Limited read-access may be configured to be publicly available (see [7.](security-faq.md#7-how-are-the-endpoints-from-6-protected))
* Access to the Certificate Master web portal uses AAD authentication and AAD Role Assignments for authorization as [described in the SCEPman documentation](../../scepman-configuration/post-installation-config.md#granting-the-rights-to-request-certificates-via-the-certificate-master-website).
* The SCEPman API uses AAD Role Assignments. In the recommended default configuration, only Certificate Master has access to the API.

### 9. Are there conditional access / role-based access controls in place to protect SCEPman?

* Yes. The full set of AAD RBAC policies can be leveraged.

### 10. Can access credentials be recovered? If yes, how?

* Login Credentials: Depends on the configured AAD policies in the customer tenant.
* Static SCEP challenge: Authorized users may review the challenge.

## Data Protection

### 11. How is _data at-rest_ protected against unauthorized access?

#### Configuration Data

* Configuration data can be stored securely in Azure Key Vault (version >= 1.7).
* If configuration data is chosen not be stored in Azure Key Vault, it is stored on AppService (Bit-Locker encryption)

#### Cryptographic Keys

* CA private key is securely stored in Azure Key Vault
* You may configure to use an HSM within Azure Key Vault (default is SW-storage)

#### Certificate Database

* The database uses the Table service of an Azure Storage Account. Thus, protection relies on the mechanisms built into Azure.
* Especially, Azure employs role-based access to manage permissions to the data.
* Azure Storage uses database encryption and supports customer-managed keys.

#### Logs

* If logging is configured active, the customer decides where the logs are stored.

### 12. How is _data in transit_ protected against unauthorized access?

* SCEP:
  * Uses TLS by default (minimum TLS 1.2 - Microsoft policies apply)
  * SCEP requests are encrypted to the CA certificate and signed with the client certificate
  * SCEP responses are encrypted to the client certificate and signed with the CA certificate
* OCSP:
  * OCSP request must not be encrypted to avoid chicken-egg-problems
  * OCSP responses are signed by the CA certificate
* Communication between SCEPman Azure components:
  * TLS

## Security by Design

### 13. Does SCEPman employ a defense in depth strategy?

#### Azure Components

SCEPman's design philosophy follows the approach to minimize its exposure to external security threats by reducing external interfaces to the required minimum. Besides this, the following technologies are used to recognize and mitigate internal and external threats on different layers:

* Key Vault
* App Insights
* Intune device enrollment verification
* Azure AD device check

Since SCEPman founds on Azure components, you may use Microsoft Defender for Cloud tools like for MD for App Service, MD for Storage, or MD for Key Vault.

#### Certificate Validity

As a cloud PKI, SCEPman is responsible for the issuance and revocation of digital certificates. These certificates in conjunction with their private keys authenticate devices or users and grant access to other resources. Hence, the security of certificate issuance and revocation processes is a very important design goal. A high level of security requires a high level of user convenience, too, because complicated and intransparent processes have a larger attack surface and higher potential for human error. Although SCEPman offers many configuration options if needed, we strived to use reasonable and secure defaults wherever possible.

Thus, if a private key is compromised, SCEPman can revoke the corresponding certificate in real-time. For certificates enrolled via Intune and Jamf, SCEPman does this automatically as soon as common countermeasures not specific to SCEPman are taken against the attack. You just have to [delete the corresponding Intune](../../architecture/device-directories.md) or Jamf object.

Depending on your device retirement processes, you can additionally configure to [revoke certificates when a wipe is triggered](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationrevokecertificatesonwipe), when [Intune requests revocation](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationdevicedirectory), depending on [device compliance](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationcompliancecheck) or [user risk level](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfigintunevalidationuserriskcheck), or you can manually revoke single certificates via the Certificate Master component.

[Manually created certificates](../../certificate-deployment/certificate-master/) always require a manual revocation.

### 14. What technologies, stacks, platforms were used to design SCEPman?

* `C#`
* `ASP.NET Core MVC`
* `Bouncy Castle Crypto API`
* `Azure (App Service, Key Vault, Storage Account)`

### 15. What cryptographic algorithms and key sizes does SCEPman support?

For the keys of issued certificates, Certificate Master has no restrictions when using the CSR method. For forms-based certificates, RSA with 2048 bits is the only supported algorithm and key size.

For SCEP-enrolled certificates, Intune supports only RSA 2048 on most platforms, but some support RSA 4096, which SCEPman also supports. When using the static SCEP endpoint, all common algorithms and key sizes are supported (specifically those which [the Bouncy Castle cryptographic library for C# supports](https://www.bouncycastle.org/csharp/)).

For the CA key, SCEPman supports RSA only. 2048 bit key size is the default, but you can use a larger key size by specifying a larger value for [AppConfig:KeyVaultConfig:RootCertificateConfig:KeySize](../../scepman-configuration/optional/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-keysize) before generating the Root CA certificate. 4096 bit is currently the maximum supported by Azure Key Vault. If you use an Intermediate CA certificate, you can also use any key size supported by Key Vault, but it must be an RSA key.

### 16. Is the CA created by SCEPman unique?

Yes

Details:

* SCEPman generates the private-public key pair for the Root CA in the Azure Key Vault in your tenant. Therefore, the Root CA is unique to your personal SCEPman instance and you have full control over the CA, its certificate and corresponding private key.
* Access to this CA is controlled via Key Vault access policies that you may change if you want. By default, only your own SCEPman instance and nobody else (also no administrator) may use the certificate, but a subscription administrator may grant additional permissions.
* Hence, other SCEPman customers will not be able to connect to your VPN, no matter how they configure their SCEPman. If they choose the same organization name, they will still have their own key pair and thus another CA certificate that your VPN Gateway will not trust.

## Azure CIS

This section covers questions that arise when defining cyberdefense policies for your Azure environment or working with best practice frameworks such as the [CIS Microsoft Azure Foundations Benchmark](https://www.cisecurity.org/benchmark/azure/).

### Storage Accounts

#### 18. Can `Allow Blob public access` be disabled?

_Yes_, that is actually already the default for new SCEPman installations.

### App Services

#### 19. TLS: Can `Client certificate mode` be set to `Require`?&#x20;

_No_, as this would break SCEPman's functionality. This is because SCEPman enrolls client certificates, so the clients do not yet have client certificates to authenticate with (chicken-egg-problem). That is not a security issue, though, as the SCEP protocol uses its own authentication mechanisms through the SCEP challenge. Hence, SCEPman needs an exemption from policies enforcing mutual TLS. The `Client certificate mode` must be set to `Ignore`.

#### 20. Can the `HTTP version` be set to `2.0`?

While SCEPman should work with any of the available HTTP versions, as of today, we only support  the default `HTTP 1.1` - mainly due to lack of testing.&#x20;

When changing this setting - on your own risk - please consider that it is not only SCEPman that needs to support the newer HTTP version. The different types of clients also need to support that version of HTTP, i.e. the OS-integrated SCEP clients of Window, MacOS, iOS, the ones in IoT devices, the OCSP clients on the same platforms, but also NACs of different vendors.

#### 21. Can `HTTPS Only` be enabled?

_No_, as this will break the OCSP-responder functionality of SCEPman in combination with many OCSP clients and vendor appliances. OCSP is a protocol that is more commonly provided over HTTP than HTTPS. One of the reasons is, if you used TLS for certificate revocation checking (downloading CRLs or OCSP), there could be a chicken-and-egg-problem, where the client or appliance cannot establish the TLS connection to the OCSP endpoint, because the server certificate needs to be verified over OCSP first. It also doesn't add a lot of security, because OCSP responses are cryptographically signed anyway and therefore cannot be spoofed. Hence, SCEPman needs an exemption from policies enforcing TLS.

## Miscellaneous

### 22. Is SCEPman part of a bug-bounty program?

No

### 23. What QA measures are in place?

* We provide SCEPman on an internal-, beta-, and production channel
* Each production release must go through the internal- and beta-channel first, passing the relevant QA hurdles as part of our CI process
  * Unit tests
  * Peer review
  * Integration tests
  * Stress tests
  * Experience-based testing
  * 3rd-party code analysis, e.g. Sonar, Dependabot, and others

### 24. What cloud-providers does SCEPman rely on?

* Microsoft Azure
* GitHub (for automatic updates)
