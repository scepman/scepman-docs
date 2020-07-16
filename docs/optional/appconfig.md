# Application Settings

The section describes additional settings for the behavior of SCEPman. All of these are optional, though, and we recommend to just start with the defaults.

Settings can add or changed manually if needed. Some changes can harm your service, please note the information below.

On your **App Service** navigate to **Configuration** and then you find this under **Application settings**.

### AppConfig:BaseUrl

**Value:** _App Service Name_ or _https://customcname.domain.com_  
  
**Description:**  
This filed defines the public OCSP endpoint URL for the certificates. By default, the value contains the **App Service Name**. If you want to use a [Custom Domain](../03_customdomain.md), you need to change this value.

### AppConfig:LicenseKey

**Value:** _empty_ ****or ****_license key_

**Description:**  
If you are using a trial deployment or the community edition this field leaves empty. After you purchased the Enterprise Edition you will receive a license key from us, then you can insert this key into this setting.

### AppConfig:RemoteDebug

**Value:** _true_ or _false_

**Description:**  
You can send Debug log information to a cloud-based monitoring solution of our company for support reasons. This can speed up support cases. You can activate and deactivate this feature by changing the value to **true** or **false**.

### AppConfig:UseRequestedKeyUsages

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:  
True:** The Key Usage and Extended Key Usage extensions in the certificates are defined by the MDM solution.   
**False:** Key Usage is always Key Encipherment + Digital Signature. Extended Key Usage is always _Client Authentication_.

{% hint style="warning" %}
iOS devices do not support customized Extended Key Usages. Their certificates will always have _Client Authentication_ as Extended Key Usage.
{% endhint %}

### AppConfig:ValidityPeriodDays

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

### WEBSITE\_RUN\_FROM\_PACKAGE

This setting points to the Application Artifacts that will be loaded by starting the App Service.  
Please have a look at these instructions: [Application Artifacts](application-artifacts.md#change-artifacts).

### AppConfig:AuthConfig:ApplicationId

The Application ID from your Azure AD App registration. This setting is configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

### AppConfig:AuthConfig:ApplicationKey

The Application Key \(Client secret\) from your Azure AD App registration. This setting is configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

### AppConfig:AuthConfig:TenantName

The Azure AD Tenant ID. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

### AppConfig:KeyVaultConfig:KeyVaultURL

The Azure Key Vault URL. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

### AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName

The Root Certificate Name. This setting is automatically configured during the Root CA creation.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}

### AppConfig:KeyVaultConfig:RootCertificateConfig:Subject

The Root Certificate Subject. This setting is automatically configured during the Root CA creation.

{% hint style="danger" %}
Changes can harm you service!
{% endhint %}



