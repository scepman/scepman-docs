# Change Log

## Versions

<!--
### 2.5 - Upcoming

- Form for user certificates allow Smart-Card-Logon, e.g. for RDP or AVD SSO or import on smart cards like Yubikeys
-->

### 2.4 - Upcoming Release in April 2023

#### SCEPman 2.4.761 (currently in Beta Channel)

* [Improved CDP endpoint containing manually revoked certificates](scepman-configuration/optional/application-settings/crl.md#appconfig-crl-source)
* [Forward logs to Azure Monitor](advanced-configuration/application-settings/logging.md)
* Library and Framework updates, including .NET 7
* Minor bugfixes and improvements

#### Certificate Master 2.4.440 (currently in Beta Channel)

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

* [New UI with customizable filters to find view different kinds of certificates](certificate-management/certificate-view.md)
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
