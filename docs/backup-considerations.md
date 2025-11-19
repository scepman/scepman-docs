# Backup Considerations

By default, SCEPmans Azure resources offer built-in data resiliency and high availability features, reducing the need for manual backup processes in typical deployments. However, in certain edge cases—such as compliance requirements, custom configurations, or specific recovery objectives—manual or supplementary backup strategies may be necessary. In these scenarios, the following backup considerations and plans should be followed to ensure data protection and business continuity.

## Key Vault

### Backup

Any Key Vault certificate can be backed up by navigating into it and clicking the `Download Backup` button:

<figure><img src=".gitbook/assets/image (115).png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
**Considerations**:&#x20;

* The backup of this certificate will be encrypted to Azure Key Vault and can only be restored in Azure Key Vault within the same subscription
* At least _Key Vault Contributor_ role required
{% endhint %}

### Restore

A back upped Key Vault certificate can be restored in any Key Vault of the same subscription using the `Restore Backup` function in the its Certificate store:

<figure><img src=".gitbook/assets/image (114).png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
**Considerations**:

* A backup of a HSM key can only be restored on a Key Vault of  Premium SKU
* The restoring account needs to have at least the role of _Key Vault Contributor_
{% endhint %}

<figure><img src=".gitbook/assets/image (113).png" alt=""><figcaption></figcaption></figure>

