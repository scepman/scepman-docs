---
title: Changelog
order: 1
---

# Changelog

## Versions

### 1.9 - July 2021

* [JAMF User Certificates](../certificate-deployment/jamf/users.md)
* Update to the [Compliance Check Preview](../scepman-configuration/optional/application-settings.md#appconfig-intunevalidation-compliancecheck)
  * Also working for Windows devices during enrollment
* Improved [RADIUSaaService](https://www.radius-as-a-service.com/) compatibility
* Minor advancements
  * Improved error messages
  * Improved Compatibility with ISE with [a new default setting](../scepman-configuration/optional/application-settings.md#appconfig-keyvaultconfig-rootcertificateconfig-addextendedkeyusage)

### 1.8 - June 2021

* Improved robustness in exceptional situations
  * Correct answers to invalid OCSP requests, which may occur rarely for certificates issued by SCEPman 1.5 or ealier
  * [Certificate issuance scheduling in overload situations](../scepman-configuration/optional/application-settings.md#appconfig-concurrentsceprequestlimit)
  * Option to configure a "Clock Skew" for clients with clocks running slow \(&gt; 10 minutes\), which [happens in few tenants for Intune-managed Windows devices](troubleshooting/general.md#windows-10-devices-cannot-enroll-with-autopilot)
* Logging
  * Less log clutter on Info level
* Performance
  * Caching some repeated requests to Graph API

### 1.7 - May 2021

* Support for [Computer and Device Certificates via JAMF](../certificate-deployment/jamf/general.md)
* Separate Certificate Lifetimes for each endpoint, e.g. for [Domain Controller Certificates](../scepman-configuration/optional/application-settings.md#appconfig-dcvalidation-validityperioddays)
* [Secure application configuration in Key Vault](../scepman-configuration/optional/application-settings.md#secure-configuration-in-azure-key-vault)
* Moved release path to [https://github.com/scepman/install](https://github.com/scepman/install). Please update your setting WEBSITE\_RUN\_FROM\_PACKAGE as described in Section [Application Artifacts](../scepman-configuration/optional/application-artifacts.md).
* Preview of [Compliance Checks](../scepman-configuration/optional/application-settings.md#appconfig-intunevalidation-compliancecheck)
* Minor advancements
  * Work around a bug on some Android version to gain correct validity periods
  * SCEPman CA certificates receive an Extended Key Usage to improve compatibility with some versions of Cisco ISE
  * Further improvements to error messages
  * Updated some dependencies
  * Improved Homepage

#### 1.7.122 - June 2021

* Bugfix regarding OCSP checks for certificates issued via JAMF 

#### 1.7.140 - June 2021

* Solution for [Microsoft's additional permission requirements preventing SCEPman from issuing certificates via Intune](https://glueckkanja.zendesk.com/hc/en-us/articles/4402360224530-SCEPman-does-not-issue-certificates)

### 1.6 - November 2020

* Support for certificates for [Domain Controllers](../certificate-deployment/other-1/domain-controller-certificates.md), especially for use in Windows Hello for Business \(Enterprise Edition only\)
* Generic support for [3rd-party MDM systems via endpoint static](../certificate-deployment/other-1/static-certificates.md)
* Improved error logging
* Bug fixing

#### 1.6.465 - January 2021

* Bugfix where some OCSP requests were unanswered
* Bugfix impacting local logging

### 1.5 - July 2020

* Key Usage, Extended Key Usage, and validity period configured in the request \(i.e. in Intune\)
* Improved performance when answering to certificate and OCSP requests

### 1.4 - Mai 2020

* Performance enhancements
* Bug fixing

### 1.3 - October 2019

* Support for Authentication-Only user certificates \(VPN, Wifi, network\) in addition to device certificates.
* Support for Intune blade certificate list

### 1.2 - 2019

* Changed Log component

### 1.1 - 2019

* Support for SAN Attributes
* Sanity Checks
* First release of Community Edition

### 1.0 - 2019

* Initial release

