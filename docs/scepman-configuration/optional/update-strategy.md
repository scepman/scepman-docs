# Update Strategy

## Evergreen approach

We recommend an Evergreen approach for our SCEPman solution. That means that you should use the latest version from our production channel. Through the possibilities of the ZIP-Deployment you can point directly to our GitHub and load the latest version that is released by our development team.

How to do that is mentioned in this article: 

{% page-ref page="application-artifacts.md" %}

With this approach you always get the newest features and security updates.

{% hint style="info" %}
Keep in mind that **an update only occurs, when the App Service is stopped and started again**. This is the event when the ZIP-Deployment is triggered. The App Service does not stop and start automatically in case new application artifacts are available, so **you have to perform it manually**.
{% endhint %}

In a production enterprise environment, you want to have more control about the update process and for this we can use the Microsoft feature **Deployment Slots**.

## Deployment Slot configuration

In case that you want to have full control about the update process of SCEPman you can use the **Deployment Slots** within the Azure App Service.

{% hint style="success" %}
To get more details about the **Deployment Slots** you can visit the Microsoft docs:   
[https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
{% endhint %}

The following steps gives you our recommended setup for a pre-release management

{% hint style="info" %}
Please keep in mind that each deployment Slot running on the same App Service Plan of your production App and use the same resources.
{% endhint %}

### pre-release slot

The idea behind the pre-release slot is to have your production App Service running with artifacts stored on your own Storage account and creating a new Deployment Slot pointing to our GitHub artifacts. You can find the steps for setting up your custom artifact's location in the following article: 

{% page-ref page="application-artifacts.md" %}

Now your production App Service is running with a custom artifacts location and we proceed with the configuration of the new Deployment Slot.

1. In your **App Service** navigate to **Deployment Slots**
2. You can see your current slot marked as **PRODUCTION** with the status **Running**, this is your primary App slot

![](../../.gitbook/assets/screen-shot-2021-01-25-at-17.35.39.png)

3. With the button **Add Slot** you get a new wizard to enter a **Name** and choose which existing slot you want to **clone settings from**

![](../../.gitbook/assets/screen-shot-2021-01-25-at-17.38.38.png)

4. Then click on **Add** and wait until you geht the message that the slot is created successfully and **Close** the wizard  
5. navigate to **Identity** in your SCEPman **App Service** and  and turn it **on**, then **Save**  
6. Go to the **Key Vault** of your SCEPman instance, navigate to **Access polices** and add a new **Access Policy** for the new pre-release slot you deployed \(your cloned instance\). 

![](../../.gitbook/assets/2021-07-09-15_57_46-gkscep02-keyvault-microsoft-azure-and-4-more-pages-c4a8-ehamed-microsoft-.png)

Now add for **Key, Secret and Certificate permissions** all permissions except the **Privileged Certificate Operations** "**Purge"** let it unchecked like in the picture:

![](../../.gitbook/assets/2021-07-09-15_59_46-add-access-policy-microsoft-azure-and-4-more-pages-c4a8-ehamed-microsoft-.png)

**Select principal**: by default it has the same name of the original instance with **/slots/Pre-release** at the end , **Select** it, **Add** and **Save**  
7. Now you can see the new **Deployment Slot** that is in status **Running** but have a **Traffic %** of zero  
8. You can now click on the **NAME** of your new deployment Slot \(Hyperlink\) to jump directly to the App Service settings of this slot

![](../../.gitbook/assets/screen-shot-2021-01-25-at-17.41.23.png)

9. Ensure that you are on your new Deployment Slot and following the steps described in **Application Artifacts** under **Change Artifacts** to point the **WEBSITE\_RUN\_FROM\_PACKAGE** to the GitHub of SCEPman

![](../../.gitbook/assets/screen-shot-2021-01-25-at-17.42.45.png)

{% page-ref page="application-artifacts.md" %}

10. If you now go back to your primary **App Service** and navigate to **Deployment Slots**  
11. You can see your two slots and can manage the **Traffic %** to root the defined among of request to the new **pre-release** slot.  
Important that this traffic rooting is completely transparent for the application and handled by the App Service. We recommend setting the **Traffic %** to **20**. After that, you can compare the two slots in **Application Insights**. In case that we are releasing an updated version to our GitHub, you only must restart the **pre-release** slot and after that you can compare the two different versions in **Application Insights**. After one week or your choice of time, you can upload the new GitHub artifacts to your custom artifacts location and have updated the SCEPman solution.

| Back to Trial Guide | Back to Community Guide | ​Back to Enterprise Guide​ |
| :--- | :--- | :--- |


