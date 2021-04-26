---
title: Changelog
order: 1
---

# Changelog

## Versions

### 1.7 - April 2021 (Currently in Internal Channel)

* Support for [JAMF Computer and Device Certificates](../certificate-deployment/jamf/general.md)
* Separate Certificate Lifetimes for each endpoint, e.g. for [Domain Controller Certificates](../scepman-configuration/optional/application-settings.md#AppConfig-DCValidation-ValidityPeriodDays)
* [Secure application configuration in Key Vault](../scepman-configuration/optional/application-settings.md#Secure-Configuration-in-Azure-Key-Vault)
* Moved release path to https://github/scepman/install. Please update your setting WEBSITE_RUN_FROM_PACKAGE as described in [Section Application Artifacts](../scepman-configuration/optional/application-artifacts.md).
* Preview of [Compliance Checks](../scepman-configuration/optional/application-settings.md#appconfig-intunevalidation-compliancecheck)
* Minor advancements
  - Work around a bug on some Android version to gain correct validity periods
  - SCEPman CA certificates receive an Extended Key Usage to improve compatibility with some versions of Cisco ISE
  - Further improvements to error messages
  - Updated some dependencies
  - Improved Homepage

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

## Roadmap

### 1.7

* Update to .NET 5.0 \(increased performance\)
* Full JAMF integration

### Currently in Research

* More options from GraphAPI

  Use compliance state in addition to active device information.

* Intune auto-configuration
* Additional certificate revocation options

