# General Configuration

{% hint style="info" %}
This feature requires version **1.7** or above.
{% endhint %}

SCEPman can be connected to Jamf as External CA. Via SCEPman's static interface and a challenge password enrolled devices will be able to obtain certificates. In addition, Jamf acts as SCEP Proxy for configuration profiles. So, Jamf proxies the communication between SCEPman and your devices.

## Enable Jamf Integration

Jamf integration of SCEPman can be easily enabled via the following app configurations:

| Setting                                                                                                                                                                    | Description                                                                      | Example                                |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------------- |
| [AppConfig:JamfValidation:Enabled](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-enabled)                                  | Do you want to use SCEPman with Jamf?                                            | true                                   |
| [AppConfig:JamfValidation:RequestPassword](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-requestpassword)                  | Jamf authenticates its certificate requests at SCEPman with this secure password | _auto generated 32 character password_ |
| [AppConfig:JamfValidation:ValidityPeriodDays](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-validityperioddays) (optional) | How many days shall certificates issued via Jamf be valid at most?               | 365                                    |

## API Connection

SCEPman needs to be connected to the Jamf API to check the status of onboarded clients. This is used for the revocation of certificates. Please define the following app configuration parameters:

| Setting                                                                                                                                           | Description                           | Example                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------- | ------------------------------- |
| [AppConfig:JamfValidation:URL](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-url)                 | The URL of your Jamf instance         | `https://contoso.jamfcloud.com` |
| [AppConfig:JamfValidation:APIUsername](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-apiusername) | The user name of Jamf service account | svc-scepman (see screenshot)    |
| [AppConfig:JamfValidation:APIPassword](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-apipassword) | The password for the above account    | password123 (see screenshot)    |

Therefore, please add an appropriate service account under "Jamf Pro User Accounts & Groups":

![](<../../.gitbook/assets/image (33).png>)

This account needs the following three **read** permissions under "Privileges" (section "Jamf Pro Server Objects"):

* Computers
* Mobile Devices
* Users

{% hint style="warning" %}
Jamf Pro's Classic API supports Bearer Authentication since version 10.35.0. There is a setting to disable the previous authentication method, Basic Authentication, since version 10.36.0. A future Jamf version scheduled for August-December 2022 will remove support for Basic Authentication. SCEPman 2.0 and lower support only Basic Authentication for the Classic API, while SCEPman 2.1 and higher uses Bearer Authentication. In order to use Bearer Authentication, you must upgrade to SCEPman 2.1 or higher.
{% endhint %}

## External CA Connection

Open Jamf settings and choose "PKI Certificates" under "Global Management":

![](<../../.gitbook/assets/image (23).png>)

Switch to tab "Management Certificate Template", "External CA" and activate edit mode. Please enable Jamf as "SCEP Proxy for configuration profiles":

![](<../../.gitbook/assets/image (26).png>)

Please fill out the following fields and save the configuration:

| Field                    | Description                                                                                      | Example/Value                                                                                                                                               |
| ------------------------ | ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **URL**                  | <p>URL to SCEPman</p><p>Do <strong>NOT</strong> Forget the <strong>/jamf</strong> at the end</p> | [https://scepman.contoso.com/jamf](https://scepman.contoso.com/jamf)                                                                                        |
| **Name**                 | name of instance                                                                                 | SCEPman Contoso                                                                                                                                             |
| **Subject**              | entities following X.500 standard                                                                | O=Contoso                                                                                                                                                   |
| **Challenge Type**       | challenge type for verification of certificate issuing                                           | Static                                                                                                                                                      |
| **(Verify) Challenge**   | pre-shared secret (challenge)                                                                    | defined in SCEPman via [AppConfig](../../advanced-configuration/application-settings/jamf-validation.md#appconfig-jamfvalidation-requestpassword) parameter |
| Key Size                 | key size in bits                                                                                 | 2048                                                                                                                                                        |
| Use as digital signature |                                                                                                  | Yes (if needed)                                                                                                                                             |
| Use for key encipherment |                                                                                                  | Yes (if needed)                                                                                                                                             |
| Fingerprint              | Thumbprint of SCEPman CA-Cert (SHA-1)                                                            | visible via SCEPman dashboard ("CA Thumbprint")                                                                                                             |

![](<../../.gitbook/assets/2021-10-21 20\_37\_05-Edit PKI Certificates PKI Certificates\_ and 1 more page - Work - Microsoft​ Edge.png>)

### Signing Certificate

When using an external CA, Jamf requires that you add the CA certificate so Jamf can compare whether the certificates are correctly signed. However, Jamf allows adding a CA certificate only, if you also add a signing certificate with a corresponding private key. Jamf uses this signing certificate to sign certificate requests send to SCEPman. However, SCEPman does not evaluate the signature on requests and accepts even unsigned requests (e.g. from Intune), because the request validity stems solely from using the right request challenge password configured in Jamf.

Hence, you may use any certificate you like signing certificate, for example you can generate a self-signed certificate with the following PowerShell command:

```
$cert = New-SelfSignedCertificate -Subject "CN=JAMF Signer Certificate for SCEPman" -CertStoreLocation "Cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(10)
$pfxBytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx, "password")
[System.IO.File]::WriteAllBytes("c:\temp\temp\jamf.pfx", $pfxBytes)
```

Then click on "Change Signing and CA Certificates" in the External CA configuration of Jamf

![](../../.gitbook/assets/jamfsigningcertificate.png)

In the wizard, upload the PFX file with the signing certificate to Jamf when it asks for it (Note: Pkcs#12 and PFX are synonyms). In the next steps, enter the password for the PFX file and confirm the selection of the signing certificate. In the tab "Upload CA Certificate", you must upload the SCEPman CA certificate. You can obtain the SCEPman CA certificate by clicking on the link "Get CACert" on the top right of the homepage of your SCEPman instance. Finally, confirm your changes.
