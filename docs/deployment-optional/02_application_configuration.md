---
category: Deployment (Optional)
title: Application Configuration
order: 2
---

# Application Configuration

The section describes additional settings for the behavior of SCEPman. All of these are optional, though, and we recommend to just start with the defaults.

## Adding Additonal Configuration Values

Navigate to the SCEPman App Service in the Azure Portal. In the menu on the left side, *Configuration* under the Settings heading.

### System Settings

The deployment creates some settings that are required to run SCEPman. In regular cases, these system settings should not be changed and SCEPman may become erroneous if you do. Currently, the system settings are:

* AppConfig:AuthConfig:ApplicationId
* AppConfig:AuthConfig:ApplicationKey
* AppConfig:AuthConfig:TenantName
* AppConfig:BaseUrl
* AppConfig:KeyVaultConfig:KeyVaultURL
* AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName
* AppConfig:KeyVaultConfig:RootCertificateConfig:Subject

### User Settings

#### WEBSITE_RUN_FROM_PACKAGE

You can use this URL to switch to another deployment channel.

#### AppConfig:UseRequestedKeyUsages (v1.5 and above)

True: The MDM defines the Key Usage and Extended Key Usage extensions in the certificates.
False: Key Usage is always Key Encipherment + Digital Signature. Extended Key Usage is always *Client Authentication*.

#### AppConfig:RemoteDebug

#### AppConfig:ValidityPeriodDays (v1.5 and above)

The maximum number of days that an issued certificate is valid. Defaults to 200 days if not configured.

You can configure shorter validity periods in each SCEP profile in Intune as described in the [Microsoft documentation](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-scep-configure#modify-the-validity-period-of-the-certificate-template). Note however, that Intune does not support this feature on iOS and macOS platforms.

#### AppConfig:LicenseKey

See [Add a License Key](../configuration/add-a-license-key).