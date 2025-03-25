# Use Cases

This page is intended to give you an **overview** of **common use cases** and scenarios our clients leverage SCEPman for. While we cannot provide support for the intricacies of every vendor solution, we hope this overview helps you to quickly assess whether SCEPman could be a fit for your scenario, too - without overwhelming you with less common or even exotic use-cases. If you are unsure, just [drop us a question](https://www.scepman.com/drop-a-question).

## Secure WiFi and Network Access

Certificates issued by SCEPman are widely used for the purpose of certificate-based network authentication (802.1X / EAP-TLS) for WiFi, Wired/LAN and VPN, typically along with a network access control (NAC) service that speaks the RADIUS or RadSec protocol. Such services commonly are

* [RADIUSaaS](https://www.radius-as-a-service.com/)
* Aruba ClearPass
* Cisco ISE / Cisco ASA
* Azure VPN Gateway / Azure AlwaysOn VPN
* Fortinet FortiGate
* Palo Alto GlobalProtect

In addition to typical user-centric client devices such as laptops, PCs or Macs, **kiosk devices** such as point of sales or self-checkout systems, scanner/barcode guns or customer terminals are often equipped with certificates from SCEPman for secure network authentication.

## Certificate-based Authentication

You can enrol user authentication certificates with SCEPman for TLS client authentication. This allows authentication to web sites or services such as

* Internal web applications
* [Windows](certificate-management/api-certificates/api-enrollment/windows-server.md) or [Linux](certificate-management/api-certificates/api-enrollment/linux-server.md) servers
* Microsoft 365
  * Exchange Online
  * Azure Active Directory (AAD) / Azure CBA (including [CRL support](scepman-configuration/application-settings/crl.md)) as, e.g. required by [NIST 800-63, Rev. 4](https://www.nist.gov/identity-access-management/roadmap-nist-special-publication-800-63-4-digital-identity-guidelines)
* Other cloud services
* Remote Desktop (RDP) connections
  * AVD
  * Windows server administration / PAWs

## MDM Solutions

To automate the deployment of relevant configuration profiles and to keep certificates up to date (auto-renewal), we recommend to use SCEPman along with an MDM solution. While SCEPman natively integrates with Microsoft Endpoint Manager/Intune and Jamf Pro, our customers have successfully deployed SCEPman along with other MDM solutions.

Below table provides an overview of the most commonly used MDM solutions and indicates how/if certificate revocation is possible.

| MDM Solution                                                                               | Supported Platforms                                                                                                                                                          | Issuance & Auto-renewal                      | Automatic Revocation         | Manual Revocation                                                                  | Links                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------- | ---------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <p><a href="certificate-management/microsoft-intune/">Intune /<br>Endpoint Manager</a></p> | <p>Windows<br>macOS<br>iOS</p><p>iPadOS<br>Android<br><a href="certificate-management/api-certificates/self-service-enrollment/intune-managed-linux-client.md">Linux</a></p> | :ballot\_box\_with\_check:                   | :ballot\_box\_with\_check:   | <p><span data-gb-custom-inline data-tag="emoji" data-code="2611">☑️</span><br></p> | [Microsoft Docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep)                                                                                                                                                                                                                                                                          |
| [Jamf](certificate-management/jamf/)                                                       | <p>macOS<br>iOS<br>iPadOS</p>                                                                                                                                                | :ballot\_box\_with\_check:                   | :ballot\_box\_with\_check:   | :ballot\_box\_with\_check:                                                         | [Jamf Technical Paper](https://docs.jamf.com/technical-papers/jamf-pro/scep-proxy/10.0.0/Introduction.html)                                                                                                                                                                                                                                                              |
| [GSuite / Google Workspace](certificate-management/static-certificates/)                   | <p>ChromeOS<br>Android</p>                                                                                                                                                   | :ballot\_box\_with\_check:                   | :ballot\_box\_with\_check:\* | :ballot\_box\_with\_check:                                                         | [Google Support Docs](https://support.google.com/chrome/a/answer/11053129?hl=en)                                                                                                                                                                                                                                                                                         |
| [Airwatch / WorkspaceONE UEM](certificate-management/static-certificates/)                 | <p>macOS<br>iOS</p>                                                                                                                                                          | :ballot\_box\_with\_check: (no auto-renewal) |                              | :ballot\_box\_with\_check:                                                         | [VMware Support Docs](https://docs.vmware.com/en/VMware-Workspace-ONE-UEM/2011/Certificate_Authority_Integrations/GUID-EF7C4D44-9480-4AD1-91E3-EA4F02448F5A.html)                                                                                                                                                                                                        |
| [Mosyle](certificate-management/static-certificates/mosyle.md)                             | <p>macOS</p><p>iOS<br>iPadOS</p>                                                                                                                                             | :ballot\_box\_with\_check:                   |                              | :ballot\_box\_with\_check:                                                         |                                                                                                                                                                                                                                                                                                                                                                          |
| [SOTI MobiControl](certificate-management/static-certificates/)                            | <p>Windows<br>macOS<br>iOS</p><p>iPadOS<br>Android<br>Ubuntu</p>                                                                                                             | :ballot\_box\_with\_check:                   |                              | :ballot\_box\_with\_check:                                                         | <p><a href="https://www.soti.net/mc/help/v14.1/en/console/reference/dialogs/globalsettings/certificates/certificate_authorities.html?hl=certificate%2Cauthority#globalsetting_certificate_authorities__genericscep">Soti Docs - External CA</a><br><a href="https://www.soti.net/mc/help/v14.1/en/console/system/certificates/add.html">Soti Docs - SCEP Profile</a></p> |
| [Kandji](certificate-management/static-certificates/kandji.md)                             | <p>macOS<br>iOS<br>iPadOS</p>                                                                                                                                                | :ballot\_box\_with\_check:                   | :ballot\_box\_with\_check:\* | :ballot\_box\_with\_check:                                                         | [Kandji Docs](https://support.kandji.io/support/solutions/articles/72000559782-scep-profile)                                                                                                                                                                                                                                                                             |
| [ManageEngine](certificate-management/static-certificates/)                                | <p>Windows<br>macOS<br>iOS</p><p>iPadOS<br>Android</p>                                                                                                                       | :ballot\_box\_with\_check:                   |                              | :ballot\_box\_with\_check:                                                         | [ManageEngine Docs](https://www.manageengine.com/mobile-device-management/help/certificate_management/mdm_integrating_generic_scep.html)                                                                                                                                                                                                                                 |

\*: Only works with user-type certificates if the user-objects are synced from Microsoft Entra ID (Azure AD).

## On-premises to Cloud Migration

Since SCEPman is a cloud-native general purpose CA, many of our clients who migrate their infrastructure into the cloud use SCEPman to replace their on-prem Microsoft PKI/AD CS and NDES. Generally, this is possible, as long as the devices that shall receive certificates are **hybrid- or full-Azure-AD-joined**.

## IoT Devices

SCEPman can be utilized to supply certificates to IoT devices. Therefore, SCEPman supports an ECC CA allowing performance- and energy-optimized cryptographic algorithms on devices with limited computational resources or on devices relying on battery power. SCEPman's flexibility supports issuing certificates with long validity periods allowing a long-term offline operation without the need to renew certificates regularly. Furthermore, certificates can be enrolled on an assembly line in a convenient way by leveraging SCEPman's REST API with Microsoft Entra ID (Azure AD)-based authentication.

