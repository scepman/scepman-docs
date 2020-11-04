# Application Settings

The section describes additional settings for the behavior of SCEPman. All of these are optional, though, and we recommend to just start with the defaults.

Settings can add or changed manually if needed. Some changes can harm your service, please note the information below.

On your **App Service** navigate to **Configuration** and then you find this under **Application settings**.

## AppConfig:BaseUrl

**Value:** _App Service Name_ or [https://customcname.domain.com](https://customcname.domain.com)

**Description:**  
This filed defines the public OCSP endpoint URL for the certificates. By default, the value contains the **App Service Name**. If you want to use a [Custom Domain](../custom-domain.md), you need to change this value.

## AppConfig:LicenseKey

**Value:** _empty_ **or** _license key_

**Description:**  
If you are using a trial deployment or the community edition this field leaves empty. After you purchased the Enterprise Edition you will receive a license key from us, then you can insert this key into this setting.

## AppConfig:RemoteDebug

**Value:** _true_ or _false_

**Description:**  
You can send Debug log information to a cloud-based monitoring solution of our company for support reasons. This can speed up support cases. You can activate and deactivate this feature by changing the value to **true** or **false**.

## AppConfig:AnonymousHomePageAccess

**Value:** _true_ or _false_

**Description:**  
When not configured or set to **true**, anyone in the internet knowing the app service's URL can access the SCEPman Homepage and see status information like the SCEPman version and whether SCEPman is up and running (except if you prevent this with a firewall). We consider this non-sensitive information, but if you want to hide it, set this to **false**. Then, the homepage is deactivated for browser access and this information is not visible anymore.

## AppConfig:UseRequestedKeyUsages

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** **True:** The Key Usage and Extended Key Usage extensions in the certificates are defined by the MDM solution.  
**False:** Key Usage is always Key Encipherment + Digital Signature. Extended Key Usage is always _Client Authentication_.

{% hint style="warning" %}
iOS devices do not support customized Extended Key Usages. Their certificates will always have _Client Authentication_ as Extended Key Usage.
{% endhint %}

## AppConfig:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _Integer_

**Description:**  
The maximum number of days that an issued certificate is valid. By default, this setting is not available and the validity period is **200 days.**

You can also configure shorter validity periods in each SCEP profile in Intune as described in the [Microsoft documentation](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-scep-configure#modify-the-validity-period-of-the-certificate-template).

{% hint style="warning" %}
iOS and macOS devices do not support the configuration via Intune and you need to configure this setting.
{% endhint %}

## AppConfig:IntuneValidation:WaitForSuccessNotificationResponse

{% hint style="info" %}
Applicable to version 1.6 \(currently internal\) and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** After a certificate was successfully issued, SCEPman sends a notification about the certificate to Intune. Microsoft recommends to wait for the response in its specification. However, some instances show long delays resulting in timeouts occasionally. Therefore **True** is the default.

Setting this to **False** makes SCEPman return the issued certificate before Intune answers to the notification. This is against the letters of the specification, but increases performance and avoids timeouts in instances where this issue arises.

## AppConfig:DCValidation:Enabled

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request Kerberos server certificates for your on-premises Domain Controllers. See [Domain Controller Certificates](domain-controller-certificates.md) for details.

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/dc`. Use in conjunction with AppConfig:DCValidation:RequestPassword. **False** \(default\): SCEPman does not issue certificates for Domain Controllers.

## AppConfig:DCValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that the Domain Controllers must include in every SCEP request to acquire a certificate. Only used if AppConfig:DCValidation:Enabled is set to _true_.

## WEBSITE\_RUN\_FROM\_PACKAGE

This setting points to the Application Artifacts that will be loaded by starting the App Service.  
Please have a look at these instructions: [Application Artifacts](application-artifacts.md#change-artifacts).

## AppConfig:AuthConfig:ApplicationId

The Application ID from your Azure AD App registration. This setting is configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

## AppConfig:AuthConfig:ApplicationKey

The Application Key \(Client secret\) from your Azure AD App registration. This setting is configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

## AppConfig:AuthConfig:TenantName

The Azure AD Tenant ID. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

## AppConfig:KeyVaultConfig:KeyVaultURL

The Azure Key Vault URL. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

## AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName

The Root Certificate Name. This setting is automatically configured during the Root CA creation.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

## AppConfig:KeyVaultConfig:RootCertificateConfig:Subject

The Root Certificate Subject. This setting is automatically configured during the Root CA creation.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

