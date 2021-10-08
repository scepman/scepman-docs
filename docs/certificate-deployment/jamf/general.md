# General Configuration

{% hint style="info" %}
This feature requires version **1.7** or above.
{% endhint %}

SCEPman can be connected to Jamf as External CA. Via SCEPman's static interface and a challenge password enrolled devices will be able to obtain certificates. In addition, Jamf acts as SCEP Proxy for configuration profiles. So, Jamf proxies the communication between SCEPman and your devices.

## Enable Jamf Integration

Jamf integration of SCEPman can be easily enabled via the following app configurations:

| Setting | Description | Example |
| :--- | :--- | :--- |
| [AppConfig:JamfValidation:Enabled](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-enabled) | Do you want to use SCEPman with JAMF? | true |
| [AppConfig:JamfValidation:RequestPassword](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-requestpassword) | JAMF authenticates its certificate requests at SCEPman with this secure password | _auto generated 32 character password_ |
| [AppConfig:JamfValidation:ValidityPeriodDays](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-validityperioddays) \(optional\) | How many days shall certificates issued via JAMF be valid at most? | 365 |

## API Connection

SCEPman needs to be connected to the Jamf API to check the status of onboarded clients. This is used for the revocation of certificates. Please define the following app configuration parameters:

| Setting | Description | Example |
| :--- | :--- | :--- |
| [AppConfig:JamfValidation:URL](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-url) | The URL of your JAMF instance | `https://contoso.jamfcloud.com` |
| [AppConfig:JamfValidation:APIUsername](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-apiusername) | The user name of Jamf service account | svc-scepman \(see screenshot\) |
| [AppConfig:JamfValidation:APIPassword](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-apipassword) | The password for the above account | password123 \(see screenshot\) |

Therefore, please add an appropriate service account under "Jamf Pro User Accounts & Groups":

![](../../.gitbook/assets/image%20%2833%29.png)

This account needs the following three **read** permissions under "Privileges" \(section "Jamf Pro Server Objects"\):

* Computers
* Mobile Devices
* Users

## External CA Connection

Open Jamf settings and choose "PKI Certificates" under "Global Management":

![](../../.gitbook/assets/image%20%2823%29.png)

Switch to tab "Management Certificate Template", "External CA" and activate edit mode. Please enable Jamf as "SCEP Proxy for configuration profiles":

![](../../.gitbook/assets/image%20%2826%29.png)

Please fill out the following fields and save the configuration:

| Field | Description | Example/Value |
| :--- | :--- | :--- |
| **URL** | URL to SCEPman | [https://scepman.contoso.com/jamf](https://scepman.contoso.com/jamf) |
| **Name** | name of instance | SCEPman Contoso |
| **Subject** | entities following X.500 standard | O=Contoso |
| **Challenge Type** | challenge type for verification of certificate issuing | Static |
| **\(Verify\) Challenge** | pre-shared secret \(challenge\) | defined in SCEPman via [AppConfig](../../scepman-configuration/optional/application-settings/jamf-validation.md#appconfig-jamfvalidation-requestpassword) parameter |
| Key Size | key size in bits | 2048 |
| Use as digital signature |  | Yes \(if needed\) |
| Use for key encipherment |  | Yes \(if needed\) |
| Fingerprint | Thumbprint of SCEPman CA-Cert \(SHA-1\) | visible via SCEPman dashboard \("CA Thumbprint"\) |

![](../../.gitbook/assets/image%20%2827%29.png)

### Signing Certificate

When using an external CA, Jamf requires that you add the CA certificate so Jamf can compare whether the certificates are correctly signed. However, Jamf allows adding a CA certificate only, if you also add a signing certificate with a corresponding private key. Jamf uses this signing certificate to sign certificate requests send to SCEPman. However, SCEPman does not evaluate the signature on requests and accepts even unsigned requests \(e.g. from Intune\), because the request validity stems solely from using the right request challenge password configured in Jamf.

Hence, you may use any certificate you like signing certificate, for example you can generate a self-signed certificate with the following PowerShell command:

```text
$cert = New-SelfSignedCertificate -Subject "CN=JAMF Signer Certificate for SCEPman" -CertStoreLocation "Cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(10)
$pfxBytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx, "password")
[System.IO.File]::WriteAllBytes("c:\temp\temp\jamf.pfx", $pfxBytes)
```

Then click on "Change Signing and CA Certificates" in the External CA configuration of Jamf

![](../../.gitbook/assets/jamfsigningcertificate.png)

In the wizard, upload the PFX file with the signing certificate to Jamf when it asks for it \(Note: Pkcs\#12 and PFX are synonyms\). In the next steps, enter the password for the PFX file and confirm the selection of the signing certificate. In the tab "Upload CA Certificate", you must upload the SCEPman CA certificate. You can obtain the SCEPman CA certificate by clicking on the link "Get CACert" on the top left of the homepage of your SCEPman instance. Finally, confirm your changes.

