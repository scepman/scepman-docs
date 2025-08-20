---
category: Other
title: Security FAQ
order: 2
description: >-
  This chapter provides an overview on frequently asked questions surrounding
  information security, privacy and quality assurance.
---

# Security & Privacy

## Data Processing and Permissions

### 1. Which data is processed by SCEPman?

SCEPman processes X.509 certificates using the SCEP and EST protocols for issuing and OCSP and CRL protocols for validating those certificates. Each **device certificate** must contain a unique device identifier. Additionally, for **user certificates**, we recommend to configure the following values as part of the certificate:

* Username
* Email
* Microsoft Entra ID (Azure AD) UPN
* Device identifier

SCEP, EST, OCSP and CRL rely on HTTP(S), i.e. the following data is visible to SCEPman:

* Client IP Address + Port
* User agent (operating system & browser information)

Certificate Master maintains an audit trail on administrator activity (UPNs).

### 2. Which data is persistently stored by/on behalf of SCEPman and how?

1. Configuration
   * Configuration data always contains the SCEPman CA public/private key pair and certificate, which is securely stored in Azure Key Vault.
   * Additionally, configuration data may contain secrets such as static SCEP challenges or passwords. The purpose of those parameters is explained in the SCEPman documentation.
   * All configuration parameters can be stored in Azure Key Vault for enhanced security.
2. Issued  Certificates
   * All issued certificates are stored in an Azure Storage Account - _excluding private keys_.
   * For the data that might be part of a certificate, please refer to [question 1](security-faq.md#id-1.-which-data-is-processed-by-scepman).
   * This behaviour can be [disabled](../scepman-configuration/application-settings/basics.md#appconfig-enablecertificatestorage).
   * When issuing certificates via Certificate Master, the requester (Microsoft Entra ID (Azure AD) UPN) is stored.
   * When revoking certificates via Certificate Master, the certificate revocation status and the identity of the user who revoked it (Microsoft Entra ID (Azure AD) UPN) is stored.
3.  Logging

    Based on the customer's configuration of SCEPman, logging may be activated. Dependent on the customer's logging verbosity settings, the logs may contain any data that SCEPman processes. The customer configures the log storage location.
4.  External Log Analytics Workspace

    SCEPman always sends a limited amount of **non-secret** and **non-personal** data to our Log Analytics Workspace (LAW). This data is used for

    * Licensing purposes.
    * Quality assurance (e.g. monitoring exceptions globally helps us to recognize general and widespread issues quickly, allowing us to provide remedy to our clients fast, thus preventing expensive service outages).

    By default, SCEPman does **not send any personal data** to our LAW.

    Depending on the logging settings, debug and other information is forwarded to glueckkanja-gab AG's LAW. Our support engineers may request to [activate](../scepman-configuration/application-settings/basics.md#appconfig-remotedebug) the remote debugging feature from the customer admin in support of troubleshooting inquiries. In such cases, information on the certificate request may be sent to our LAW account, possibly (the customer decides what information is part of the certificate) containing personal data such as:

    * Username
    * Email
    * Microsoft Entra ID (Azure AD) UPN
    * Device identifier

    We periodically delete **all** logged data at an interval of

    * 30 days

### 3. Where (geographically) does SCEPman process and store data?

By design, SCEPman is realized as an Azure App (solution-template-based), i.e. it is deployed into the customer's Azure tenant. As such, data sovereignty including the choice of the hosting data center's geo-location is within the customer's hands and preference.

#### External Log Analytics Workspace

The external LAW we leverage to collect (by default **non-personal** and **non-secret**) telemetry information for license enforcement purposes is located in **Azure's West Europe** data center.

### 4. Which tenant permissions does the admin have to consent to?

SCEPman leverages Managed Identities to implement a secure permission model in your Azure tenant.

#### Intune

1. Intune `scep_challenge_provider`:\
   \
   With this permission SCEPman may forward the certificate request to Intune and verify that the certificate request originates from Intune, where the latter adds an additional layer of security.
2. Microsoft Graph `Directory.Read.All`:\
   \
   With this permission, SCEPman may consult with Microsoft Entra ID (Azure AD) in order to check if the user or device certificate is originating from an authorized user or device.
3. Microsoft Graph `DeviceManagementManagedDevices.Read.All` and `DeviceManagementConfiguration.Read.All`:\
   \
   With these permissions, SCEPman requests the list of issued certificates via Intune when using the [EndpointList revocation feature](../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-devicedirectory).
4. Microsoft Graph `IdentityRiskyUser.Read.All`:\
   \
   This permission allows SCEPman to automatically [revoke user certificates if the AAD User Risk exceeds a configured threshold](../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-userriskcheck).

#### Jamf Pro

1. Read permissions on users, computers and devices\
   \
   With these permissions, SCEPman may consult with Jamf Pro in order to check if the user or device certificate is originating from an authorized user or device.

#### Certificate Master

1. Microsoft Graph `User.Read` (via App Registration):\
   \
   With this permission, Certificate Master determines who manually requests or revokes a certificate.
2. Micrsoft Graph `DeviceManagementManagedDevices.Read.All` and `DeviceManagementConfiguration.Read.All` (as Managed Identity):\
   \
   With these permissions, Certificate Master requests the list of issued certificates via Intune. Administrators can review and manually revoke these certificates.

### 5. Which externally accessible endpoints does SCEPman expose?

#### **SCEPman Core Service**

1. SCEP-endpoint(s)
   * Invoked for SCEP-requests.
   * Based on the configuration, SCEPman may expose several SCEP-endpoints for Intune, Jamf Pro, DCs, generic Other MDMs.
2. Enrollment REST API
   * Allows Certificate Master to request certificates from SCEPman's core service.
   * Allows custom applications to request certificates from SCEPman's core service.
3. EST-endpoint
   * Invoked for EST simple re-enroll requests. Can be enabled via configuration.
   * Invoked for EST simple enroll requests.
4. OCSP-endpoint
   * Invoked for OCSP-requests.
5. Certificate Distribution Point (CDP)
   * The Certificate Revocation List (CRL) is made available via this endpoint.
   * Can be enabled via [configuration](../scepman-configuration/application-settings/crl.md).
6. Validation API
   * Allows Certificate Master to evaluate the automatic revocation status of a certificate.
7. SCEPman homepage
   * Displays SCEPman's basic status information publicly (no secrets).
   * Read-only.
   * Can be disabled via [configuration](../scepman-configuration/application-settings/basics.md#appconfig-anonymoushomepageaccess).
8. SCEPman probe-endpoint
   * Health Checks: Integrated App Service Health Check, Traffic Manager probing, Application Gateway probing.

#### Certificate Master

1. Certificate Master web portal
   * Manually issue server certificates and sign CSRs.
   * Manually revoke certificates issued via the Certificate Master.
   * View list of manually issued certificates.
2. Certificate Master probe-endpoint
   * Health Checks: Integrated App Service Health Check

### 6. How are the endpoints from 5. protected?

#### SCEPman Core Service

1. SCEP-endpoint(s)
   * Intune: Protected via Intune Challenge API ([Microsoft Docs](https://docs.microsoft.com/en-us/mem/intune/protect/scep-libraries-apis))
   * Jamf Pro, DCs, generic Other MDMs: Protected with a static SCEP-challenge. Configurable by the customer. May be stored in Azure Key Vault.
2. Enrollment REST API
   * Microsoft Entra ID (Azure AD) integrated authentication.
3. EST-endpoint
   * Simple re-enroll: Certificate-based authentication.
   * Simple enroll: Microsoft Entra ID (Azure AD) integrated authentication.
4. OCSP-endpoint
   * No protection required.
5. Certificate Distribution Point (CDP)
   * Access token required.
6. Validation API
   * Microsoft Entra ID (Azure AD) integrated authentication.
7. SCEPman homepage
   * No protection but can be disabled.
8. SCEPman probe-endpoint
   * No protection.

#### Certificate Master

1. Certificate Master web portal
   * Microsoft Entra ID (Azure AD) integrated authentication.
   * Microsoft Entra ID (Azure AD) [Role Assignments](../scepman-configuration/rbac/).
2. Certificate Master probe-endpoint
   * No protection.

### 7. What ports and protocols are used by the endpoints from Question 6?

**SCEPman Core Service**

1. SCEP-endpoint(s)
   * Intune: HTTPS (TCP / 443)
   * Jamf Pro, DCs, generic Other MDMs: HTTPS (TCP / 443)
2. Enrollment REST API
   * HTTPS (TCP / 443)
3. EST-endpoint
   * HTTPS (TCP / 443)
4. OCSP-endpoint
   * HTTP (TCP / 80)
5. Certificate Distribution Point (CDP)
   * HTTP (TCP / 80)
6. Validation API
   * Not used by external services.
7. SCEPman homepage
   * HTTPS (TCP / 443)
8. SCEPman probe-endpoint
   * HTTPS (TCP / 443)

#### Certificate Master

1. Certificate Master web portal
   * HTTPS (TCP / 443)
2. Certificate Master probe-endpoint
   * HTTPS (TCP / 443)

## Identity

### 1. Are there conditional access / role-based access controls in place to protect SCEPman?

* Yes. The full set of Microsoft Entra ID (Azure AD) RBAC policies can be leveraged.

### 2. Can access credentials be recovered? If yes, how?

* Login Credentials: Depends on the configured Microsoft Entra ID (Azure AD) policies in the customer tenant.
* Static SCEP challenge: Authorized users may access the challenge.

## Data Protection

### 1. How is _data at-rest_ protected against unauthorized access?

#### Configuration Data

* Configuration data can be stored securely in Azure Key Vault (version >= 1.7).
* If configuration data is chosen not be stored in Azure Key Vault, it is stored on AppService (Bit-Locker encryption)
* Any configuration data (Azure Key Vault, App Services) can only be accessed by authorized users with the relevant Azure permissions.

#### Cryptographic Keys

* The CA private key is securely stored in Azure Key Vault ([FIPS 140 validated HSM](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys#compliance) by default).
* The private key cannot be read or exported.
* The private key is protected against deletion by rogue admins ([purge protection and soft delete](https://learn.microsoft.com/en-us/azure/key-vault/general/soft-delete-overview) are enabled by default).
* Azure Key Vault uses a private endpoint and can only be accessed from SCEPman (default for SCEPman installations of version 2.8 and above).

#### Certificate Database

* The database uses the Table service of an Azure Storage Account. Thus, protection relies on the mechanisms built into Azure.
* Especially, Azure employs role-based access to manage permissions to the data.
* Azure Storage uses database encryption and supports customer-managed keys.
* The Azure Storage Account uses a private endpoint and can only be accessed from SCEPman  (default for SCEPman installations of version 2.8 and above).

#### Logs

* Logs are stored in a Log Analytics workspace.
* Log Analytics uses database encryption and supports customer-managed keys.

### 2. How is _data in transit_ protected against unauthorized access?

* SCEP:
  * Uses TLS by default (minimum TLS 1.2 - Microsoft policies apply).
  * SCEP requests are encrypted to the CA certificate and signed with the client certificate.
  * SCEP responses are encrypted to the client certificate and signed with the CA certificate.
* OCSP:
  * OCSP requests should not be encrypted to avoid chicken-egg-problems.
  * OCSP responses are signed by the CA certificate.
* Enrollment REST API and EST:
  * Enforces TLS (minimum TLS 1.2 - Microsoft policies apply).
* Certificate Master web portal:
  * Enforces TLS (minimum TLS 1.2 - Microsoft policies apply).
* Communication between SCEPman Azure components:
  * TLS (minimum TLS 1.2 - Microsoft policies apply).

## Security by Design

### 1. Does SCEPman employ a defense in depth strategy?

#### Azure Components

SCEPman's design philosophy follows the approach to minimize its exposure to external security threats by reducing external interfaces to the required minimum. Besides this, the following technologies are used to recognize and mitigate internal and external threats on different layers:

* Key Vault
* App Insights
* Intune device enrollment verification
* Microsoft Entra ID (Azure AD) device check
* Private Endpoints

Since SCEPman is built on top of Azure components, you may use Microsoft Defender (MD) for Cloud tools like for MD for App Service, MD for Storage, or MD for Key Vault.

#### Certificate Validity

As a cloud PKI, SCEPman is responsible for the issuance and revocation of digital certificates. These certificates in conjunction with their private keys authenticate devices or users and grant access to other resources. Hence, the security of certificate issuance and revocation processes is a very important design goal. A high level of security requires a high level of user convenience, too, because complicated and intransparent processes have a larger attack surface and higher potential for human error. Although SCEPman offers many configuration options if needed, we strived to use reasonable and secure defaults wherever possible.

Thus, if a private key is compromised, SCEPman can revoke the corresponding certificate in real-time. For certificates enrolled via Intune and Jamf Pro, SCEPman does this automatically as soon as common countermeasures not specific to SCEPman are taken against the attack. You just have to [delete the corresponding Intune](../scepman-configuration/device-directories.md) or Jamf Pro object.

Depending on your device retirement processes, you can additionally configure to [revoke certificates when a wipe is triggered](../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfigintunevalidationrevokecertificatesonwipe), when [Intune requests revocation](../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfigintunevalidationdevicedirectory), depending on [device compliance](../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfigintunevalidationcompliancecheck) or [user risk level](../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfigintunevalidationuserriskcheck), or you can manually revoke single certificates via the Certificate Master component.

[Manually created certificates](../certificate-management/certificate-master/) always require a manual revocation.

### 2. What technologies, stacks, platforms were used to design SCEPman?

* `C#`
* `ASP.NET Core MVC`
* `Bouncy Castle Crypto API`
* `Azure (App Service, Key Vault, Storage Account, Log Analytics)`

### 3. What cryptographic algorithms and key sizes does SCEPman support?

For the keys of issued certificates, Certificate Master has no restrictions when using the CSR method. For forms-based certificates, RSA with 2048 or 4096 bits are the supported algorithms and key sizes.

For SCEP-enrolled certificates, Intune supports up to RSA 4096 bit keys on all platforms, which SCEPman also supports. When using the platform KSP (TPM), Windows supports at most RSA 2048 bits keys. When using the static SCEP endpoint, all common algorithms and key sizes are supported (specifically those which [the Bouncy Castle cryptographic library for C# supports](https://www.bouncycastle.org/csharp/)).

For the CA key, SCEPman supports RSA only. RSA 4096 bit is the default key size. 4096 bit is currently the maximum supported by Azure Key Vault. If you use an Intermediate CA certificate, you can also use any key size supported by Key Vault, but it must be an RSA key.

For scenarios that do not require SCEP, an ECC CA can be created, supporting the following elliptic curves: P-256, secp256k1/P-256K, P-384, P-521.

### 4. Is the CA created by SCEPman unique?

Yes

Details:

* SCEPman generates the private-public key pair for the Root CA in the Azure Key Vault in your tenant. Therefore, the Root CA is unique to your personal SCEPman instance and you have full control over the CA, its certificate and corresponding private key.
* Access to this CA is controlled via Key Vault access policies that you may change if you want. By default, only your own SCEPman instance and nobody else (also no administrator) may use the certificate, but a subscription administrator may grant additional permissions.
* Hence, other SCEPman customers will not be able to connect to your VPN, no matter how they configure their SCEPman. If they choose the same organization name, they will still have their own key pair and thus another CA certificate that your VPN Gateway will not trust.

## Azure CIS

This section covers questions that arise when defining cyberdefense policies for your Azure environment or working with best practice frameworks such as the [CIS Microsoft Azure Foundations Benchmark](https://www.cisecurity.org/benchmark/azure/).

### Storage Accounts

#### 1. Can `Allow Blob public access` be disabled?

_Yes_, that is actually already the default for new SCEPman installations.

### App Services

#### 2. TLS: Can `Client certificate mode` be set to `Require`?&#x20;

_No_, as this would break SCEPman's functionality. This is because SCEPman enrolls client certificates, so the clients do not yet have client certificates to authenticate with (chicken-egg-problem). That is not a security issue, though, as the SCEP protocol uses its own authentication mechanisms through the SCEP challenge. Hence, SCEPman needs an exemption from policies enforcing mutual TLS. The `Client certificate mode` must be set to `Ignore` or `Optional`. &#x20;

#### 3. Can the `HTTP version` be set to `2.0`?

While SCEPman should work with any of the available HTTP versions, as of today, we only support the default `HTTP 1.1` - mainly due to lack of testing.&#x20;

When changing this setting - at your own risk - please consider that it is not only SCEPman that needs to support the newer HTTP version. The different types of clients also need to support that version of HTTP, i.e. the OS-integrated SCEP clients of Window, macOS, iOS, iPadOS the ones in IoT devices, the OCSP clients on the same platforms, but also NACs of different vendors.

#### 4. Can `HTTPS Only` be enabled?

_No (not for SCEPman App Service)_, as this will break the OCSP-responder functionality of SCEPman in combination with many OCSP clients and vendor appliances. OCSP is a protocol that is more commonly provided over HTTP than HTTPS. One of the reasons is, if you used TLS for certificate revocation checking (downloading CRLs or OCSP), there could be a chicken-and-egg-problem, where the client or appliance cannot establish the TLS connection to the OCSP endpoint, because the server certificate needs to be verified over OCSP first. It also doesn't add a lot of security, because OCSP responses are cryptographically signed anyway and therefore cannot be spoofed. Hence, SCEPman needs an exemption from policies enforcing TLS.

**Note:** **`HTTPS Only`** cannot be enabled for the SCEPman App Service, but it should be enabled for the Certificate Master App Service.

#### 5. Can the Minimum Inbound TLS Version be set to 1.3?

_No_ for the SCEPman App Service, as TLS 1.3 doesn't support re-negotiation. This means that once a connection is established, the server cannot ask the client to present a client certificate. We want the client to authenticate with a certificate in some circumstances (EST simple reenroll), so if you set TLS to 1.3, you won't be able to renew your certificates using EST.

Additionally, not all SCEP clients support TLS 1.3. One important example is the SCEP client integrated in Windows 8, 10, and 11, which as of 2025-07 does not support TLS 1.3 (there will be a client-side [error during SCEP enrollment](troubleshooting/general.md#some-windows-machines-do-not-enroll-or-renew-certificates)).

**Note:** As only browsers access the Certificate Master App Service, it is recommend for Certificate Master to set the Minimum Inbound TLS Version to 1.3.

## GDPR and Data-residency <a href="#user-content-gdpr-and-data-residency" id="user-content-gdpr-and-data-residency"></a>

### 1. Is data leaving Europe?

* This depends on the customer's choice on the Azure data center in which SCEPman and its components shall be deployed.
* A full deployment of SCEPman including all its components into European Azure data centers is possible.

### 2. What 3rd-Party cloud-providers does SCEPman rely on and why?

| Company                                          | Services                                                                  | Contact                                                                                   | Purpose                                                                                            |
| ------------------------------------------------ | ------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Microsoft Corporation                            | Cloud Services (Azure)                                                    | <p>Building 3, Carmanhall Road Sandyford,<br>Industrial Estate 18, Dublin,<br>Ireland</p> | See [here](../scepman-deployment/deployment-guides/enterprise-guide-1.md#overview-azure-resource). |
| GitHub Inc (subsidiary of Microsoft Corporation) | git code repository, integration, testing and release automation, storage | <p>88 Colin P Kelly Jr St, </p><p>San Francisco,</p><p>CA 94107, </p><p>United States</p> | Code repository, CI/CD pipeline, binary storage                                                    |

## Secure Development Practices

### 1. What ensures that SCEPman is secure software?

Our software development founds on the [Microsoft Security Development Lifecycle](https://www.microsoft.com/en-us/securityengineering/sdl/). Employing SDL practices helps us to create secure code and deployments. [We have the ISO 27001 information security certification for our product development](https://www.glueckkanja.com/documents/general/gkgab-ISO27001Certificate-en.pdf).

### 2. How do you implement common Secure Design Practices?

This is how we implement [Secure Design Practices recommended by the SDL](https://www.microsoft.com/en-us/securityengineering/sdl/practices/secure-by-design):

#### Design and Threat Model as a Team

Our Thread Modelling practice founds on the [recommendations of the Tufts Security and Privacy Lab](https://tsp.cs.tufts.edu/tmnt/threatmodeling.html). We discuss design decisions and potential STRIDE threats in a heterogeneous team of developers, our [CSOC ](https://www.glueckkanja.com/en/security/cloud-security-operations-center/)and PKI consultants, and support crew.

#### Prefer Platform Security to Custom Code

Where possible, we use functionality from .NET or established libraries, preferably Open Source, instead of re-inventing the wheel. For example, we use Legion of the Bouncy Castle C# for working with cryptographic data standards. We also rely on Azure services like Key Vault for generating cryptographic keys, App Services for webserver hosting, Azure Monitor for logging, and Azure Storage as database engine.

#### Secure Configuration is the Default

In order to minimize the potential for human error, we design the products such that you have a secure configuration if you use the defaults. For example, our [ARM templates](https://github.com/scepman/install) and our [Terraform provider ](https://registry.terraform.io/modules/scepman/scepman/)set configuration settings to use 4096-bit HSM-backed RSA keys, and they disable all enrollment endpoints except for Intune SCEP and Certificate Master (for which you have to explicitly assign permissions).

#### Never Trust Data from the Client

As a PKI software, deciding which data to trust is at the very heart of every decision. After all, the purpose of certificates and their enrollment protocols is deciding which data to trust.

#### Assume Breach

Our logging based on Azure Monitor allows surveillance of SCEPman's operations. It integrates easily with SIEM systems like Sentinel to detect successful attackers, e.g. if they succeeded to enroll certificates without authorization. Our integration with Azure Services allows leveraging the Microsoft Defender for Cloud services, e.g. Defender for App Service.

#### Enforce Least Privilege

Our RBAC model for Certificate Master allows to assign only those permissions to users that they really need.

SCEPman uses Managed Identities that have only [the permissions needed for operation](security-faq.md#id-4.-which-tenant-permissions-does-the-admin-have-to-consent-to).

#### Minimize Blast Radius

We strive to minimize the possible damage in case of a successful attack. For example, our default installation enables the Key Vault[ Soft Delete feature with Purge Protection](https://learn.microsoft.com/en-us/azure/key-vault/general/soft-delete-overview) with a [non-exportable HSM-backed private key](https://learn.microsoft.com/en-us/azure/key-vault/keys/about-keys#hsm-protected-keys) for the Certification Authority. Soft Delete with Purge Protection makes sure that no rogue admin or compromised admin account can delete the private key of the CA -- it can be restored in minutes to continue with normal operations and not even a Global Admin can purge it before a 90 days period. The non-exportable HSM-backed CA key makes sure that even an attacker with the highest possible privileges cannot steal the CA key.

#### Minimize Attack Surface

We make sure to expose only those interfaces required for operations by the customer. If a SCEP-endpoint is unconfigured, SCEP requests are not even processed.

Using [Private Endpoints](../azure-configuration/private-endpoints.md), we make sure that two services SCEPman depends on, Azure Key Vault and Azure Storage, are not reachable over the internet.

#### Consider Abuse Cases

When SCEPman receives an authorized certificate signing requests (CSRs), it is still subject to several configurable restrictions. For example, the lifetime can never exceed the [configured maximum validity period](../scepman-configuration/application-settings/certificates.md#appconfig-validityperioddays), even if this was requested.

#### Monitor and Alert on Security Events

If SCEPman detects Security Events, they will be logged as Warning or Error to the logs. The integration with Azure Monitor and Azure Event Hub makes it easy to [configure alerts](https://learn.microsoft.com/en-us/azure/azure-monitor/alerts/alerts-overview) or analyze these Security Events with a SIEM.

### 3. How do you secure your own development environment?

As part of a company that also provides CSOC services and security consulting, we have high security standards for our devices, processes, and user awareness. We are part of Microsoft MISA, ISO 27001-certified, and Microsoft Partner of the Year with our Security offerings.

Our source repositories have Branch Protection rules and we assign only the least necessary principles to the repositories and deployment pipelines to individual developer accounts. We automate tests and deployments where possible to reduce the attack surface using compromised accounts.

### 4. Is SCEPman part of a bug-bounty program?

No.

### 5. What QA measures are in place?

* We provide SCEPman on an internal-, beta-, and production channel
* Each production release must go through the internal- and beta-channel first, passing the relevant QA hurdles as part of our CI process
  * Unit tests
  * Peer review
  * Integration tests
  * Stress tests
  * Experience-based testing
  * 3rd-party code analysis, e.g. Sonar, Dependabot, and others

### 6. Do you regularly perform penetration tests?&#x20;

No.

As part of our Secure Development Practices, we employ tools (e.g. static code analysis) that scan the code base for CVEs and other common exploits (including dependencies such as 3rd party libraries) that could impact the security of the endpoints SCEPman exposes. Before any release, any relevant findings are assessed and remediated, to ensure SCEPman remains free from any known vulnerabilities. We neither perform penetration tests ourselves, nor do we use 3rd party "Penetration Test-as-a-Service" tools. For the former, we see an inherent conflict of interest. For the latter, since typical penetration test services often simply check the exposed endpoints against CVEs and other known exploits, we do not see any added value to the checks we already perform using static code analysis. If you wish to perform your own penetration tests, please [reach out to us](https://support.scepman.com/support/tickets/new?ticket_form=drop_a_question_%28scepman%29) and tell us about your requirements.
