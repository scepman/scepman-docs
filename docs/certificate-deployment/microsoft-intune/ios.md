---
category: Configuration
title: iOS
order: 4
---

# iOS

The following article describes how to deploy a device certificate or a user certificate for iOS.

## Deploying Device Certificates

iOS certificate deployment is very similar to Windows 10 certificate deployment.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2822%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman_ios1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29.png)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **iOS/iPadOS** as **Platform**
4. Select **Trusted Certificate** as **Profile type**
5. Click **Settings**, select **A valid .cer file**
6. Then, click **OK**
7. Finally, click **Create**

When you are done with it you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%2821%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **iOS** as **Platform**
6. Select **SCEP certificate** as **Profile type**
7. Click **Settings**

![](../../.gitbook/assets/scepman_ios1_1.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term all settings will be supported for configuration. **There is a dependency on the {{AAD\_Device\_ID} in the subject name, which is used as a seed for the certificate serial number generation. Therefore the subject name must include**.

With our automatically set settings, we fulfill Apple's certificate requirements. For more details click [here](https://support.apple.com/en-us/HT210176).
{% endhint %}

![](../../.gitbook/assets/scepman_ios2%20%281%29%20%281%29.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all its done, you have the following two certificate configurations:

* SCEPman - SCEP iOS device certificate
* SCEPman - Trusted root iOS certificate

## Deploying User Certificates

iOS certificate deployment is very similar to Windows 10 and macOS deployments.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2813%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman_ios1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29.png)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **iOS/iPadOS** as **Platform**
4. Select **Trusted Certificate** as **Profile type**
5. Click **Settings**, select **A valid .cer file**
6. Then, click **OK**
7. Finally, click **Create**

When you are done with it you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%2815%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
_\*\*_\('xxx' is a placeholder\)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **iOS/iPadOS** as **Platform**
6. Select **SCEP certificate** as **Profile type**
7. Click **Settings**

![](../../.gitbook/assets/scepman_user_ios_1%20%281%29%20%281%29%20%281%29%20%281%29%20%281%29%20%281%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term all settings will be supported for configuration. **The setting for 'Subject name format' is freely selectable. For Subject alternative name we recommend to set 'User principal name \(UPN\)'.**

With our automatically set settings, we fulfill Apple's certificate requirements. For more details click [here](https://support.apple.com/en-us/HT210176).
{% endhint %}

![](../../.gitbook/assets/scepman_user_ios_2%20%281%29%20%281%29.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all its done, you have the following two certificate configurations:

* SCEPman - SCEP iOS user certificate
* SCEPman - Trusted root iOS certificate

| ​[Back to Trial Guide​](../../scepman-deployment/trial-guide.md#step-4-configure-intune-deployment-profiles) | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-9-configure-intune-deployment-profiles) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-11-configure-intune-deployment-profiles) |
| :--- | :--- | :--- |


