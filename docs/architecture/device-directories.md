# Device Directories

SCEPman offers two options for validating device certificates (e.g. for OCSP requests). Both directories store device objects with different IDs that are checked for existence by SCEPman:

* Microsoft Entra ID (Azure AD) Device ID
* Intune (Intune Device ID)

Those IDs are visible in Intune per device under tab "Hardware":

![](<../.gitbook/assets/image (15).png>)

For recognizing the device behind an issued certificate, SCEPman requires the corresponding **ID in the subject name**:

* Microsoft Entra ID (Azure AD): `CN={{AAD_Device_ID}}`
* Intune: `CN={{DeviceId}}`

When setting up SCEPman and certificate profiles in Intune, it is important to **decide which inventory should be used**.

### AAD vs. Intune

Both directories have their pros and cons. In general, we **recommend Intune** as inventory since SCEPman 2.0:

* Microsoft Entra ID (Azure AD) **device ID can change during enrollment** (seen on iOS/iPadOS/macOS):\
  The AAD device ID is set to the Intune device ID until the device is finally AAD registered. Intune already issues the certificate before the device gets its final ID. As a result, SCEPman cannot find the device in the AAD after this ID change.
* **Intune is often maintained better than the AAD**:\
  In theory, the AAD and Intune device objects are independent of each other. Deleting a device in Intune, does not delete the corresponding AAD object. In addition, Autopilot devices can only be deleted in Intune and not in Microsoft Entra ID (Azure AD). So, the certificates would still be valid.

### SCEPman Configuration

SCEPman needs to know which directory/directories should be used for validation. Therefore, we offer the configuration option[#appconfig-intunevalidation-devicedirectory](../advanced-configuration/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory "mention"). Please adjust that value on your needs.

{% hint style="warning" %}
Note, that this requires version 2.0 or newer. SCEPman 1.x only supports Microsoft Entra ID (Azure AD) as directory.
{% endhint %}

### Certificate Profiles

Please also adjust the subject name on your needs as stated under [microsoft-intune](../certificate-deployment/microsoft-intune/ "mention").

Please note, that `CN={{DeviceId}}` is currently not supported for Android Enterprise Fully Managed, Dedicated and Corporate-Owned Work Profile as stated in [Microsoft docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep#create-a-scep-certificate-profile). If those device types are in use, think about checking both directories or only Microsoft Entra ID (Azure AD).

For **migrating** from Microsoft Entra ID (Azure AD) to Intune ID or vice versa, **certificates** need to be **re-issued on all clients**. During that change, please configure SCEPman via[#appconfig-intunevalidation-devicedirectory](../advanced-configuration/application-settings/intune-validation.md#appconfig-intunevalidation-devicedirectory "mention") to check both directories (so, that both IDs are valid). After migration, you can switch to Intune or AAD as only directory.
