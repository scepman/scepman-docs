---
description: The easy way to deploy certificates with Intune.
---

# Welcome

SCEPman is a slim and resource-friendly solution to issue and validate certificates using SCEP. **It is an Azure Web App providing the SCEP protocol and works directly with the Microsoft Graph and Intune API.** SCEPman uses an Azure Key Vault based Root CA and certificate creation. No other component is involved, neither a database nor any other stateful storage except the Azure Key Vault itself. That said, SCEPman **will not need any backup procedures** or other operation level tasks. Only an Azure subscription is necessary to deploy it.

The following documentation will show you a straightforward way to deploy certificates to modern cloud managed clients. Without any on-premises PKI your users and devices will be able to get certificates.

## Get more details about SCEPman

{% page-ref page="details.md" %}

{% page-ref page="editions.md" %}

## SCEPman Guides

{% page-ref page="getting-started/trial-guide.md" %}

{% page-ref page="getting-started/community-guide.md" %}

{% page-ref page="getting-started/enterprise-guide.md" %}

If you want to have a detailed look at specific documentation steps you can manually scroll through the **SCEPMAN CONFIGURATION** or **CERTIFICATE DEPLOYMENT**.

