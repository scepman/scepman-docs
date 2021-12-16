# iOS

The following article describes how to deploy a device certificate or a user certificate for iOS.

## Deploying Device Certificates

iOS certificate deployment is very similar to Windows 10 certificate deployment.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate (from SCEPman) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

![](<../../.gitbook/assets/scepman24 (1) (7) (8) (8) (8) (4) (8).png>)

Then, create a profile in Microsoft Intune:

![](<../../.gitbook/assets/2021-10-22 11\_48\_06-Window.png>)

1. Download the CA Certificate
2. Then, create a profile in Microsoft Intune
3. Select **iOS/iPadOS** as **Platform**
4. Select **Trusted Certificate** as **Profile type**
5. Click **Settings**, select **A valid .cer file**
6. Then, click **OK**
7. Finally, click **Create**

When you are done with it you can deploy this profile to your devices.

Now, you must create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server, you can find it from [here](windows-10.md#how-to-find-scep-url-for-intune)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click on **Devices**
3. Click on **Configuration profiles**
4. Click **+ Create profile**
5. Select iOS/IPadOS as **Platform**
6. Select **SCEP certificates** as **Profile type**
7. **Create**
8. Choose **Name** and Description (optional) for this profile
9. Set the **Configuration settings** as in the picture below
10. Configure the **SCEP Certificate**

{% hint style="warning" %}
You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory to set by SCEPman, the green rectangle is automatically set by SCEPman (for better visibility I recommend setting the settings in the green rectangle to the SCEPman mandatory settings like shown below). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to a fixed 6 months currently. The red rectangle is a setting that is free to modify. Long term all settings will be supported for configuration. **There is a dependency on the {{AAD\_Device\_ID} in the subject name, which is used as a seed for the certificate serial number generation. Therefore the subject name must include**.

With our automatically set settings, we fulfill Apple's certificate requirements. For more details click [here](https://support.apple.com/en-us/HT210176).
{% endhint %}

![](<../../.gitbook/assets/2021-10-22 12\_14\_11-Window.png>)

1. Scroll down and enter the SCEPman URL you have noted
2. Click **Next,** Assign users and groups
3. **Next** and finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP iOS device certificate
* SCEPman - Trusted root iOS certificate

## Deploying User Certificates

iOS certificate deployment is very similar to Windows 10 and macOS deployments.

First, we need to trust the public root certificate from SCEPman. Therefore, This step we did it already by deploying device certificates. Check [Deploying device certificates](ios.md#deploying-device-certificates).

Now, you must create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server, you can find it from [here](windows-10.md#how-to-find-scep-url-for-intune)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click on **Devices**
3. Click on **Configuration profiles**
4. Click **+ Create profile**
5. Select iOS/IPadOS as **Platform**
6. Select Templates as **Profile type**
7. Search and select **SCEP certificate**
8. **Create**
9. Choose **Name** and Description (optional) for this profile
10. Set the **Configuration settings** as in the picture below

{% hint style="warning" %}
You cannot configure all SCEP Certificate settings. Specifically, SCEPman requires that user certificates contain the user's **UPN** in the **Subject alternative name** extension. All iOS versions we tested **ignore** the configured **validity period**. Thus, the [default validity period ](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-validityperioddays)configured in SCEPman applies.\
Other settings can be chosen according to your requirements, but we **recommend** the settings shown in the below screenshot for the most common use cases: Leave **Subject name format** as is. Set Key usage to **Digital signature** and **Key encipherment**. Have **2048 bits** as Key size. Select the configuration profile of your SCEPman **Root certificate**. Add **Client Authentication** as Extended key usage from the list of predefined values. Leave the Renewal threshold at **20 %**.
{% endhint %}

{% hint style="warning" %}
With our automatically set settings, we fulfill Apple's certificate requirements. For more details click [here](https://support.apple.com/en-us/HT210176).
{% endhint %}

![](<../../.gitbook/assets/2021-10-22 12\_32\_39-Window.png>)

* Scroll down and enter the SCEPman URL you have noted
* Click **Next,** Assign users and groups
* **Next** and finally click **Create**

When all is done, you have the following two certificate configurations:

* SCEPman - SCEP iOS user certificate
* SCEPman - Trusted root iOS certificate

| ​[Back to Trial Guide​](../../scepman-deployment/trial-guide.md#step-4-configure-intune-deployment-profiles) | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-9-configure-intune-deployment-profiles) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-11-configure-intune-deployment-profiles) |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------- |
