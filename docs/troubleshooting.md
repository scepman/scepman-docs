---
category: Troubleshooting
title: Troubleshooting Steps
order: 1
---

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
    * SCEP: Certificate enroll failed. Result (The hash value is not correct.).

[![Event32](./media/event32_1.png)](./media/event32_1.png)

### SCEPman Azure Web App is not running 

Check if the Azure resource is up and running.

[![AzureResource](./media/event32_2.png)](./media/event32_2.png)

### SCEPman has a configuration or internal problem

Check Azure Web App log files via **Advanced Tools**:

1. Go to **Kudu**
2. Use **CMD**
3. Navigate to **LogFiles**
4. Then, **Application**

Click on the download icon on the latest .txt file and review it

[![AzureWebAppLog](./media/event32_3.png)](./media/event32_3.png)

[![Review](./media/event32_4.png)](./media/event32_4.png)

## Additional way of logging

1. Configure the **App Services Logs**
2. Check the **Log Stream** of the **App Service**.

[![AppServiceLogs](./media/event32_5.png)](./media/event32_5.png)

[![LogStream](./media/event32_6.png)](./media/event32_6.png)

4. Monitor the log stream
5. Reproduce the error
6. Look for the log starting with **Request validation unsuccessful, as Intune validation threw an exception**
7. These message should have more details

## My Certificate does not have the correct OCSP URL Entry

> [!NOTE]
> This is just a problem **before** version 1.2

If the device certificate has a localhost URL for the OCSP entry in the certificate like this:

[![Certificate](./media/event32_7.png)](./media/event32_7.png)

The App Service is missing an important application setting with the name **AppConfig:BaseUrl** set to the azurewebsite URL. To fix this, add the variable and save the App Service config:

```
AppConfig:BaseUrl
https://scepman-XXXXX.azurewebsites.net
```

Delete this certificate from the device and do the MDM sync. If you did it you will see a proper URL for the OCSP entry:

[![ProperURL](./media/event32_8.png)](./media/event32_8.png)

## Revocation of a Certificate

First, you need to check the validity of the device certificate. Therefore, open a command prompt as administrator and type the following command:

```
certutil -verifyStore MY
```

Look at the certificate with the device ID issued by the SCEPman-Device-Root-CA-V1 and verify if the certificate is valid (see last line).

[![CertificateValid](./media/scepman_revocation1.png)](./media/scepman_revocation1.png)

To verify that the OCSP responder is working, you can look at the OCSP url cache with the following command:

```
certutil -urlcache OCSP
```

[![OCSPUrlCache](./media/scepman_revocation2.png)](./media/scepman_revocation2.png)

If you want to revoke a device certificate, you have two options:

1. Deleting the device from Azure AD or
2. Disabling a device

The following example shows the the second option 'Disabling a device':

1. Navigate to **Devices - All devices** in your Azure AD
2. Choose a device
3. Click **Disable**

Next, type in the following command again:

```
certutil -verifyStore MY
```

As you can see in the last line, the **Certificate is REVOKED**

[![Revoked](./media/scepman_revocation3.png)](./media/scepman_revocation3.png)

When you enable the device in Azure AD again and you type in the command from above again, the certificate should be marked as valid.

> [!NOTE]
> It can take up to 5 minutes before the prompt 'Marked as valid' appears.

As an alternate you can export the device certificate and use ```certutil``` to display a small certutil UI for the OSCP check:

```
certutil -url <path-to-exported-device-certificate>
```

[![CertutilUI](./media/scepman_revocation4.png)](./media/scepman_revocation4.png)
