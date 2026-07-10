# RADIUSaaS Integration

SCEPman integrates seamlessly with [RADIUSaaS](https://docs.radiusaas.com/?_gl=1*1qkd9on*_ga*MTY4NjA4MjY0NS4xNzgzNDA2ODEx*_ga_5D8Y8TBBDJ*czE3ODM0MDY4MTAkbzEkZzAkdDE3ODM0MDY4MTAkajYwJGwwJGgw) to provide a complete certificate-based authentication solution for Wi-Fi, VPN, and wired network access. Together, both products enable organizations to deploy passwordless network authentication using certificates issued by SCEPman and validated by RADIUSaaS. Customers can choose between a self-managed Enterprise Bundle or a fully managed SaaS Bundle depending on their operational and compliance requirements.

**The following bundle options are available:**

## **RADIUSaaS + SCEPman Enterprise Bundle**

The RADIUSaaS + SCEPman Enterprise Bundle combines the full Enterprise Editions of SCEPman and RADIUSaaS into one integrated solution for certificate-based network access. The bundle includes all enterprise features, product support, and advanced authentication capabilities required for productive environments. It is designed for organizations that want to secure Wi-Fi, VPN, and wired network access using certificates without relying on traditional passwords.

**We recommend the Enterprise Bundle for:**

* Productive environments
* Enterprise-grade network security
* Certificate-based Wi-Fi, VPN, and LAN authentication
* Scalability and high availability
* Organizations requiring support and enterprise features

## **RADIUSaaS + SCEPman SaaS Bundle**

The RADIUSaaS + SCEPman SaaS Bundle provides a fully managed cloud-based solution for certificate issuance and network authentication. By combining SCEPman and RADIUSaaS in a SaaS offering, organizations can deploy secure network access without managing their own PKI or RADIUS infrastructure. The solution integrates with Microsoft Intune and Microsoft Entra ID to enable modern, passwordless network authentication.

**We recommend the SaaS Bundle for:**

* Organizations looking for a fully managed service
* Simplified deployment and operations
* Cloud-first environments
* Certificate-based Wi-Fi and VPN authentication
* Reduced infrastructure and maintenance effort

For both options the [SCEPman Connection](https://docs.radiusaas.com/admin-portal/settings/settings-server#scepman-connection) feature enables automatic issuance and renewal of RADIUSaaS server certificates through SCEPman.

## **RADIUSaaS + SCEPman Bundle Edition Comparison**

<table data-search="false"><thead><tr><th width="241">Capability</th><th width="241" align="center">RADIUSaaS + SCEPman Enterprise Bundle</th><th align="center">RADIUSaaS + SCEPman SaaS Bundle</th></tr></thead><tbody><tr><td><strong>Hosting</strong></td><td align="center">Customer's Azure Tenant</td><td align="center">Vendor's Datacenters</td></tr><tr><td><strong>Infrastructure Cost</strong></td><td align="center">Customer</td><td align="center">Vendor</td></tr><tr><td><strong>Maintenance</strong></td><td align="center">Customer / Azure</td><td align="center">Vendor</td></tr><tr><td><strong>Configuration</strong></td><td align="center">Customer</td><td align="center">Customer</td></tr><tr><td><strong>Geo-Redundancy</strong></td><td align="center">Yes</td><td align="center">Planned</td></tr><tr><td><strong>Certificate Master RBAC</strong></td><td align="center">Yes</td><td align="center">No</td></tr><tr><td><strong>AD Enrollment</strong></td><td align="center">Yes</td><td align="center">Planned</td></tr><tr><td><strong>Enrollment REST API</strong></td><td align="center">Yes</td><td align="center">Planned</td></tr><tr><td><strong>Logging</strong></td><td align="center">Azure Monitor / <br>Log Analytics</td><td align="center">WebConsole</td></tr><tr><td><strong>CA hierarchy</strong></td><td align="center">Yes</td><td align="center">Bring your own Key Vault (BYOK)</td></tr><tr><td><strong>Machine certificates</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>User certificates</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>AD Device Certificates</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>Certificate Management</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>Kerberos Certificates</strong></td><td align="center">Yes</td><td align="center">Planned</td></tr><tr><td><strong>Other MDM Integration</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>Device Compliance Check</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>Support</strong></td><td align="center">Yes</td><td align="center">Yes</td></tr><tr><td><strong>Licensing</strong></td><td align="center"> Subscription-fee</td><td align="center"> Subscription-fee</td></tr></tbody></table>

For licensing, purchasing, and trial options, visit the [RADIUSaaS + SCEPman Bundle website](https://www.scepman.com/secure-network-access-bundle).
