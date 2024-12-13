# Android

The following article describes how to deploy a device or a user certificate for Android. Android certificate deployment is similar to Windows 10, macOS, and iOS certificate deployments.

{% hint style="info" %}
Android provides two distinct solution sets: one is the [work profile](https://developers.google.com/android/work/requirements/work-profile) (known as _Personally-Owned Work Profile)_ and the other is the [fully managed device](https://developers.google.com/android/work/requirements/fully-managed-device) (known also as _Fully Managed, Dedicated, and Corporate-Owned Work Profile_). In both scenarios, the settings for certificate configuration profiles remain consistent.
{% endhint %}

{% hint style="info" %}
Android device administrator management was released in Android 2.2 as a way to manage Android devices. Then beginning with Android 5, the more modern management framework of Android Enterprise was released (for devices that can reliably connect to Google Mobile Services). **Google is encouraging movement from device administrator management by decreasing its management support in new Android releases**. For more information please check [MS. Intune Decreasing support for Android device admin](https://techcommunity.microsoft.com/t5/intune-customer-success/decreasing-support-for-android-device-administrator/ba-p/1441935)
{% endhint %}

## Root Certificate

The basis for deploying SCEP certificates (device or user) is to trust the root certificate of SCEPman. Therefore, you have to download the CA Root certificate and deploy it as a **Trusted certificate** profile via Microsoft Intune:

* [ ] Download the CA Certificate from SCEPman portal

![](<../../.gitbook/assets/image-2 (10).png>)

* [ ] Create a profile for Android Enterprise with the type **Trusted certificate** in Microsoft Intune (based on your enrollment option for Android devices)

<figure><img src="../../.gitbook/assets/2024-01-09 15_24_48-Create a profile.png" alt=""><figcaption></figcaption></figure>

* [ ] Upload your previously downloaded **.cer file**.
* [ ] Now you can deploy this profile to your devices. Please choose All Users and/or All Devices or a dedicated group for the assignment.

{% hint style="info" %}
Note, that you have to use the **same group for assigning** the **Trusted certificate** and **SCEP profile**. Otherwise, the Intune deployment might fail.
{% endhint %}

## Device Certificates

* [ ] Open the SCEPman portal and copy the URL under **Intune MDM**

<figure><img src="../../.gitbook/assets/2024-01-09 15_10_27.png" alt=""><figcaption></figcaption></figure>

* [ ] Create a profile for Android Enterprise with type **SCEP certificate** in Microsoft Intune (again, based on your enrollment option for the Android devices)

<figure><img src="../../.gitbook/assets/2024-01-09 16_09_19-Create a SCEP profile.png" alt=""><figcaption></figcaption></figure>

* [ ] Configure the profile as described

<details>

<summary>Certificate type: <code>Device</code></summary>

In this section, we are setting up a device certificate.

</details>

<details>

<summary>Subject name format: <code>CN={{DeviceId}}</code> or <code>CN={{AAD_Device_ID}}</code></summary>

SCEPman uses the CN field of the subject to identify the device and as a seed for the certificate serial number generation. Microsoft Entra ID (Azure AD) and Intune offer two different IDs:

* \{{DeviceId\}}: This ID is generated and used by Intune **(Recommended).** (Requires SCEPman 2.0 or higher and [#AppConfig:IntuneValidation:DeviceDirectory](../../scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory) to be set to **Intune** or **AADAndIntune**
* \{{AAD\_Device\_ID\}}: This ID is generated and used by Microsoft Entra ID (Azure AD).

You can add other RDNs if needed (e.g.: `CN={{DeviceId}}, O=Contoso, CN={{WiFiMacAddress}}`). Supported variables are listed in the [Microsoft docs](https://learn.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep#create-a-scep-certificate-profile).

</details>

<details>

<summary>Subject alternative name: <code>URI</code> Value:<code>IntuneDeviceId://{{DeviceId}}</code></summary>

The URI field is [recommended by Microsoft](https://techcommunity.microsoft.com/t5/intune-customer-success/new-microsoft-intune-service-for-network-access-control/ba-p/2544696) for NAC solutions to identify the devices based on their Intune Device ID.

Other SAN values like DNS can be added if needed.

</details>

<details>

<summary>Certificate validity period: <code>1 years</code></summary>

The amount of time remaining before the certificate expires. Default is set at one year.

SCEPman caps the certificate validity to the configured maximum in setting [_**AppConfig:ValidityPeriodDays**_](../../scepman-configuration/optional/application-settings/certificates.md#appconfig-validityperioddays), but otherwise uses the validity configured in the request.

</details>

<details>

<summary>Key usage: <code>Digital signature</code> and <code>key encipherment</code></summary>

Please activate both cryptographic actions.

</details>

<details>

<summary>Key size (bits): <code>4096</code></summary>

SCEPman supports 4096 bits.

</details>

<details>

<summary>Root Certificate: <code>Profile from previous step</code></summary>

Please select the Intune profile from \[[#root-certificate](android.md#root-certificate "mention")]\(android.md#root-certificate).

If you are using an [Intermediate CA](../../advanced-configuration/intermediate-certificate.md), you must still select the Trusted certificate profile for Root CA, not the Intermediate CA!

</details>

<details>

<summary>Extended key usage: <code>Client Authentication, 1.3.6.1.5.5.7.3.2</code></summary>

Please choose **Client Authentication (1.3.6.1.5.5.7.3.2)** under **Predefined values**. The other fields will be filled out automatically.

</details>

<details>

<summary>Renewal threshold (%): <code>20</code></summary>

This value defines when the device is allowed to renew its certificate (based on the remaining lifetime of an existing certificate). Please read the note under **Certificate validity period** and select a suitable value that allows the device the renew the certificate over a long period. A value of 20% would allow the device with 1 year valid certificate to start renewal 73 days before expiration.

</details>

<details>

<summary>SCEP Server URLs: Open the SCEPman portal and copy the URL of <a href="android.md#device-certificates">#Intune MDM</a></summary>

**Example**

```
https://scepman.contoso.com/certsrv/mscep/mscep.dll
```

</details>

### **Example**

<figure><img src="../../.gitbook/assets/2024-01-11 11_04_19-SCEP certificate - AndroidEnterpriseDeviceCert.png" alt=""><figcaption></figcaption></figure>

## User Certificates

Please follow the instructions of [#Device certificates](android.md#device-certificates) and take care of the following differences:

<details>

<summary>Certificate type: <code>User</code></summary>

In this section we are setting up a user certificate.

</details>

<details>

<summary>Subject name format: <code>CN={{UserName}},E={{EmailAddress}}</code></summary>

You can define RDNs based on your needs. Supported variables are listed in the [Microsoft docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep#create-a-scep-certificate-profile). We recommend to include the username (e.g.: janedoe) and email address (e.g.: janedoe@contoso.com) as baseline setting.

</details>

<details>

<summary>Subject alternative name: <code>(UPN)</code>Value: <code>{{UserPrincipalName}}</code></summary>

You **must** add the User principal name as the Subject alternative name. **Add '\{{UserPrincipalName\}}' as Subject Alternative Name of type User principal name (UPN).** This ensures that SCEPman can link certificates to user objects in AAD.

Other SAN values like an Email address can be added if needed.

</details>

{% hint style="info" %}
It is required to have a **Subject alternative name** in the **SCEP Certificate, User Type**. Without a SAN, you have no access to your company's Wi-Fi.
{% endhint %}

### **Example**

<figure><img src="../../.gitbook/assets/2024-01-11 10_59_48-SCEP certificate - AndroidEnterpriseUserCert.png" alt=""><figcaption></figcaption></figure>

## Certificate Check

To ensure the correct deployment of certificates on your Android device, there are two options:

* In newer Android versions (e.g. 14), you can verify certificates (user and trusted certs.) from the **settings** > **security and privacy**
* Via 3rd party apps like [My Certificates](https://play.google.com/store/apps/details?id=com.wesbunton.projects.mycertificates\&hl=en) or [X509 Certificate Viewer Tool](https://play.google.com/store/apps/details?id=com.rdupletlabs.certificateviewer)
