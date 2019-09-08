---
category: Deployment
title: Azure App Registration
order: 1
---

## Azure App Registration

The first step is the registration of an application in Azure AD:

| Task | Image |
| ---- | ----- |
| 1. Login in to [Azure Portal](https://portal.azure.com) | |
| 2. Navigate to **Azure Active Directory** | |
| 3. Click **App registrations** | [![AppReg](/media/scepman2.png)](/media/scepman2.png) |
| 4. Then, **New registration** | [![NewReg](/media/scepman3.png)](/media/scepman3.png) |
| 5. Enter a **Name** (e.g. SCEPman)
| 6. For **Supported account types** choose **Accounts in this organizational directory only** | [![AccountTypes](/media/scepman4.png)](/media/scepman4.png) |
| 7. Then, click **Register** | |
| 8. Save the **Application (client) ID**. The ID is important and will be needed later | [![AppID](/media/scepman5.png)](/media/scepman5.png) |

## Azure App Registration / Authentication

| Task | Image |
| ---- | ----- |
| 1. Click **Authentication** | [![Auth](/media/scepman6.png)](/media/scepman6.png) |
| 2. Scroll down to **Advanced settings** | |
| 3. Select **ID tokens** | [![IDtokens](/media/scepman7.png)](/media/scepman7.png) |
| 4. Finally, click **Save** | |

## Azure App Registration / Client Secret

| Task | Image |
| ---- | ----- |
| 1. Click **Certificates & secrets** | [![Secret](/media/scepman8.png)](/media/scepman8.png) |
| 2. Click **New client secret** | |
| 3. Define a **Description** and select **Never** | |
| 4. Finally, click **Add** | [![NewSecret](/media/scepman9.png)](/media/scepman9.png) |

> Copy the client secret value. You will not be able to retrieve it after you leave this submenu.
>  
> [![ClientSecretValue](/media/scepman10.png)](/media/scepman10.png)
>  

## Azure App Registration / API permissions

| Task | Image |
| ---- | ----- |
| 1. Still in the SCEPman Application, click **API permissions** | |
| 2. Click **Add a permission** | [![AddPermission](/media/scepman11.png)](/media/scepman11.png) |
| 3. Then, click **Intune** | [![Intune](/media/scepman12.png)](/media/scepman12.png) |
| 4. Select **Application permissions** | [![PermissionType](/media/scepman13.png)](/media/scepman13.png) |
| 5. Click **scep_challenge_provider** | [![SelectPermission](/media/scepman14.png)](/media/scepman14.png) |
| 6. Then, click **Add permissions** | |
| 7. Next, click **Microsoft Graph** | [![MicrosoftGraph](/media/scepman15.png)](/media/scepman15.png) |
| 8. Scroll down to **Directory** and click it | |
| 9. Select **Directory.Read.All** | [![Directory](/media/scepman16.png)](/media/scepman16.png) |
| 10. Then, click **Add permission** | |
| 11. Click **Grant admin consent for...** and confirm the displayed dialog with **Yes** | [![GrantAdmin](/media/scepman17.png)](/media/scepman17.png) |
| 12. The Azure AD app registration is finished | |
