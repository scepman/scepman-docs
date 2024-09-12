---
description: >-
  This document describes deploying a device and/or user certificates for
  ChromeOS devices. The deployment of the SCEPman Root Certificate is mandatory.
---

# ChromeOS

## Root Certificate

As a first step, you must deploy SCEPman's root certificate. Therefore, follow these steps:

1. Download the root CA certificate from your SCEPman website by clicking on the **Get CA Certificate** link.

<figure><img src="../../../.gitbook/assets/image (69).png" alt=""><figcaption></figcaption></figure>

2. Now upload your SCEPmen root CA to your Google Workplace. In your Google **Admin console** (admin.google.com) navigate to **Menu** > **Devices** > **Networks** > **Certificates** > **ADD CERTIFICATE**

<figure><img src="../../../.gitbook/assets/image (70).png" alt=""><figcaption></figcaption></figure>

## Add a SCEP Profile

The SCEP profile defines the certificate that lets users access your WiFi. Assign the profile to specific users by adding it to an organisational unit. Set up multiple SCEP profiles to manage access by device type. The following configuration example&#x20;

1. In your Google **Admin console** (admin.google.com) navigate to **Menu** > **Devices** > **Network**
2. Click **Create SCEP Profile**.
3. Click **Add Secure SCEP Profile**.
4. Enter the configuration details for the profile.&#x20;

| Attribute            | Value (Device)      | Value (User)      |
| -------------------- | ------------------- | ----------------- |
| **Device platforms** | Chromebook (device) | Chromebook (user) |

<figure><img src="../../../.gitbook/assets/image (51).png" alt=""><figcaption></figcaption></figure>

| Attribute             |                                       |
| --------------------- | ------------------------------------- |
| **SCEP profile name** | Provide a name for your SCEP profile. |

<figure><img src="../../../.gitbook/assets/image (52).png" alt=""><figcaption></figcaption></figure>

<table><thead><tr><th width="246">Attribute</th><th width="282">Value (Device)</th><th>Value (User)</th></tr></thead><tbody><tr><td><strong>Subject name format</strong></td><td><strong>Fully distinguished name</strong></td><td><strong>Fully distinguished name</strong></td></tr><tr><td></td><td><strong>Common name</strong>: ${DEVICE_SERIAL_NUMBER}</td><td><strong>Common name:</strong> ${USER_EMAIL}</td></tr><tr><td></td><td><strong>Company name</strong>: Your company name.</td><td><strong>Company name</strong>: Your company name.</td></tr><tr><td></td><td><strong>Organisation unit:</strong> Your organizational unit. This is optional.</td><td><strong>Organisation unit:</strong> Your organizational unit. This is optional.</td></tr><tr><td></td><td><strong>Locality</strong>: Your organisation unit's location. This is optional.</td><td><strong>Locality</strong>: Your organisation unit's location. This is optional.</td></tr><tr><td></td><td><strong>State</strong>: Your organisation unit's state. This is optional.</td><td><strong>State</strong>: Your organisation unit's state. This is optional.</td></tr><tr><td></td><td><strong>Country / region</strong>: Your organisation unit's country. This is optional.</td><td><strong>Country / region</strong>: Your organisation unit's country. This is optional.</td></tr><tr><td><strong>Subject alternative name</strong></td><td>Default: <strong>None</strong><br><br>This can be set to <strong>Custom</strong> when the SAN shall be used, e.g. as outer identity when authenticating to a WiFi using EAP-TLS.</td><td><p><strong>Custom</strong></p><p></p><p></p><p></p><p></p><p><strong>User Principal:</strong> ${USER_EMAIL_NAME}</p></td></tr><tr><td></td><td></td><td></td></tr></tbody></table>

<figure><img src="../../../.gitbook/assets/image (54).png" alt=""><figcaption></figcaption></figure>

| Attribute             | Value                                      |
| --------------------- | ------------------------------------------ |
| **Signing algorithm** | SHA256withRSA                              |
| **Key usage**         | Key encipherment, Signing                  |
| **Key size (bits)**   | 3072                                       |
| **Security**          | Strict (only supported by managed devices) |

<figure><img src="../../../.gitbook/assets/image (55).png" alt=""><figcaption></figcaption></figure>

<table><thead><tr><th width="246">Attribute</th><th>Value</th></tr></thead><tbody><tr><td><strong>SCEP server attributes</strong></td><td><strong>SCEP server URL</strong>: <a href="http://scepman.yourdomain.net/static">http://scepman.yourdomain.net/static</a></td></tr><tr><td></td><td><strong>Certificate validity period (years)</strong>: 1</td></tr><tr><td></td><td><strong>Renew within days</strong>: 42</td></tr><tr><td></td><td><strong>Extended key usage</strong>: Client authentication</td></tr><tr><td></td><td><strong>Challenge type</strong>: Static</td></tr><tr><td></td><td><strong>Challenge</strong>: Provide the challenge value you have configured when <a href="./#enable-google-workspace-integration">enabling the SCEPman Google Workspace</a> integration.</td></tr><tr><td></td><td><strong>Certificate Authority</strong>: Reference here the certificate profile containing your <a href="chromeos.md#root-certificate">SCEPman Root CA</a>.</td></tr><tr><td></td><td><strong>Network type this profile applies to</strong>: Wi-Fi</td></tr></tbody></table>

<figure><img src="../../../.gitbook/assets/image (56).png" alt=""><figcaption></figcaption></figure>

5. The SCEP profile is automatically distributed to users in the organisational unit.
6. To check for this certificate, in your Chromebook navigate to **chrome://certificate.manager** > **Your certificates.**

<figure><img src="../../../.gitbook/assets/image (73).png" alt=""><figcaption></figcaption></figure>
