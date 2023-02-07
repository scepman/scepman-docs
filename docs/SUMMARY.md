# Table of contents

* [Welcome](README.md)
* [Details](details.md)
* [Editions](editions.md)
* [Use Cases](use-cases.md)

## SCEPMAN Deployment

* [Getting Started](scepman-deployment/deployment-guides/README.md)
  * [Standard Guide](scepman-deployment/deployment-guides/community-guide.md)
  * [Extended Guide](scepman-deployment/deployment-guides/enterprise-guide-1.md)
* [Azure Sizing](scepman-deployment/azure-sizing.md)
* [Permissions](scepman-deployment/permissions/README.md)
  * [V1.x: Azure App Registration](scepman-deployment/permissions/azure-app-registration.md)
  * [🆕 V2.x: Managed Identities](scepman-deployment/permissions/post-installation-config.md)
* [Deployment Options](scepman-deployment/deployment-options/README.md)
  * [Marketplace deployment](scepman-deployment/deployment-options/marketplace-deployment.md)
  * [Enterprise deployment](scepman-deployment/deployment-options/enterprise-deployment.md)
* [Root Certificate](scepman-deployment/first-run-root-cert.md)
* [Uninstallation](scepman-deployment/uninstall.md)

## Architecture

* [Device Directories](architecture/device-directories.md)

## Certificate Deployment

* [Microsoft Intune](certificate-deployment/microsoft-intune/README.md)
  * [Windows](certificate-deployment/microsoft-intune/windows-10.md)
  * [macOS](certificate-deployment/microsoft-intune/macos.md)
  * [Android](certificate-deployment/microsoft-intune/android.md)
  * [iOS/iPadOS](certificate-deployment/microsoft-intune/ios.md)
* [Jamf](certificate-deployment/jamf/README.md)
  * [General Configuration](certificate-deployment/jamf/general.md)
  * [Computers](certificate-deployment/jamf/computers.md)
  * [Devices](certificate-deployment/jamf/devices.md)
  * [Users](certificate-deployment/jamf/users.md)
* [Certificate Master](certificate-deployment/certificate-master/README.md)
  * [Certificate Signing Request (CSR)](certificate-deployment/certificate-master/certificate-signing-request-csr.md)
  * [TLS Server Certificate PKCS#12](certificate-deployment/certificate-master/tls-server-certificate-pkcs-12.md)
  * [Manual Client Certificate PKCS#12](certificate-deployment/certificate-master/client-certificate-pkcs-12.md)
* [3rd-party MDM Solutions](certificate-deployment/static-certificates/README.md)
  * [Mosyle](certificate-deployment/static-certificates/mosyle.md)
* [Domain Controller Certificates](certificate-deployment/domain-controller-certificates.md)
* [Enrollment REST API](certificate-deployment/api-certificates.md)

## Certificate Management

* [Manage Certificates](certificate-management/certificate-view.md)

## Advanced Configuration

* [Application Artifacts](advanced-configuration/application-artifacts.md)
* [Application Insights](advanced-configuration/application-insights.md)
* [Application Settings](advanced-configuration/application-settings/README.md)
  * [Basics](advanced-configuration/application-settings/basics.md)
  * [Certificates](advanced-configuration/application-settings/certificates.md)
  * [Intune Validation](advanced-configuration/application-settings/intune-validation.md)
  * [Jamf Validation](advanced-configuration/application-settings/jamf-validation.md)
  * [DC Validation](advanced-configuration/application-settings/dc-validation.md)
  * [Static Validation](advanced-configuration/application-settings/static-validation.md)
  * [Static-AAD Validation](advanced-configuration/application-settings/staticaad-validation.md)
  * [Certificate Master](advanced-configuration/application-settings/csr-validation.md)
  * [REST API](advanced-configuration/application-settings/dbcsr-validation.md)
  * [Azure AD](advanced-configuration/application-settings/azure-ad.md)
  * [Azure KeyVault](advanced-configuration/application-settings/azure-keyvault.md)
  * [National Cloud platforms](advanced-configuration/application-settings/national-cloud-platforms.md)
* [Autoscaling](advanced-configuration/autoscaling.md)
* [Certificate Master Settings](advanced-configuration/application-settings-1/README.md)
  * [Basics](advanced-configuration/application-settings-1/basics.md)
  * [Azure AD](advanced-configuration/application-settings-1/azure-ad.md)
  * [National Cloud Platforms](advanced-configuration/application-settings-1/national-cloud-platforms.md)
* [Custom Domain](advanced-configuration/custom-domain.md)
* [Geo-redundancy](advanced-configuration/geo-redundancy.md)
* [Health Check](advanced-configuration/health-check.md)
* [Intermediate Certificate](advanced-configuration/intermediate-certificate.md)
* [License Key](advanced-configuration/add-a-license-key.md)
* [Log configuration](advanced-configuration/log-configuration.md)
* [Update Strategy](advanced-configuration/update-strategy.md)

## NAC Configuration

* [Network Access Controllers](nac-configuration/nac-configuration.md)

## Other

* [FAQs](other/faqs/README.md)
  * [Security & Privacy](other/faqs/security-faq.md)
  * [Certificate Connector](other/faqs/certificate-connector.md)
* [Troubleshooting](other/troubleshooting/README.md)
  * [Common Problems](other/troubleshooting/general.md)
  * [Certifried Security Vulnerability](other/troubleshooting/certifried.md)
  * [Cisco ISE Host Header Limitation](other/troubleshooting/cisco-ise-host-header-limitation.md)
  * [Re-enrollment trigger](other/troubleshooting/re-enrollment-trigger.md)
  * [View SCEPman issued certificates](other/troubleshooting/view-scepman-issued-certificates.md)
* [Important Links](other/important-links.md)

***

* [Change Log](changelog.md)
* [Licensing](licensing/README.md)
  * [Azure Marketplace](licensing/azure-marketplace.md)
* [Support](support.md)
* [SCEPman Website](https://scepman.com)
