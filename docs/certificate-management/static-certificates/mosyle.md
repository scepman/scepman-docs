# Mosyle

{% hint style="info" %}
This feature requires version 1.6 or above.
{% endhint %}

SCEPman can be connected to [Mosyle](https://mosyle.com/) as an External CA using SCEPman's static interface and a challenge password enrolled devices will be able to obtain certificates.

For more general information about other MDM solutions and SCEPman integration please check [here](./).

## Enable Mosyle Integration

Integrating Mosyle with SCEPman can be easily enabled via the following SCEPman app configurations:

{% hint style="info" %}
You can differentiate between the SCEPman App Service and the Certificate Master by looking for the App Service **without** the "-cm" in its name
{% endhint %}

|                                                                                                      Setting                                                                                                     | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                           [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                          | Enable the 3rd-party validation                                                                                                                                                                                                                                                                         |   **true** to enable, **false** to disable   |
|                   [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)                  | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|          [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)          | How many days shall certificates issued via Mosyle be valid                                                                                                                                                                                                                                             |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |

{% hint style="info" %}
After adding or editing SCEPman configuration parameters, you need to restart the app service.
{% endhint %}

## Mosyle Configuration

### SCEPman Root Certificate

As a first step you must deploy SCEPman's root certificate. Download this CA certificate via SCEPman website:

![SCEPman Website](<../../.gitbook/assets/image-2 (10).png>)

In Mosyle, navigate to Management and add "**Multi-Cert Profile**" as a new profile type (if it does not already exist).

Now **Add new profile,** choose a name for this profile, e.g. SCEPman Root CA, then click on **+ADD PROFILE** under Profile Name (see screenshot below)**,** and choose "Add Certificate profile" from the shown window. Next, select and upload the SCEPman root certificate you already download, add SCEPman Root CA as Profile Name and Save.

![Adding a Root CA Profile](<../../.gitbook/assets/2022-07-25 09-56-09-Glueckkanja GAB and 1 more page - Work - Microsoft Edge.png>)

![Upload Root CA](<../../.gitbook/assets/2022-07-25 10_04_49-Window.png>)

Now you need to assign this profile to your devices/users, then Save

![Save Root CA profile](<../../.gitbook/assets/2022-07-25 10_07_23-Window.png>)

After saving, you can check the compliance status by clicking on view details on the profile

![Profile Distribution Status](<../../.gitbook/assets/2022-07-25 10_10_27-Window.png>)

### Device Certificate

Add a new profile, add profile name e.g. SCEPman Device Certificate, **+ADD PROFILE,** now choose **SCEP Profile** and fill out the values as shown below

![SCEP Profile Configuration](<../../.gitbook/assets/2022-07-25 11_41_51.png>)

![SCEP Profile Configuration](<../../.gitbook/assets/2022-07-25 11_29_43.png>)

**Profile Name:** choose a name for your profile

**Server:** choose URL

**URL:** past your SCEPman URL with **/static** at the end as shown on the screenshot. You can also copy this value from SCEPman homepage near **Static MDM**

**Subject:** It is up to you which variables you choose for the subject, you can choose one or multiple Relative Distinguished Name (RDN). NOTE that RDNs always start with **/** for example

`/CN=%DeviceName%` for device name. On our example on the screenshot, we have added 3 RDNs, multiple CNs is also allowed. You can check the variable list by clicking on **View available variables** above the field.

**Subject Alternative Name** is optional.

**Challenge:** add your 32 character challenge password configured in SCEPman configuration, [see enable Mosyle integration](mosyle.md#enable-mosyle-integration)

**Key Size:** 2048

Enable the two options "**Use for signing**" and "**Use for encryption**", and leave all other settings as default (like shown on the screenshot) then **Save**

Now you need to assign this profile to your devices/users, then **Save**.

After saving, you can check the compliance status by clicking on view details on the profile

![Profile Distribution Status](<../../.gitbook/assets/2022-07-25 11_55_57-Window.png>)
