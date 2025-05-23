---
description: >-
  Implementing strong mapping for SCEP and PKCS certificates in Intune using
  SCEPman.
---

# Intune Strong Mapping

[Currently Microsoft informs customers to double-check their PKIs](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-implementing-strong-mapping-in-microsoft-intune/ba-p/4053376): With the May 10, 2022 Windows update ([KB5014754](https://support.microsoft.com/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16)) changes were made to the Active Directory Kerberos Key Distribution (KDC) behavior in Windows Server 2008 and later versions to mitigate elevation of privilege vulnerabilities associated with certificate spoofing. [We described the impact of this change when the vulnerability was originally disclosed](../other/troubleshooting/certifried.md).

### Scope

First off, this vulnerability applies only to CAs whose certificates are published in the AD Forest's NTAuth store. If you do not use your certificates to authenticate against your on-prem AD, you do not need to publish your CA certificate in the NTAuth store and then you are invulnerable against this attack. Note that Microsoft ADCS publishes its CA certificates in the NTAuth store by default.

For network authentication, the only NAC we know requiring the CA certificate in the NTAuth store is Microsoft NPS. Among the NACs that do not require on-prem authentication and the NTAuth store are RADIUSaaS, Cisco ISE, and Aruba Clearpass. If you are using certificates only for this use case, just make sure your CA certificate is not in your Forest's NTAuth store and you don't have to worry about strong certificate mapping.

If you do have a use case that requires your CA certificate in the NTAuth store, like our [Domain Controller Certificates](../certificate-management/domain-controller-certificates.md), you might still not want your end-user certificates to be used for on-prem authentication. In this case, you again do not need a strong certificate mapping _for these certificates_. Thus, you should enable Full Enforcement Mode, but not add the on-prem SIDs to the certificates.

Only if you are using your end certificates for on-prem authentication, you should make sure SIDs are added. The most common examples for this use case is if you are using Microsoft NPS or if you use certificate-based authentication to log on to on-prem VMs using RDP in ordert to avoid passwords.

### Enabling Strong Certificate Mapping

To address the ADCS/KDC changes, Microsoft Intune can include the SID in enrolled certificates. You can include the SID by adding a SAN of type URI with the value "\{{OnPremisesSecurityIdentifier\}}" and it will appear in the certificate like this:

```
URL=tag:microsoft.com,2022-09-14:sid:<value>
```

This change rolls out this new feature in October/November 2024 for all Microsoft Intune customers.

{% hint style="success" %}
SCEPman is ready for this change. No changes to SCEPman are required, only to the Intune configuration.
{% endhint %}

If you want to use this feature, you must update your SCEP Configuration Profiles in Intune according to Microsoft instructions. We have tested that SCEPman supports this SAN format and it works with all SCEPman versions.

Alternatively, you can add a [SID extension](application-settings/certificates.md#appconfig-addsidextension) with SCEPman. This is how we addressed the KDC issue in [July 2023](../changelog.md#scepman-2.5.892) in the same way that the on-premises ADCS does it. Therefore, SCEPman customers do not require the new SAN field, especially if they are already using the SID extension.

SCEPman customers can choose whether they want the SID extension or the SID SAN value. The former requires a SCEPman configuration setting, the latter requires a change to the SCEP configuration profiles, as detailed above.
