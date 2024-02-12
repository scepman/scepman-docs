# Intune implementing strong mapping for SCEP and PKCS certificates

[Currently Microsoft informs customers to double-check if their PKIs](https://techcommunity.microsoft.com/t5/intune-customer-success/support-tip-implementing-strong-mapping-in-microsoft-intune/ba-p/4053376): With the May 10, 2022 Windows update ([KB5014754](https://support.microsoft.com/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16)), changes were made to the Active Directory Kerberos Key Distribution (KDC) behaviour in Windows Server 2008 and later versions to mitigate elevation of privilege vulnerabilities associated with certificate spoofing.

To address the ADCS/KDC changes, Microsoft Intune will include SID in certificates. It will be included as an URL in the SAN:

```
URL=tag:microsoft.com,2022-09-14:sid:<value>
```

This change is currently (February 2024) being rolled out to all Microsoft Intune customers.

{% hint style="success" %}
SCEPman is ready for this change. SCEPman customers do not have to take action.
{% endhint %}

We addressed the KDC issue [some time ago](https://docs.scepman.com/changelog#scepman-2.5.892) by using the SID extension that the on-premises ADCS also use ([https://docs.scepman.com/advanced-configuration/application-settings/certificates#appconfig-addsidextension](https://deu01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.scepman.com%2Fadvanced-configuration%2Fapplication-settings%2Fcertificates%23appconfig-addsidextension\&data=05%7C02%7CStefan.Schoenleber%40glueckkanja.com%7Cfdb47492c8d54b4a188808dc297f3b66%7Ca53834b742bc46a3b004369735c3acf9%7C0%7C0%7C638430873640010878%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C\&sdata=lXkGIARGS8bCTIhg6sVAJdqQEgQekk2K2Lh4571wBRI%3D\&reserved=0)). Therefore, SCEPman customers do not require the new SAN field and should not be affected.&#x20;

However, we have also tested that SCEPman supports this SAN format and it works with all SCEPman versions. SCEPman customers can choose whether they want the SID extension or the SID SAN value.
