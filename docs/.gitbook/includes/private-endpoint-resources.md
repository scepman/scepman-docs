---
title: Private Endpoint Resources
---

<table><thead><tr><th width="374">Type</th><th>Description</th></tr></thead><tbody><tr><td>Virtual Network</td><td>The SCEPman App Services, the Key Vault, and the Storage Account connect over this VNET.</td></tr><tr><td>Private Endpoint (×2)</td><td>One for the Key Vault and one for the Storage Account. It makes them accessible over the VNET.</td></tr><tr><td>Private DNS zone (×2)</td><td>One for the Key Vault and one for the Storage Account. They both have an internal IP address in the VNET, for which they have a name in their respective Private DNS zone.</td></tr><tr><td>Network Interface (×2)</td><td>One for the Key Vault and one for the Storage Account. It connects the Private Endpoint to the VNET.</td></tr></tbody></table>
