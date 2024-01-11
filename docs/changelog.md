# Change Log

## Versions

### 2.7 - Currently in Internal Channel

#### SCEPman

* SCEPman's EST endpoint allows certificate renewal using mTLS. This is useful for unmanaged devices like web servers and Linux clients.
* Device certificates enrolled via Intune can now contain any Subject, as long as they have a URI in the Subject Alternative Name in the format `IntuneDeviceId://{{DeviceId}}`.
* SCEPman can use a User-Assigned Managed Identity instead of a System-Assigned Managed Identity. This is useful for large geo-redundant deployments, where you do not want to configure the System-assigned Managed Identity on all instances.
* Fixes and small improvements

#### Certificate Master

* When downloading certificates in PFX format, you can select whether to use a modern cryptographic algorithm required for example by OpenSSL 2.x or a legacy algorithm required by MacOS and Windows Server 2016.
* Small improvements, including:
  * Logging to Azure Event Hub like SCEPman
  * Document Signing Certificates

### 2.6 - November 2023

#### SCEPman 2.6.945

* Logging to [Azure Event Hub](advanced-configuration/application-settings/logging.md#appconfig-loggingconfig-azureeventhubconnectionstring)
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

* Define an [enrollment grace period](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-compliancegraceperiodminutes), during which devices are allowed to be incompliant.
* SCEPman can [add extension 1.3.6.1.4.1.311.25.2 with the users' Security Identifiers (SIDs)](scepman-configuration/optional/application-settings/certificates.md#appconfig-addsidextension) to certificates, mitigating [Certifried attacks](other/troubleshooting/certifried.md)
* [Performance improved by around factor 4](scepman-deployment/azure-sizing.md)
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
* [RBAC roles](advanced-configuration/rbac.md)
* Library Updates
* Minor bugfixes and improvements, including
  * UI search button bugfix
  * Prevent double submissions of CSRs
  * Algorithms with improved compatibility (e.g. AES and SHA-256 for PKCS#12 CertBags)

### 2.4 - April 2023

#### SCEPman 2.4.772

* [Improved CDP endpoint containing manually revoked certificates](scepman-configuration/optional/application-settings/crl.md#appconfig-crl-source)
* [Log to Azure Monitor](advanced-configuration/application-settings/logging.md)
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

* [CSR submission REST API](certificate-deployment/api-certificates.md)
* Store certificates issued via [Jamf](advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-enablecertificatestorage), [Static](advanced-configuration/application-settings/static-validation.md#appconfig-staticvalidation-enablecertificatestorage), [Static-AAD](advanced-configuration/application-settings/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage), and [DC](advanced-configuration/application-settings/dc-validation.md#appconfig-dcvalidation-enablecertificatestorage) endpoints in Storage Account (and allow manual revocation in Certificate Master)
* Partial support of ECC CAs
* Better error messages on some faults
* Improvements to compliance checks
  * An additional extension better suppresses usage of ephemeral certificates on Windows
  * An additional SCEP endpoint for Apple devices prevents issuance of ephemeral certificates
* [Fake CDP endpoint](scepman-configuration/optional/application-settings/crl.md) for cases where a CRL is technically required (the CRL contains no entries yet, though)
* Minor bugfixes/improvements

#### Certificate Master 2.3.327

* [New UI with customizable filters to find view different kinds of certificates](certificate-deployment/manage-certificates.md#search-for-certificates-in-the-certificate-database)
* Better compatibility with Microsoft's API changes to list certificate issued via Intune
* Minor improvements

### 2.2 - October 2022

* Improved installation experience

#### SCEPman 2.2.631

* [Revoke Intune certificates on some MEM events](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory)
* [Intune-enrolled user certificates become invalid when user risk exceeds a configured threshold](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-userriskcheck) (requires an additional permission for which you must [re-run the SCEPman configuration script](scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet))
* [Additional static SCEP endpoint with AAD-bound certificates](advanced-configuration/application-settings/staticaad-validation.md)
* Library updates

#### SCEPman Certificate Master 2.2.282

* UI improvements
* Additional certificate file formats for Certificate Master
* Certificate Master lists issued client certificates for manual revocation (requires an additional permission for which you must [re-run the SCEPman configuration script](scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet))
* Library updates

### 2.1.522 - May 2022

* [Request Client Certificates manually through Certificate Master](certificate-deployment/certificate-master/client-certificate-pkcs-12.md)
* Library and Framework updates
  * Improved Performance with .NET 6
  * Other library updates
* Robustness
* Bearer Authentication for Jamf Classic API
* [Invalidate certificates for Intune devices with pending wipes or otherwise unhealthy management states](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-revokecertificatesonwipe)
* Minor Improvements

### 2.0.473 - March 2022

* [Certificate Management](certificate-deployment/certificate-master/)
  * Manually issue TLS Server certificates
  * Revoke manually issued certificates
  * Search for manual certificates
* Library and Framework updates
  * Improved Performance with .NET 5
  * Azure Key Vault
  * Other library updates
* [Easier deployment, no manual app registraton required anymore](scepman-configuration/post-installation-config.md)
* [Select whether to use AAD or Intune directory for device validity checks](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory)
* New UI
  * So beautiful and with a new logo
  * Detailed information on activated SCEP endpoints
* [Compatibility with GCC High, GCC DoD, and 21Vianet environments](scepman-configuration/optional/application-settings/national-cloud-platforms.md)
* Various minor improvements

### 1.9.207 - July 2021

* [JAMF User Certificates](certificate-deployment/jamf/users.md)
* Update to the [Compliance Check Preview](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-compliancecheck)
  * Also working for Windows devices during enrollment
* Improved [RADIUS-as-a-Service](https://www.radius-as-a-service.com) compatibility
* Minor advancements
  * Improved error messages
  * Improved Compatibility with ISE with [a new default setting](scepman-configuration/optional/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-addextendedkeyusage)

### 1.8.155 - June 2021

* Improved robustness in exceptional situations
  * Correct answers to invalid OCSP requests, which may occur rarely for certificates issued by SCEPman 1.5 or earlier
  * [Certificate issuance scheduling in overload situations](scepman-configuration/optional/application-settings/certificates.md#appconfig-concurrentsceprequestlimit)
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

* Support for [Computer and Device Certificates via JAMF](certificate-deployment/jamf/general.md)
* Separate Certificate Lifetimes for each endpoint, e.g. for [Domain Controller Certificates](advanced-configuration/application-settings/dc-validation.md#appconfig-dcvalidation-validityperioddays)
* [Secure application configuration in Key Vault](advanced-configuration/application-settings/#secure-configuration-in-azure-key-vault)
* Moved the release path to [https://github.com/scepman/install](https://github.com/scepman/install). Please update your setting WEBSITE\_RUN\_FROM\_PACKAGE as described in Section [Application Artifacts](advanced-configuration/application-artifacts.md).
* Preview of [Compliance Checks](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-compliancecheck)
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

* Support for certificates for [Domain Controllers](certificate-deployment/domain-controller-certificates.md), especially for use in Windows Hello for Business (Enterprise Edition only)
* Generic support for [3rd-party MDM systems via endpoint static](certificate-deployment/static-certificates/)
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
