# Android

The following article describes how to deploy a device certificate or a user certificate for Android. Android certificate deployment is similar to Windows 10, macOS and iOS certificate deployments.

## Deploying Device Certificate

Android offers two different solution sets for using an Android device. A [work profile](https://developers.google.com/android/work/requirements/work-profile) solution set and a [fully managed device](https://developers.google.com/android/work/requirements/fully-managed-device) solution set.

### Certificate Deployment for Android Work Profiles

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2824%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman_android1%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%281%29%20%284%29.png)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** \(under **Work Profile Only**\)
5. Click **Settings** and **select a valid .cer file**
6. Then click **OK**
7. Finally click **Create**

When you are finished with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Make note of the SCEP server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%284%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates, you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. Select **SCEP certificate**, under **Work Profile Only**, as **Profile type**
7. Click **Settings**

![](../../.gitbook/assets/scepman_android1_1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%281%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **There is a dependency on the {{AAD\_Device\_ID} in the subject name, which is used as a seed for the certificate serial number generation. Therefore, the subject name must include**.
{% endhint %}

![](../../.gitbook/assets/scepman_android2%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%281%29.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next, click **OK** and finally click **Create**

When all is finished, you have the following two certificate configurations:

* SCEPman - SCEP Android device certificate
* SCEPman - Trusted root Android certificate

### Certificate Deployment for Fully Managed Devices

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2813%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman_android1%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%281%29%20%281%29.png)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** \(under **Device Owner Only**\)
5. Click **Settings** and select **A valid .cer file**
6. Then click **OK**
7. Finally click **Create**

When you are finished with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Make note of the SCEP server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%282%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates, you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. As **Profile type** select **SCEP certificate** \(under **Device Owner Only**\)
7. Click **Settings**

![](../../.gitbook/assets/scepman_android1_1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **There is a dependency on the {{AAD\_Device\_ID} in the subject name, which is used as a seed for the certificate serial number generation. Therefore, the subject name must include**.
{% endhint %}

![](../../.gitbook/assets/scepman_android2%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next, click **OK** and finally click **Create**

When all is finished, you have the following two certificate configurations:

* SCEPman - SCEP Android device certificate
* SCEPman - Trusted root Android certificate

### Subject Alternative Name

A [Subject alternative name](https://tools.ietf.org/html/rfc5280#section-4.2.1.6) \(SAN\) is important for the whole android device login process into a Wi-Fi profile. It can be divided into three phases:

1. During the enrollment phase, you have to login to your company portal with a company domain \(like john.doe@companyname.com\)
2. When the synchronization starts the device gets a certificate and a Wi-Fi.
3. The Wi-Fi profile will be deployed. In detail, the following steps working in background:
   * SAN verification \([RFC 2818](https://tools.ietf.org/html/rfc2818)\)
   * Search for certifications and profiles, based on your company domain
   * Deploy Wi-Fi profile on your device

It is much important to enter a **Subject alternative name** into the **SCEP Certificate**. Without a SAN you have no access to your company WLAN.

### My Certificates

To check if your certificate runs well on your Android device you can use [My Certificates](https://play.google.com/store/apps/details?id=com.wesbunton.projects.mycertificates&hl=en) from Google Play.

## Deploying User Certificate

Android offers two different solution sets for using an Android device. A [work profile](https://developers.google.com/android/work/requirements/work-profile) solution set and a [fully managed device](https://developers.google.com/android/work/requirements/fully-managed-device) solution set.

### Certificate Deployment for Android Work Profiles

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2816%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman_android1%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%281%29%20%283%29.png)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** \(under **Work Profile Only**\)
5. Click **Settings**, select **A valid .cer file**
6. Then, click **OK**
7. Finally, click **Create**

When you are done with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%2820%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. As **Profile type** select **SCEP certificate** \(under **Device Owner Only**\)
7. Click **Settings**

![](../../.gitbook/assets/scepman_user_android_1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **The setting for 'Subject name format' is freely selectable. For Subject alternative name we recommend to set 'User principial name \(UPN\)'.**
{% endhint %}

![](../../.gitbook/assets/scepman_user_android_2%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%281%29.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all its done, you have the following two certificate configurations:

* SCEPman - SCEP Android user certificate
* SCEPman - Trusted root Android certificate

### Certificate Deployment for Fully Managed Devices

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](../../.gitbook/assets/scepman24%20%281%29%20%287%29%20%288%29%20%288%29%20%288%29%20%284%29%20%2827%29.png)

Then, create a profile in Microsoft Intune:

![](../../.gitbook/assets/scepman_android1%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%281%29.png)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** \(under **Device Owner Only**\)
5. Click **Settings** and select **A valid .cer file**
6. Then click **OK**
7. Finally click **Create**

When you are done with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](../../.gitbook/assets/scepman27%20%282%29%20%281%29%20%2815%29.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)  
\('xxx' is a placeholder\)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. As **Profile type** select **SCEP certificate** \(under **Device Owner Only**\)
7. Click **Settings**

![](../../.gitbook/assets/scepman_user_android_1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%281%29.png)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **The setting for 'Subject name format' is freely selectable. For Subject alternative name we recommend to set 'User principial name \(UPN\)'.**
{% endhint %}

![](../../.gitbook/assets/scepman_user_android_2%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%281%29%20%282%29.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all its done, you have the following two certificate configurations:

* SCEPman - SCEP Android user certificate
* SCEPman - Trusted root Android certificate

### Subject Alternative Name

A [Subject alternative name](https://tools.ietf.org/html/rfc5280#section-4.2.1.6) \(SAN\) is important for the whole android device login process into a Wi-Fi profile. It can be divided into three phases:

1. During the enrollment phase, you have to login to your company portal with a company domain \(like john.doe@companyname.com\)
2. When the synchronization starts the device gets a certificate and a Wi-Fi.
3. The Wi-Fi profile will be deployed. In detail, the following steps working in background:
   * SAN verification \([RFC 2818](https://tools.ietf.org/html/rfc2818)\)
   * Search for certifications and profiles, based on your company domain
   * Deploy Wi-Fi profile on your device

It is much important to enter a **Subject alternative name** into the **SCEP Certificate**. Without a SAN you have no access to your company WLAN.

### My Certificates

To check if your certificate runs well on your Android device you can use [My Certificates](https://play.google.com/store/apps/details?id=com.wesbunton.projects.mycertificates&hl=en) from Google Play.

| ​[Back to Trial Guide​](../../scepman-deployment/trial-guide.md#step-4-configure-intune-deployment-profiles) | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-9-configure-intune-deployment-profiles) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-11-configure-intune-deployment-profiles) |
| :--- | :--- | :--- |


