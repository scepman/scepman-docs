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
  * [V2.x: Managed Identities](scepman-deployment/permissions/post-installation-config.md)
* [Deployment Options](scepman-deployment/deployment-options/README.md)
  * [Marketplace deployment](scepman-deployment/deployment-options/marketplace-deployment.md)
  * [Enterprise deployment](scepman-deployment/deployment-options/enterprise-deployment.md)
  * [Terraform deployment](scepman-deployment/deployment-options/terraform-deployment.md)
* [Root Certificate](scepman-deployment/first-run-root-cert.md)
* [Uninstallation](scepman-deployment/uninstall.md)

## Architecture

* [Device Directories](architecture/device-directories.md)
* [Private Endpoints](architecture/private-endpoints.md)

## Certificate Deployment

* [Microsoft Intune](certificate-deployment/microsoft-intune/README.md)
  * [Windows](certificate-deployment/microsoft-intune/windows-10.md)
  * [macOS](certificate-deployment/microsoft-intune/macos.md)
  * [Android](certificate-deployment/microsoft-intune/android.md)
  * [iOS/iPadOS](certificate-deployment/microsoft-intune/ios.md)
* [Jamf Pro](certificate-deployment/jamf/README.md)
  * [General Configuration](certificate-deployment/jamf/general.md)
  * [Computers](certificate-deployment/jamf/computers.md)
  * [Devices](certificate-deployment/jamf/devices.md)
  * [Users](certificate-deployment/jamf/users.md)
* [Certificate Master](certificate-deployment/certificate-master/README.md)
  * [Certificate Signing Request (CSR)](certificate-deployment/certificate-master/certificate-signing-request-csr.md)
  * [TLS Server Certificate](certificate-deployment/certificate-master/tls-server-certificate-pkcs-12.md)
  * [Sub CA Certificate](certificate-deployment/certificate-master/sub-ca-certificate.md)
  * [Code Signing Certificate](certificate-deployment/certificate-master/code-signing-certificate.md)
  * [Client Certificate](certificate-deployment/certificate-master/client-certificate-pkcs-12.md)
  * [User Certificate](certificate-deployment/certificate-master/user-certificate.md)
* [Other MDM Solutions](certificate-deployment/static-certificates/README.md)
  * [Google Workspace](certificate-deployment/static-certificates/google-workspace/README.md)
    * [ChromeOS](certificate-deployment/static-certificates/google-workspace/chromeos.md)
  * [Kandji](certificate-deployment/static-certificates/kandji.md)
  * [Mosyle](certificate-deployment/static-certificates/mosyle.md)
  * [SOTI MobiControl](certificate-deployment/static-certificates/soti-mobicontrol.md)
* [Domain Controller Certificates](certificate-deployment/domain-controller-certificates.md)
* [Enrollment REST API](certificate-deployment/api-certificates.md)
* [Manage Certificates](certificate-deployment/manage-certificates.md)

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
  * [Enrollment REST API](advanced-configuration/application-settings/dbcsr-validation.md)
  * [Microsoft Entra ID (Azure AD)](advanced-configuration/application-settings/azure-ad.md)
  * [Azure KeyVault](advanced-configuration/application-settings/azure-keyvault.md)
  * [CRL](advanced-configuration/application-settings/crl.md)
  * [Logging](advanced-configuration/application-settings/logging.md)
  * [National Cloud platforms](advanced-configuration/application-settings/national-cloud-platforms.md)
* [Autoscaling](advanced-configuration/autoscaling.md)
* [Certificate Master Settings](advanced-configuration/application-settings-1/README.md)
  * [Basics](advanced-configuration/application-settings-1/basics.md)
  * [Microsoft Entra ID (Azure AD)](advanced-configuration/application-settings-1/azure-ad.md)
  * [Logging](advanced-configuration/application-settings-1/logging.md)
  * [National Cloud Platforms](advanced-configuration/application-settings-1/national-cloud-platforms.md)
* [Certificate Master RBAC](advanced-configuration/rbac.md)
* [Custom Domain](advanced-configuration/custom-domain.md)
* [Geo-Redundancy](advanced-configuration/geo-redundancy.md)
* [Health Check](advanced-configuration/health-check/README.md)
  * [Using 3rd Party Monitoring](advanced-configuration/health-check/using-3rd-party-monitoring.md)
* [Intermediate CA](advanced-configuration/intermediate-certificate.md)
* [License Key](advanced-configuration/add-a-license-key.md)
* [Log Configuration](advanced-configuration/log-configuration.md)
* [Split-Tenancy](advanced-configuration/split-tenancy.md)
* [Update Strategy](advanced-configuration/update-strategy.md)

## NAC Configuration

* [Network Access Controllers](nac-configuration/nac-configuration.md)

## Other

* [FAQs](other/faqs/README.md)
  * [General](other/faqs/general.md)
  * [Security & Privacy](other/faqs/security-faq.md)
  * [Certificate Connector](other/faqs/certificate-connector.md)
  * [Intune implementing strong mapping for SCEP and PKCS certificates](other/faqs/intune-implementing-strong-mapping-for-scep-and-pkcs-certificates.md)
* [Troubleshooting](other/troubleshooting/README.md)
  * [Common Problems](other/troubleshooting/general.md)
  * [Certifried Security Vulnerability](other/troubleshooting/certifried.md)
  * [Cisco ISE Host Header Limitation](other/troubleshooting/cisco-ise-host-header-limitation.md)
  * [Intune service discovery API permissions](other/troubleshooting/intune-service-discovery-api-permissions.md)
  * [Re-enrollment trigger](other/troubleshooting/re-enrollment-trigger.md)
* [Important Links](other/important-links.md)

***

* [Change Log](changelog.md)
* [Licensing](licensing/README.md)
  * [Azure Marketplace](licensing/azure-marketplace.md)
* [Support](support.md)
* [SCEPman Website](https://scepman.com)
