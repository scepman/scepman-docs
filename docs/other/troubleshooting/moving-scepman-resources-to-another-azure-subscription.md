# Moving SCEPman resources to another Azure subscription

Moving SCEPman resources to another Azure subscription is technically feasible, but neither recommended nor supported from our side. &#x20;

The main breaking change is moving the Key Vault. See  [Azure Key Vault moving a vault to a different subscription | Microsoft Learn](https://learn.microsoft.com/EN-us/azure/key-vault/general/move-subscription)

We recommend deploying a new SCEPman instance and migrating to the specified use case.
