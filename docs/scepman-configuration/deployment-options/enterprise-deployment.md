---
description: GitHub Deployment
---

# Enterprise deployment

The deployment of SCEPman 2.x is different from a SCEPman 1.x deployment. If you want to install a new SCEPman 2.x instance or upgrade your existing 1.x instance keep reading.

## New SCEPman 2.0 Instance

**Deploy Azure Resources**

Log in with an AAD administrator account and visit this site, choose and click one of the following deployment links:

* [Production channel](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Finstall%2Fprod%2Fazuredeploy.json)
* [Beta channel](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Finstall%2Fbeta%2Fazuredeploy.json)
* [Internal channel](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Finstall%2Finternal%2Fazuredeploy.json)
* [Production channel in GCC High national cloud](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Finstall%2Fgcchigh%2Fazuredeploy.json)
* [Production channel in 21Vianet national cloud](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Finstall%2Fvianet%2Fazuredeploy.json) (Experimental!)

Fill out the values in the form

<figure><img src="../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

* **Subscription:** Select your subscription, where you have permissions to create app services, storage account, app service plan, and key vault
* **Resource group:** Select an existing resource group or create a new one. The SCEPman resources will be deployed to this resource group
* **Region:** Select the region according to your location
* **Org Name:** Name of your company or organization for the CA certificate subject name (O RDN)

{% hint style="warning" %}
To maximize compatibility, for the **Org Name** we recommend omitting

* language-specific special characters (e.g. ö, ø, é, ...)
* a leading space (spaces between words can be used)
* quotation marks
{% endhint %}

* **License:** leave as "trial" to deploy a Community Edition or paste your license key for the Enterprise Edition of SCEPman.
* **Ca Key Type**:&#x20;
  * **RSA-HSM** (**recommended**, HSM-backed root CA)
  * **RSA** (software-backed root CA)
* For the **Storage Account Name**, please notice that the name **must** be between 3 and 24 characters in length and may contain **numbers and lowercase letters only**
* Define a **globally** unique name for the **Key Vault Name, App Service Plan Name,** **Primary App Service Name**, **Log Analytics Workspace Name**, **Certificate Master App Service Name**, **Virtual Network Name**, **Private Endpoint for Key Vault Name** and **Private Endpoint for Table Storage.** Replace _UNIQUENAME_ with a value that hints at your organization name.

{% hint style="warning" %}
In case you have previously deployed SCEPman with the same **Key Vault Name**, and deleted all resources of the previous deployment, make sure to [**recover**](https://learn.microsoft.com/en-gb/azure/key-vault/general/key-vault-recovery?tabs=azure-portal\&WT.mc_id=Portal-Microsoft_Azure_KeyVault#list-recover-or-purge-a-soft-deleted-key-vault) the previously deleted Key Vault. It will re-appear in the previous resource group. The ARM deployment - if pointed to the same resource group - will recognize the existing Key Vault and re-use it. A full deletion of the previous Key Vault is not feasible due to [**Purge Protection**](https://learn.microsoft.com/en-gb/azure/key-vault/general/key-vault-recovery?tabs=azure-portal\&WT.mc_id=Portal-Microsoft_Azure_KeyVault#what-are-soft-delete-and-purge-protection) for 90 days.
{% endhint %}

* **Existing App Service Plan ID:** Provide the App Service Plan ID of an existing App Service Plan or keep the default value 'none' if you want to create a new one

To find your **existing App Service Plan ID:** navigate to your existing App Service Plan > JSON View > copy the Resource ID (see screenshots)

![](<../../.gitbook/assets/2022-04-04 12_51_33AppServicePlan.png>) ![](<../../.gitbook/assets/2022-04-04 12_54_04-Resource JSON.png>)

* **Deploy on Linux:**
  * **true** (deploys SCEPman on a Linux App Service Plan)
  * **false** (deploys to a Windows App Service Plan)
* **Deploy Private Network**:&#x20;
  * **true** (**recommended**, isolates the key vault and storage account behind private endpoints so that only SCEPman can access them from a networking perspective)
  * **false** (key vault and storage account can be accessed from any IP address)
* **Location:** of all resources, the default value `[resourceGroup().location]` is Microsoft recommendation, you can just leave it as it is
* **Review + create**, then **Create**

After a successful deployment of SCEPman 2.x please follow the[ Managed Identities ](../post-installation-config.md)article

## Upgrade from 1.x to 2.x

SCEPman 2.0 comprises two additional Azure resources, an Azure Storage account and an App Service called "Cert Master". These are used to issue and manage the server certificates. But you can run SCEPman 2.0 also without them if you just go for the client certificates as before.

If you are still running SCEPman 1.x, ensure that your instance uses 2.x application artifacts as described here: [Application Artifacts](../application-artifacts.md).

**Please restart your App Service afterward.**

### Add SCEPman Cert Master

{% hint style="warning" %}
**Before** adding the Cert Master component through the PowerShell script mentioned below, the existing SCEPman base service must be updated to version >= 2.0 as described in the previous paragraph.
{% endhint %}

If you want to use the new SCEPman Cert Master component to issue server certificates, you need to add the additional Azure resources and configure them. This will enable authentication as Managed Identity, one advantage of it is you do not require any application secrets anymore. Thus, you also don't need to worry about the expiration of application secrets! This is how you do it:

After upgrading the main component, you need to follow the guide of [Post-Installation Configuration](../post-installation-config.md). In contrast to a new installation, this will also create the two new Azure resources.

## Downgrade from 2.x to 1.x

You can downgrade to any older SCEPman version by downloading the older artifacts, host them in your location, e.g. Azure Blob storage and then reference the binaries using the [WEBSITE\_RUN\_FROM\_PACKAGE](../application-artifacts.md#change-artifacts) setting.

However, if you also used the SCEPman PowerShell module to upgrade the internal wiring, there is one caveat: 2.x supports a different way of authentication to Graph and Intune using Managed Identities, which is also the new default and which is enabled by the script. If you downgrade your main component, it won't be able to use the new way of authentication and is missing one setting for the old one, so it won't work anymore. Thus, after a downgrade, you must manually change the application settings [AppConfig:AuthConfig:ApplicationId](../application-settings/dependencies-azure-services/azure-ad.md#appconfig-authconfig-applicationid) and [AppConfig:AuthConfig:ApplicationKey](../application-settings/dependencies-azure-services/azure-ad.md#appconfig-authconfig-applicationkey). The script creates backups of the settings by prefixing `Backup:`. Thus, you need to rename `Backup:AppConfig:AuthConfig:ApplicationKey` back to `AppConfig:AuthConfig:ApplicationKey` and copy the old value from `Backup:AppConfig:AuthConfig:ApplicationId` to `AppConfig:AuthConfig:ApplicationId`. Then the 1.x will work again using authentication based on App Registrations.
