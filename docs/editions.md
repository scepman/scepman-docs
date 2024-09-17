# Editions

## Overview

We offer two different SCEPman editions:

* Enterprise Edition
* Community Edition

Both editions use the same codebase and binaries. A Community Edition can be converted to an Enterprise Edition just by inserting a SCEPman license key (and maybe doing some additional config work).

## Enterprise Edition (SCEPman EE)

SCEPman EE comes with all features and is supported by our team. We charge a subscription fee for SCEPman EE.

We recommend SCEPman EE for:

* Productive environments
* Scalability and performance
* Enterprise feature set

## Community Edition (SCEPman CE)

SCEPman CE misses some features of SCEPman EE and is not supported by our team. SCEPman CE is free of charge.

We recommend SCEPman CE for:

* Lab environments
* Small businesses
* Easy testing of SCEPman

If you want to test SCEPman in your own environment, you can follow the **mandatory** steps in our [Standard Guide](scepman-deployment/community-guide.md) and install SCEPman directly into your lab. If you later decide to purchase SCEPman EE, you should review our Getting Started guide [decision matrix](scepman-deployment/deployment-guides/#decision-matrix) and revisit all **recommended** and **optional** steps.

{% hint style="info" %}
If your organization has Azure resource naming conventions in place and you intend to re-use the Community Edition deployment after a successful trial, please directly start with our [Extended Guide](scepman-deployment/deployment-guides/enterprise-guide-1.md) (**mandatory** steps only). For the basic steps, no license key is required.
{% endhint %}

## Edition Comparison

The following table shows the most important differences between the two editions:

| SCEPman Feature                                                                                                                                                                                                                                    |           Community Edition           |             Enterprise Edition             |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-----------------------------------: | :----------------------------------------: |
| <p><strong>Machine certificates</strong> for Intune- or JAMF-managed devices<br>(Windows 10, MacOS, Android, iOS)</p>                                                                                                                              | <mark style="color:green;">yes</mark> |    <mark style="color:green;">yes</mark>   |
| <p><strong>User certificates</strong> on Intune- or JAMF-managed devices<br>(Windows 10, MacOS, Android, iOS)</p>                                                                                                                                  | <mark style="color:green;">yes</mark> |    <mark style="color:green;">yes</mark>   |
| <p><a href="certificate-deployment/certificate-master/">Certificate management</a>, manually issue &#x26; revoke certificates,<br>e.g. for web servers</p>                                                                                         |   <mark style="color:red;">no</mark>  |    <mark style="color:green;">yes</mark>   |
| <p><a href="certificate-deployment/domain-controller-certificates.md">Kerberos authentication <strong>certificates for DCs</strong></a></p><p>(Access on-prem ressources and use<br>Windows Hello for Business with AAD/Hybrid-joined devices)</p> |   <mark style="color:red;">no</mark>  |    <mark style="color:green;">yes</mark>   |
| [Redundancy](advanced-configuration/geo-redundancy.md)                                                                                                                                                                                             |   <mark style="color:red;">no</mark>  |    <mark style="color:green;">yes</mark>   |
| [SCEPman as intermediate CA](advanced-configuration/intermediate-certificate.md)                                                                                                                                                                   |   <mark style="color:red;">no</mark>  |    <mark style="color:green;">yes</mark>   |
| [AAD Device Compliance Check](scepman-configuration/optional/application-settings/intune-validation.md#appconfig-intunevalidation-compliancecheck)                                                                                                 |   <mark style="color:red;">no</mark>  |    <mark style="color:green;">yes</mark>   |
| Support                                                                                                                                                                                                                                            |   <mark style="color:red;">no</mark>  | <mark style="color:green;">included</mark> |
| Fee                                                                                                                                                                                                                                                |                  free                 |              subscription-fee              |
