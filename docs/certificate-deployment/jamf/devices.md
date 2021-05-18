# Devices

## SCEPman Root Certificate

As first step you need to deploy SCEPman root certficate. Download this CA certificate via SCEPman dashboard:

![](../../.gitbook/assets/image%20%2822%29.png)

Add a new "Mobile Device Configuration Profile" and choose "Certificate" as payload. Enter a meaningful name and upload the certificate \(for "Select Certificate Option" select "Upload\):

![](../../.gitbook/assets/image%20%2825%29.png)

## Device Certificate

Please add another "Mobile Device Configuration Profile" and choose "SCEP" as payload. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field | Description | Value/Example |
| :--- | :--- | :--- |
| Name | name/purpose | e.g. "Device Authentication" |
| Redistribute Profile | re-deploys profile for renewal | e.g. "14 days" |
| Subject | subject for certificate, additions are possible | CN=$JSSID,OU=devices,CN=$PROFILE\_IDENTIFIER |

![](../../.gitbook/assets/image%20%2827%29.png)

Distribute the profile to your clients as desired.

