# Editions

## Overview

We offer two different SCEPman editions:

* Enterprise Edition
* Community Edition

Both editions use the same codebase and binaries. A Community Edition can be converted to an Enterprise Edition just by inserting a SCEPman license key \(and maybe doing some additional config work\).

## Enterprise Edition \(SCEPman EE\)

SCEPman EE comes with all features and is supported by our team. We charge a subscription fee for SCEPman EE.

We recommend SCEPman EE for:

* Productive environments
* Scalability and performance
* Enterprise feature set

## Community Edition \(SCEPman CE\)

SCEPman CE misses some features of SCEPman EE and is not supported by our team. SCEPman CE is free of charge.

We recommend SCEPman CE for:

* Lab environments
* Small businesses
* Easy testing of SCEPman

If you want to test SCEPman in your own environment, you can use the [Trial Guide](scepman-deployment/trial-guide.md) and install SCEPman directly into your lab.  
When you later decide to buy SCEPman EE you should follow our [Enterprise Guide](scepman-deployment/enterprise-guide.md) to get a recommended production environment.

## Version Comparison

The following table shows the most important differences between the two editions:

<table>
  <thead>
    <tr>
      <th style="text-align:left">SCEPman Feature</th>
      <th style="text-align:center">Community Edition</th>
      <th style="text-align:center">Enterprise Edition</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left">Machine certificates for Intune- or JAMF-managed devices
        <br />(Windows 10, MacOS, Android, iOS)</td>
      <td style="text-align:center">yes</td>
      <td style="text-align:center">yes</td>
    </tr>
    <tr>
      <td style="text-align:left">User certificates on Intune-or JAMF-managed devices
        <br />(Windows 10, MacOS, Android, iOS)</td>
      <td style="text-align:center">yes</td>
      <td style="text-align:center">yes</td>
    </tr>
    <tr>
      <td style="text-align:left">
        <p><a href="https://docs.scepman.com/certificate-deployment/other-1/domain-controller-certificates">Kerberos authentication certificates for DCs</a>
        </p>
        <p>(Access on-prem ressources and use
          <br />Windows Hello for Business with AAD/Hybrid-joined devices)</p>
      </td>
      <td style="text-align:center">no</td>
      <td style="text-align:center">yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><a href="https://docs.scepman.com/scepman-configuration/optional/geo-redundancy">Redundancy</a>
      </td>
      <td style="text-align:center">no</td>
      <td style="text-align:center">yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><a href="https://docs.scepman.com/scepman-configuration/optional/intermediate-certificate">SCEPman as intermediate CA</a>
      </td>
      <td style="text-align:center">no</td>
      <td style="text-align:center">yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><a href="https://docs.scepman.com/scepman-configuration/optional/application-settings#appconfig-intunevalidation-compliancecheck">AAD Device Compliance Check</a>
      </td>
      <td style="text-align:center">no</td>
      <td style="text-align:center">preview</td>
    </tr>
    <tr>
      <td style="text-align:left">Support</td>
      <td style="text-align:center">no</td>
      <td style="text-align:center">included</td>
    </tr>
    <tr>
      <td style="text-align:left">Fee</td>
      <td style="text-align:center">free</td>
      <td style="text-align:center">subscription-fee</td>
    </tr>
  </tbody>
</table>

