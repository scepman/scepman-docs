# Windows

The following article describes deploying a device or/and user certificates for Windows devices. The deployment of the SCEPman Root Certificate is mandatory. Afterward, you can choose between deploying only the device, user, or even both certificate types.

## Root Certificate

The basis for deploying SCEP certificates is to trust the root certificate of SCEPman. Therefore, you have to download the CA Root certificate and deploy it as a **Trusted certificate** profile via Microsoft Intune:

* [ ] Download the CA Certificate from SCEPman portal:

![](<../../.gitbook/assets/image-2 (10).png>)

* [ ] Create a profile for **Windows 10 and later** with type **Trusted certificate** in Microsoft Intune:

![](../../.gitbook/assets/SCEPmanWindowsRootCA.png)

* [ ] Upload your previously downloaded **.cer file**.
* [ ] Now you can deploy this profile to your devices. Please choose All Users and/or All Devices or a dedicated group for assignment.

{% hint style="info" %}
Note that you have to use the same group for assigning the Trusted certificate and SCEP profile. Otherwise, the Intune deployment might fail.
{% endhint %}

## Device Certificates

* [ ] Open the SCEPman portal and copy the URL under Intune MDM

![](<../../.gitbook/assets/image-3 (1).png>)

* [ ] Create a profile for **Windows 10 and later** with type **SCEP certificate** in Microsoft Intune

![](../../.gitbook/assets/SCEPmanWindowsDeviceCr.png)

* [ ] Configure the profile as described:

<details>

<summary>Certificate type: <code>Device</code></summary>

In this case we are setting up a device certificate

</details>

<details>

<summary>Subject name format: <code>CN={{DeviceName}}</code> or <code>CN={{DeviceId}}</code> or <code>CN={{AAD_Device_ID}}</code></summary>

**Recommended:** Use `{{DeviceName}}`for the CN RDN to have a meaningful name of the certificate on the device or when searching for the certificate.

**Optional:** If configured to `CN={{DeviceId}}` or `CN={{AAD_Device_ID}}`, SCEPman uses the CN field of the subject name to identify the device and as a seed for the certificate serial number generation. Microsoft Entra ID (Azure AD) and Intune offer two different IDs:

* `{{DeviceId}}`: This ID is generated and used by Intune.\
  \
  (requires SCEPman 2.0 or higher and [#appconfig-intunevalidation-devicedirectory](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory "mention") to be set to **Intune** or **AADAndIntune**)

- `{{AAD_Device_ID}}`: This ID is generated and used by Microsoft Entra ID (Azure AD).

In case neither `CN={{DeviceId}}` nor `CN={{AAD_Device_ID}}` is used for the CN field (e.g. `CN={{DeviceName}})`, SCEPman will identify the device based on the Intune Device ID (`(URI)Value:` `IntuneDeviceId://{{DeviceId}}`) provided in the subject alternative name (SAN).

**Important:** The choice of the CN field affects the [automatic revocation behavior](../manage-certificates.md#automatic-revocation) of certificates issued to your Intune-managed devices.

You can add other RDNs if needed (e.g.: `CN={{DeviceId}}, O=Contoso, CN={{WiFiMacAddress}}`). Supported variables are listed in the [Microsoft docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep#create-a-scep-certificate-profile).

</details>

<details>

<summary>Subject alternative name: <code>(URI)</code>Value: <code>IntuneDeviceId://{{DeviceId}}</code></summary>

The URI field is [recommended by Microsoft](https://techcommunity.microsoft.com/t5/intune-customer-success/new-microsoft-intune-service-for-network-access-control/ba-p/2544696) for NAC solutions to identify the devices based on their Intune Device ID. The value should be:

```
IntuneDeviceId://{{DeviceId}}
```

The **URI field is mandatory** in case neither `CN={{DeviceId}}` nor `CN={{AAD_Device_ID}}` is used in the **Subject name format** field.

Other SAN values like DNS can be added if needed.

</details>

<details>

<summary>Certificate validity period: <code>1 year</code></summary>

The amount of time remaining before the certificate expires. Default is set at one year.

SCEPman caps the certificate validity to the configured maximum in setting [_**AppConfig:ValidityPeriodDays**_](../../scepman-configuration/optional/application-settings/certificates.md#appconfig-validityperioddays), but otherwise uses the validity configured in the request.

</details>

<details>

<summary>Key storage provider (KSP): <code>Enroll to Trusted Platform Module (TPM) KSP, otherwise fail</code></summary>

This setting determines the storage location of the private key for the end-user certificates. Storage in the TPM is more secure than software storage because the TPM provides an additional layer of security to prevent key theft.

Note: There is **a bug in some older TPM firmware versions** that invalidates some signatures created with a TPM-backed private key. In such cases, the certificate cannot be used for EAP authentication as it is common for Wi-Fi and VPN connections. In addition, this might break your Autopilot onboarding process.

Affected TPM firmware versions include:

* STMicroelectronics: 71.12, 73.4.17568.4452, 71.12.17568.4100, 73.20.17568.6684
* Intel: 11.8.50.3399, 2.0.0.2060
* Infineon: 7.63.3353.0
* IFX: Version 3.19 / Specification 1.2

If you use TPM with this firmware, either update your firmware to a newer version or select "Software KSP" as a key storage provider.

**Update:** You can workaround the TPM bug by removing the RSA-PSS signature algorithms -that are causing the issue- from the registry, for more information please check [Richard Hicks's article](https://directaccess.richardhicks.com/2023/02/13/always-on-vpn-authentication-failed-reason-code-16/) and [Microsoft Q\&A](https://learn.microsoft.com/en-us/answers/questions/467673/windows-10-tpm-2-0-client-authentication-in-tls-1)

</details>

<details>

<summary>Key usage: <code>Digital signature</code> and <code>Key encipherment</code></summary>

Please activate both cryptographic actions.

SCEPman automatically sets the Key usage to **Digital signature** and **Key encipherment** and overrides the setting here unless the setting [_**AppConfig:UseRequestedKeyUsages**_](../../scepman-configuration/optional/application-settings/certificates.md#appconfig-userequestedkeyusages) is set to _true_.

</details>

<details>

<summary>Key size (bits): <code>2048</code></summary>

SCEPman supports 2048 bits.

</details>

<details>

<summary>Hash algorithm: <code>SHA-2</code></summary>

SCEPman supports SHA-2 algorithm.

</details>

<details>

<summary>Root Certificate: <code>Profile from previous step (Root certificate Profile)</code></summary>

Please select the Intune profile from [#Root Certificate](windows-10.md#root-certificate).\
If you are using an [Intermediate CA](../../advanced-configuration/intermediate-certificate.md), you must select the Trusted certificate profile for the Intermediate CA, not the Root CA!

</details>

<details>

<summary>Extended key use: <code>Client Authentication, 1.3.6.1.5.5.7.3.2</code></summary>

Please choose **Client Authentication (1.3.6.1.5.5.7.3.2)** under **Predefined values**. The other fields will be filled out automatically.

</details>

<details>

<summary>Renewal threshold (%): <code>20</code></summary>

This value defines when the device is allowed to renew its certificate (based on the remaining lifetime of an existing certificate). Please read the note under **Certificate validity period** and select a suitable value that allows the device the renew the certificate over a long period. A value of 20% would allow the device with 1 year valid certificate to start renewal 73 days before expiration.

</details>

<details>

<summary>SCEP Server URLs: Open the SCEPman portal and copy the URL of <a href="windows-10.md#device-certificates">Intune MDM</a></summary>

**Example**

```
https://scepman.contoso.com/certsrv/mscep/mscep.dll
```

</details>

### Example

<figure><img src="../../.gitbook/assets/2024-03-14 15_18_35.png" alt=""><figcaption></figcaption></figure>

* [ ] Now you can deploy this profile to your devices. Please choose the same group/s for the assignment as for the Trusted certificate profile.

## User Certificates

Please follow the instructions of [#Device certificates](windows-10.md#device-certificates) and take care of the following differences:

<details>

<summary>Certificate type: <code>User</code></summary>

In this section we are setting up a user certificate.

</details>

<details>

<summary>Subject name format: <code>CN={{UserName}},E={{EmailAddress}}</code></summary>

You can define RDNs based on your needs. Supported variables are listed in the [Microsoft docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep#create-a-scep-certificate-profile). We recommend to include the username (e.g.: janedoe) and email address (e.g.: janedoe@contoso.com) as baseline setting.

</details>

<details>

<summary>Subject alternative name: <code>(UPN)</code>Value: <code>{{UserPrincipalName}}</code></summary>

You must add the User principal name as the Subject alternative name. **Add '\{{UserPrincipalName\}}' as Subject Alternative Name of type User principal name (UPN).** This ensures that SCEPman can link certificates to user objects in AAD. The setting for 'Subject name format' is freely selectable.

Other SAN values like an Email address can be added if needed.

</details>

{% hint style="info" %}
Based on customer feedback, it appears that some VPN clients (e.g., Azure VPN Client for Virtual WAN) are unable to discover the user certificate when it is stored in the TPM. Try enrolling it to the software KSP instead.
{% endhint %}

### Example

<figure><img src="../../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

## User Digital Signature Certificate

You may use SCEPman for transnational **digital signatures** i.e. for S/MIME signing in Microsoft Outlook. If you plan to use the certificates for message signing you need to add the corresponding extended key usages in the Intune profile configuration.

{% hint style="warning" %}
**Do not** use SCEPman **for email-encryption** i.e. for S/MIME mail encryption in Microsoft Outlook (without a separate technology for key management). The nature of **the SCEP protocol does not include a mechanism to backup or archive private key material.** If you would use SCEP for email-encryption you may lose the keys to decrypt the messages later.
{% endhint %}

* [ ] You must set these configuration variables otherwise the requested key usage and extended validity period in the SCEP profile are not honored by SCEPman:

- [_`AppConfig:UseRequestedKeyUsages`_](../../scepman-configuration/optional/application-settings/certificates.md#appconfig-userequestedkeyusages) set to _`true`_
- [_`AppConfig:ValidityPeriodDays`_](../../scepman-configuration/optional/application-settings/certificates.md#appconfig-validityperioddays) _set to `365` (a maximum value of 1825 - 5 years is possible)_

To deploy user certificates used for **Digital Signatures** please follow the instructions of [#User certificates](windows-10.md#user-certificates) and take care of the following differences and notes:

<details>

<summary>Subject alternative name</summary>

* **(required) User principal name (UPN):** _`{{UserPrincipalName}}`_
* **(required) Email address:** _`{{EmailAddress}}`_

By deploying a digital signature certificate, you must add the UPN and the email address.

</details>

<details>

<summary>Key usage: only <code>Digital signature</code></summary>



</details>

<details>

<summary>Extended key usage: <code>Secure Email (1.3.6.1.5.5.7.3.4)</code></summary>

Please choose **Secure Email (1.3.6.1.5.5.7.3.4)** under **Predefined values**. The other fields will be filled out automatically.

</details>

<details>

<summary>Renewal Threshold (%): <code>50</code></summary>

We recommend setting Renewal Threshold (%) to a value that ensures certificates are renewed at least 6 months before expiration when issuing S/MIME signature certificates. This is because emails signed with expired certificates are shown to have invalid signatures in Outlook, which confuses users. Having a new certificate long before the old one expires ensures that only older emails show this behavior, which users are more unlikely to look at. For example, if your signature certificates are valid for one year, you should set the Renewal Threshold to at least 50 %.

</details>

### **Example**

<figure><img src="../../.gitbook/assets/image (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

After a successful profile sync, you should see the user certificate for Intended Purposes **Secure Email**

![](<../../.gitbook/assets/image (16) (1).png>)

The certificate will be available for Digital Signature usage in e.g. Outlook. Below is an example of the usage

![](<../../.gitbook/assets/digital Sign2.png>)

### Activate S/MIME Signatures in Microsoft Outlook

{% hint style="warning" %}
S/MIME feature is not available for the latest Outlook client. More info [here](https://techcommunity.microsoft.com/t5/outlook-blog/the-new-outlook-for-windows-for-organization-admins/ba-p/3929169).
{% endhint %}

Once you have deployed S/MIME signature certificates to your client machines, you must configure Outlook to use these certificates before sending signed emails. You can do this manually or use our [PowerShell Script to configure Outlook](https://github.com/glueckkanja-pki/PKI-Configuration-Tools/blob/master/README.md).

### Activate S/MIME Signatures in Outlook on the Web

You can sign emails with S/MIME in Outlook on the Web using certificates from your local Windows machine. You need to enable this with the following command:

```
Set-SmimeConfig -OWAAllowUserChoiceOfSigningCertificate $true
```

See https://learn.microsoft.com/en-us/powershell/module/exchange/set-smimeconfig for more details.
