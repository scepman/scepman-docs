# Users

{% hint style="info" %}
This feature requires version **1.9** or above.
{% endhint %}

Please follow this guide to distribute certificates to users. User certificates are possible on computers \(macOS\) as well as devices \(e.g.: iOS, iPadOS\). Before deploying the first certificates via JAMF, follow the [general steps for JAMF](general.md) first.

## SCEPman Root Certificate

As first step you need to deploy SCEPman root certficate if you haven't done this already for the target plattform. Download this CA certificate via SCEPman dashboard:

![](../../.gitbook/assets/image%20%2822%29.png)

Add a new "Mobile Device Configuration Profile" and/or "macOS Configuration Profile", depending on your target plattform, and choose "Certificate" as payload. Enter a meaningful name and upload the certificate \(for "Select Certificate Option" select "Upload\):

![](../../.gitbook/assets/image%20%2825%29.png)

## User Certificates on Computers

Under Computers -&gt; Configuration Profiles, please add another "macOS Configuration Profile". Under the General Tab, change the Level to "User Level". On the left side, switch to the "SCEP" tab and configure a new SCEP payload. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field | Description | Value/Example |
| :--- | :--- | :--- |
| Name | name/purpose | e.g. "User Authentication" |
| Redistribute Profile | re-deploys profile for renewal | e.g. "14 days" |
| Subject | subject for certificate, additions are possible | CN=$JSSID,OU=users-on-computers,CN=$PROFILE\_IDENTIFIER |
| Subject Alternative Name Type |  | RFC 822 Name |
| Subject Alternative Name Value |  | $EMAIL |

Distribute the profile to your users as desired.

## User Certificates on Devices

Under Devices -&gt; Configuration Profiles, please add another "Mobile Device Configuration Profile". Keep the level at "Device Level", as User Level currently does not support SCEP. Then, choose "SCEP" as payload On the left side. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field | Description | Value/Example |
| :--- | :--- | :--- |
| Name | name/purpose | e.g. "User Authentication" |
| Redistribute Profile | re-deploys profile for renewal | e.g. "14 days" |
| Subject | subject for certificate, additions are possible | CN=$JSSID,OU=users-on-devices,CN=$PROFILE\_IDENTIFIER |
| Subject Alternative Name Type |  | RFC 822 Name |
| Subject Alternative Name Value |  | $EMAIL |

Distribute the profile to your clients as desired.

Note that the "User and Location" data of your mobile devices need to be properly populated, so certificate can be issued.

