---
title: Changelog
order: 1
---

# Changelog

## Versions

### 1.6 - November 2020

* Bug fixing
* Support for certificates for [Domain Controllers](../scepman-configuration/optional/domain-controller-certificates), especially for use in Windows Hello for Business (Enterprise Edition only)
* Generic support for [3rd-party MDM systems via endpoint static](../scepman-configuration/optional/static-certificates)
* Improved error logging

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

* Update to .NET 5.0 (increased performance)

* Full JAMF integration

### Currently in Research

* More options from GraphAPI

  Use compliance state in addition to active device information.

* Intune auto-configuration

* Additional certificate revocation options