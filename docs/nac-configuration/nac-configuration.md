---
category: NAC-Configuration
layout: docs-default
title: Configuration of Network Access Controllers (NACs)
order: 1
---

# Network Access Controllers

We recommend using our RADIUS-as-a-Service as Network Access Controller \(NAC\), as it allows a one-click configuration. SCEPman certificates generally work with all NACs that support standard 802.1x certificate-based authentication, though.

This article describes notable characteristics of some of the most common NACs.

## RADIUS-as-a-Service

Please refer to the [RADIUS-as-a-Service documentation](https://docs.radiusaas.com/portal/settings-trusted-roots/trusted-roots) to see how to use SCEPman certificates in RADIUS-as-a-Service.

## Cisco ISE

Cisco ISE commonly does not support HTTP 1.1 but only HTTP 1.0 for OCSP requests. This requires an additional Application Proxy in front of SCEPman. Refer to our [Troubleshooting Article for ISE](../other/troubleshooting/cisco-ise-host-header-limitation.md) for details.

At least some versions of Cisco ISE 3.x require an Extended Key Usage extension containing the OCSP Responder Extended Key Usage in order to accept OCSP responses, even if they come from a CA, where it is not required per RFC. SCEPman versions until 1.7 did not add an Extended Key Usage by default to its CA certificate. Version 1.8 allows you to add this extension via a [configuration setting](../scepman-configuration/optional/application-settings/azure-keyvault.md#appconfig-keyvaultconfig-rootcertificateconfig-addextendedkeyusage). In SCEPman 1.9, the default of the configuration setting already adds the Extended Key Usage. If you already have a CA certificate without an Extended Key Usage extension and have issues with Cisco ISE 3.x, you may need to create a new SCEPman Root CA certificate with the Extended Key Usage extension.

## Aruba ClearPass

Analogously to Cisco ISE, Aruba ClearPass uses HTTP 1.0 for OCSP requests and therefore requires [extra configuration steps adding an Application Proxy](../other/troubleshooting/cisco-ise-host-header-limitation.md) to work with SCEPman.

## Microsoft Network Policy Server \(NPS\)

NPS maps certificates to device or user entities in AD \(not AAD\). As there is no device synchronization out-of-the-box between AAD and AD, it is usually not possible to use NPS with device certificates distributed via Intune with SCEPman or any other PKI. User certificates can work for users synchronized between AAD and AD. The certificates must contain the users' UPNs, which NPS uses to map to AD user objects with the same UPN.

## Others

Generally, you have to add the SCEPman Root CA certificate as a trusted CA in the NAC.

Possibly, you have to manually add the SCEPman OCSP URL. You can find the OCSP URL in the Authority Information Access \(AIA\) extension of any client certificate.

