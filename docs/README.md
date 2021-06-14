---
description: The easy way to deploy certificates with Intune.
---

# Welcome

{% hint style="danger" %}
Some tenants are currently facing the issue, that SCEPman does not issue certificates for Intune managed clients.

If you are facing the same issue, please have a look [here](https://glueckkanja.zendesk.com/hc/en-us/articles/4402360224530-SCEPman-does-not-issue-certificates) to solve the issue.
{% endhint %}



SCEPman is a slim and resource-friendly solution to issue and validate certificates using SCEP. **It is an Azure Web App providing the SCEP protocol and works directly with the Microsoft Graph and Intune API.** SCEPman uses an Azure Key Vault based Root CA and certificate creation. No other component is involved, neither a database nor any other stateful storage except the Azure Key Vault itself. That said, SCEPman **will not need any backup procedures** or other operation level tasks. Only an Azure subscription is necessary to deploy it.

The following documentation will show you a straightforward way to deploy certificates to modern cloud managed clients. Without any on-premises PKI your users and devices will be able to get certificates.

## Get more details about SCEPman

{% page-ref page="details.md" %}

{% page-ref page="editions.md" %}

## SCEPman Guides

We offer three guides to deploy the SCEPman environment. The codebase between these guides is the same, so you have no limitations from this point of view. 

The Trial Guide is made for those who wants to get the first experience and test the SCEPman functionalities. This is the smallest Azure setup, and you can test all features.

{% page-ref page="getting-started/trial-guide.md" %}

The Community Guide is made for small companies and anyone that don´t need a full support of the SCEPman solution. In addition to the basic Azure resources, this Guide will help you to setup logging and some helpful configurations for a production environment.

{% page-ref page="getting-started/community-guide.md" %}

The Enterprise Guide represents the full-blown setup for a production environment and is targeted to enterprise customers. In addition to the basic Azure environment, this Guide will give you some recommendations and shows you how to setup logging, autoscaling, deployment slots and more.

{% page-ref page="getting-started/enterprise-guide.md" %}

If you want to have a detailed look at specific documentation steps you can manually scroll through the **SCEPMAN CONFIGURATION** or **CERTIFICATE DEPLOYMENT**.

News from our development and our roadmap can be found under the **Changelog**.

{% page-ref page="other/changelog.md" %}

