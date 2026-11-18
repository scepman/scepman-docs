---
description: Issue and manage SCEPman certificates through Microsoft Intune.
---

# Microsoft Intune

Issue and manage certificates for Microsoft Intune-managed devices. SCEPman acts as the certificate authority (CA). Intune deploys trusted certificate and SCEP profiles to enrolled devices.

{% hint style="info" %}
Before you begin, deploy SCEPman and prepare access to the Microsoft Intune admin center. Deploy the SCEPman root certificate before assigning SCEP certificate profiles.
{% endhint %}

### How it works

1. Download the SCEPman root certificate from the SCEPman portal.
2. Deploy it with an Intune trusted certificate profile.
3. Create and assign an Intune SCEP certificate profile for supported platforms.

{% hint style="info" %}
Assign the trusted certificate and SCEP profiles to the same groups. Otherwise, certificate deployment can fail.
{% endhint %}

### Choose a certificate deployment

<table data-view="cards"><thead><tr><th>Platform</th><th data-card-target data-type="content-ref">Guide</th></tr></thead><tbody><tr><td><i class="fa-windows">:windows:</i> Windows</td><td><a href="windows-10.md">windows-10.md</a></td></tr><tr><td><i class="fa-apple">:apple:</i> macOS</td><td><a href="macos.md">macos.md</a></td></tr><tr><td><i class="fa-android">:android:</i> Android</td><td><a href="android.md">android.md</a></td></tr><tr><td><i class="fa-mobile-screen">:mobile-screen:</i> iOS and iPadOS</td><td><a href="ios.md">ios.md</a></td></tr><tr><td><i class="fa-linux">:linux:</i> Linux via the enrollment REST API</td><td><a href="linux.md">linux.md</a></td></tr></tbody></table>
