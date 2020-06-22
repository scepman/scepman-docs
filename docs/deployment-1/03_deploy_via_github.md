---
category: Deployment (Optional)
title: GitHub Deployment
order: 1
---

# GitHub Deployment

{% hint style="warning" %}
This is an alternative approach to Azure Marketplace Deployment  
We recommend this for production Enterprise deployments!
{% endhint %}

## SCEPman Deployment via GitHub

This article will show you how you can deploy SCEPman via GitHub. But why should you do this?  
Via the GitHub deployment you have full controll of the ressource naming. 

## Start the Deployment

{% hint style="info" %}
You need your Client ID and your Client Secret before you can start the deployment.

See [Azure App Registration](../deployment/01_azure_app_registration.md)
{% endhint %}

Instead of using Azure Marketplace you can deploy SCEPman via Github. Click the following deploy button to start the deployment via GitHub:

[![](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fglueckkanja%2Fgk-scepman%2Fmaster%2Fazuredeploy.json)

Next, you will see the following configuration menu:

![](../.gitbook/assets/scepman_optional1%20%281%29.png)

1. Select an existing resource group or create a new one \(SCEPman resources will be deployed in this group\)
2. Set the location according to your location
3. Enter your **App Registration Guid** \(App client ID\)
4. Enter your **App Registration Key** \(Client secret\)
5. Define a **Key Vault Name**, **App Service Plan Name** and web site
6. Then, click **I agree to the terms...**
7. Finally, click **Purchase**

When you did it you need to create a [custom domain](../deployment/03_customdomain.md).

To get continuous updates for SCEPman you can point a configuration variable to the [maintained GitHub repository](https://github.com/glueckkanja/gk-scepman) of SCEPman. During every restart, the Azure Web App will do a check and a copy deployment if necessary. To configure this do the following:

1. Go to your Azure AD
2. Navigate to **App Service**
3. Choose your SCEPman app
4. Then, click **Configuration** \(submenu **Setting**\)
5. Look for **WEBSITE\_RUN\_FROM\_PACKAGE** and click on it

![](../.gitbook/assets/scepman_optional2%20%281%29.png)

1. Then replace the URL with the SCEPman GitHub URL:

   `https://github.com/glueckkanja/gk-scepman/raw/master/dist/Artifacts.zip`

![](../.gitbook/assets/scepman_optional3%20%281%29.png)

