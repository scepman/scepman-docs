---
description: Issue SCEPman certificates through supported third-party MDM solutions.
---

# Other MDM Solutions

Issue certificates through MDM systems other than Microsoft Intune and Jamf Pro. SCEPman uses a shared [SCEP challenge password](https://www.rfc-editor.org/rfc/rfc8894.html#name-challengepassword-shared-se) to authenticate certificate requests.

{% hint style="warning" %}
The challenge password protects every certificate request. Store it securely. Never expose it to end-user devices.
{% endhint %}

### Choose an endpoint

Choose the endpoint that matches your MDM integration.

| Endpoint       | Use when                                                                                                                                                               |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Static-AAD** | Your MDM integrates with Microsoft Entra ID. User certificates can use [automatic revocation](../manage-certificates/#automatic-revocation) when the user is disabled. |
| **Static**     | Your MDM does not require Entra ID integration. This endpoint supports most third-party MDM solutions.                                                                 |

### Configure SCEPman

Add the settings for your chosen endpoint in **SCEPman App Service** → **Environment Variables**. Save the settings, then **restart** the App Service.

<details>

<summary>Static-AAD validation</summary>

Use these settings when your MDM integrates with Microsoft Entra ID.

{% include "../../.gitbook/includes/static-aad-environment-variables.md" %}

</details>

<details>

<summary>Static validation</summary>

Use these settings when your MDM does not use Entra ID integration.

{% include "../../.gitbook/includes/static-environment-variables.md" %}

</details>

### Set up your MDM

Deploy the SCEPman root certificate first. Configure the selected SCEP endpoint and the same challenge password in your MDM.

<table data-view="cards"><thead><tr><th>MDM</th><th data-card-target data-type="content-ref">Guide</th></tr></thead><tbody><tr><td><i class="fa-apple">:apple:</i> Addigy</td><td><a href="addigy.md">addigy.md</a></td></tr><tr><td><i class="fa-apple">:apple:</i> Iru</td><td><a href="kandji-1.md">kandji-1.md</a></td></tr><tr><td><i class="fa-apple">:apple:</i> Mosyle</td><td><a href="mosyle.md">mosyle.md</a></td></tr><tr><td><i class="fa-mobile-screen">:mobile-screen:</i> SOTI MobiControl</td><td><a href="soti-mobicontrol.md">soti-mobicontrol.md</a></td></tr></tbody></table>

### Protect the challenge password

If your MDM acts as the SCEP client, it generates the key pair and delivers the certificate and private key to the device. The challenge password remains between the MDM and SCEPman.

Some MDMs relay SCEP messages between the device and SCEPman. In this model, the device receives the challenge password. A compromised device could expose the password and request unauthorized certificates.

Protect the challenge password wherever it is stored or transmitted. Restrict access to the MDM configuration and rotate the password if exposure is suspected.
