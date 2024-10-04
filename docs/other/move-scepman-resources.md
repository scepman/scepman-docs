# Move SCEPman resources

{% hint style="warning" %}
Moving SCEPman resources from **tenant to tenant** is not supported. For more information on the underlying problem, see [https://learn.microsoft.com/en-us/azure/key-vault/general/move-subscription](https://learn.microsoft.com/en-us/azure/key-vault/general/move-subscription)
{% endhint %}

{% hint style="info" %}
This guide explains how to move SCEPman resources from one subscription to a new resource group in a different subscription within the same tenant.
{% endhint %}

## Preparations

* Resources associated with the private endpoint cannot be moved. Therefore, if your SCEPman is using Private endpoints, the following SCEPman resources are not movable:
  * 1x Virtual network
  * 2x Private endpoints
  * 2x Network Interface
  * 2x Private DNS zone

{% hint style="info" %}
Alerts and Action groups are also not movable, in case you have any, they need to be reconfigured in the new subscription.
{% endhint %}

* Movable SCEPman resources are:
  * App Service Plan
  * SCEPman and Certificate Master App Services
  * Storage Account
  * Key Vault
  * Log Analytics Workspace

#### Since Private Endpoints are not movable, you need to take the following steps (if your SCEPman is not using Private endpoints, skip these steps):

* First, enable public access on the Key Vault and Storage Account and remove the private endpoints

<figure><img src="../.gitbook/assets/2024-09-30 16_38_27-kv-scepman-n4gwfa6u2pwuc - Microsoft Azure and 8 more pages - ADMIN MPN Tenant -.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image.png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>

* Then, disconnect the outbound network integration on both app services

<figure><img src="../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (5).png" alt=""><figcaption></figcaption></figure>

The same applies to the Certificate Master App service.

## Moving Resources

{% hint style="warning" %}
After moving SCEPman resources to the new subscription, SCEPman will lose its connection to the Storage Account. To resolve this, you will need to [run the Complete-SCEPmanInstallation command](../scepman-configuration/post-installation-config.md#disabled-homepage). Please note that this will be the only **downtime** during the process (from moving the resources until you run the command), which should be resolved within 3-5 minutes.
{% endhint %}

{% hint style="warning" %}
Make sure to have the [required permissions](../scepman-configuration/post-installation-config.md#prerequisites) to run the [_Complete-SCEPmanInstallation_ CMDlet](../scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet) before moving the resources.
{% endhint %}

* Create a new Resource group in the target subscription.
* Now move the resources. An easy way to move resources is to select them in the Resource group and choose "Move to another subscription" option

<figure><img src="../.gitbook/assets/image (7).png" alt=""><figcaption></figcaption></figure>

* Then you need to choose the new Subscription and Resource group, resources will be validated and moved.

## After moving SCEPman resources:

* To fix the connection to the Storage Account, [run the _Complete-SCEPmanInstallation_ CMDlet.](../scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet)
* Now you have the option to reconfigure the private endpoints as mentioned at [Private Endpoints](https://docs.scepman.com/architecture/private-endpoints)

## Considerations regarding the location of the moved SCEPman resources

* Moving resources within the same resource group location is possible.
* Moving resources between different resource group locations, the resources will remain in the original location and will simply be listed in the new resource group under a different location. E.g.:

<figure><img src="../.gitbook/assets/image (8).png" alt=""><figcaption></figcaption></figure>
