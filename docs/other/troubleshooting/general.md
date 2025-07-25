# Common Problems

## Problems Starting SCEPman

### I deployed SCEPman from GitHub and it used to work, but now the Web App does not start anymore

If the error is '503 Cannot download ZIP', then the web app cannot download the ZIP with the application binaries from the URL configured in the app setting WEBSITE\_RUN\_FROM\_PACKAGE (see [Application Configuration](../../scepman-configuration/application-artifacts.md#change-artifacts)).

The URL _https://github.com/glueckkanja/gk-scepman/raw/master/dist/Artifacts.zip_ that we had recommended for GitHub deployments in earlier versions of this documentation redirects to another URL. Microsoft changed the behavior of some of their Web Apps and now some versions do not support redirects together with WEBSITE\_RUN\_FROM\_PACKAGE. Hence, you need to change the URL to `https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts.zip`.

### SCEPman Azure Web App is not running

Check if the Azure resource is up and running.

![](<../../.gitbook/assets/event32-2 (14).png>)

### My App Service uses the wrong .NET version

In the App Service resource of SCEPman or Certificate Master, you can check which Stack and version is configured for that App Service under Settings -> Configuration -> General settings -> Stack settings. While the Stack is .NET, the .NET version might not match what you expect for your version of SCEPman, e.g. .NET 8 for SCEPman 2.8.

This is because some common .NET versions are automatically available on all Windows App Services, independently of which .NET version you select in the settings. We only lift SCEPman to a new .NET version when this version is included in this set of automatically installed .NET versions. We do this because our update mechanism via [WEBSITE\_RUN\_FROM\_PACKAGE ](../../scepman-configuration/application-settings/basics.md#website_run_from_package)does not give us any control over the .NET version setting. Hence, it actually does not matter what is configured as .NET version.

### My SCEPman App Service did not work on 2024-11-27 and it ceased to work completely since 2024-12-16 after is has been working with no issues for many years

We are shutting down the deprecated SCEPman artifacts repository [https://github.com/glueckkanja/gk-scepman](https://github.com/glueckkanja/gk-scepman) after over three years of moving artifacts to the new location [https://github.com/scepman/install](https://github.com/scepman/install). On Wednesday, 2024-11-27, we temporarily disabled the old location to make users aware of the permanent shutdown on Monday, 2024-12-16.

If you are affected, check your WEBSITE\_RUN\_FROM\_PACKAGE setting and [update the value](../../scepman-configuration/application-artifacts.md) to the new package location. This will also update your SCEPman version from 1.8 to the latest version, granting [many improvements](../../changelog.md) with full backwards compatibility.

If you are unsure whether you are using the latest repository, visit your SCEPman's splash page. If it is still configured at the old repository, it is displaying a warning (and has done that for the last three years already) that looks like this:

<figure><img src="../../.gitbook/assets/image (78).png" alt=""><figcaption><p>SCEPman using the old package location for WEBSITE_RUN_FROM_PACKAGE</p></figcaption></figure>

## Problems Issuing Certificates

### Trusted Root Certificate is deployed but my Device Certificate via SCEP Profile results in an Error

The SCEP profile will result in an error if the certificate deployment was not successful. Errors can have several reasons:

### SCEP certificate profile is configured with an error

This could happen when a wrong trusted root certificate was selected in the SCEP certificate profile. This is also shown in the event log:

1. Open the Windows Events application
2. Click **Applications and Services Logs**
3. Next, click **Microsoft**
4. Then, click **Windows**
5. Scroll down and search for **DeviceManagement-Enterprise-Diagnostics-Provider** and click it.
6. In the window which will appear, click **Admin**
7. Scroll through the list and search for event ID **32**
8. It contains a short error report
   * SCEP: Certificate enrollment failed. Result (The hash value is not correct.).

![](<../../.gitbook/assets/event32-1 (15).png>)

If you are using an Intermediate CA, note that you have to [select the Intermediate CA certificate](../../scepman-deployment/intermediate-certificate.md#intermediate-cas-and-intune-scep-profiles) and not the Root CA certificate in the SCEP configuration profile! Note that this is specific to the Windows platform and for example Android requires selecting the Root CA certificate in the SCEP configuration profile.

### My Certificate does not have the correct OCSP URL Entry

{% hint style="info" %}
This is just a problem before version 1.2
{% endhint %}

If the device certificate has a localhost URL for the OCSP entry in the certificate like this:

![](<../../.gitbook/assets/event32-7 (15).png>)

The App Service is missing an important application setting with the name **AppConfig:BaseUrl** set to the azurewebsite URL. To fix this, add the variable and save the App Service config:

```
AppConfig:BaseUrl
https://scepman-XXXXX.azurewebsites.net
```

Delete this certificate from the device and do the MDM sync. If you did it you will see a proper URL for the OCSP entry:

![](<../../.gitbook/assets/event32-8 (7).png>)

### My SCEP configuration profile shows pending and is not applied

The SCEP configuration profile depends on the Trusted Root certificate profile. Assign both profiles to the same Azure Active Directory user or device group to make sure the user or device overlaps and both profiles are targeted to the device. Do not mix user and device groups. If you see pending as status for the configurations profiles in Intune for a long time, the assignment is probably wrong.

### Some Windows Machines do not enroll or renew certificates

You can check both from the SCEPman side and the client side. Depending on the problem, which you often do not know beforehand, the root cause is shown on only of the two sides.

Check whether there is any `[ERROR]` entry in the SCEPman logs. Possibly also search for the search term `[WARN`, but this may yield some false positives.

Oliver Kieselbach and Christoph Hannebauer wrote [a blog article about analysis of certificate request or renewal problems](https://oliverkieselbach.com/2022/09/21/deep-dive-of-scep-certificate-request-renewal-on-intune-managed-windows-clients/) that helps you to track down enrollment problems on the client side.

The Windows SCEP client supports only TLS up to version 1.2. Setting the minimum inbound TLS version to 1.3 in the SCEPman App Service causes particular error entries in the `DeviceManagement-Enterprise-Diagnostics-Provider` event log. Here is an example from a Windows 11 machine:

{% code overflow="wrap" fullWidth="false" %}
```
TimeCreated  : 7/2/2025 12:51:06 PM
ProviderName : Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider
Id           : 32
Message      : SCEP: Certificate enroll failed. Result: (Unknown Win32 Error code: 0x80072f8f).

TimeCreated  : 7/2/2025 12:51:06 PM
ProviderName : Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider
Id           : 307
Message      : SCEP: Failed LogError Message : (SCEPInstallCertificateWithScepHelper:Failed to Initialize
               SCEP enrollment with NDES Server
               'https://scepman.contoso.com/certsrv/mscep/mscep.dll/pkiclient.exe', CA cert thumbprint
               '24C45EF4284A5093A9C3886A6466C1D6D84EE058' and server certs ''. LogError 0x80)
```
{% endcode %}

### Windows 10 devices cannot enroll with AutoPilot

Currently, some Windows 10 devices do not have the correct time during the OOBE experience. This is not easy to see, since the screen shows no clock. This causes a problem with newly issued certificates, as they are _not yet_ valid. Windows then discards these "invalid" certificates and shows an error. Certificates are issued 10 minutes in the past by default to address smaller clock issues, but we have recently seen Windows 10 devices that are up to 9 hours behind time.

You may proceed with the enrollment and once this is finished, the device will get a certificate successfully, as the clock is correct then. You may also use the new option [**AppConfig:ValidityClockSkewMinutes**](../../scepman-configuration/application-settings/certificates.md#appconfig-validityclockskewminutes) to date back certificates for more than 10 minutes. Use 1440 minutes to date back the certificates for a whole day. This will be the default for new SCEPman installations to address this issue.

### I issued a certificate today, but the Issuance Date says it was yesterday

This is because SCEPman dates back certificate by one day to counter issues with devices whose clock is late, see [Windows 10 devices cannot enroll with AutoPilot](general.md#windows-10-devices-cannot-enroll-with-autopilot).

## Problems with the Validity of Certificates

### Check local Certificate

#### Windows Machine

First, you need to check the validity of the device certificate. Therefore, open a command prompt as administrator and type the following command:

```
certutil -verifyStore MY
```

Look at the certificate with the device ID issued by the SCEPman-Device-Root-CA-V1 and verify if the certificate is valid (see last line).

![](<../../.gitbook/assets/scepman-revocation1 (6).png>)

To verify that the OCSP responder is working, you can look at the OCSP url cache with the following command:

```
certutil -urlcache OCSP
```

![](<../../.gitbook/assets/scepman-revocation2 (7).png>)

#### macOS Machine

To check the validity of a certificate on a macOS machine using OCSP, please follow these steps:

1. Export the SCEPman Root CA certificate from **Keychain Access** (**System Keychains > System Roots**) as \*.cer file and place it in a folder (alternatively, you can download it from your SCEPman instance's website).
2. Export the client authentication certificate you want to verify from **Keychain Access** (**System Keychains > System > My Certificates**) as \*.cer file into the same folder.
3.  Extract the OCSP responder URL from the client authentication certificate's **Authority Information Access** (AIA) property:

    <figure><img src="../../.gitbook/assets/image (2) (1) (1).png" alt=""><figcaption></figcaption></figure>
4. Open a **Terminal** session and `cd` to the folder that contains the exported certifcates.
5. Execute the following command:

```
openssl ocsp -issuer <filename-scepman-root-ca-certificate> -cert <filename-certificate-to-be-verified> -text -url <ocsp-responder-url>
```

6.  Towards the end of the response, the revocation status is displayed:\\

    <figure><img src="../../.gitbook/assets/image (50).png" alt=""><figcaption></figcaption></figure>

### Check certificates from other machines

As an alternate you can export the device certificate and use `certutil` on a Windows machine to display a small certutil UI for the OSCP check:

```
certutil -url <path-to-exported-device-certificate>
```

![](<../../.gitbook/assets/scepman-revocation4 (7).png>)

### Revoke a user

If you want to revoke a **user** certificate, you have two options:‌

1. Deleting the user from Microsoft Entra ID (Azure AD) or
2. Block sign-in for the user

If you want to revoke a **device** certificate, you have multiple options depending on [#appconfig-intunevalidation-devicedirectory](../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-devicedirectory "mention"):

1. Microsoft Entra ID (Azure AD): Delete or disable the device ([Microsoft Entra ID (Azure AD) Portal](https://aad.portal.azure.com/): "Devices" - "All devices").
2. **Intune**: Delete the device or trigger a remote action (several managements states like "WipePending" automatically revoke certificates as stated under [#appconfig-intunevalidation-revokecertificatesonwipe](../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-revokecertificatesonwipe "mention")).
3. **Both directories**: Execute actions for Microsoft Entra ID (Azure AD) **and** Intune as described.

{% hint style="info" %}
For more details on device directories, please read the article [device-directories.md](../../scepman-configuration/device-directories.md "mention").
{% endhint %}

The following example revokes a device certificate via Microsoft Entra ID (Azure AD):

1. Navigate to **Devices - All devices** in your Microsoft Entra ID (Azure AD)
2. Choose a device
3. Click **Disable**

Next, type in the following command again:

```
certutil -verifyStore MY
```

As you can see in the last line, the **Certificate is REVOKED**

![](<../../.gitbook/assets/scepman-revocation3 (15).png>)

When you enable the device in Microsoft Entra ID (Azure AD) again and you type in the command from above again, the certificate should be marked as valid.

{% hint style="info" %}
It can take up to 5 minutes before the prompt 'Marked as valid' appears.
{% endhint %}

### Access Point cannot verify an authentication certificate that SCEPman has issued

_Symptoms_: Cisco ISE shows an OCSP unreachable error. Aruba ClearPass also has this problem. The server, seemingly SCEPman, answers with an TCP reset packet to the OCSP request.

_Cause_: Both Cisco ISE as well as Aruba ClearPass do not support HTTP 1.1 when looking up OCSP and do not send a host header in their OCSP request. Therefore, they cannot connect to a general SCEPman instance running on Azure App Services. The error message may look like this:

![](<../../.gitbook/assets/cisco-ocsp-error (18).jpg>)

_Solution_: Please see [here](cisco-ise-host-header-limitation.md).

### Device Certificates on my Android (dedicated) systems are not valid

On Android (dedicated) systems, Intune or Android accidentally puts the Intune Device ID into the certificate instead of the AAD Device ID in random cases, although you configure the variable in the SCEP configuration profile. SCEPman then cannot find a device with this ID in AAD and therefore considers the certificate revoked.

This happens only when you use the Microsoft Entra ID (Azure AD) shared mode for enrollment method for corporate-owned dedicated devices instead of the default mode. If you use the default mode for Token types `Corporate-owned dedicated device`, you will not be affected by the problem. Intune will still put the Intune Device ID into the certificate instead of the AAD Device ID, but they will be the same for the default mode, so it does not matter. To change the enrollment mode, go to the [Android enrollment settings of Microsoft Endpoint Manager admin center](https://endpoint.microsoft.com/#blade/Microsoft_Intune_DeviceSettings/DevicesAndroidMenu/androidEnrollment) and choose `Corporate-owned dedicated device (default)` instead of `Corporate-owned dedicated device with Azure AD shared mode`. Please refer to the [Microsoft documentation](https://docs.microsoft.com/en-us/mem/intune/enrollment/android-kiosk-enroll) for the implications of this selection.

We are currently working with Microsoft to solve this issue in all configurations. Please contact our support if you are also affected.

### My Storage Account says it is Not Connected

If your SCEPman homepage shows a red tag "Not Connected" for Storage Account connectivity, possibly the Managed Identity of the SCEPman App Service (and possibly that of SCEPman Certificate Master) is missing permissions on the Storage Account. In this case, SCEPman cannot check whether a certificate is manually revoked and therefore cannot respond to OCSP requests. This usually happens if you move the Storage Account to another subscription or resource group. It may also occur after upgrading a Community Edition version to Enterprise Edition -- in this case, the permission problem existed before, but the Community Edition did not check for it.

To fix this, you need to grant the Managed Identity of the SCEPman App Service and that of SCEPman Certificate Master the role "Storage Table Data Contributor" on the Storage Account. The role assignments can be done manually in the Azure Portal under "Access Control (IAM)" in the Storage Account. Alternatively, just [execute the SCEPman Installation CMDlet from the SCEPman PowerShell module once again](../../scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet).



## SCEPman won't issue certificates with EKUs other than Client Authentication

Check your SCEPman Environment Variables to see what is configured for [AppConfig:UseRequestedKeyUsages](../../scepman-configuration/application-settings/certificates.md#appconfig-userequestedkeyusages). If it is not set, it defaults to "false".&#x20;

New installations will automatically set this to "true", however older SCEPman installations have this set as false. SCEPman updates don't change any behavior except for fixes or changes that have under no circumstances a disadvantage. When this is set to false, the requests EKUs and Key Usages are ignored.\
