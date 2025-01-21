# Non-Intune-managed Linux Client

{% hint style="info" %}
Applicable to SCEPman version 2.9 and above
{% endhint %}

This method can be used to enroll certificates for users and devices that are not managed by Intune or another MDM.

## Prerequisites

### 1. Self Service Enrollment

{% include "../../../.gitbook/includes/enrollment-rest-api-self-service-enrollment.md" %}



### 2. App Service Settings

{% include "../../../.gitbook/includes/enrollment-rest-api-app-service-settings.md" %}

This scenario will enroll certificates of the type _**IntuneUser.**_

### **3. Client Prerequisites**

{% include "../../../.gitbook/includes/enrollment-rest-api-client-prerequisites.md" %}



## Enrollment and Renewal Script

The [enrollrenewcertificate.sh](https://github.com/scepman/csr-request/blob/main/enroll-certificate/enrollrenewcertificate.sh) script can be used to initially receive a certificate as well as to verify it and attempt a renewal in case it is about to expire.

Example:

{% code overflow="wrap" %}
```bash
./enrollrenewcertificate.sh -u https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 ~/certs/ "myCertificate" "myKeyName" 30
```
{% endcode %}

#### 1. Command

Defines the behavior of the script

Can be any of:

**-u** for user certificate with auto-detection whether it is an initial enrollment or renewal

**-d** for device certificate with auto-detection whether it is an initial enrollment or renewal

**-r** for renewal

**-w** for initial enrollment of a user

**-x** for initial enrollment of a device

{% hint style="warning" %}
If you are enrolling or renewing a device certificate the DeviceId will be tried to read from _\~/.config/intune/registration.toml_ by default and the authenticated user will need to match the owner of the object in the configured [DeviceDirectory](https://docs.scepman.com/advanced-configuration/application-settings/intune-validation#appconfig-intunevalidation-devicedirectory)
{% endhint %}



#### 2. App Service URL

The URL of the SCEPman app service.

_Example: "https://scepman.contoso.net/"_

#### 3. API Scope

This is the _**Application ID URI**_ of the _**SCEPman-api**_ app registration in your environment.

_Example: "api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436"_

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

#### 4. Certificate Filename

The filename (without extension) of the certificate that will be created or read for renewal.

_Example: "myCertificate"_

#### 5. Certificate Directory

The directory the certificate will be created or tried to be renewed.

_Example: \~/certs/_

#### 8. Renewal Threshold

The amount of days the certificate will need to expire in for the script to begin the renewal process.

_Example: 30_



### Considerations

* This script does not encrypt the generated keys (this requires passphrase input, so encryption has been omitted to allow for automatic renewal.)
* If you are renewing passphrase-protected certificates from Certificate Master, you will need to input this passphrase in order to renew them.

## Set up automatic renewal

When the above bash script is run and detects that a certificate has already been enrolled, it will renew the certificate (if it is close to expiry) using mTLS. If the script is run regularly, this will ensure the certificate is renewed when it gets close to expiry. You can set up a cronjob to achieve this. The below command is an example of how this could be done. It will set up a cronjob to run the command daily (if the system is powered on) and a cronjob to run the command on reboot.

<pre data-overflow="wrap"><code><strong>(crontab -l ; echo @daily /path/to/enrollrenewcertificate.sh -u https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 /home/user/certs/ "myCertificate" "myKeyName" 30 ; echo @reboot /path/to/enrollrenewcertificate.sh -u https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 /home/user/certs/ "myCertificate" "myKeyName" 30 ) | crontab -
</strong></code></pre>

Since commands run by Cron will not necessarily be run from the directory that the script/certificates are in, it is important to provide the absolute paths to the script/certificates.&#x20;
