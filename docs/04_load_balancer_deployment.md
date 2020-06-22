---
category: Deployment (Optional)
title: Load Balancer Deployment
order: 2
---

# High Availability Scenario

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

## Load Balancer Deployment \(optional\)

This section describes a high availability architecture for production use.

![](.gitbook/assets/scepman_loadbalancer1.png)

## Clone App

After successful deployment of SCEPman, you can set up a load balancer for higher availability. Start cloning the app:

| Task | Image |
| :--- | :--- |
| 1. Navigate to **App Service** |  |
| 2. Scroll down to **Development Tools** and click **Clone App** |  |
| 3. Fill in the required fields | [![CreateCloneApp](.gitbook/assets/scepman_cloneapp1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cloneapp1.png) |
| 4. Click **App Service plan/Location** | [![AppServicePlan](.gitbook/assets/scepman_cloneapp2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cloneapp2.png) |
| 5. Then, click **Create new** to create a new service plan |  |
| 6. Enter a **App Service plan** and select a **Location** and a **Pricing tier** | [![NewServicePlan](.gitbook/assets/scepman_cloneapp3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cloneapp3.png) |
| 7. Click **OK** |  |
| 8. Do not configure the **Clone Settings** |  |
| 9. Finally, click **Create** |  |

Next, you need a managed identity for the cloned app:

| Task | Image |
| :--- | :--- |
| 1. Go to your cloned web app and click **Identity** | [![Identity](.gitbook/assets/scepman_identity1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_identity1.png) |
| 2. Under **System assigned** switch the Status to **On** | [![Status](.gitbook/assets/scepman_identity2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_identity2.png) |
| 3. Click **Save** |  |
| 4. This will register your web app into Azure AD |  |

Your **Identity** should look like this:

![](.gitbook/assets/scepman_identity3.png)

## Setup Azure Key Vault Access Policy

| Task | Image |
| :--- | :--- |
| 1. Go to your Key Vault |  |
| 2. Click **Access policies** and then click **Add new** | [![AccessPolicies](.gitbook/assets/scepman_keyvault1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_keyvault1.png) |
| 3. In the submenu **Add access policy** click **Select principal** | [![SelectPrincipal](.gitbook/assets/scepman_keyvault2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_keyvault2.png) |
| 4. Search your web app identity |  |
| 5. Now select **Key permissions**, **Secret permissions** and **Certificate permissions**. |  |
| 6. Your access policy should look like this | [![AccessPolicy](.gitbook/assets/scepman_keyvault3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_keyvault3.png) |
| 7. Then click **Add** |  |
| 8. Finally, click **Save** |  |

## Setup Traffic Manager

| Task | Image |
| :--- | :--- |
| 1. In Microsoft Azure click **Create a resource** |  |
| 2. Search **Traffic Manager profile** and click **Create** |  |
| 3. Fill in the fields | [![TrafficManagerProfile](.gitbook/assets/scepman_trafficmanager1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_trafficmanager1.png) |
| 4. Then, click **Create** |  |
| 3. After your Traffic Manager is deployed, go to it and click **Configuration** |  |
| 4. Change the settings | [![ChangeSettings](.gitbook/assets/scepman_trafficmanager2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_trafficmanager2.png) |
| 5. Then, under **Settings**, choose **Endpoints** |  |
| 6. Click **Add** and choose the primary web app | [![AddEndpoint](.gitbook/assets/scepman_trafficmanager3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_trafficmanager3.png) |
| 7. Repeat these steps for your second web app |  |

In the **Overview** your traffic manager should like this \(here you find the traffic manage URL\):

![](.gitbook/assets/scepman_trafficmanager4.png)

## Own Application Setup \(optional\)

The SCEPman application will be loaded from the zip file which is located in a Glück & Kanja [Github repository](https://github.com/glueckkanja/gk-scepman/raw/master/dist/Artifacts.zip). This zip file will be updated automatically from the Glück & Kanja development team. If a customer does not want to get auto-updates, the web apps can load the zip file from the self-managed storage account.

| Task | Image |  |
| :--- | :--- | :--- |
| 1. In Microsoft Azure click \*\*Create a resource |  |  |
| 2. Search for **Storage account** and click **Create** |  |  |
| 3. Configure your storage account like this | [![CreateStorage](.gitbook/assets/scepman_storage1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_storage1.png) |  |
| 4. Click **Create** |  |  |
| 5. Go to your Storage account and choose **Blobs** | [![StorageExplorer](.gitbook/assets/scepman_storage2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_storage2.png) |  |
| 6. Then, click **+ Container** |  |  |
| 7. Enter a **Name** |  |  |
| 8. As **Public access level** select **Blob \(anonymous read access for blobs only\)** | [![AccessLevel](.gitbook/assets/scepman_storage3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_storage3.png) |  |
| 9. Click **OK** |  |  |
| 10. Select your Container and click **Upload** |  |  |
| 11. Choose the **Artifacts.zip** | [![Artifacts](.gitbook/assets/scepman_storage4.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_storage4.png) |  |
| 12. Then, click **Upload** |  |  |
| 13. Next, click on the zip-file |  |  |
| 14. Click **Properties** and copy the **Uri** value |  |  |
| 15. Then, navigate to your primary web app in \*\*App Services |  |  |
| 16. Click **Configuration** |  | [![Configuration](.gitbook/assets/scepman_storage5.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_storage5.png) |
| 17. In **Application settings** search **WEBSITE\_RUN\_FROM\_PACKAGE** | [![AppSettings](.gitbook/assets/scepman_storage6.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_storage6.png) |  |
| 18. Repeat the steps 14 to 17 for each web app and restart these web apps after your changes |  |  |

