# Computers

## SCEPman Root Certificate

As first step you need to deploy SCEPman root certficate. Download this CA certificate via SCEPman dashboard:

![](../../.gitbook/assets/image%20%2822%29.png)

Add a new "macOS Configuration Profile" and choose "Certificate" as payload. Enter a meaningful name, upload the certificate \(for"Select Certificate Option" select "Upload\)" and activate "Allow all apps access":

![](../../.gitbook/assets/image%20%2828%29.png)

Distribute that profile to all clients that should get SCEP certificates later.

## Device Certificate

Please add another "macOS Configuration Profile" and choose "SCEP" as payload. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field | Description | Value/Example |
| :--- | :--- | :--- |
| Name | name/purpose | e.g. "Device Authentication" |
| Redistribute Profile | re-deploys profile for renewal | e.g. "14 days" |
| Subject | subject for certificate, additions are possible | CN=$JSSID,OU=devices,CN=$PROFILE\_IDENTIFIER |
| Allow export from keychain | controls wether private key is exportable | No |

Please adjust other options on your needs.

![](../../.gitbook/assets/image%20%2821%29.png)

![](../../.gitbook/assets/image%20%2824%29.png)

## Output on the Client

Besides reporting on Jamf, you can easily verify the distribution of SCEPman Root Certificate and Device Certificate via "Keychain Access" on the desired client \(under "System"\):

![SCEPman Root Certificate](../../.gitbook/assets/image%20%2830%29.png)

![Device Certificate](../../.gitbook/assets/image%20%2831%29.png)

