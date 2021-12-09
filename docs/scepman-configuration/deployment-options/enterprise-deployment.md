---
description: GitHub Deployment
---

# Enterprise deployment

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

{% hint style="success" %}
Recommended for production
{% endhint %}

This article will show you how you can deploy SCEPman via GitHub. But why should you do this?\
Via the GitHub deployment you have full control of the resource naming.

## Start the Deployment

{% hint style="info" %}
You need your Client ID and your Client Secret before you can start the deployment. Please check [App Registration](../azure-app-registration.md).
{% endhint %}

Click the following deploy button to start the deployment via GitHub:

[![](https://camo.githubusercontent.com/decd8b19034344bb486631a9d3501b663b199bf367c8a9eb2c43ad0df9be10b2/687474703a2f2f617a7572656465706c6f792e6e65742f6465706c6f79627574746f6e2e706e67)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fscepman%2Finstall%2Fmaster%2Fazuredeploy-prod.json)

Next, you will see the following configuration menu:

![](<../../.gitbook/assets/2021-10-11 13\_34\_23-Custom deployment - Microsoft Azure and 11 more pages - C4A8 EHamed - Microsoft​.png>)

1. Select an existing resource group or create a new one (SCEPman resources will be deployed in this group)
2. Set the location according to your location
3. Enter Organisation name for your SCEPman Instance
4. Enter your License key
5. Enter your **App Registration Guid** (App client ID, you already copied before)
6. Enter your **App Registration Key** (Client secret, you already copied before)
7. Define a **Key Vault Name**, **App Service Plan Name** and **App Service Name**
8. Finally, click **Review + Create,** then **Create**
9. After the deployment is done, go to [create root certificate](../first-run-root-cert.md)

| Back to Trial Guide | Back to Community Guide | [Back to Enterprise Guide](../../scepman-deployment/enterprise-guide.md#step-2-deploy-scepman-base-services) |
| ------------------- | ----------------------- | ------------------------------------------------------------------------------------------------------------ |
