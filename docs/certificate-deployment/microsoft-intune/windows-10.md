# Windows 10

The following article describes how to deploy a device certificate or a user certificate for Windows 10.

## Deploy Root CA Certificate

First, we need to trust the public root certificate from SCEPman. Therefore, you must download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](<../../../.gitbook/assets/scepman24 (1) (7) (8) (8) (8) (4) (1) (27).png>)

Then, create a profile in Microsoft Intune:

1. Navigate to **Microsoft Intune**
2. Click **Devices**
3. Click **Configuration profiles**
4. Click + **Create profile**

Choose the following profile setting:

1. Enter a **Name**
2. As **Platform** select **Windows 10 or later**
3. As **Profile type** select **Templates** then select **Trusted certificate**
4. Click **Create**

![](../../.gitbook/assets/2021-07-02-13\_46\_41-.png)

Now you will get the following window:

![](../../.gitbook/assets/2021-06-29-10\_41\_25-trusted-certificate-microsoft-endpoint-manager-admin-center-and-4-more-pages-.png)

1. Choose a profile name and **Next**
2. Select **A valid .cer file** which you already downloaded
3. As **Destination store** select **Computer certificate store - Root** and **Next**
4. In **Assignments,** assign the profile to **devices and users,** **Next**
5. Applying **Applicability Rules** is optional, **Next**
6. Finally, click **Create**

When you are finished with it, you can deploy this profile to your devices.

## Deploy Device Certificates

Now, you must create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server, you can find it from [here](windows-10.md#how-to-find-scep-url-for-intune)

to deploy the device certificates, you must create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Devices**
3. Click **Configuration profiles**
4. Click + **Create profile**
5. Select **Windows 10 and later** as **Platform**
6. Select **Templates** as **Profile type**
7. Select **SCEP certificate** from the Template name list
8. Click **Create**
9. Provide a **Name** e.g. _\*\*Win10 - SCEP certificate - Device certificate_

Set the properties like shown below.

{% hint style="warning" %}
There are some restrictions to the **SCEP Device Certificate** settings:

**Important**: You must add the AAD Device ID to the subject. **Add 'CN=\{{AAD\_Device\_ID\}} ' in the field Subject name format**. This ensures that SCEPman can link certificates to device objects in AAD.

SCEPman automatically sets the Key usage to **Digital signature** and **Key encipherment** and overrides the setting here unless the setting _AppConfig:UseRequestedKeyUsages_ is set to _true_.

SCEPman caps the certificate validity to the configured maximum in setting _AppConfig:ValidityPeriodDays_, but otherwise uses the validity configured in the request.
{% endhint %}

* **Certificate type**: Device
* **Subject name format:** CN=\{{AAD\_Device\_ID\}}
* **Subject alternative name: Attribute:** URI, **Value:** IntuneDeviceId://\{{DeviceID\}}

![](<../../.gitbook/assets/2021-10-27 09\_49\_08-SCEP certificate - Microsoft Endpoint Manager admin center and 20 more pages - C.png>)

{% hint style="warning" %}
The setting Key Storage Provider (KSP) determines the storage location of the private key for the end-user certificates. Storage in the TPM is more secure than software storage, because the TPM provides an additional layer of security to prevent key theft. However, there is **a bug in some older TPM firmware versions** that invalidates some signatures created with a TPM-backed private key. In such cases, the certificate cannot be used for EAP authentication as it is common for Wi-Fi and VPN connections. Affected TPM firmware versions include:

* STMicroelectronics: 71.12, 73.4.17568.4452, 71.12.17568.4100
* Intel: 11.8.50.3399, 2.0.0.2060
* Infineon: 7.63.3353.0

If you use TPM with this firmware, either update your firmware to a newer version or select "Software KSP" as key storage provider.
{% endhint %}

* Scroll down and enter the URL you have noted
* Then, click **Next**
* Assign Users and Devices, click **Next**
* **Applicability Rules** is Optional, **Next**
* Finally click **Create**

When all is finished, you have the following two certificate configurations:

* SCEPman - SCEP device certificate
* SCEPman - Trusted root certificate

## Deploy User Authentication Certificates

The following section will show you how you can deploy user certificates via Intune Certificate profile on Windows 10 (or later) devices.

First, we need to trust the public root certificate from SCEPman.\
Therefore follow the instructions [here](windows-10.md#deploy-root-ca-certificate).

Now, you must create a SCEP certificate profile to deploy the user certificates. Important for this step is the SCEP Server URL, you can find it [here](windows-10.md#how-to-find-scep-url-for-intune)

Next, to deploy the user certificates you must create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Devices**
3. Click **Configuration profiles**
4. Click + **Create profile**
5. Select **Windows 10 and later** as **Platform**
6. Select **Templates** as **Profile type**
7. Select **SCEP certificate** from the Template name list
8. Click **Create**
9. Provide a **Name** e.g. _\*\*Win10 - SCEP certificate - User certificate_

Set the properties as shown below.

{% hint style="warning" %}
There are some restrictions to the **SCEP User Certificate** settings:

You must add the User principal name as the Subject alternative name. **Add '\{{UserPrincipalName\}}' as Subject Alternative Name of type User principal name (UPN).** This ensures that SCEPman can link certificates to user objects in AAD. The setting for 'Subject name format' is freely selectable.\
You should **add 'L=\{{AAD\_Device\_ID\}}'** as part of the Subject. This ensures the user certificate can be linked to the device where it resides on. This may improve revocation and compliance checks. \
SCEPman automatically sets the Key usage to **Digital signature** and **Key encipherment** and overrides the settings configured here unless the setting _AppConfig:UseRequestedKeyUsages_ is set to _true_. \
For SCEPman version before 1.5, the validity period is set to a fixed 6 month. For SCEPman 1.5 and above, SCEPman caps the certificate validity to the configured maximum in setting _AppConfig:ValidityPeriodDays_, but otherwise uses the validity configured in the request.
{% endhint %}

* **Certificate type**: User
* **Subject name format:** CN=\{{UserName\}},L=\{{AAD\_Device\_ID\}}
* **Subject alternative name:**

| Attribute                         | Value                           |
| --------------------------------- | ------------------------------- |
| User principal name (UPN)         | \{{UserPrincipalName\}}         |
| Uniform Resource Identifier (URI) | IntuneDeviceId://\{{DeviceID\}} |

![](<../../.gitbook/assets/2021-10-27 09\_46\_16-SCEP certificate - Microsoft Endpoint Manager admin center and 20 more pages - C.png>)

{% hint style="warning" %}
The setting Key Storage Provider (KSP) determines the storage location of the private key for the end-user certificates. Storage in the TPM is more secure than software storage, because the TPM provides an additional layer of security to prevent key theft. However, there is **a bug in some older TPM firmware versions** that invalidates some signatures created with a TPM-backed private key. In such cases, the certificate cannot be used for EAP authentication as it is common for Wi-Fi and VPN connections. Affected TPM firmware versions include:

* STMicroelectronics: 71.12
* Intel: 11.8.50.3399, 2.0.0.2060
* Infineon: 7.63.3353.0

If you use TPMs with this firmware, either update your firmware to a newer version or select "Software KSP" as a key storage provider.
{% endhint %}

* Scroll down and enter the URL you have noted, Click **Next**
* Assign users and groups, click **Next**
* Finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP Device certificate
* SCEPman - Trusted root certificate

## Deploy User Digital Signature Certificate

Deploying user certificates used for **Digital Signatures** can be achieved by following these instructions.

{% hint style="warning" %}
**You may** use SCEPman for transnational **digital signatures** i.e. for S/MIME signing in Microsoft Outlook. If you plan to use the certificates for message signing you need to add the corresponding extended key usages in the Intune profile configuration.

**Do not** use SCEPman **for email-encryption** i.e. for S/MIME mail encryption in Microsoft Outlook (without a separate technology for key management). The nature of **the SCEP protocol does not include a mechanism to backup or archive private key material.** If you would use SCEP for email-encryption you may lose the keys to decrypt the messages later.
{% endhint %}

You must set these configuration variables otherwise the requested key usage and extended validity period in the SCEP profile is not honored by SCEPman:

{% hint style="warning" %}
_AppConfig:UseRequestedKeyUsages_ set to _true_\
_AppConfig:ValidityPeriodDays set to 365 (a maximum value of 1825 - 5 years is possible)_
{% endhint %}

Another requirement is trusted root certificate of SCEPman, it must be deployed like described in the user or device certificate deployment section above to be referenced in this new digital signature profile.

To deploy the user digital signature certificate, you must create a SCEP certificate profile in Intune, before that you need to copy the SCEPman Server URL, you can find it [here](windows-10.md#how-to-find-scep-url-for-intune)

Now the Go to Intune to create a SCEP certificate profile:

1. Navigate to **Microsoft Intune**
2. Click **Devices**
3. Click **Configuration profiles**
4. Click + **Create profile**
5. Select **Windows 10 and later** as **Platform**
6. Select **Templates** as **Profile type**
7. Select **SCEP certificate** from the Template name list
8. Click **Create**
9. Provide a **Name** e.g. _\*\*Win10 - SCEP certificate - Digital Signature_

Set the properties like shown below. Have special attention for the Key Usage select _only_ '**Digital Signature**' and for the Extended key usage '**Secure Email**'.

* **Certificate type**: User
* **Subject name format:** CN=\{{UserName\}},E=\{{EmailAddress\}},L=\{{AAD\_Device\_ID\}}
* **Subject alternative name:**

| Attribute                 | Value                           |
| ------------------------- | ------------------------------- |
| User principal name (UPN) | \{{UserPrincipalName\}}         |
| Email address             | \{{EmailAddress\}}              |
| URI                       | IntuneDeviceId://\{{DeviceID\}} |

![](<../../.gitbook/assets/2021-10-27 09\_54\_08-SCEP certificate - Microsoft Endpoint Manager admin center and 20 more pages - C.png>)

We recommend setting Renewal Threshold (%) to a value that ensures certificates are renewed at least 6 months before expiration when issuing S/MIME signature certificates. This is because emails signed with expired certificates are shown to have invalid signatures in Outlook, which confuses users. Having a new certificate long before the old one expires ensures that only older emails show this behavior, which users are more unlikely to look at. For example, if your signature certificates are valid for one year, you should set the Renewal Threshold to at least 50 %.

* Scroll down and enter the URL you have noted, Click **Next**
* Assign users and groups, click **Next**
* Finally click **Create**

Assign the profile to your user group and wait for the device to synchronize. After successful sync you should see the user certificate for Intended Purposes **Secure Email**

![](<../../.gitbook/assets/image (16).png>)

The certificate will be available for Digital Signature usage in e.g. Outlook. Below an example of the usage:

![](<../../.gitbook/assets/image (14).png>)

## How to find SCEP-URL for Intune

This URL can be found in the **Overview** sub-menu of the app service of SCEPman:

![](<../../../.gitbook/assets/scepman27 (2) (1) (1) (27).png>)

Now click on the URL, you will be redirected to the SCEPman instance website:

![](../../.gitbook/assets/2021-07-02-16\_19\_49-scepman-server-node-and-4-more-pages-c4a8-ehamed-microsoft-edge.png)

Copy the path URL (you can copy it by clicking on the copy symbol at the end) and note it, you will need it later on.

| ​[Back to Trial Guide​](../../scepman-deployment/trial-guide.md#step-4-configure-intune-deployment-profiles) | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-9-configure-intune-deployment-profiles) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-11-configure-intune-deployment-profiles) |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |

