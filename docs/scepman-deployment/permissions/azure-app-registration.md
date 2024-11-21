# V1.x: Azure App Registration

{% hint style="info" %}
Only the **1.x** versions require an Azure App Registration. SCEPman 2.x still supports it, but we recommend using [Managed Identities](../../scepman-configuration/post-installation-config.md).
{% endhint %}

SCEPman needs to interact with your Azure Active Directory and Intune endpoints to provide the certificate and OCSP validation of users and devices. To provide the necessary permissions to SCEPman you need to create an App Registration within your tenant.

## Generate App Registration (get Application ID)

1. Login to [Azure Portal](https://portal.azure.com)
2. Navigate to **Azure Active Directory**
3. Click **App registrations**

![](../../.gitbook/assets/2021-07-23-08\_47\_59-app-registrations-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-.png)

4\. Click **New Registration** and enter a **name**, i.e. SCEPman. For supported account type choose **Accounts in this organizational directory only** and click register.

![](../../.gitbook/assets/2021-07-23-08\_49\_37-register-an-application-microsoft-azure-and-2-more-pages-c4a8-ehamed-micro.png)

5\. You may copy the **Application (client) ID** now. The ID is important and will be needed later by SCEPman deployment.

![](../../.gitbook/assets/2021-07-23-08\_50\_59-scepmanreg-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-edge.png)

Create a new environment variable in SCEPman app service with the name [AppConfig:AuthConfig:ApplicationId](../../advanced-configuration/application-settings/azure-ad.md#appconfig-authconfig-applicationid) and paste the copied application ID as a value.

## Generate Secret (get Client Secret Value)

1\. Stay within **App registrations** and click on **Certificates & secrets**

![](../../.gitbook/assets/2021-07-23-08\_52\_08-scepmanreg-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-edge.png)

2\. Click **New client secret**, add a description, and choose the expiration. We recommend **24 months**, this helps to provide an ongoing service for two years. You can revoke a secret at any time. Click **Add**

![](../../.gitbook/assets/2021-07-23-09\_06\_11-azure-app-registration-scepman-docs-and-1-more-page-work-microsoft-edge.png)

3\. **Copy the secret value** and copy it down in a secure place.

{% hint style="warning" %}
Please do not mix it up with the "Client Secret **ID**". We need the "Client Secret **Value**", here.
{% endhint %}

{% hint style="warning" %}
Copy the client secret value immediately. You will not be able to retrieve it after you leave this submenu.
{% endhint %}

![](<../../.gitbook/assets/image (18).png>)

4. update the value of the SCEPman setting [AppConfig:AuthConfig:ApplicationKey](../../advanced-configuration/application-settings/azure-ad.md#appconfig-authconfig-applicationkey) with the client secret value.

## Configure Permissions

Stay within **App Registrations** and click on **API permissions**

1. **Remove** the default **User** **Read** permission.

![](<../../.gitbook/assets/screenshot-2020-02-03-at-10.54.48 (1) (1).png>)

2\. Click on **Add a permission** and choose **Microsoft Graph**. When chosen, select **Application permissions** and search for directory. Add **Directory.ReadAll** as permission.

![](<../../.gitbook/assets/app-permission-graph (1) (1).png>)

![](<../../.gitbook/assets/app-permission-directory-read (1) (1) (1) (1).png>)

3\. Now click on **Add a permission** and choose **Intune**. When chosen, select **Application permissions** and search for scep. Add **scep\_challenge\_provider** as a permission

![](<../../.gitbook/assets/app-permission-intune (1) (1) (1).png>)

![](<../../.gitbook/assets/app-permission-scep (1) (1).png>)

4. Search and add the following Graph permissions as well: `DeviceManagementConfiguration.Read.All` and `DeviceManagementManagedDevices.Read.All`
5. &#x20;Finally click on **Grant admin** consent and **confirm** the consent for the given app registration.

<figure><img src="../../.gitbook/assets/2024-03-13 12_10_27-SCEPman-api.png" alt=""><figcaption></figcaption></figure>

6. After successfully granting the permissions you should see green status for each permission.

<figure><img src="../../.gitbook/assets/2024-03-13 12_12_18-SCEPman-api.png" alt=""><figcaption></figcaption></figure>

The app registration is done.
