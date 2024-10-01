# Computers

Please follow this guide to distribute certificates to computers (macOS). Before deploying the first certificates via Jamf, follow the [general steps for Jamf](general.md) first.

{% hint style="success" %}
We strongly recommend configuring all use-case relevant certificate payloads (trusted certificate / SCEP certificate) in a **single** Configuration Profile in Jamf.
{% endhint %}

## SCEPman Root Certificate

As first step you need to deploy SCEPman root certificate. Download this CA certificate via SCEPman dashboard:

![](<../../.gitbook/assets/SCEPmanHomePage (2).png>)

Add a new "macOS Configuration Profile" and choose "Certificate" as payload. Enter a meaningful name, upload the certificate (for"Select Certificate Option" select "Upload)" and activate "Allow all apps access":

![](<../../.gitbook/assets/image (29).png>)

Distribute that profile to all clients that should get SCEP certificates later.

## Machine Certificate

Please add another "macOS Configuration Profile" and choose "SCEP" as payload. Activate "Use the External Certificate Authority settings to enable Jamf Pro as SCEP proxy for this configuration profile" and enter the following information:

| Field                      | Description                                     | Value/Example                                  |
| -------------------------- | ----------------------------------------------- | ---------------------------------------------- |
| Name                       | Name/purpose                                    | e.g. "Device Authentication"                   |
| Redistribute Profile       | Re-deploys profile for renewal                  | e.g. "14 days"                                 |
| Subject                    | Subject for certificate, additions are possible | CN=$JSSID,OU=computers,CN=$PROFILE\_IDENTIFIER |
| Allow export from keychain | Controls whether the private key is exportable  | No                                             |
| Allow all apps access      | Controls access to the SCEP certificate         | Yes                                            |

Please adjust other options on your needs.

![](<../../.gitbook/assets/image (21) (1).png>)

<figure><img src="../../.gitbook/assets/image (6) (1).png" alt=""><figcaption></figcaption></figure>

## Output on the Client

Besides reporting on Jamf, you can easily verify the distribution of SCEPman Root Certificate and Device Certificate via "Keychain Access" on the desired client (under "System"):

![SCEPman Root Certificate](<../../.gitbook/assets/image (31).png>)

![Device Certificate](<../../.gitbook/assets/image (32).png>)
