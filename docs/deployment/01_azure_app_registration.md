---
category: Deployment
title: Azure App Registration
order: 1
---

# Azure App Registration

## Azure App Registration

The first step is the registration of an application in Azure AD:

| Task | Image |
| :--- | :--- |
| 1. Login in to [Azure Portal](https://portal.azure.com) |  |
| 2. Navigate to **Azure Active Directory** |  |
| 3. Click **App registrations** | [![AppReg](../.gitbook/assets/scepman2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman2.png) |
| 4. Then, **New registration** | [![NewReg](../.gitbook/assets/scepman3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman3.png) |
| 5. Enter a **Name** \(e.g. SCEPman\) |  |
| 6. For **Supported account types** choose **Accounts in this organizational directory only** | [![AccountTypes](../.gitbook/assets/scepman4.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman4.png) |
| 7. Then, click **Register** |  |
| 8. Save the **Application \(client\) ID**. The ID is important and will be needed later | [![AppID](../.gitbook/assets/scepman5.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman5.png) |

## Azure App Registration / Authentication

| Task | Image |
| :--- | :--- |
| 1. Click **Authentication** | [![Auth](../.gitbook/assets/scepman6.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman6.png) |
| 2. Scroll down to **Advanced settings** |  |
| 3. Select **ID tokens** | [![IDtokens](../.gitbook/assets/scepman7.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman7.png) |
| 4. Finally, click **Save** |  |

## Azure App Registration / Client Secret

| Task | Image |
| :--- | :--- |
| 1. Click **Certificates & secrets** | [![Secret](../.gitbook/assets/scepman8.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman8.png) |
| 2. Click **New client secret** |  |
| 3. Define a **Description** and select **Never** |  |
| 4. Finally, click **Add** | [![NewSecret](../.gitbook/assets/scepman9.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman9.png) |

{% hint style="warning" %}
Copy the client secret value. You will not be able to retrieve it after you leave this submenu
{% endhint %}

## Azure App Registration / API permissions

| Task | Image |
| :--- | :--- |
| 1. Still in the SCEPman Application, click **API permissions** |  |
| 2. Click **Add a permission** | [![AddPermission](../.gitbook/assets/scepman11.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman11.png) |
| 3. Then, click **Intune** | [![Intune](../.gitbook/assets/scepman12.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman12.png) |
| 4. Select **Application permissions** | [![PermissionType](../.gitbook/assets/scepman13.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman13.png) |
| 5. Click **scep\_challenge\_provider** | [![SelectPermission](../.gitbook/assets/scepman14.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman14.png) |
| 6. Then, click **Add permissions** |  |
| 7. Next, click **Microsoft Graph** | ![](../.gitbook/assets/screenshot-2020-02-03-at-07.57.59.png) |
| 8. Scroll down to **Directory** and click it |  |
| 9. Select **Directory.Read.All** | [![Directory](../.gitbook/assets/scepman16.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman16.png) |
| 10. Then, click **Add permission** |  |
| 11. Click **Grant admin consent for...** and confirm the displayed dialog with **Yes** | [![GrantAdmin](../.gitbook/assets/scepman17.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman17.png) |
| 12. The Azure AD app registration is finished |  |



