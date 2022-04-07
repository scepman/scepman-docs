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

Fill out the values in the form

![](<../../.gitbook/assets/2022-04-04CustomDeploymentV2 .png>)

* **Subscription:** Select your subscription, where you have permissions to create app services, storage account, app service plan, and key vault
* **Resource group:** Select an existing resource group or create a new one. The SCEPman resources will be deployed to this resource group.
* **Region:** Select the region according to your location.
* **Org Name:** Name of your company or organization for the certificate subject
* **License:** leave it "trial" to deploy a community edition, or paste your license key -if you already have one- for an enterprise edition.
* Define a unique name for the **Key Vault Name, App Service Name,** and **App Service Cert Master Name,** you need just to replace it with the placeholder _UNIQUENAME_
* By **Storage Account Name** please notice that the name **must** be between 3 and 24 characters in length and may contain **numbers and lowercase letters only.**
* **Existing App Service Plan ID:** Provide the AppServicePlan ID of an existing App Service Plan or keep the default value 'none' if you want to create a new one.

To find your **existing App Service Plan ID:** navigate to your existing App Service Plan -> JSON View -> copy the Resource ID (see screenshots)

![](<../../.gitbook/assets/2022-04-04 12\_51\_33AppServicePlan.png>) ![](<../../.gitbook/assets/2022-04-04 12\_54\_04-Resource JSON.png>)

* **Review + create**, then **Create**

After a successful deployment of SCEPman 2.x please follow the [V2.x Managed Identities ](../post-installation-config.md)article.

## Upgrade from 1.x to 2.x

SCEPman 2.0 comprises two additional Azure resources, an Azure Storage account and an App Service called "Cert Master". These are used to issue and manage the server certificates. But you can run SCEPman 2.0 also without them if you just go for the client certificates as before.

If you are still running SCEPman 1.x, ensure that your instance uses 2.x application artifacts as described here: [Application Artifacts](../optional/application-artifacts.md).

**Please restart your AppService afterwards.**

### Add SCEPman Cert Master

{% hint style="warning" %}
**Before** adding the Cert Master component through the PowerShell script mentioned below, the existing SCEPman base service must be updated to version >= 2.0 as described in the previous paragrapgh.
{% endhint %}

If you want to use the new SCEPman Cert Master component to issue server certificates, you need to add the additional Azure resources and configure them. This will enable authentication as Managed Identity, one advantage of it is you do not require any application secrets anymore. Thus, you also don't need to worry about the expiration of application secrets! This is how you do it:

After upgrading the main component, you need to follow the guide of [Post-Installation Configuration](../post-installation-config.md). In contrast to a new installation, this will also create the two new Azure resources.

## Downgrade from 2.x to 1.x

You can downgrade to any older SCEPman version by downloading the older artifcats, host them in your location, e.g. Azure Blob storage and then reference the binaries using the [WEBSITE\_RUN\_FROM\_PACKAGE](../optional/application-artifacts.md#change-artifacts) setting.

However, if you also used the SCEPman PowerShell module to upgrade the internal wiring, there is one caveat: 2.x supports a different way of authentication to Graph and Intune using Managed Identities, which is also the new default and which is enabled by the script. If you downgrade your main component, it won't be able to use the new way of authentication and is missing one setting for the old one, so it won't work anymore. Thus, after a downgrade, you must manually change the application settings [AppConfig:AuthConfig:ApplicationId](../optional/application-settings/azure-ad.md#appconfig-authconfig-applicationid) and [AppConfig:AuthConfig:ApplicationKey](../optional/application-settings/azure-ad.md#appconfig-authconfig-applicationkey). The script creates backups of the settings by prefixing `Backup:`. Thus, you need to rename `Backup:AppConfig:AuthConfig:ApplicationKey` back to `AppConfig:AuthConfig:ApplicationKey` and copy the old value from `Backup:AppConfig:AuthConfig:ApplicationId` to `AppConfig:AuthConfig:ApplicationId`. Then the 1.x will work again using authentication based on App Registrations.

| Back to Trial Guide | Back to Community Guide | [Back to Enterprise Guide](broken-reference) |
| ------------------- | ----------------------- | -------------------------------------------- |
