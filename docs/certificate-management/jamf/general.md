# General Configuration

SCEPman can be connected to Jamf Pro as an External CA via a SCEPman's dedicated Jamf endpoint allowing enrolled users and devices to obtain certificates. Jamf Pro acts as a SCEP Proxy, proxing communication between SCEPman and Jamf Pro devices.

## Enable Jamf Integration

Jamf integration of SCEPman can be easily enabled via the following environment variables on **SCEPman app service**:

| Setting                                                                                                                                                                                              | Description                                                                                                                                                                                                                                                       | Example                     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| [AppConfig:JamfValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-enabled)                                              | Do you want to use SCEPman with Jamf?                                                                                                                                                                                                                             | true                        |
| [AppConfig:JamfValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-requestpassword)                              | <p>Jamf authenticates its certificate requests at SCEPman with this secure password.</p><p>Consider adding this as a secret in your SCEPman <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">KeyVault</a>.</p> | max _32 character password_ |
| [AppConfig:JamfValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-validityperioddays) (optional)             | How many days shall certificates issued via Jamf be valid at most?                                                                                                                                                                                                | 365                         |
| [AppConfig:JamfValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-enablecertificatestorage) (optional) | Enable this setting to save Jamf certificates in Certificate Master                                                                                                                                                                                               | true or false (default)     |

## API Connection

SCEPman needs to be connected to the Jamf API to check the status of onboarded clients. This is used for the revocation of certificates.

[Refer to the Jamf documentation](https://learn.jamf.com/en-US/bundle/jamf-pro-documentation-current/page/API_Roles_and_Clients.html) on how to create an API role and API client. The API client must have a role with these permissions:

* Read Mobile Devices
* Read Computers
* Read User

&#x20;Please define the following environment variables in your **SCEPman App Service**:

| Setting                                                                                                                                                           | Description                                                                                                                                                                                                                               | Example                                                                                                                                    |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| [AppConfig:JamfValidation:URL](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-url)                   | The URL of your Jamf instance                                                                                                                                                                                                             | `https://contoso.jamfcloud.com`                                                                                                            |
| [AppConfig:JamfValidation:ClientID](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-clientid)         | The identifier of the Jamf API client                                                                                                                                                                                                     | See [Jamf ClientId](https://learn.jamf.com/en-US/bundle/jamf-pro-documentation-current/page/API_Roles_and_Clients.html#ariaid-title3)      |
| [AppConfig:JamfValidation:ClientSecret](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-clientsecret) | <p>The Client Secret value for the API Client configuration.</p><p>Consider adding this as a secret in your SCEPman <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">KeyVault</a>.</p> | See [Jamf Client Secret](https://learn.jamf.com/en-US/bundle/jamf-pro-documentation-current/page/API_Roles_and_Clients.html#ariaid-title4) |

{% hint style="warning" %}
Jamf Pro's Classic API supports Bearer Authentication since version 10.35.0. There is a setting to disable the previous authentication method, Basic Authentication, since version 10.36.0. A future Jamf version scheduled for August-December 2022 will remove support for Basic Authentication. SCEPman 2.0 and lower support only Basic Authentication for the Classic API, while SCEPman 2.1 and higher uses Bearer Authentication. In order to use Bearer Authentication, you must upgrade to SCEPman 2.1 or higher.
{% endhint %}

## External CA Connection

Open Jamf Pro settings and choose "PKI Certificates" under "Global Management":

![](<../../.gitbook/assets/image (23).png>)

Switch to tab "Management Certificate Template", "External CA" and activate edit mode. Please enable Jamf Pro as "SCEP Proxy for configuration profiles":

![](<../../.gitbook/assets/image (26).png>)

Please fill out the following fields and save the configuration:

| Field                    | Description                                                                                      | Example/Value                                                                                                                                                             |
| ------------------------ | ------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **URL**                  | <p>URL to SCEPman</p><p>Do <strong>NOT</strong> Forget the <strong>/jamf</strong> at the end</p> | [https://scepman.contoso.com/jamf](https://scepman.contoso.com/jamf)                                                                                                      |
| **Name**                 | name of instance                                                                                 | SCEPman Contoso                                                                                                                                                           |
| **Subject**              | entities following X.500 standard                                                                | O=Contoso                                                                                                                                                                 |
| **Challenge Type**       | challenge type for verification of certificate issuing                                           | Static                                                                                                                                                                    |
| **(Verify) Challenge**   | pre-shared secret (challenge)                                                                    | defined in SCEPman via [AppConfig](../../scepman-configuration/application-settings/scep-endpoints/jamf-validation.md#appconfig-jamfvalidation-requestpassword) parameter |
| Key Size                 | key size in bits                                                                                 | 2048                                                                                                                                                                      |
| Use as digital signature |                                                                                                  | Yes (if needed)                                                                                                                                                           |
| Use for key encipherment |                                                                                                  | Yes (if needed)                                                                                                                                                           |
| Fingerprint              | Thumbprint of SCEPman CA-Cert (SHA-1)                                                            | visible via SCEPman dashboard ("CA Thumbprint")                                                                                                                           |

![](<../../.gitbook/assets/2021-10-21 20-37-05-Edit PKI Certificates PKI Certificates- and 1 more page - Work - Microsoft Edge.png>)

### Signing Certificate

When using an external CA, Jamf requires that you add the CA certificate so Jamf can compare whether the certificates are correctly signed. However, Jamf only allows adding a CA certificate if you also add a signing certificate with a corresponding private key. Jamf uses this signing certificate to sign certificate requests that are sent to SCEPman. However, SCEPman does not evaluate the signature on requests and accepts even unsigned requests (e.g. from Intune), because the request validity stems solely from using the right request challenge password configured in Jamf.

{% tabs %}
{% tab title="OpenSSL" %}
```shellscript
openssl req -x509 -newkey rsa:4096 -keyout tempKey.key -out tempCert.pem -sha256 -days 3650 -nodes -subj "/CN=JAMF Signer Certificate for SCEPman"
openssl pkcs12 -export -out SigningCert.pfx -inkey .\tempKey.key -in .\tempCert.pem -passout pass:password
# Remove temporary files
rm tempKey.key
rm tempCert.pem
```
{% endtab %}

{% tab title="PowerShell" %}
```powershell
$cert = New-SelfSignedCertificate -Subject "CN=JAMF Signer Certificate for SCEPman" -CertStoreLocation "Cert:\CurrentUser\My" -NotAfter (Get-Date).AddYears(10)
$pfxBytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Pfx, "password")
[System.IO.File]::WriteAllBytes("c:\temp\jamf.pfx", $pfxBytes)
```
{% endtab %}
{% endtabs %}

Then click on "Change Signing and CA Certificates" in the External CA configuration of Jamf

![](../../.gitbook/assets/jamfsigningcertificate.png)

In the wizard, upload the PFX file with the signing certificate to Jamf when it asks for it (Note: Pkcs#12 and PFX are synonyms). In the next steps, enter the password for the PFX file and confirm the selection of the signing certificate. In the tab "Upload CA Certificate", you must upload the SCEPman CA certificate. You can obtain the SCEPman CA certificate by clicking on the link "Get CA Certificate" on the top right of the homepage of your SCEPman instance. Finally, confirm your changes.
