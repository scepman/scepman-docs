# Use Cases

This page is intended to give you an **overview** of **common use cases** and scenarios our clients leverage SCEPman as cloud-CA for. While we cannot provide support for the intricacies of every vendor solution, we hope this overview helps you to quickly assess whether SCEPman could be a fit for your scenario, too - without overwhelming you with less common or even exotic use-cases. If you are unsure, just [drop us a question](https://www.scepman.com/drop-a-question).

## Secure WiFi and Network Access

Certificates issued by SCEPman are widely used for the purpose of certificate-based network authentication (802.1X / EAP-TLS) for WiFi, Wired/LAN and VPN, typically along with a network access control (NAC) service that speaks the RADIUS or RadSec protocol. Such services commonly are

* [RADIUSaaS](https://www.radius-as-a-service.com/)
* Aruba ClearPass
* Cisco ISE / Cisco ASA
* Azure VPN Gateway / Azure AlwaysOn VPN
* Fortinet FortiGate
* Palo Alto GlobalProtect

## Certificate-based Authentication

You can enroll user authentication certificates with SCEPman for TLS client authentication. This allows authentication to web sites or services such as

* Internal web applications
* Microsoft 365
  * Exchange Online
  * Azure Active Directory (AAD)
* Other cloud services
* Remote Desktop connections
  * AVD
  * Windows server administration

## MDM Solutions

To automate the deployment of relevant configuration profiles and to keep certificates up to date (auto-renewal), we recommend to use SCEPman along with an MDM solution. While SCEPman natively integrates with Microsoft Endpoint Manager/Intune and Jamf Pro, our customers have successfully deployed SCEPman along with other MDM solutions.

Below table provides an overview of the most commonly used MDM solutions and indicates how/if certificate revocation is possible.

| MDM Solution                                                                               | Supported Platforms                                              | Issuance & Auto-renewal    | Automatic Revocation         | Manual Revocation                                                                 | Links                                                                                                                                                                                                                                                                                                                                                                    |
| ------------------------------------------------------------------------------------------ | ---------------------------------------------------------------- | -------------------------- | ---------------------------- | --------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| <p><a href="certificate-deployment/microsoft-intune/">Intune /<br>Endpoint Manager</a></p> | <p>Windows<br>macOS<br>iOS</p><p>iPadOS<br>Android<br>Ubuntu</p> | :ballot\_box\_with\_check: | :ballot\_box\_with\_check:   | <p><span data-gb-custom-inline data-tag="emoji" data-code="2611">☑</span><br></p> | [Microsoft Docs](https://docs.microsoft.com/en-us/mem/intune/protect/certificates-profile-scep)                                                                                                                                                                                                                                                                          |
| [Jamf](certificate-deployment/jamf/)                                                       | <p>macOS<br>iOS<br>iPadOS</p>                                    | :ballot\_box\_with\_check: | :ballot\_box\_with\_check:   | :ballot\_box\_with\_check:                                                        | [Jamf Technical Paper](https://docs.jamf.com/technical-papers/jamf-pro/scep-proxy/10.0.0/Introduction.html)                                                                                                                                                                                                                                                              |
| [GSuite / Google Workspace](certificate-deployment/static-certificates/)                   | <p>ChromeOS<br>Android</p>                                       | :ballot\_box\_with\_check: | :ballot\_box\_with\_check:\* | :ballot\_box\_with\_check:                                                        | [Google Support Docs](https://support.google.com/chrome/a/answer/11053129?hl=en)                                                                                                                                                                                                                                                                                         |
| [WorkspaceONE UEM](certificate-deployment/static-certificates/)                            | <p>macOS<br>iOS</p>                                              | :ballot\_box\_with\_check: |                              | :ballot\_box\_with\_check:                                                        | [VMware Support Docs](https://docs.vmware.com/en/VMware-Workspace-ONE-UEM/2011/Certificate\_Authority\_Integrations/GUID-EF7C4D44-9480-4AD1-91E3-EA4F02448F5A.html)                                                                                                                                                                                                      |
| [Mosyle](certificate-deployment/static-certificates/mosyle.md)                             | <p>iOS<br>iPadOS</p>                                             | :ballot\_box\_with\_check: |                              | :ballot\_box\_with\_check:                                                        |                                                                                                                                                                                                                                                                                                                                                                          |
| [SOTI MobiControl](certificate-deployment/static-certificates/)                            | <p>Windows<br>macOS<br>iOS</p><p>iPadOS<br>Android<br>Ubuntu</p> | :ballot\_box\_with\_check: |                              | :ballot\_box\_with\_check:                                                        | <p><a href="https://www.soti.net/mc/help/v14.1/en/console/reference/dialogs/globalsettings/certificates/certificate_authorities.html?hl=certificate%2Cauthority#globalsetting_certificate_authorities__genericscep">Soti Docs - External CA</a><br><a href="https://www.soti.net/mc/help/v14.1/en/console/system/certificates/add.html">Soti Docs - SCEP Profile</a></p> |
| [Kandji](certificate-deployment/static-certificates/)                                      | <p>macOS<br>iOS<br>iPadOS</p>                                    | :ballot\_box\_with\_check: | :ballot\_box\_with\_check:\* | :ballot\_box\_with\_check:                                                        | [Kandji Docs](https://support.kandji.io/support/solutions/articles/72000559782-scep-profile)                                                                                                                                                                                                                                                                             |

\*: Only works with user-type certificates if the user-objects are synced from Azure AD.

## On-premise to Cloud Migration

Since SCEPman is a cloud-native general purpose CA, many of our clients who migrate their infrastructure into the cloud, use SCEPman to replace their on-premise Microsoft PKI/AD CS and NDES. Generally this is always possible, as long as the devices that shall receive certificates are **hybrid- or full-Azure-AD-joined**.
