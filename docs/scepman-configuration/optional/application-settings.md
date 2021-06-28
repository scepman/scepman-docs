# Application Settings

The section describes additional settings for the behavior of SCEPman. All of these are optional, though, and we recommend to just start with the defaults.

Settings can be added or changed manually if needed. Some changes can harm your service. Please carefully read all information about a setting before changing.

For each Setting, you can choose whether you want to define the setting in the App Service Configuration or in Azure Key Vault. If you define the same setting in both places, Azure Key Vault takes precedence.

## Convenient Configuration in the App Service Configuration

On your **App Service** navigate to **Configuration** and then you find this under **Application settings**. Use the setting names as described below.

We recommend to define settings in the App Service Configuration except for passwords.

## Secure Configuration in Azure Key Vault

{% hint style="info" %}
This feature requires version **1.7** or above.
{% endhint %}

Especially for sensitive information, you can also configure settings as Secrets in Azure Key Vault. You must first grant edit rights to Secrets in the Azure Key Vault associated with your SCEPman instance to an administrator account. Then, you can use this administrator account to define new Secrets.

**Remark:** Use double dashes instead of colons in configuration names! For example, instead of _AppConfig:DCValidation:RequestPassword_, the Secret must be named _AppConfig--DCValidation--RequestPassword_.

We recommend to use this type of configuration only for sensitive information.

## List of Settings

### AppConfig:BaseUrl

**Value:** _App Service Name_ or [https://customcname.domain.com](https://customcname.domain.com)

**Description:**  
This filed defines the public OCSP endpoint URL for the certificates. By default, the value contains the **App Service Name**. If you want to use a [Custom Domain](custom-domain.md), you need to change this value.

### AppConfig:LicenseKey

**Value:** _empty_ **or** _license key_

**Description:**  
If you are using a trial deployment or the community edition this field leaves empty. After you purchased the Enterprise Edition you will receive a license key from us, then you can insert this key into this setting.

### AppConfig:RemoteDebug

**Value:** _true_ or _false_

**Description:**  
You can send Debug log information to a cloud-based monitoring solution of our company for support reasons. This can speed up support cases. You can activate and deactivate this feature by changing the value to **true** or **false**.

### AppConfig:AnonymousHomePageAccess

**Value:** _true_ or _false_

**Description:**  
When not configured or set to **true**, anyone in the internet knowing the app service's URL can access the SCEPman Homepage and see status information like the SCEPman version and whether SCEPman is up and running \(except if you prevent this with a firewall\). We consider this non-sensitive information, but if you want to hide it, set this to **false**. Then, the homepage is deactivated for browser access and this information is not visible anymore.

### AppConfig:UseRequestedKeyUsages

{% hint style="info" %}
Applicable to version 1.5 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** **True:** The Key Usage and Extended Key Usage extensions in the certificates are defined by the MDM solution.  
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
The maximum number of days that an issued certificate is valid. By default, this setting is not available and the validity period is **200 days**. SCEPman never issues certificates with a longer validity than the value defined here. There are ways to reduce validity for specific certificates, though.

You can configure shorter validity periods in each SCEP profile in Intune as described in the [Microsoft documentation](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-scep-configure#modify-the-validity-period-of-the-certificate-template).

{% hint style="warning" %}
iOS and macOS devices ignore the configuration of the validity period via Intune. Therefore you need to configure this setting in SCEPman if you want to have shorter validity periods than 200 days for your iOS and macOS devices.
{% endhint %}

You can also configure shorter validity periods for each SCEP endpoint. These can never exceed the validity defined in this global setting, though!

### AppConfig:IntuneValidation:ComplianceCheck

{% hint style="warning" %}
**Experimental Setting** - Applicable to version 1.7 and above.

SCEPman Enterprise Edition only

Due to delayed compliance state evaluation during enrollment this feature breaks Windows Autopilot enrollment. After certificate deployment the immediate following OCSP check will return '**not valid**' during enrollment time and the Autopilot process will not succeed.
{% endhint %}

**Value:** _Always_ or _Never_

**Description:** When SCEPman receives an OCSP request, SCEPman can optionally check the device compliance state. When set to **Always** SCEPman will query the device compliance state and the OCSP result can only be GOOD if the device is also marked as compliant in Azure AD.

Settting this to **Never** will disable the compliance check.

### AppConfig:IntuneValidation:WaitForSuccessNotificationResponse

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** After a certificate was successfully issued, SCEPman sends a notification about the certificate to Intune. Microsoft recommends to wait for the response in its specification. However, some instances show long delays resulting in timeouts occasionally. Therefore **True** is the default.

Setting this to **False** makes SCEPman return the issued certificate before Intune answers to the notification. This is against the letters of the specification, but increases performance and avoids timeouts in instances where this issue arises.

### AppConfig:IntuneValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Intune endpoint.

### AppConfig:DCValidation:Enabled

{% hint style="info" %}
Applicable to version 1.6 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request Kerberos server certificates for your on-premises Domain Controllers. See [Domain Controller Certificates](../../certificate-deployment/other-1/domain-controller-certificates.md) for details.

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/dc`. Use in conjunction with AppConfig:DCValidation:RequestPassword. **False** \(default\): SCEPman does not issue certificates for Domain Controllers.

### AppConfig:DCValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.6 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** _String_

**Description:** A challenge password that the Domain Controllers must include in every SCEP request to acquire a certificate. Only used if AppConfig:DCValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--DCValidation--RequestPassword_.

### AppConfig:DCValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above

SCEPman Enterprise Edition only
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Domain Controller endpoint. For example, you may define a low value like 10 days here and reduce the validity of Domain Controller certificates, while still having a long validity for your client certificates.

### AppConfig:StaticValidation:Enabled

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates from [3rd-party MDM systems](../../certificate-deployment/other-1/static-certificates.md) \(i.e. other than Intune and JAMF\).

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/static`. Use in conjunction with AppConfig:StaticValidation:RequestPassword. **False** \(default\): SCEPman does not issue certificates for 3rd-party MDM systems \(i.e. other than Intune and JAMF\).

### AppConfig:StaticValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.6 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that a 3rd-party MDM system must include in every SCEP request to acquire a certificate. Only used if AppConfig:StaticValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--StaticValidation--RequestPassword_.

### AppConfig:StaticValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Static endpoint. For example, you may define a low value like 10 days here and reduce the validity of certificates issued over the static endpoint, while still having a long validity for your regular client certificates.

### AppConfig:JamfValidation:Enabled

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting helps you to request certificates via the [JAMF](https://github.com/scepman/scepman-docs/tree/6358a93fe3c35dd51ae9501a385049ad1c8feb0b/docs/certificate-deployment/jamf/general.md) MDM system.

**True**: SCEPman listens at the additional SCEP server endpoint with the path `/jamf`. Use in conjunction with AppConfig:JamfValidation:RequestPassword. **False** \(default\): SCEPman does not issue certificates for Jamf.

### AppConfig:JamfValidation:RequestPassword

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** A challenge password that Jamf must include in every SCEP request to acquire a certificate. Only used if AppConfig:JamfValidation:Enabled is set to _true_.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--JamfValidation--RequestPassword_.

### AppConfig:JamfValidation:ValidityPeriodDays

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** Positive _Integer_

**Description:** This setting further reduces the global ValidityPeriodDays for the Jamf endpoint.

### AppConfig:JamfValidation:URL

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** The root URL of your JAMF instance. If you use JAMF Cloud, this will probably look like `https://your-instance.jamfcloud.com/`.

### AppConfig:JamfValidation:APIUsername

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** The name of a service account in JAMF that SCEPman uses to authenticate on your JAMF instance. SCEPman needs the following permissions to query for computers, devices, and users:

* Computers -&gt; Read
* Mobile Devices -&gt; Read
* Users -&gt; Read

### AppConfig:JamfValidation:APIPassword

{% hint style="info" %}
Applicable to version 1.7 and above
{% endhint %}

**Value:** _String_

**Description:** The password of the service account configured in AppConfig:JamfValidation:APIUsername.

We recommend to define this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--JamfValidation--APIPassword_.

### AppConfig:ConcurrentSCEPRequestLimit

{% hint style="info" %}
Applicable to version 1.8 and above
{% endhint %}

**Value:** Positive _Integer_

**Default:** 50

**Description:** When more SCEP requests arrive at SCEPman, it takes longer for each request to finish. At high request frequencies, e.g. immediately after assigning a SCEP configuration profile to a large number of devices, processing the requests may take so long that the requests time out. The clients will retry their failed requests, which may keep the request frequency above the critical overload level.

With this setting, SCEPman will work only on this number of SCEP requests in parallel. If there are more requests, SCEPman returns HTTP 329 \(Too Many Requests\). Intune-based clients will retry certificate issuance again later in this case, so usually no request is lost. This ensures that SCEPman can finish requests on time and has a chance to work off the queue.

The optimal setting depends on the performance of the App Service Plan. As a rule of thumb, 12 is a good limit for a single instance on an S1 App Service Plan. Note that setting a too low value may prevent automatic out-scaling, as it may reduce resource usage to a value below the thresholds.

### WEBSITE\_RUN\_FROM\_PACKAGE

This setting points to the Application Artifacts that will be loaded by starting the App Service.  
Please have a look at these instructions: [Application Artifacts](application-artifacts.md#change-artifacts).

### AppConfig:ValidityClockSkewMinutes

{% hint style="info" %}
Applicable to version 1.8 and above
{% endhint %}

**Value:** Positive _Integer_

**Default:** 10

**Description:** When SCEPman issues a certificate, it will not be valid exactly from the time of issuance, but already a few minutes earlier \(default is 10\). This is because the client's clock may run slower then SCEPman's and then assume that the certificate is not yet valid. Some platforms immediately discard invalid certificates, even if they became valid a few seconds later.

Starting with version 1.8, you can configure the number of minutes that certificates are pre-dated. If you have issues with clocks on clients running late, you may increase this value.

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

You must define this setting in the configuration of your App Service. It is NOT possible to define this setting as a Secret in Azure Key Vault!

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

