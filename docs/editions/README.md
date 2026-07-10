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

{% content-ref url="../other/licensing/" %}
[licensing](../other/licensing/)
{% endcontent-ref %}

## Community Edition (SCEPman CE)

SCEPman CE misses some features of SCEPman EE and is not supported by our team. SCEPman CE is free of charge.

We recommend SCEPman CE for:

* Lab environments
* Small businesses
* Easy testing of SCEPman

If you want to test SCEPman in your own environment, you can follow the **mandatory** steps in our [Standard Guide](../scepman-deployment/community-guide.md) and install SCEPman directly into your lab. If you later decide to purchase SCEPman EE, you should review our Getting Started guide [decision matrix](../scepman-deployment/deployment-guides/#decision-matrix) and revisit all **recommended** and **optional** steps.

{% hint style="info" %}
If your organization has Azure resource naming conventions in place and you intend to re-use the Community Edition deployment after a successful trial, please directly start with our [Extended Guide](../scepman-deployment/deployment-guides/enterprise-guide-1.md) (**mandatory** steps only). For the basic steps, no license key is required.
{% endhint %}

## Edition Comparison

The following table shows the most important differences between the two editions:

<table data-search="false"><thead><tr><th>SCEPman Feature</th><th align="center">Community Edition</th><th align="center">Enterprise Edition</th></tr></thead><tbody><tr><td><strong>Machine certificates</strong> for Intune- or Jamf Pro-managed devices<br>(Windows 11, MacOS, Android, iOS)</td><td align="center"><mark style="color:green;">yes</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><strong>User certificates</strong> on Intune- or Jamf Pro-managed devices<br>(Windows 11, MacOS, Android, iOS)</td><td align="center"><mark style="color:green;">yes</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><strong>Machine</strong> and <strong>user certificats</strong> for <a href="../certificate-management/active-directory/">Active Directory / GPO</a> managed (domain-joined) devices (Windows 10/11)</td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><a href="../certificate-management/certificate-master/">Certificate management</a>, manually issue &#x26; revoke certificates,<br>e.g. for web servers</td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><p><a href="../certificate-management/domain-controller-certificates.md">Kerberos authentication <strong>certificates for DCs</strong></a></p><p>(Access on-prem ressources and use<br>Windows Hello for Business with Entra ID/Hybrid-joined devices)</p></td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td>Certificates for other MDM-systems <a href="../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md"><strong>with Entra ID validation</strong></a>.</td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><a href="../azure-configuration/geo-redundancy.md">Redundancy</a></td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><a href="../scepman-deployment/intermediate-certificate.md">SCEPman as intermediate CA</a></td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td><a href="../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-compliancecheck">Device Compliance Check</a></td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">yes</mark></td></tr><tr><td>Support</td><td align="center"><mark style="color:red;">no</mark></td><td align="center"><mark style="color:green;">included</mark></td></tr><tr><td>Fee</td><td align="center">free</td><td align="center">subscription-fee</td></tr></tbody></table>

