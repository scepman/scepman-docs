# General Configuration

{% hint style="info" %}
This feature requires version **1.7** or above.
{% endhint %}

{% hint style="warning" %}
Under construction.
{% endhint %}

SCEPman can be connected to Jamf as External CA. Via SCEPman's static interface and a challenge password enrolled devices will be able to obtain certificates. In addition, Jamf acts as SCEP Proxy for configuration profiles. So, Jamf proxies the communication between SCEPman and your devices.

## External CA Connection

Open Jamf settings and choose "PKI Certificates" under "Global Management":

![](../../.gitbook/assets/image%20%2823%29.png)

Switch to tab "Management Certificate Template", "External CA" and activate edit mode. Please enable Jamf as "SCEP Proxy for configuration profiles":

![](../../.gitbook/assets/image%20%2826%29.png)

Please fill out the following fields and save the configuration:

| Field | Description | Example/Value |
| :--- | :--- | :--- |
| **URL** | URL to SCEPman | https://scepman.contoso.com/jamf |
| **Name** | name of instance | SCEPman Contoso |
| **Subject** | entities following X.500 standard | O=Contoso |
| **Challenge Type** | challenge type for verification of certificate issuing | Static |
| **\(Verify\) Challenge** | pre-shared secret \(challenge\) | defined in SCEPman via [AppConfig](../../scepman-configuration/optional/application-settings.md#appconfig-jamfvalidation-requestpassword) parameter |
| Key Size | key size in bits | 2048 |
| Use as digital signature |  | Yes \(if needed\) |
| Use for key encipherment |  | Yes \(if needed\) |
| Fingerprint | Thumbprint of SCEPman CA-Cert \(SHA-1\) | visible via SCEPman dashboard \("CA Thumbprint"\) |

![](../../.gitbook/assets/image%20%2827%29.png)

## Signing Certificate

When using an external CA Jamf requires an import of the signing and CA certificate. Otherwise, connection between Jamf and SCEPman will fail \(because signing and CA certificates of the Jamf Pro built-in CA are used\).

## API Connection

SCEPman needs to be connected to the Jamf API to check the validity status of clients. This is used for the revocation of certificates.

## Other Settings

Please refer to "Application Settings" for other Jamf related configuration parameters.

{% page-ref page="../../scepman-configuration/optional/application-settings.md" %}



