# Devices

Please follow this guide to distribute certificates to devices (e.g.: iOS, iPadOS). Before deploying the first certificates via Jamf Pro, follow the [general steps for Jamf Pro](general.md) first.

{% hint style="success" %}
We strongly recommend configuring all use-case relevant certificate payloads (trusted certificate / SCEP certificate) in a **single** Configuration Profile in Jamf Pro.
{% endhint %}

## SCEPman Root Certificate

As first step you need to deploy SCEPman root certificate. Download this CA certificate via SCEPman dashboard:

![](<../../.gitbook/assets/image-2 (10).png>)

Add a new "Mobile Device Configuration Profile" and choose "Certificate" as payload. Enter a meaningful name and upload the certificate (for "Select Certificate Option" select "Upload):

![](<../../.gitbook/assets/image (25).png>)

## Device Certificate

Please add another "Mobile Device Configuration Profile" and choose "SCEP" as payload. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field                | Description                                     | Value/Example                                |
| -------------------- | ----------------------------------------------- | -------------------------------------------- |
| Name                 | Name/purpose                                    | e.g. "Device Authentication"                 |
| Redistribute Profile | Re-deploys profile for renewal                  | e.g. "14 days"                               |
| Subject              | Subject for certificate, additions are possible | CN=$JSSID,OU=devices,CN=$PROFILE\_IDENTIFIER |

![](<../../.gitbook/assets/image (28).png>)

Distribute the profile to your clients as desired.
