---
description: SCEPman - Certificates Simplified
---

# Welcome

SCEPman is a slim and resource-friendly solution to issue and validate certificates using SCEP. **It is an Azure Web App providing the SCEP protocol and works directly with the Microsoft Graph and Intune API.** SCEPman uses an Azure Key Vault based Root CA and certificate creation. No other component is involved, neither a database nor any other stateful storage except the Azure Key Vault itself. That said, SCEPman **will not need any backup procedures** or other operation level tasks. Only an Azure subscription is necessary to deploy it.

![SCEP flow with Microsoft Intune](.gitbook/assets/scepman-flowchart.webp)

The following documentation will show you a straightforward way to deploy certificates to modern cloud managed clients. Without any on-premises PKI your users and devices will be able to get certificates.

## Get more details about SCEPman

{% content-ref url="details.md" %}
[details.md](details.md)
{% endcontent-ref %}

{% content-ref url="editions.md" %}
[editions.md](editions.md)
{% endcontent-ref %}

## SCEPman Guides

We offer two guides to deploy the SCEPman environment. Please follow below link for guidance on which guide is best suited for your scenario and deployment requirements:



{% content-ref url="scepman-deployment/deployment-guides/" %}
[deployment-guides](scepman-deployment/deployment-guides/)
{% endcontent-ref %}

## Changelog

News from our development and our roadmap can be found under the **Changelog**.

{% content-ref url="changelog.md" %}
[changelog.md](changelog.md)
{% endcontent-ref %}
