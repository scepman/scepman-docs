---
category: Deployment
title: Azure App Registration
order: 1
---

# Azure App Registration

SCEPman needs to interact with your Azure Active Directory and Intune endpoints to provide the certificate and OCSP validation of users and devices. To provide the necessary permissions to SCEPman you need to create an App Registration within your tenant.

### Basic App Registration

1. Login in to [Azure Portal](https://portal.azure.com)

2. Navigate to **Azure Active Directory**

3. Click **App registrations**

![](../.gitbook/assets/azure-app-registration.png)

4. Click **New registration** and enter a **name**, i.e. SCEPman. For supported account types choose **Accounts in this organizational directory only** and click register.

![](../.gitbook/assets/azure-app-registration-register.png)

5. You may copy the **Application \(client\) ID** now. The ID is important and will be needed later when installing SCEPman from marketplace. But you can access this ID anytime.

![](../.gitbook/assets/azure-app-registration-scepman.png)

### Azure App Registration / Client Secret

1. Stay within **App registrations** and click on **Certificates & secrets**

![](../.gitbook/assets/azure-app-registration-client-secret.png)

2. Click **New client secret**, add a description and choose the expiration. We recommend **Never**, this helps to provide an ongoing service for a long time. You can revoke a secret at any time. Click **Add**.

![](../.gitbook/assets/azure-app-registration-client-secret-new.png)

3. **Copy the secret** and write it down in a secure place.

{% hint style="warning" %}
Copy the client secret value. You will not be able to retrieve it after you leave this submenu
{% endhint %}

![](../.gitbook/assets/azure-app-registration-client-secret-copy.png)

### Azure App Registration / API permissions

1. Stay within **App registrations** and click on **API permissions**

**2. Remove** the default **User Read** permission

![](../.gitbook/assets/screenshot-2020-02-03-at-10.54.48.png)

3. Click on **Add a permission** and choose **Microsoft Graph**. When chosen, select **Application permissions** and search for directory. Add **Directory.ReadAll** as a permission.

![](../.gitbook/assets/app-permission-graph.png)

![](../.gitbook/assets/app-permission-directory-read.png)

4. Now click on **Add a permission** and choose **Intune**. When chosen, select **Application permissions** and search for scep. Add **scep\_challenge\_provider** as a permission.

![](../.gitbook/assets/app-permission-intune.png)

![](../.gitbook/assets/app-permission-scep.png)

5. Finally click on **Grant admin consent** and **confirm** the consent for the given app registration.

![](../.gitbook/assets/app-registration-consent.png)

![](../.gitbook/assets/app-registration-consent-confirm.png)

The app registration is done.

