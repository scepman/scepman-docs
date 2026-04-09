---
description: GitHub Deployment
---

# Enterprise deployment

## New SCEPman Instance

**Deploy Azure Resources**

Log in with an AAD administrator account and visit this site, choose and click one of the following deployment links:

* [Production channel](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Fdeploy%2Fprod%2Fazuredeploy.json)
* [Beta channel](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Fdeploy%2Fbeta%2Fazuredeploy.json)
* [Internal channel](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Fdeploy%2Finternal%2Fazuredeploy.json)
* [Production channel in GCC High national cloud](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Fdeploy%2Fgcchigh%2Fazuredeploy.json)
* [Production channel in 21Vianet national cloud](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Fdeploy%2Fvianet%2Fazuredeploy.json) (Experimental!)

Fill out the values in the form

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

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

After a successful deployment of SCEPman please follow the[ Managed Identities ](../post-installation-config.md)article
