---
category: Troubleshooting
title: Troubleshooting Steps
order: 1
---

# Troubleshooting

## I deployed SCEPman from GitHub and it used to work, but now the Web App does not start anymore

If the error is '503 Cannot download ZIP', then the web app cannot download the ZIP with the application binaries from the URL configured in the app setting WEBSITE\_RUN\_FROM\_PACKAGE \(see [Application Configuration](https://github.com/glueckkanja/gk-scepman-docs/tree/a12be7b940f4bb801d1f91fc7150b3b50dcb0209/docs/other/deployment-optional/02_application_configuration/README.md)\).

The URL [https://github.com/glueckkanja/gk-scepman/raw/master/dist/Artifacts.zip](https://github.com/glueckkanja/gk-scepman/raw/master/dist/Artifacts.zip) that we had recommended for GitHub deployments in earlier versions of this documentation redirects to another URL. Microsoft changed the behavior of some of their Web Apps and now some versions do not support redirects together with WEBSITE\_RUN\_FROM\_PACKAGE. Hence, you need to change the URL to `https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts.zip`.

## Trusted Root Certificate is deployed but my Device Certificate via SCEP Profile results in an Error

The SCEP profile will result in an error if the certificate deployment was not successful. Errors can have several reasons:

### SCEP certificate profile is configured with an error

This could happen when a wrong trusted root certificate was selected in the SCEP certificate profile. This is also shown in the event log:

1. Open the Windows Events application
2. Click **Applications and Services Logs**
3. Next, click **Microsoft**
4. Then, click **Windows**
5. Scroll down and search for **DeviceManagement-Enterprise-Diagnostics-Provider** and click it.
6. In the window which will appear, click **Admin**
7. Scroll through the list an search for event ID **32**
8. It contains a short error report
   * SCEP: Certificate enroll failed. Result \(The hash value is not correct.\).

![](../../.gitbook/assets/event32_1%20%282%29%20%283%29%20%283%29%20%283%29%20%282%29%20%281%29%20%281%29.png)

### SCEPman Azure Web App is not running

Check if the Azure resource is up and running.

![](../../.gitbook/assets/event32_2%20%283%29%20%283%29%20%283%29%20%283%29%20%282%29%20%281%29%20%283%29.png)

### SCEPman has a configuration or internal problem

Check Azure Web App log files via **Advanced Tools**:

1. Go to **Kudu**
2. Use **CMD**
3. Navigate to **LogFiles**
4. Then, **Application**

Click on the download icon on the latest .txt file and review it

![](../../.gitbook/assets/event32_3%20%282%29%20%287%29%20%284%29%20%283%29.png)

![](../../.gitbook/assets/event32_3%20%282%29%20%287%29%20%284%29%20%286%29.png)

## Additional way of logging

1. Configure the **App Services Logs**
2. Check the **Log Stream** of the **App Service**.

![](../../.gitbook/assets/event32_5%20%282%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%282%29%20%281%29.png)

![](../../.gitbook/assets/event32_6%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%282%29%20%281%29.png)

1. Monitor the log stream
2. Reproduce the error
3. Look for the log starting with **Request validation unsuccessful, as Intune validation threw an exception**
4. These message should have more details

## My Certificate does not have the correct OCSP URL Entry

{% hint style="info" %}
This is just a problem before version 1.2
{% endhint %}

If the device certificate has a localhost URL for the OCSP entry in the certificate like this:

![](../../.gitbook/assets/event32_7%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%281%29%20%282%29.png)

The App Service is missing an important application setting with the name **AppConfig:BaseUrl** set to the azurewebsite URL. To fix this, add the variable and save the App Service config:

```text
AppConfig:BaseUrl
https://scepman-XXXXX.azurewebsites.net
```

Delete this certificate from the device and do the MDM sync. If you did it you will see a proper URL for the OCSP entry:

![](../../.gitbook/assets/event32_8%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%282%29.png)

## Revocation of a Certificate

First, you need to check the validity of the device certificate. Therefore, open a command prompt as administrator and type the following command:

```text
certutil -verifyStore MY
```

Look at the certificate with the device ID issued by the SCEPman-Device-Root-CA-V1 and verify if the certificate is valid \(see last line\).

![](../../.gitbook/assets/scepman_revocation1%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%281%29.png)

To verify that the OCSP responder is working, you can look at the OCSP url cache with the following command:

```text
certutil -urlcache OCSP
```

![](../../.gitbook/assets/scepman_revocation2%20%282%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29.png)

If you want to revoke a **user** certificate, you have two options:‌

1. Deleting the user from Azure AD or
2. Block sign-in for the user

If you want to revoke a **device** certificate, you have two options:

1. Deleting the device from Azure AD or
2. Disabling a device

The following example shows the the second option 'Disabling a device'\(the result for user certificates will be the same\):

1. Navigate to **Devices - All devices** in your Azure AD
2. Choose a device
3. Click **Disable**

Next, type in the following command again:

```text
certutil -verifyStore MY
```

As you can see in the last line, the **Certificate is REVOKED**

![](../../.gitbook/assets/scepman_revocation3%20%282%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%282%29%20%282%29.png)

When you enable the device in Azure AD again and you type in the command from above again, the certificate should be marked as valid.

{% hint style="info" %}
It can take up to 5 minutes before the prompt 'Marked as valid' appears.
{% endhint %}

As an alternate you can export the device certificate and use `certutil` to display a small certutil UI for the OSCP check:

```text
certutil -url <path-to-exported-device-certificate>
```

![](../../.gitbook/assets/scepman_revocation4%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%283%29%20%282%29.png)

### My SCEP configuration profile shows pending and is not applied

The SCEP configuration profile depends on the Trusted Root certificate profile. Assign both profiles to the same Azure Active Directory user or device group to make sure the user or device overlaps and both profiles are targeted to the device. Do not mix user and device groups. If you see pending as status for the configurations profiles in Intune for a long time, the assignment is probably wrong.

### Access Point cannot verify an authentication certificate that SCEPman has issued

_Symptoms_: Cisco ISE shows an OCSP unreachable error. Aruba ClearPass also has this problem. The server, seemingly SCEPman, answers with an TCP reset packet to the OCSP request.

_Cause_: Both Cisco ISE as well as Aruba ClearPass do not support HTTP 1.1 when looking up OCSP and do not send a host header in their OCSP request. Therefore, they cannot connect to a general SCEPman instance running on Azure App Services. The error message may look like this:

![](../../.gitbook/assets/cisco-ocsp-error%20%282%29%20%284%29%20%284%29%20%284%29%20%284%29%20%284%29%20%282%29%20%281%29%20%282%29.jpg)

_Solution_: Please see [here](cisco-ise-host-header-limitation.md).

## Device Certificates on my Android (dedicated) systems are not valid

On Android (dedicated) systems, Intune or Android accidentially puts the Intune Device ID into the certificate instead of the AAD Device ID in random cases, although you configure the variable &#123;&#123;AAD\_Device\_ID&#125;&#125; in the SCEP configuration profile. SCEPman then cannot find a device with this ID in AAD and therefore considers the certificate revoked.

<!-- For the cases we have seen, the issue was resolved when using &#123;&#123;AzureADDeviceId&#125;&#125; instead of &#123;&#123;AAD\_Device\_ID&#125;&#125; in the configuration profile. -->

This issue occurs only if a Subject Alternative Name (SAN) is defined in the configuration profile. If you remove the SAN configuration, but keep &#123;&#123;AAD\_Device\_ID&#125;&#125; in the subject, the certificates will consistently get the actual Azure AD Device ID in their subject. This fixes the problem.