# Change Log

{% hint style="success" %}
If you'd like to **stay up to date on the latest changes and news in the SCEPman changelog**, you can subscribe to our email update service. Subscribers will receive **email notifications** when there are new updates to the changelog.

[**Please click here to sign up for email notifications.**](https://feedback.scepman.com/)
{% endhint %}

## Versions

### 2.10 - Mai 2025

#### SCEPman 2.10.1404

* Smaller Improvements, e.g.
  * Increased robustness when dependent services fail
  * Updates to the SCEPman splash page
  * Adjusted log levels of some log messages to avoid clutter and highlight important messages
  * Allow adding a CDP to issued certificates
  * Specify a specific version of a Key Vault certificate as CA certificate
* Library Updates, including
  * an update to Microsoft.Identity.Web 3.8.2, fixing [CVE-2025-32016](https://www.cve.org/CVERecord?id=CVE-2025-32016)

#### Certificate Master 2.10.997

* Overhaul of Certificate Request UI
* Submission of CSR for web servers (requires SCEPman 2.10)
  * Allowed for users with the Request.Server role in addition to those with Request.All and Admin.Full
  * Users can modify the SAN DNS entries in the enrollment form
* Improved performance when creating certificates via the forms method
* Smaller Improvements, e.g.
  * Fixed an issue where the "Forbidden" page was not displayed to unauthorized users
  * SAN entries of type IP
  * The User certificates form features adding email addresses as SAN entries
* Library Updates, including
  * an update to Microsoft.Identity.Web 3.8.2, fixing [CVE-2025-32016](https://www.cve.org/CVERecord?id=CVE-2025-32016)

### 2.9 - December 2024

**SCEPman 2.9.1294**

* [Certificate self-service enrollment via EST/REST API](certificate-management/api-certificates/self-service-enrollment/)
* [ClientID/ClientSecret support in Jamf](scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-clientid)
* [Authorized Responders for OCSP Requests](scepman-configuration/application-settings/ocsp.md#appconfig-ocsp-authorizedrespondervalidityhours)
* Smaller improvements, e.g.
  * Configure default EKUs for the REST API, allowing you to enforce specific EKUs
  * Logging improvements to make the log more concise
  * Improved connectivity status evaluation on splash page
  * OCSP Response for the status of SCEPman's CA certificate (for compatibility with a Palo Alto setup)
* Library Updates, including
  * the update to Azure.Identity 1.12, fixing [CVE-2024-35255](https://www.cve.org/CVERecord?id=CVE-2024-35255),
  * the update to Bouncy Castle .NET 2.4, fixing [CVE-2024-29857](https://github.com/bcgit/bc-csharp/wiki/CVE%E2%80%902024%E2%80%9029857).

**Certificate Master 2.9.858**

* Smaller improvements
* Library Updates, including
  * the update of Azure.Identity to 1.12, fixing [CVE-2024-35255](https://www.cve.org/CVERecord?id=CVE-2024-35255),
  * the update to Bouncy Castle .NET 2.4, fixing [CVE-2024-29857](https://github.com/bcgit/bc-csharp/wiki/CVE%E2%80%902024%E2%80%9029857).

**SCEPman PowerShell Module 2.9**

Starting with this version, the SCEPman PowerShell Module with have the same major and minor version number as the corresponding SCEPman release.

* New CMDlet `Update-CertificateViaEST` for[ renewing certificates over EST](https://docs.scepman.com/certificate-deployment/api-certificates/use-cases/windows-server) on Windows

### 2.8 - May 2024

**SCEPman 2.8.1225**

* Fix for CRL generation if SCEPman is a Subordinate Certification Authority.

**SCEPman 2.8.1155**

* SCEPman uses a newer URL and data format for the Jamf Bearer authentication, which is required when using Jamf \~11.5.0 and newer, which has disabled the older URL alongside Basic Authentication

**SCEPman 2.8.1135**

* Improvements to OCSP response times
* Logging improvements
  * Tweaking of log levels to better emphasize important information
  * Additional information about certificate revocations
  * Less log clutter
  * A transaction ID in the logs allows to correlate log entries that belong to the same SCEP or OCSP request
* Configure default Extended Key Usages (EKUs) and Key Usages for each SCEP endpoint, e.g. if [you want to enroll smart-card authentication certificates through Jamf](scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-defaultekus)
* Update to .NET 8
* Library updates
  * Including the update of Azure.Identity to 1.11, fixing [CVE-2024-29992](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-29992). Currently, the exploit is not publicly disclosed, so the scope of the issue is unclear, but the published information indicates that SCEPman is likely not affected.
* Small improvements, including:
  * Use a Managed Identity when logging to Azure Event Hub

**Certificate Master 2.8.773**

* Live Revocation Check telling whether a certificate is currently valid and explaining the reason if it isn't
* Update to .NET 8
* Library updates
  * Including the update of Azure.Identity to 1.11, fixing [CVE-2024-29992](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2024-29992). Currently, the exploit is not publicly disclosed, so the scope of the issue is unclear, but the published information indicates that SCEPman is likely not affected.
* Small fixes and improvements including:
  * Fixed a bug where the certificates were not displayed when there was a certificate in the list without CN field.
  * Fixed a bug where a user with only the MANAGE\_INTUNE or MANAGE\_INTUNE\_READ role couldn't see revoked certificates enrolled over Intune.

### 2.7 - February 2024

#### SCEPman 2.7.1068

* Fixed an issue where device certificates were bound to their Intune objects where they should have been bound to their Entra ID objects.

#### SCEPman 2.7.1052

* Fixed an issue with generating the Root CA in new installations of SCEPman.

#### SCEPman 2.7.1049

* Support storing certificates enrolled via Intune in the Storage Account for easier searching.
* SCEPman's EST endpoint allows certificate renewal using mTLS ("simplereenroll"). This is useful for unmanaged devices like web servers and Linux clients.
* Device certificates enrolled via Intune can now contain any Subject, as long as they have a URI in the Subject Alternative Name in the format `IntuneDeviceId://{{DeviceId}}`.
* SCEPman can use a User-Assigned Managed Identity instead of a System-Assigned Managed Identity. This is useful for large geo-redundant deployments, where you do not want to configure the System-assigned Managed Identity on all instances.
* Fixes and small improvements, including:
  * Automatic analysis of OCSP responses with performance issues

#### Certificate Master 2.7.705

* Fixed a case of a broken view of manually revoked certificates enrolled via Intune.

#### Certificate Master 2.7.702

* Show certificates enrolled via Intune from the Storage Account.
* When downloading certificates in PFX format, you can select whether to use a modern cryptographic algorithm required for example by OpenSSL 2.x or a legacy algorithm required by MacOS and Windows Server 2016.
* Small improvements, including:
  * Improved performance for large numbers of certificates in the database
  * Logging to Azure Event Hub like SCEPman
  * Document Signing Certificates
  * Adjustable PFX password length with a default of 24 instead of 32 characters for increased compatibility

### 2.6 - November 2023

#### SCEPman 2.6.945

* Logging to [Azure Event Hub](scepman-configuration/application-settings/dependencies-azure-services/logging.md#appconfig-loggingconfig-azureeventhubconnectionstring)
* Library Updates, including the update to Azure.Identity 1.10.3, fixing [CVE-2023-36414](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-36414). Currently, the exploit is not publicly disclosed, so the scope of the issue is unclear, but the published information indicates that SCEPman is likely not affected.
* Robustness for various special cases

#### Certificate Master 2.6.586

* Select Extended Key Usages for each certificate
* Library Updates, including the update to Azure.Identity 1.10.3, fixing [CVE-2023-36414](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2023-36414). Currently, the exploit is not publicly disclosed, so the scope of the issue is unclear, but the published information indicates that Certificate Master is likely not affected.
* Small UI improvements

### 2.5 - July 2023

#### SCEPman 2.5.895

* Bugfix: OCSP Responses encoded GeneralizedTime with fraction of seconds, which is not compliant to RFC 5280, Section 4.1.2.5.2 and caused some clients to reject the OCSP response (we know about Checkpoint).

#### SCEPman 2.5.892

* Define an [enrollment grace period](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-compliancegraceperiodminutes), during which devices are allowed to be incompliant.
* SCEPman can [add extension 1.3.6.1.4.1.311.25.2 with the users' Security Identifiers (SIDs)](scepman-configuration/application-settings/certificates.md#appconfig-addsidextension) to certificates, mitigating [Certifried attacks](other/troubleshooting/certifried.md)
* [Performance improved by around factor 4](azure-configuration/azure-sizing/)
* Library Updates
* Bugfixes and small improvements, including:
  * streamlined GCC High installation experience
  * UI improvements
  * Robustness for some special cases

#### Certificate Master 2.5.542

* Improvement/fix for displaying Intune certificates

#### Certificate Master 2.5.516

* Download certificates + private keys in PEM format
* Revocation audit trail
* [RBAC roles](scepman-configuration/rbac.md)
* Library Updates
* Minor bugfixes and improvements, including
  * UI search button bugfix
  * Prevent double submissions of CSRs
  * Algorithms with improved compatibility (e.g. AES and SHA-256 for PKCS#12 CertBags)

### 2.4 - April 2023

#### SCEPman 2.4.772

* [Improved CDP endpoint containing manually revoked certificates](scepman-configuration/application-settings/crl.md#appconfig-crl-source)
* [Log to Azure Monitor](scepman-configuration/application-settings/dependencies-azure-services/logging.md)
* Library and Framework updates, including .NET 7
* Bugfixes and improvements

#### Certificate Master 2.4.445

* Form to request Code Signing certificates
* Form to request Sub CA certificates, e.g. for Firewalls that inspect TLS traffic
* Form to manually request user certificates for Client Authentication, e.g. on websites
* UI optimizations
* Library and Framework updates, including .NET 7
* Minor bugfixes and improvements, including:
  * In some cases, revoked Intune certificates were still display in the list of Intune certificates
  * Hide Intune certificates that are not issued by SCEPman
  * Certificates for Jamf devices could show up as "Unknown" in the list of Jamf certificates

### 2.3 - January 2023

#### SCEPman 2.3.723

* [CSR submission REST API](certificate-management/api-certificates/)
* Store certificates issued via [Jamf](scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-enablecertificatestorage), [Static](scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage), [Static-AAD](scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage), and [DC](scepman-configuration/application-settings/scep-endpoints/dc-validation.md#appconfig-dcvalidation-enablecertificatestorage) endpoints in Storage Account (and allow manual revocation in Certificate Master)
* Partial support of ECC CAs
* Better error messages on some faults
* Improvements to compliance checks
  * An additional extension better suppresses usage of ephemeral certificates on Windows
  * An additional SCEP endpoint for Apple devices prevents issuance of ephemeral certificates
* [Fake CDP endpoint](scepman-configuration/application-settings/crl.md) for cases where a CRL is technically required (the CRL contains no entries yet, though)
* Minor bugfixes/improvements

#### Certificate Master 2.3.327

* [New UI with customizable filters to find view different kinds of certificates](certificate-management/manage-certificates.md#search-for-certificates-in-the-certificate-database)
* Better compatibility with Microsoft's API changes to list certificate issued via Intune
* Minor improvements

### 2.2 - October 2022

* Improved installation experience

#### SCEPman 2.2.631

* [Revoke Intune certificates on some MEM events](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-devicedirectory)
* [Intune-enrolled user certificates become invalid when user risk exceeds a configured threshold](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-userriskcheck) (requires an additional permission for which you must [re-run the SCEPman configuration script](scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet))
* [Additional static SCEP endpoint with AAD-bound certificates](scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md)
* Library updates

#### SCEPman Certificate Master 2.2.282

* UI improvements
* Additional certificate file formats for Certificate Master
* Certificate Master lists issued client certificates for manual revocation (requires an additional permission for which you must [re-run the SCEPman configuration script](scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet))
* Library updates

### 2.1.522 - May 2022

* [Request Client Certificates manually through Certificate Master](certificate-management/certificate-master/client-certificate-pkcs-12.md)
* Library and Framework updates
  * Improved Performance with .NET 6
  * Other library updates
* Robustness
* Bearer Authentication for Jamf Classic API
* [Invalidate certificates for Intune devices with pending wipes or otherwise unhealthy management states](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-revokecertificatesonwipe)
* Minor Improvements

### 2.0.473 - March 2022

* [Certificate Management](certificate-management/certificate-master/)
  * Manually issue TLS Server certificates
  * Revoke manually issued certificates
  * Search for manual certificates
* Library and Framework updates
  * Improved Performance with .NET 5
  * Azure Key Vault
  * Other library updates
* [Easier deployment, no manual app registraton required anymore](scepman-configuration/post-installation-config.md)
* [Select whether to use AAD or Intune directory for device validity checks](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-devicedirectory)
* New UI
  * So beautiful and with a new logo
  * Detailed information on activated SCEP endpoints
* [Compatibility with GCC High, GCC DoD, and 21Vianet environments](scepman-configuration/application-settings/dependencies-azure-services/national-cloud-platforms.md)
* Various minor improvements

### 1.9.207 - July 2021

* [JAMF User Certificates](certificate-management/jamf/users.md)
* Update to the [Compliance Check Preview](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-compliancecheck)
  * Also working for Windows devices during enrollment
* Improved [RADIUS-as-a-Service](https://www.radius-as-a-service.com) compatibility
* Minor advancements
  * Improved error messages
  * Improved Compatibility with ISE with [a new default setting](scepman-configuration/application-settings/dependencies-azure-services/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-addextendedkeyusage)

### 1.8.155 - June 2021

* Improved robustness in exceptional situations
  * Correct answers to invalid OCSP requests, which may occur rarely for certificates issued by SCEPman 1.5 or earlier
  * [Certificate issuance scheduling in overload situations](scepman-configuration/application-settings/certificates.md#appconfig-concurrentsceprequestlimit)
  * Option to configure a "Clock Skew" for clients with clocks running slow (> 10 minutes), which [happens in few tenants for Intune-managed Windows devices](other/troubleshooting/general.md#windows-10-devices-cannot-enroll-with-autopilot)
* Logging
  * Less log clutter on Info level
* Performance
  * Caching some repeated requests to Graph API

#### 1.7.140 - June 2021

* Solution for [Microsoft's additional permission requirements preventing SCEPman from issuing certificates via Intune](https://glueckkanja.zendesk.com/hc/en-us/articles/4402360224530-SCEPman-does-not-issue-certificates)

#### 1.7.122 - June 2021

* Bugfix regarding OCSP checks for certificates issued via JAMF

### 1.7.101 - May 2021

* Support for [Computer and Device Certificates via JAMF](certificate-management/jamf/general.md)
* Separate Certificate Lifetimes for each endpoint, e.g. for [Domain Controller Certificates](scepman-configuration/application-settings/scep-endpoints/dc-validation.md#appconfig-dcvalidation-validityperioddays)
* [Secure application configuration in Key Vault](scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault)
* Moved the release path to [https://github.com/scepman/install](https://github.com/scepman/install). Please update your setting WEBSITE\_RUN\_FROM\_PACKAGE as described in Section [Application Artifacts](scepman-configuration/application-artifacts.md).
* Preview of [Compliance Checks](scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-compliancecheck)
* Minor advancements
  * Workaround a bug on some Android versions to gain correct validity periods
  * SCEPman CA certificates receive an Extended Key Usage to improve compatibility with some versions of Cisco ISE
  * Further improvements to error messages
  * Updated some dependencies
  * Improved Homepage

### 1.6.465 - January 2021

* Bugfix where some OCSP requests were unanswered
* Bugfix impacting local logging

### 1.6.455 - November 2020

* Support for certificates for [Domain Controllers](certificate-management/domain-controller-certificates.md), especially for use in Windows Hello for Business (Enterprise Edition only)
* Generic support for [Other MDM systems via endpoint static](certificate-management/static-certificates/)
* Improved error logging
* Bug fixing

### 1.5 - July 2020

* Key Usage, Extended Key Usage, and validity period configured in the request (i.e. in Intune)
* Improved performance when answering certificate and OCSP requests

### 1.4 - Mai 2020

* Performance enhancements
* Bug fixing

### 1.3 - October 2019

* Support for Authentication-Only user certificates (VPN, Wifi, network) in addition to device certificates.
* Support for Intune blade certificate list

### 1.2 - 2019

* Changed Log component

### 1.1 - 2019

* Support for SAN Attributes
* Sanity Checks
* First release of Community Edition

### 1.0 - 2019

* Initial release
