# MacOS

The following article describes how to deploy a device certificate or a user certificate for MacOS.

## Deploying Device Certificates

The following section will show you how you can deploy user certificates via Intune Certificate profile on macOS X 10.12 (or later) devices.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](<../../../.gitbook/assets/scepman24 (1) (7) (8) (8) (8) (4) (13).png>)

Then, create a profile in Microsoft Intune:

![](<../../.gitbook/assets/2021-10-11 17\_26\_56-.png>)

1. Platform: macOS
2. Profile type: Templates
3. Search for **trusted certificate**, create
4. Set profile **Name **and **Description**(optional)
5. Upload your root certificate
6. Assign users and/or groups
7. Finally, click **Create**

When you are done with it, you can deploy this profile to your devices.

Now, you must create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server, you can find it from [here](windows-10.md#how-to-find-scep-url-for-intune)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click on **Devices**
3. Click on **Configuration profiles**
4. Click **+ Create profile**
5. Select macOS as **Platform**
6. Select Templates as **Profile type**
7. Search and select **SCEP certificate**
8. **Create**
9. Choose **Name** and Description (optional) for this profile
10. Set the** Configuration settings** as in the picture below

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the green rectangle is automatically set by SCEPman (for better visibility I recommend to set the settings in the green rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to fixed 6 month currently. The red rectangle is a setting that is free to modify. Long term all settings will be supported for configuration. **There is a dependency on the {{AAD_Device_ID} in the subject name, which is used as a seed for the certificate serial number generation. Therefore the subject name must include**.

With our automatically set settings, we fulfill Apple's certificate requirements. For more details click [here](https://support.apple.com/en-us/HT210176).
{% endhint %}

![](<../../.gitbook/assets/2021-10-11 18\_08\_20-SCEP certificate - Microsoft Endpoint Manager admin center and 12 more pages - C.png>)

11\. Scroll down and enter the URL you have noted under SCEP Server URLs

12\. Click **Next, **Assign users and groups

13\.  **Next** and finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP device certificate
* SCEPman - Trusted root certificate

## Deploying User Certificates

The following section will show you how you can deploy user certificates via Intune Certificate profile on macOS X 10.12 (or later) devices.

First, we need to trust the public root certificate from SCEPman. This step we did it already by deploying device certificates. Check [Deploying Device Certificates](macos.md#deploying-device-certificates)

Now, you must create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server, you can find it from [here](windows-10.md#how-to-find-scep-url-for-intune)

Next, to finally deploy the user certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click on **Devices**
3. Click on **Configuration profiles**
4. Click **+ Create profile**
5. Select macOS as **Platform**
6. Select Templates as **Profile type**
7. Search and select **SCEP certificate**
8. **Create**
9. Choose **Name** and Description (optional) for this profile
10. Set the **Configuration settings** as in the picture below

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the green rectangle is automatically set by SCEPman (for better visibility I recommend to set the settings in the green rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to fixed a 6 month currently. The red rectangle is a settings that is free to modify. Long term all settings will be supported for configuration. **The setting for 'Subject name format' is freely selectable. For Subject alternative name we recommend to set 'User principal name (UPN)'.**

With our automatically set settings, we fulfill Apple's certificate requirements. For more details click [here](https://support.apple.com/en-us/HT210176).
{% endhint %}

![](<../../.gitbook/assets/2021-10-11 18\_29\_44-SCEP certificate - Microsoft Endpoint Manager admin center and 12 more pages - C.png>)

11\. Scroll down and enter the URL you have noted

12\. Then, click **Add**

13\. Next click **OK** and finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP user certificate
* SCEPman - Trusted root certificate

| ​[Back to Trial Guide​](../../scepman-deployment/trial-guide.md#step-4-configure-intune-deployment-profiles) | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-9-configure-intune-deployment-profiles) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-11-configure-intune-deployment-profiles) |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
