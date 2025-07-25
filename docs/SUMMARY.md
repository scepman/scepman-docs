# Table of contents

* [Welcome](README.md)
* [Details](details.md)
* [Editions](editions.md)
* [Use Cases](use-cases.md)

## SCEPMAN Deployment

* [Getting Started](scepman-deployment/deployment-guides/README.md)
  * [Standard Guide](scepman-deployment/community-guide.md)
  * [Extended Guide](scepman-deployment/deployment-guides/enterprise-guide-1.md)
  * [Scenarios](scepman-deployment/deployment-guides/scenarios/README.md)
    * [Certificate-based Network Authentication](scepman-deployment/deployment-guides/scenarios/nac-configuration.md)
    * [Certificate-based Authentication for Entra ID](scepman-deployment/deployment-guides/scenarios/certificate-based-authentication-for-entra-id.md)
    * [Certificate-based Authentication for RDP](scepman-deployment/deployment-guides/scenarios/certificate-based-authentication-for-rdp.md)
* [Permissions](scepman-deployment/permissions/README.md)
  * [Azure App Registration](scepman-deployment/permissions/azure-app-registration.md)
  * [Managed Identities](scepman-configuration/post-installation-config.md)
* [Deployment Options](scepman-configuration/deployment-options/README.md)
  * [Marketplace deployment](scepman-configuration/deployment-options/marketplace-deployment.md)
  * [Enterprise deployment](scepman-configuration/deployment-options/enterprise-deployment.md)
  * [Terraform deployment](scepman-configuration/deployment-options/terraform-deployment.md)
* [Root CA](scepman-configuration/first-run-root-cert.md)
* [Intermediate CA](scepman-deployment/intermediate-certificate.md)

## Certificate Management

* [Revocation](certificate-management/manage-certificates.md)
* [Microsoft Intune](certificate-management/microsoft-intune/README.md)
  * [Windows](certificate-management/microsoft-intune/windows-10.md)
  * [macOS](certificate-management/microsoft-intune/macos.md)
  * [Android](certificate-management/microsoft-intune/android.md)
  * [iOS/iPadOS](certificate-management/microsoft-intune/ios.md)
  * [Linux](certificate-management/microsoft-intune/linux.md)
* [Jamf Pro](certificate-management/jamf/README.md)
  * [General Configuration](certificate-management/jamf/general.md)
  * [Computers](certificate-management/jamf/computers.md)
  * [Devices](certificate-management/jamf/devices.md)
  * [Users](certificate-management/jamf/users.md)
* [Other MDM Solutions](certificate-management/static-certificates/README.md)
  * [Addigy](certificate-management/static-certificates/kandji.md)
  * [Google Workspace](certificate-management/static-certificates/google-workspace/README.md)
    * [ChromeOS](certificate-management/static-certificates/google-workspace/chromeos.md)
  * [Kandji](certificate-management/static-certificates/kandji-1.md)
  * [Mosyle](certificate-management/static-certificates/mosyle.md)
  * [SOTI MobiControl](certificate-management/static-certificates/soti-mobicontrol.md)
* [Certificate Master](certificate-management/certificate-master/README.md)
  * [Manage Certificates](certificate-management/certificate-master/manage-certificates.md)
  * [Certificate Signing Request (CSR)](certificate-management/certificate-master/certificate-signing-request-csr.md)
  * [TLS Server Certificate](certificate-management/certificate-master/tls-server-certificate-pkcs-12.md)
  * [TLS Inspection (Sub CA) Certificate](certificate-management/certificate-master/sub-ca-certificate.md)
  * [Code Signing Certificate](certificate-management/certificate-master/code-signing-certificate.md)
  * [Device Certificate](certificate-management/certificate-master/client-certificate-pkcs-12.md)
  * [User Certificate](certificate-management/certificate-master/user-certificate.md)
* [Domain Controller Certificates](certificate-management/domain-controller-certificates.md)
* [Enrollment REST API](certificate-management/api-certificates/README.md)
  * [Self Service Enrollment](certificate-management/api-certificates/self-service-enrollment/README.md)
    * [Intune Managed Linux Client](certificate-management/api-certificates/self-service-enrollment/intune-managed-linux-client.md)
    * [Unmanaged Linux Client](certificate-management/api-certificates/self-service-enrollment/unmanaged-linux-client.md)
  * [API Enrollment](certificate-management/api-certificates/api-enrollment/README.md)
    * [Linux Server](certificate-management/api-certificates/api-enrollment/linux-server.md)
    * [Windows Server](certificate-management/api-certificates/api-enrollment/windows-server.md)
  * [SCEPmanClient](certificate-management/api-certificates/scepmanclient.md)

## Azure Configuration

* [Application Insights](azure-configuration/application-insights.md)
* [App Service Sizing](azure-configuration/azure-sizing/README.md)
  * [Autoscaling](azure-configuration/azure-sizing/autoscaling.md)
* [Custom Domain](azure-configuration/custom-domain.md)
* [Geo-Redundancy](azure-configuration/geo-redundancy.md)
* [Health Check](azure-configuration/health-check/README.md)
  * [Using 3rd Party Monitoring](azure-configuration/health-check/using-3rd-party-monitoring.md)
* [Log Management](azure-configuration/log-configuration.md)
* [Moving Resources](azure-configuration/move-scepman-resources.md)
* [Private Endpoints](azure-configuration/private-endpoints.md)
* [Split-Tenancy](scepman-configuration/optional/split-tenancy.md)

***

* [Update Strategy](update-strategy.md)

## SCEPman Configuration

* [SCEPman Settings](scepman-configuration/application-settings/README.md)
  * [Basics](scepman-configuration/application-settings/basics.md)
  * [Certificates](scepman-configuration/application-settings/certificates.md)
  * [Certificate Master](scepman-configuration/application-settings/csr-validation.md)
  * [CRL](scepman-configuration/application-settings/crl.md)
  * [Dependencies (Azure Services)](scepman-configuration/application-settings/dependencies-azure-services/README.md)
    * [Azure KeyVault](scepman-configuration/application-settings/dependencies-azure-services/azure-keyvault.md)
    * [Logging](scepman-configuration/application-settings/dependencies-azure-services/logging.md)
    * [Microsoft Entra ID (Azure AD)](scepman-configuration/application-settings/dependencies-azure-services/azure-ad.md)
    * [National Cloud Platforms](scepman-configuration/application-settings/dependencies-azure-services/national-cloud-platforms.md)
  * [Enrollment REST API](scepman-configuration/application-settings/dbcsr-validation.md)
  * [OCSP](scepman-configuration/application-settings/ocsp.md)
  * [SCEP Endpoints](scepman-configuration/application-settings/scep-endpoints/README.md)
    * [DC Validation](scepman-configuration/application-settings/scep-endpoints/dc-validation.md)
    * [Intune Validation](scepman-configuration/application-settings/scep-endpoints/intune-validation.md)
    * [Jamf Validation](scepman-configuration/application-settings/scep-endpoints/jamf-validation.md)
    * [Static Validation](scepman-configuration/application-settings/scep-endpoints/static-validation.md)
    * [Static-AAD Validation](scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md)
* [Certificate Master Settings](scepman-configuration/application-settings-1/README.md)
  * [Basics](scepman-configuration/application-settings-1/basics.md)
  * [Microsoft Entra ID (Azure AD)](scepman-configuration/application-settings-1/azure-ad.md)
  * [Logging](scepman-configuration/application-settings-1/logging.md)
  * [National Cloud Platforms](scepman-configuration/application-settings-1/national-cloud-platforms.md)
* [Application Artifacts](scepman-configuration/application-artifacts.md)
* [Certificate Master RBAC](scepman-configuration/rbac.md)
* [Device Directories](scepman-configuration/device-directories.md)
* [Intune Strong Mapping](scepman-configuration/intune-implementing-strong-mapping-for-scep-and-pkcs-certificates.md)

## Other

* [Security & Privacy](other/security-faq.md)
* [Support](other/support.md)
* [Licensing](other/licensing/README.md)
  * [Azure Marketplace](other/licensing/azure-marketplace.md)
  * [cleverbridge](other/licensing/cleverbridge.md)
* [FAQs](other/faqs/README.md)
  * [General](other/faqs/general.md)
  * [Certificate Connector](other/faqs/certificate-connector.md)
  * [Renewing SCEPman Root CA](other/faqs/renewing-scepman-root-ca.md)
* [Troubleshooting](other/troubleshooting/README.md)
  * [Common Problems](other/troubleshooting/general.md)
  * [Certifried Security Vulnerability](other/troubleshooting/certifried.md)
  * [Cisco ISE Host Header Limitation](other/troubleshooting/cisco-ise-host-header-limitation.md)
  * [Intune service discovery API permissions](other/troubleshooting/intune-service-discovery-api-permissions.md)
  * [Re-enrollment trigger](other/troubleshooting/re-enrollment-trigger.md)

***

* [Uninstallation](uninstall.md)
* [Change Log](changelog.md)
* [Links](important-links.md)
* [SCEPman Website](https://scepman.com)
