---
description: Issue and manage SCEPman certificates through Jamf Pro.
---

# Jamf Pro

Issue and manage certificates for Jamf Pro-managed Macs, iPhones, and iPads. SCEPman acts as the external certificate authority (CA). Jamf Pro proxies SCEP requests from managed devices to SCEPman.

{% hint style="info" %}
Before you begin, deploy SCEPman and prepare Jamf Pro administrator access. Create Jamf API credentials with permission to read computers, mobile devices, and users.
{% endhint %}

### How it works

1. Configure the SCEPman Jamf endpoint and API connection.
2. Connect Jamf Pro to SCEPman as an external CA.
3. Deploy trusted root and SCEP certificate payloads through Jamf Pro.

### Set up the integration

{% content-ref url="general.md" %}
[general.md](general.md)
{% endcontent-ref %}

### Choose a certificate deployment

<table data-view="cards"><thead><tr><th>Deployment</th><th data-card-target data-type="content-ref">Guide</th></tr></thead><tbody><tr><td><i class="fa-laptop">:laptop:</i> Mac device certificates</td><td><a href="computers.md">computers.md</a></td></tr><tr><td><i class="fa-mobile-screen">:mobile-screen:</i> iOS and iPadOS device certificates</td><td><a href="devices.md">devices.md</a></td></tr><tr><td><i class="fa-user">:user:</i> User certificates</td><td><a href="users.md">users.md</a></td></tr></tbody></table>
