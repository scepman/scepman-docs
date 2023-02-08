# Mosyle

{% hint style="info" %}
This feature requires version 1.6 or above.
{% endhint %}

SCEPman can be connected to Mosyle as External CA. Via SCEPman's static interface and a challenge password enrolled devices will be able to obtain certificates.

For more general information about 3rd-party MDM solutions and SCEPman integration please check [here](./).

## Enable Mosyle Integration

Mosyle integration of SCEPman can be easily enabled via the following app configurations:

|                                                                                                                 Setting                                                                                                                 |                                        Description                                        |                        Value                        |
| :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------: | :-------------------------------------------------: |
|                                           [**AppConfig:StaticValidation:Enabled**](../../advanced-configuration/application-settings/static-validation.md#appconfig-staticvalidation-enabled)                                           |                             To enable the 3rd-party validation                            | \_**true** \_ to enable, \_ **false** \_ to disable |
|                                   [**AppConfig:StaticValidation:RequestPassword**](../../advanced-configuration/application-settings/static-validation.md#appconfig-staticvalidation-requestpassword)                                   | Mosyle authenticates its certificate requests at SCEPman with this secure static password |          _generate a 32 character password_         |
| <p><a href="../../advanced-configuration/application-settings/static-validation.md#appconfig-staticvalidation-validityperioddays"><strong>AppConfig:StaticValidation:ValidityPeriodDays</strong></a><br><strong>(optional)</strong></p> |                How many days shall certificates issued via Mosyle be valid                |                         365                         |

{% hint style="info" %}
After adding or editing SCEPman configuration, you need to restart the app service.
{% endhint %}

## Mosyle Configuration

### SCEPman Root Certificate

As first step you need to deploy SCEPman root certificate. Download this CA certificate via SCEPman dashboard:

![](<../../.gitbook/assets/SCEPmanHomePage (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (2) (9).png>)

In Mosyle, navigate to Management and add "**Multi-Cert Profile**" as a new profile type (if it does not already exist).

Now **Add new profile,** choose a name for this profile, e.g. SCEPman Root CA, then click on **+ADD PROFILE** under Profile Name (see screenshot below)**,** and choose "Add Certificate profile" from the shown window. Next, select and upload the SCEPman root certificate you already download, add SCEPman Root CA as Profile Name and Save.

![](<../../.gitbook/assets/2022-07-25 09\_56\_09-Glueckkanja GAB and 1 more page - Work - Microsoft​ Edge.png>)

![](<../../.gitbook/assets/2022-07-25 10\_04\_49-Window.png>)

Now you need to assign this profile to your devices/users, then Save

![](<../../.gitbook/assets/2022-07-25 10\_07\_23-Window.png>)

After saving, you can check the compliance status by clicking on view details on the profile

![](<../../.gitbook/assets/2022-07-25 10\_10\_27-Window.png>)

### Device Certificate

Add a new profile, add profile name e.g. SCEPman Device Certificate, **+ADD PROFILE,** now choose **SCEP Profile** and fill out the values as shown below

![](<../../.gitbook/assets/2022-07-25 11\_41\_51.png>)

![](<../../.gitbook/assets/2022-07-25 11\_29\_43.png>)

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

![](<../../.gitbook/assets/2022-07-25 11\_55\_57-Window.png>)
