---
description: Issue, manage, and revoke certificates through the Certificate Master UI.
---

# Certificate Master

{% embed url="https://youtu.be/kr8uBPlG4J8?t=122" %}
SCEPman Certificate Master Quick Overview
{% endembed %}

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

Certificate Master is the SCEPman web UI for issuing, inspecting, and managing certificates. It runs as a separate App Service, typically identified by the `-cm` suffix.

{% hint style="info" %}
Before you begin, assign a Certificate Master role to your account.
{% endhint %}

### Get started

{% content-ref url="../../scepman-configuration/rbac/" %}
[rbac](../../scepman-configuration/rbac/)
{% endcontent-ref %}

### Manage issued certificates

Search, inspect, and revoke certificates issued by your SCEPman PKI.

{% content-ref url="manage-certificates.md" %}
[manage-certificates.md](manage-certificates.md)
{% endcontent-ref %}

### Choose a certificate workflow

<table data-view="cards"><thead><tr><th>Workflow</th><th data-card-target data-type="content-ref">Guide</th></tr></thead><tbody><tr><td><i class="fa-file-signature">:file-signature:</i> Sign an existing certificate request</td><td><a href="certificate-signing-request-csr.md">certificate-signing-request-csr.md</a></td></tr><tr><td><i class="fa-server">:server:</i> TLS server certificate</td><td><a href="tls-server-certificate-pkcs-12.md">tls-server-certificate-pkcs-12.md</a></td></tr><tr><td><i class="fa-shield-halved">:shield-halved:</i> TLS inspection subordinate CA certificate</td><td><a href="sub-ca-certificate.md">sub-ca-certificate.md</a></td></tr><tr><td><i class="fa-code">:code:</i> Code signing certificate</td><td><a href="code-signing-certificate.md">code-signing-certificate.md</a></td></tr><tr><td><i class="fa-laptop">:laptop:</i> Device certificate</td><td><a href="client-certificate-pkcs-12.md">client-certificate-pkcs-12.md</a></td></tr><tr><td><i class="fa-user">:user:</i> User certificate</td><td><a href="user-certificate.md">user-certificate.md</a></td></tr></tbody></table>

### Certificate Master home

<figure><img src="../../.gitbook/assets/image (72) (1).png" alt=""><figcaption></figcaption></figure>
