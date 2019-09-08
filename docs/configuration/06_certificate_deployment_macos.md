---
category: Configuration
title: MacOS
order: 2
---

# MacOS

## Deploying Device Certificates - MacOS

The following section will show you how you can deploy device certificates via Intune Certificate profile on macOS X 10.12 \(or later\) devices.

First, we need to trust the public root certificate from SCEPman. Therefore, you have to download the CA certificate \(from SCEPman\) and deploy it via a trusted certificate profile in Microsoft Intune:

Download the CA certificate:

[![GetCACert](../.gitbook/assets/scepman24.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman24.png)

Then, create a profile in Microsoft Intune:

[![TrustedCertificate](../.gitbook/assets/scepman_macos1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_macos1.png)

1. Enter a **Name**
2. As **Platform** select **macOS**
3. As **Profile type** select **Trusted certificate**
4. Click **Settings**, select **A valid .cer file**
5. Then, click **OK**
6. Finally, click **Create**

When you are done with it you can deploy this profile to your devices.

Now, you have to create a SCEP certificate profile to deploy the device certificates. Important for this step is the SCEP Server URL. This URL can be found in the **Overview** submenu of the app service of SCEPman:

[![SCEPServerURL](../.gitbook/assets/scepman27%20%281%29.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman27.png)

Append the following to your URL: **/certsrv/mscep/mscep.dll**. Note this URL: [https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll](https://scepman-xxx.azurewebsites.net/certsrv/mscep/mscep.dll)

Next, to finally deploy the device certificates you have to create a SCEP certificate profile in Intune:

1. Navigate to **Microsoft Intune**
2. Click **Device Configuration**
3. Choose **Profile** and click **Create profile**
4. Then, enter a **Name**
5. Select **macOS** as **Platform**
6. Select **SCEP Certificate** as **Profile type**
7. Click **Settings**

[![SCEPCertificate](../.gitbook/assets/scepman_macos1_1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_macos1_1.png)

1. Configure the **SCEP Certificate**

> \[!IMPORTANT\] You can not configure all **SCEP Certificate** settings. This is because some settings are mandatory set by SCEPman, the yellow rectangle is automatically set by SCEPman \(for better visibility I recommend to set the settings in the yellow rectangle to the SCEPman mandatory settings like shown below\). Hereby is the Key usage set to **Digital signature** and **Key encipherment**. The validity period is set to fixed 6 month currently. The red rectangle are settings which are free to modify. Long term all settings will be supported for configuration. **There is a dependency on the  in the subject name, which is used as a seed for the certificate serial number generation. Therefore the subject name must include** .
>
> [![SCEPCertificateMandatory](../.gitbook/assets/scepman_macos2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_macos2.png)

1. Scroll down and enter the URL you have noted
2. Then, click **Add**
3. Next click **OK** and finally click **Create**

When all its done, you have the following two certificate configurations:

* SCEPman - SCEP device certificate
* SCEPman - Trusted root certificate

## Next Steps

* [Deploying Mobile Device Certificates](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/07_cert_mobile_client.md)
* [Troubleshooting](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/11_troubleshooting.md)

