# Intune-managed Linux Client

{% hint style="info" %}
Applicable to SCEPman version 2.9 and above
{% endhint %}

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

This method can be used to enroll certificates for users and devices that are managed by Intune.

Intune will in this case push a script to leverage the SCEPman REST API that in turn will either enroll a new certificate or renew an already existing one.



## Prerequisites

### 1. Self Service Enrollment

{% include "../../../.gitbook/includes/enrollment-rest-api-self-service-enrollment.md" %}



### 2. App Service Settings

{% include "../../../.gitbook/includes/enrollment-rest-api-app-service-settings.md" %}

This scenario will enroll certificates of the type _**IntuneUser**_ and _**IntuneDevice**_ depending on your choice.

### **3. Client Prerequisites**

{% include "../../../.gitbook/includes/enrollment-rest-api-client-prerequisites.md" %}

#### [**Intune Enrollment**](https://learn.microsoft.com/en-us/mem/intune/user-help/enroll-device-linux)

Follow the linked documentation to enroll your Linux client to Intune.&#x20;

## Enrollment and Renewal Script

The [enrollrenewcertificate.sh](https://github.com/scepman/csr-request/blob/main/enroll-certificate/enrollrenewcertificate.sh) script will be used to initially receive a certificate as well as checking it on a regular schedule and attempt a renewal in case the threshold is reached.

While the script is usually operated by passing the parameters in the terminal we will need to modify some parts of it to be deployed over Intune.

Locate the part of the script that assigns the passed terminal arguments to the variable and adjust them to your needs:



Example configuration:

```bash
APPSERVICE_URL="https://scepman.contoso.net/"
API_SCOPE="api://b7d17d51-8b6d-45eb-b42b-3dae638cd5bc/Cert.Enroll"
CERT_DIR=~/certs
CERT_NAME="myCertificate"
KEY_NAME="myKey"
RENEWAL_THRESHOLD_DAYS=30

# Additionally add the following variables
CERT_TYPE="user"
CERT_COMMAND="auto"
```

#### APPSERVICE\_URL

The URL of the SCEPman app service.

_Example: "https://scepman.contoso.net/"_

#### API\_SCOPE

This is the API scope you can create in the _**SCEPman-api**_ app registration in your environment.

The user will be presented with your desired consent dialog and can afterwards user the self service functionality.

_Example: "api://_&#x62;7d17d51-8b6d-45eb-b42b-3dae638cd5bc/Cert.Enrol&#x6C;_"_

<figure><img src="../../../.gitbook/assets/image (30).png" alt=""><figcaption></figcaption></figure>

#### CERT\_DIR

The directory the certificate will be created or tried to be renewed. The private key and root certificate will also be placed in here.

_Example: \~/certs/_

#### CERT\_NAME

The filename (without extension) of the certificate that will be created or read for renewal.

_Example: "myCertificate"_

#### KEY\_NAME

The filename of the private key that will be created or read for renewal.

_Example: "myKey"_

#### RENEWAL\_THRESHOLD\_DAYS

The amount of days the certificate will need to expire in for the script to begin the renewal process.

_Example: 30_

#### CERT\_TYPE

The type of certificate that will be enrolled.

_Can be either "user" or "device"_

#### CERT\_COMMAND

This defines the behavior of the script in relation to enrollment and renewal:

**"auto"** will create a certificate initially or renew a certificate if it already exists and is about to expire.

**"renewal"** will renew a certificate if it is about to expire but will not create a certificate initially.

**"initial"** will only enroll a certificate but not renew a existing one.

{% hint style="warning" %}
If you are enrolling or renewing a device certificate the DeviceId will be retrieved from _\~/.config/intune/registration.toml_ and the authenticated user will need to match the owner of the object in the configured [DeviceDirectory](https://docs.scepman.com/advanced-configuration/application-settings/intune-validation#appconfig-intunevalidation-devicedirectory).
{% endhint %}



### Considerations

* This script does not encrypt the generated keys (this requires passphrase input, so encryption has been omitted to allow for automatic renewal.)
* If you are renewing passphrase-protected certificates from Certificate Master, you will need to input this passphrase in order to renew them.

## Deploy Script

Using Intune we can deploy the modified script on a schedule to initially enroll a certificate with the given parameters and regularly check if it needs to be renewed.

Add a new Linux script deployment and make sure to set the _**Execution context**_ to _**User**_ and either upload or paste the content of the modified bash script you created in the prior section.

Adjust the _**Execution frequency**_ in accordance to your renewal threshold.

{% hint style="info" %}
The user will be prompted to login to the Azure CLI application on the first execution as they are required to authenticate.&#x20;
{% endhint %}
