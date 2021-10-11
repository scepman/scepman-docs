---
description: Azure Marketplace Deployment
---

# Marketplace deployment

{% hint style="info" %}
You need your Client ID and your Client Secret before you can start the deployment. Please check [App Registration](../azure-app-registration.md).
{% endhint %}

When the registration of the application is done, SCEPman can be deployed to the Azure subscription.

To get SCEPman go to the [SCEPMAN page in **Azure Marketplace**](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/glueckkanja-gabag.scepman?tab=Overview). Click on **GET IT NOW**, select the software plan **SCEPman Community Edition** and click **CONTINUE**. Then click on **CREATE**.

Now follow these steps to create a SCEPman Intune SCEP-as-a-Service instance:

![](<../../.gitbook/assets/2021-10-11 13\_49\_06-Create SCEPman \_ Intune SCEP-as-a-Service - Microsoft Azure and 11 more pages - .png>)

{% hint style="info" %}
If you have a license key, you can paste it into the field **License Key**. Leave it empty to use the free community edition of SCEPman.
{% endhint %}

1. Select an existing resource group or create a new one (SCEPman resources will be deployed in this group)
2. Set the location according to your location
3. Set an Organization Name
4. **Next, Review + Create**
5. Azure AD **App Registration** Choose **Select Existing, **then click on **Make selection**
6. now search for the App Registration you already did, then click on **Select**
7. Paste the value of **Client secret** you already copied in **App Registration Secret **(See picture below)
8. **Create**

![](<../../.gitbook/assets/2021-10-11 14\_25\_40-Create SCEPman \_ Intune SCEP-as-a-Service - Microsoft Azure and 13 more pages - .png>)

Congratulation! The deployment is done. Now go to [create root certificate](../first-run-root-cert.md)

| [Back to Trial Guide](../../scepman-deployment/trial-guide.md#step-2-deploy-scepman-base-services) | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-2-deploy-scepman-base-services) | [Back to Enterprise Guide](../../scepman-deployment/enterprise-guide.md#step-1-azure-app-registration) |
| -------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
