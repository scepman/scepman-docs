# Azure Key Vault API retirement notices (2026/2027)

Microsoft is notifying Azure customers about the retirement of Key Vault API versions, for example API version **2026-03-01-preview** (31 January 2027) and all control plane API versions before **2026-02-01** (27 February 2027).

**Your SCEPman instance is not affected. No action is required.**

Azure Key Vault has two separate APIs:

* The **control plane** creates and configures key vaults. This is the API being retired, but SCEPman does not use it.
* The **data plane** accesses keys and certificates. SCEPman uses only this API during operation, and it is not affected by the retirement.

[Update the Azure Key Vault API version you use (Microsoft Learn)](https://learn.microsoft.com/en-us/azure/key-vault/general/migrate-api-version)
