# Device Directories

SCEPman offers two options for validating device certificates (e.g. for OCSP requests). Both directories store device objects with different IDs that are checked for existence by SCEPman:

* Microsoft Entra ID (Azure AD) Device ID
* Intune (Intune Device ID)

Those IDs are visible in Intune per device under the "Hardware" tab:

![](<../.gitbook/assets/image (15).png>)

For recognizing the device behind an issued certificate, SCEPman requires the corresponding **ID in the subject name**:

* Microsoft Entra ID (Azure AD): `CN={{AAD_Device_ID}}`
* Intune: `CN={{DeviceId}}`

When setting up SCEPman and certificate profiles in Intune, it is important to **decide which inventory should be used**.

### Entra ID vs. Intune

Both directories have their pros and cons. In general, we **recommend Intune** as your inventory:

* **The Entra Device ID can change during enrollment (seen on iOS/iPadOS/macOS)**:\
  The Entra Device ID is set to the Intune device ID until the device is finally Entra ID registered. Intune already issues the certificate before the device gets its final ID. As a result, SCEPman cannot find the device in the Entra ID after this ID change.
* **Intune is often maintained better than Entra ID**:\
  In theory, the Entra ID and Intune device objects are independent of each other. Deleting a device in Intune does not delete the corresponding Entra ID object. In addition, Autopilot devices can only be deleted in Intune and not in Microsoft Entra ID so the certificates would still be valid.

### SCEPman Configuration

SCEPman needs to know which directory/directories should be used for validation. Therefore, we offer the configuration option[#appconfig-intunevalidation-devicedirectory](application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-devicedirectory "mention"). Please adjust that value to suit your needs.

### Certificate Profiles

Please also adjust the subject name on your needs as stated under [microsoft-intune](../certificate-management/microsoft-intune/ "mention").

Please note that `CN={{DeviceId}}` is currently not supported for Android Enterprise Fully Managed, Dedicated and Corporate-Owned Work Profile as stated in [Microsoft docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep#create-a-scep-certificate-profile). If those device types are in use, think about checking both directories or only Microsoft Entra ID.

For **migrating** from Microsoft Entra ID to Intune ID or vice versa, **certificates** need to be **re-issued on all clients**. During that change, please configure SCEPman via [#appconfig-intunevalidation-devicedirectory](application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-devicedirectory "mention") to check both directories (so that both IDs are valid). After migration, you can switch to Intune or Entra ID as only directory.
