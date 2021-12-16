# Application Artifacts

## Available Channels

We offer three channels for our SCEPman application.

### Production

* full released version
* function and load-tested
* bugs not expected

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts.zip
```

### Beta

* next production release
* function tested, but no load-test
* bugs possible

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Beta.zip
```

### Intern

* ongoing development
* limited function tested and no load-test
* bugs expected

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Intern.zip
```

## Custom Artifact location

To have full control about the update process and what artifacts loaded by your App Service you can deploy your own Azure Storage Account.

Follow this instruction to create a storage account:

1\. Start at your **Resource group** where you have deployed SCEPman and click **+ Add**

2\. Search for **storage account** in the Marketplace search bar and click on **Storage account - blob, file, table, queue**

3\. Your Subscription and resource group are pre-selected and you can start with defining **Storage account name, Location Performance, Account kind, Replication and Access tier** (Use settings as shown in the screenshot)

![](../../.gitbook/assets/image.png)

4\. Go to the **Advanced** tab and set the **Blob public access** to **Enabled**

5\. Click on **Review + create** and then on **Create**

6\. After the successful creation of your storage account you can open the Storage account overview and open the **Storage Explorer (preview)**

7\. In the **Storage Explorer (preview)** you can right click on the **BLOB CONTAINERS** and select **Create blob container.** Specify a **Name** and set the **Public access level** to **Blob.** After this you can click on **Create**

![](../../.gitbook/assets/screenshot-2020-07-09-at-17.20.42.png)

8\. You need to reload the **Storage Explorer (Preview)** and then you can see your container under **BLOB CONTAINERS**. Now you can download the Artifacts from our GitHub (See [Application Artifacts](application-artifacts.md#available-channels)) and upload the artifacts here.

9\. After the successful upload you can select your blob and click on **Copy URL.** You need this URL in the Part **Change Artifacts (**[**Application Artifacts**](application-artifacts.md#change-artifacts)**)**

## Change Artifacts

To get continuous updates for SCEPman you can point a configuration variable to the [maintained GitHub repository](https://github.com/scepman/install) of SCEPman. During every restart, the Azure Web App will do a check and a copy deployment if necessary.

{% hint style="info" %}
If you want to have more control over the updates you can use your own location.\
(See [Application Resources](application-artifacts.md#custom-artifact-location))
{% endhint %}

To configure this, do the following:

1. Go to your Azure AD
2. Navigate to **App Service**
3. Choose your SCEPman app
4. Then, click **Configuration** (submenu **Setting**)
5. Look for **WEBSITE\_RUN\_FROM\_PACKAGE** and click on it

![](<../../.gitbook/assets/scepman\_optional2 (3) (3) (3) (3) (3) (3) (3) (2) (4).png>)

6\. Then replace the URL in \*\*Value \*\*with the SCEPman GitHub URL or your Storage account blob URL you already copied:

![](<../../.gitbook/assets/2021-10-08 16\_40\_54-Scepman02testServiceName - Microsoft Azure and 10 more pages - C4A8 EHamed - Mic.png>)

| Back to Trial Guide | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-5-deploy-storage-account-and-change-artifacts) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-5-deploy-storage-account-and-change-artifacts) |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
