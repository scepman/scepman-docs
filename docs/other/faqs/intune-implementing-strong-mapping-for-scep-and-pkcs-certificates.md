# Intune implementing strong mapping for SCEP and PKCS certificates

[Currently Microsoft informs customers to double-check their PKIs](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-implementing-strong-mapping-in-microsoft-intune/ba-p/4053376): With the May 10, 2022 Windows update ([KB5014754](https://support.microsoft.com/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16)) changes were made to the Active Directory Kerberos Key Distribution (KDC) behavior in Windows Server 2008 and later versions to mitigate elevation of privilege vulnerabilities associated with certificate spoofing. [We described the impact of this change when the vulnerability was originally disclosed](../troubleshooting/certifried.md).

To address the ADCS/KDC changes, Microsoft Intune will include the SID in user certificates. It will be included as an URL in the SAN:

```
URL=tag:microsoft.com,2022-09-14:sid:<value>
```

This change is currently (February 2024) being rolled out to all Microsoft Intune customers.

{% hint style="success" %}
SCEPman is ready for this change. SCEPman customers do not have to take action.
{% endhint %}

We addressed the KDC issue in [July 2023](../../changelog.md#scepman-2.5.892) by [using the SID extension](../../advanced-configuration/application-settings/certificates.md#appconfig-addsidextension) that the on-premises ADCS also use. Therefore, SCEPman customers do not require the new SAN field.

However, we have also tested that SCEPman supports this SAN format and it works with all SCEPman versions. SCEPman customers can choose whether they want the SID extension or the SID SAN value.
