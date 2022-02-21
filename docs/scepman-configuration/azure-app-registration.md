# Azure App Registration

{% hint style="info" %}
Only the **1.x** versions require an Azure App Registration. SCEPman 2.x still supports it, but we recommend using the [SCEPman PowerShell Module](post-installation-config.md).
{% endhint %}

SCEPman needs to interact with your Azure Active Directory and Intune endpoints to provide the certificate and OCSP validation of users and devices. To provide the necessary permissions to SCEPman you need to create an App Registration within your tenant.

## Generate App Registration (get Application ID)

1. Login in to [Azure Portal](https://portal.azure.com)
2. Navigate to **Azure Active Directory**
3. Click **App registrations**

![](../../.gitbook/assets/2021-07-23-08\_47\_59-app-registrations-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-.png)

4\. Click **New registration** and enter a **name**, i.e. SCEPman. For supported account type choose **Accounts in this organizational directory only** and click register.

![](../../.gitbook/assets/2021-07-23-08\_49\_37-register-an-application-microsoft-azure-and-2-more-pages-c4a8-ehamed-micro.png)

5\. You may copy the **Application (client) ID** now. The ID is important and will be needed later by SCEPman deployment.

![](../../.gitbook/assets/2021-07-23-08\_50\_59-scepmanreg-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-edge.png)

## Generate Secret (get Client Secret Value)

1\. Stay within **App registrations** and click on **Certificates & secrets**

![](../../.gitbook/assets/2021-07-23-08\_52\_08-scepmanreg-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-edge.png)

2\. Click **New client secret**, add a description and choose the expiration. We recommend **24 months**, this helps to provide an ongoing service for two years. You can revoke a secret at any time. Click **Add**

![](../../.gitbook/assets/2021-07-23-09\_06\_11-azure-app-registration-scepman-docs-and-1-more-page-work-microsoft-edge.png)

3\. **Copy the secret value** and copy it down in a secure place.

{% hint style="warning" %}
Please do not mix it up with the "Client Secret **ID**". We need the "Client Secret **Value**", here.
{% endhint %}

{% hint style="warning" %}
Copy the client secret value \*\*\*\* immediately. You will not be able to retrieve it after you leave this submenu.
{% endhint %}

![](<../.gitbook/assets/image (1).png>)

## Configure Permissions

Stay within **App Registrations** and click on **API permissions**

{% hint style="warning" %}
1. **Remove** the default **User Read** permission
{% endhint %}

![](<../../.gitbook/assets/screenshot-2020-02-03-at-10.54.48 (1) (1).png>)

2\. Click on **Add a permission** and choose **Microsoft Graph**. When chosen, select **Application permissions** and search for directory. Add **Directory.ReadAll** as permission.

![](<../../.gitbook/assets/app-permission-graph (1).png>)

![](<../../.gitbook/assets/app-permission-directory-read (1) (1) (1) (1).png>)

3\. Now click on **Add a permission** and choose **Intune**. When chosen, select **Application permissions** and search for scep. Add **scep\_challenge\_provider** as a permission

![](<../../.gitbook/assets/app-permission-intune (1) (1) (1).png>)

![](<../../.gitbook/assets/app-permission-scep (1).png>)

4\. Finally click on **Grant admin** consent and **confirm** the consent for the given app registration.

![](../../.gitbook/assets/app-registration-consent.png)

![](../../.gitbook/assets/app-registration-consent-confirm.png)

5\. After successfully granting the permissions you should see green status for each permission.

![](../../.gitbook/assets/2021-07-23-09\_29\_34-scepmanreg-microsoft-azure-and-2-more-pages-c4a8-ehamed-microsoft-edge.png)

The app registration is done.

| [Back to Trial Guide](../scepman-deployment/trial-guide.md#step-1-azure-app-registration) | [Back to Community Guide](../scepman-deployment/community-guide.md#step-1-azure-app-registration) | [Back to Enterprise Guide](../scepman-deployment/enterprise-guide.md#step-1-azure-app-registration) |
| ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
