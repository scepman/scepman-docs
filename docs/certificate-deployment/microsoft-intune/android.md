# Android

The following article describes how to deploy a device certificate or a user certificate for Android. Android certificate deployment is similar to Windows 10, macOS, and iOS certificate deployments.

## Deploying Device Certificate

Android offers two different solution sets for using an Android device with a [work profile](https://developers.google.com/android/work/requirements/work-profile) solution set and a [fully managed device](https://developers.google.com/android/work/requirements/fully-managed-device) solution set.

{% hint style="info" %}
Android device administrator management was released in Android 2.2 as a way to manage Android devices. Then beginning with Android 5, the more modern management framework of Android Enterprise was released (for devices that can reliably connect to Google Mobile Services). **Google is encouraging movement off of device administrator management by decreasing its management support in new Android releases**. For more information please check [MS. Intune Decreasing support for Android device admin](https://techcommunity.microsoft.com/t5/intune-customer-success/decreasing-support-for-android-device-administrator/ba-p/1441935)
{% endhint %}

### Certificate Deployment for Android Work Profiles

{% hint style="warning" %}
In case you are using an intermediate CA, use the root CA certificate instead of the CA certificate from SCEPman. This applies to the trusted root configuration profile as well as the SCEP configuration profiles.
{% endhint %}

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](<../../.gitbook/assets/SCEPmanHomePage (2).png>)

Then, create a profile in Microsoft Intune:

1. Navigate to **Microsoft Intune**
2. Click **Devices**
3. Click **Configuration profiles**
4. Click + **Create profile**
5. Platform: **Android Enterprise**
6. Profile type: **Trusted certificate**
7. **Create**
8. Set profile **Name** and **Description**(optional)
9. Upload your root CA certificate
10. Assign users and/or groups
11. Finally, click **Create**

![](<../../.gitbook/assets/2021-10-12 15\_28\_15-.png>)

Now, you must create a SCEP certificate profile to deploy the device certificates. Essential for this step is the SCEP Server, you can find it

Next, to finally deploy the device certificates, you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. Select **SCEP certificate**, under **Fully Managed, Dedicated, and Work Profile**, as **Profile type**
7. **Create,** then choose **Name** and description (optional) for the profile, **Next**
8. Set the **Configuration settings** as in the picture below

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the green rectangle is automatically set by SCEPman (for better visibility I recommend to set the settings in the green rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 months currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **There is a dependency on the \{{AAD\_Device\_ID\}} in the subject name, which is used as a seed for the certificate serial number generation. Therefore, the subject name must include CN=\{{AAD\_Device\_ID\}}**.
{% endhint %}

![](<../../.gitbook/assets/scepman\_android2 (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next, click **OK,** and finally click **Create**

When all is finished, you have the following two certificate configurations:

* SCEPman - SCEP Android device certificate
* SCEPman - Trusted root Android certificate

### Certificate Deployment for Fully Managed Devices

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

<figure><img src="../../.gitbook/assets/2023-06-15 14_02_30-Android - SCEPman.png" alt=""><figcaption></figcaption></figure>

Then, create a profile in Microsoft Intune:

![](<../../.gitbook/assets/scepman\_android1 (4) (4) (4) (4) (4) (4) (4) (4) (4) (1) (4).png>)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** (under **Device Owner Only**)
5. Click **Settings** and select **A valid .cer file**
6. Then click **OK**
7. Finally click **Create**

When you are finished with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Make note of the SCEP server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman

![](<../../.gitbook/assets/scepman27 (2) (1) (28).png>)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman.contoso.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman.contoso.azurewebsites.net/certsrv/mscep/mscep.dll)

Next, to finally deploy the device certificates, you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. As **Profile type** select **SCEP certificate** (under **Device Owner Only**)
7. Click **Settings**

![](<../../.gitbook/assets/scepman\_android1\_1 (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2).png>)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman (for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **There is a dependency on the \{{AAD\_Device\_ID\}} in the subject name, which is used as a seed for the certificate serial number generation. Therefore, the subject name must include CN=\{{AAD\_Device\_ID\}}**.
{% endhint %}

![](<../../.gitbook/assets/scepman\_android2 (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next, click **OK** and finally click **Create**

When all is finished, you have the following two certificate configurations:

* SCEPman - SCEP Android device certificate
* SCEPman - Trusted root Android certificate

### Subject Alternative Name

A [Subject alternative name](https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.6) (SAN) is important for the whole Android device login process into a Wi-Fi profile. It can be divided into three phases:

1. During the enrollment phase, you have to log in to your company portal with a company domain (like john.doe@companyname.com)
2. When the synchronization starts the device gets a certificate and a Wi-Fi.
3. The Wi-Fi profile will be deployed. In detail, the following steps working in the background:
   * SAN verification ([RFC 2818](https://www.rfc-editor.org/rfc/rfc2818))
   * Search for certifications and profiles, based on your company domain
   * Deploy Wi-Fi profile on your device

It is required to have a **Subject alternative name** in the **SCEP Certificate**. Without a SAN, you have no access to your company's Wi-Fi.

### My Certificates

To check if your certificate runs well on your Android device you can use [My Certificates](https://play.google.com/store/apps/details?id=com.wesbunton.projects.mycertificates\&hl=en) from Google Play.

## Deploying User Certificate

Android offers two different solution sets for using an Android device. A [work profile](https://developers.google.com/android/work/requirements/work-profile) solution set and a [fully managed device](https://developers.google.com/android/work/requirements/fully-managed-device) solution set.

### Certificate Deployment for Android Work Profiles

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

<figure><img src="../../.gitbook/assets/2023-06-15 14_02_30-Android - SCEPman.png" alt=""><figcaption></figcaption></figure>

Then, create a profile in Microsoft Intune:

![](<../../.gitbook/assets/scepman\_android1 (4) (4) (4) (4) (4) (4) (4) (4) (4) (1) (4).png>)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** (under **Work Profile Only**)
5. Click **Settings**, select **A valid .cer file**
6. Then, click **OK**
7. Finally, click **Create**

When you are done with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](<../../.gitbook/assets/scepman27 (2) (1) (28).png>)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman.contoso.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman.contoso.azurewebsites.net/certsrv/mscep/mscep.dll)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. As **Profile type** select **SCEP certificate** (under **Device Owner Only**)
7. Click **Settings**

![](<../../.gitbook/assets/scepman\_user\_android\_1 (2) (2) (2) (2) (2) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman (for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **The setting for 'Subject name format' is freely selectable. For Subject alternative name we recommend to set 'User principial name (UPN)'.**
{% endhint %}

![](<../../.gitbook/assets/scepman\_user\_android\_2 (2) (2) (2) (2) (2) (2) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP Android user certificate
* SCEPman - Trusted root Android certificate

### Certificate Deployment for Fully Managed Devices

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

<figure><img src="../../.gitbook/assets/2023-06-15 14_02_30-Android - SCEPman.png" alt=""><figcaption></figcaption></figure>

Then, create a profile in Microsoft Intune:

![](<../../.gitbook/assets/scepman\_android1 (4) (4) (4) (4) (4) (4) (4) (4) (4) (1) (4).png>)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **Android Enterprise** as **Platform**
4. As **Profile type** select **Trusted certificate** (under **Device Owner Only**)
5. Click **Settings** and select **A valid .cer file**
6. Then click **OK**
7. Finally click **Create**

When you are done with it, you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

![](<../../.gitbook/assets/scepman27 (2) (1) (28).png>)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman.contoso.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman.contoso.azurewebsites.net/certsrv/mscep/mscep.dll)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **Android Enterprise** as **Platform**
6. As **Profile type** select **SCEP certificate** (under **Device Owner Only**)
7. Click **Settings**

![](<../../.gitbook/assets/scepman\_user\_android\_1 (2) (2) (2) (2) (2) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

1. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory to set by SCEPman, the yellow rectangle is automatically set by SCEPman (for better visibility I recommend setting the settings in the yellow rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 months currently. The red rectangle is a setting that is free to modify. Long term, all settings will be supported for configuration. **The setting for 'Subject name format' is freely selectable. For Subject alternative name we recommend to set 'User principial name (UPN)'.**
{% endhint %}

![](<../../.gitbook/assets/scepman\_user\_android\_2 (2) (2) (2) (2) (2) (2) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1).png>)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next, click **OK** and finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP Android user certificate
* SCEPman - Trusted root Android certificate

### Subject Alternative Name

A [Subject alternative name](https://www.rfc-editor.org/rfc/rfc5280#section-4.2.1.6) (SAN) is important for the whole android device login process into a Wi-Fi profile. It can be divided into three phases:

1. During the enrollment phase, you have to login to your company portal with a company domain (like john.doe@companyname.com)
2. When the synchronization starts the device gets a certificate and a Wi-Fi.
3. The Wi-Fi profile will be deployed. In detail, the following steps working in background:
   * SAN verification ([RFC 2818](https://www.rfc-editor.org/rfc/rfc2818))
   * Search for certifications and profiles, based on your company domain
   * Deploy Wi-Fi profile on your device

It is required to have a **Subject alternative name** in the **SCEP Certificate**. Without a SAN, you have no access to your company's Wi-Fi.

### My Certificates

To check if your certificate runs well on your Android device you can use [My Certificates](https://play.google.com/store/apps/details?id=com.wesbunton.projects.mycertificates\&hl=en) from Google Play.
