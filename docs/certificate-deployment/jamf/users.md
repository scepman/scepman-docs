# Users

{% hint style="info" %}
This feature requires version **1.9** or above.
{% endhint %}

Please follow this guide to distribute certificates to users. User certificates are possible on computers (macOS) as well as devices (e.g.: iOS, iPadOS). Before deploying the first certificates via Jamf, follow the [general steps for Jamf](general.md) first.

{% hint style="info" %}
Note that the "User and Location" data of your computers or mobile devices need to be properly populated for user certificate to be issued. Especially, the user must have an email address, as this is used as unique identifier.
{% endhint %}

## SCEPman Root Certificate

As first step you need to deploy SCEPman root certificate if you haven't done this already for the target platform. Download this CA certificate via SCEPman dashboard:

![](<../../.gitbook/assets/SCEPmanHomePage (1) (1) (1) (1).png>)

Add a new "Mobile Device Configuration Profile" and/or "macOS Configuration Profile", depending on your target platform, and choose "Certificate" as payload. Enter a meaningful name and upload the certificate (for "Select Certificate Option" select "Upload):

![](<../../.gitbook/assets/image (25).png>)

## User Certificates on Computers

Under Computers -> Configuration Profiles, please add another "macOS Configuration Profile". Under the General Tab, change the Level to "User Level". On the left side, switch to the "SCEP" tab and configure a new SCEP payload. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field                          | Description                                     | Value/Example                                           |
| ------------------------------ | ----------------------------------------------- | ------------------------------------------------------- |
| Name                           | name/purpose                                    | e.g. "User Authentication"                              |
| Redistribute Profile           | re-deploys profile for renewal                  | e.g. "14 days"                                          |
| Subject                        | subject for certificate, additions are possible | CN=$JSSID,OU=users-on-computers,CN=$PROFILE\_IDENTIFIER |
| Subject Alternative Name Type  |                                                 | RFC 822 Name                                            |
| Subject Alternative Name Value |                                                 | $EMAIL                                                  |

Distribute the profile to your users as desired.

## User Certificates on Devices

Under Devices -> Configuration Profiles, please add another "Mobile Device Configuration Profile". Keep the level at "Device Level", as User Level currently does not support SCEP. Then, choose "SCEP" as payload On the left side. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field                          | Description                                     | Value/Example                                         |
| ------------------------------ | ----------------------------------------------- | ----------------------------------------------------- |
| Name                           | name/purpose                                    | e.g. "User Authentication"                            |
| Redistribute Profile           | re-deploys profile for renewal                  | e.g. "14 days"                                        |
| Subject                        | subject for certificate, additions are possible | CN=$JSSID,OU=users-on-devices,CN=$PROFILE\_IDENTIFIER |
| Subject Alternative Name Type  |                                                 | RFC 822 Name                                          |
| Subject Alternative Name Value |                                                 | $EMAIL                                                |

Distribute the profile to your clients as desired.
