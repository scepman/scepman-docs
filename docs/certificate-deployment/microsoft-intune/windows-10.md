---
category: Configuration
title: Windows 10
order: 1
---

# Windows 10

The following article describes how to deploy a device certificate or a user certificate for Windows 10.

## Deploying Device Certificates

The following section will show you how you can deploy device certificates via Intune Certificate profile on Windows 10 \(or later\) devices.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2812%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman26.png)

1. Enter a **Name**
2. As **Platform** select **Windows 10 or later**
3. As **Profile type** select **Trusted certificate**
4. Click **Settings**, select **A valid .cer file**
5. As **Destination store** select **Computer certificate store - Root**
6. Then, click **OK**
7. Finally, click **Create**

When you are finished with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%2811%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates, you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profiles** and click **Create profile**
4. Then, enter a **Name**
5. Select **Windows 10 and later** as **Platform**
6. Select **SCEP certificate** as **Profile type**
7. Click **Settings**

![](../../.gitbook/assets/scepman28%20%283%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
There are some restrictions to the **SCEP Certificate** settings:

**Important: You must add the '{{AAD\_Device\_ID}}' as CN in Subject name format or in the User principal name \(UPN\) of the Subject alternative name field.** This ensures that SCEPman can link certificates to device objects in AAD.

SCEPman automatically sets the Key usage to **Digital signature** and **Key encipherment** and overrides the settings configured here, unless the setting _AppConfig:UseRequestedKeyUsages_ is set to _true_.

For SCEPman version before 1.5, the validity period is set to a fixed 6 month. For SCEPman 1.5 and above, SCEPman caps the certificate validity to the configured maximum in setting _AppConfig:ValidityPeriodDays_, but otherwise uses the validity configured in the request.
{% endhint %}

![](../../.gitbook/assets/scepman29%20%283%29.png)

{% hint style="warning" %}
The setting Key Storage Provider \(KSP\) determines the storage location of the private key for the end-user certificates. Storage in the TPM is more secure than software storage, because the TPM provides an additional layer of security to prevent key theft. However, there is **a bug in some older TPM firmware versions** that invalidates some signatures created with a TPM-backed private key. In such cases, the certificate cannot be used for EAP authentication as it is common for Wi-Fi and VPN connections. Affected TPM firmware versions include:

* STMicroelectronics: 71.12
* Intel: 11.8.50.3399

If you use TPMs with these firmwares, either update your firmware to a newer version or select "Software KSP" as key storage provider.
{% endhint %}

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next, click **OK** and finally click **Create**

When all is finished, you have the following two certificate configurations:

* SCEPman - SCEP device certificate
* SCEPman - Trusted root certificate

## Deploying User Certificates

The following section will show you how you can deploy user certificates via Intune Certificate profile on Windows 10 \(or later\) devices.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%282%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman26%20%285%29.png)

1. Enter a **Name**
2. As **Platform** select **Windows 10 or later**
3. As **Profile type** select **Trusted certificate**
4. Click **Settings**, select **A valid .cer file**
5. As **Destination store** select **Computer certificate store - Root**
6. Then, click **OK**
7. Finally, click **Create**

When you are done with it you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%285%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Windows 10 and later** as **Platform**
6. Select **SCEP certificate** as **Profile type**
7. Click **Settings**

![](../../.gitbook/assets/scepman_user_w10_1%20%281%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
There are some restrictions to the **SCEP Certificate** settings:

**You must add the 'User principal name \(UPN\)' as Subject alternative name.** This ensures that SCEPman can link certificates to user objects in AAD. The setting for 'Subject name format' is freely selectable.

SCEPman automatically sets the Key usage to **Digital signature** and **Key encipherment** and overrides the settings configured here, unless the setting _AppConfig:UseRequestedKeyUsages_ is set to _true_.

For SCEPman version before 1.5, the validity period is set to a fixed 6 month. For SCEPman 1.5 and above, SCEPman caps the certificate validity to the configured maximum in setting _AppConfig:ValidityPeriodDays_, but otherwise uses the validity configured in the request.
{% endhint %}

![](../../.gitbook/assets/scepman_user_w10_2%20%281%29%20%281%29.png)

{% hint style="warning" %}
The setting Key Storage Provider \(KSP\) determines the storage location of the private key for the end-user certificates. Storage in the TPM is more secure than software storage, because the TPM provides an additional layer of security to prevent key theft. However, there is **a bug in some older TPM firmware versions** that invalidates some signatures created with a TPM-backed private key. In such cases, the certificate cannot be used for EAP authentication as it is common for Wi-Fi and VPN connections. Affected TPM firmware versions include:

* STMicroelectronics: 71.12
* Intel: 11.8.50.3399

If you use TPMs with these firmwares, either update your firmware to a newer version or select "Software KSP" as key storage provider.
{% endhint %}

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all its done, you have the following two certificate configurations:

* SCEPman - SCEP user certificate
* SCEPman - Trusted root certificate

| ​[Back to Trial Guide​](../../getting-started/trial-guide.md#step-4-configure-intune-deployment-profiles) | [Back to Community Guide](../../getting-started/community-guide.md#step-9-configure-intune-deployment-profiles) | ​[Back to Enterprise Guide​](../../getting-started/enterprise-guide.md#step-11-configure-intune-deployment-profiles) |
| :--- | :--- | :--- |


