# Update Strategy

## Evergreen Approach

We recommend an Evergreen approach for our SCEPman solution. That means that you should use the latest version from our production channel. Through the possibilities of the ZIP-Deployment you can point directly to our GitHub and load the latest version that is released by our development team.

How to do that is mentioned in this article:&#x20;

{% content-ref url="application-artifacts.md" %}
[application-artifacts.md](application-artifacts.md)
{% endcontent-ref %}

With this approach you always get the newest features and security updates.

{% hint style="info" %}
Keep in mind that **an update only occurs, when the App Service is stopped and started again**. This is the event when the ZIP-Deployment is triggered. The App Service does not stop and start automatically in case new application artifacts are available, so **you have to perform it manually**.
{% endhint %}

In a production enterprise environment, if you want to have more control over the update process you can use the Microsoft feature **Deployment Slots**.

## Deployment Slot Configuration

In case you want to have full control over the update process of SCEPman you can use the **Deployment Slots** within the Azure App Service.

{% hint style="success" %}
To get more details about the **Deployment Slots** you can visit the Microsoft docs: \
[https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots](https://docs.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
{% endhint %}

The following steps give you our recommended setup for a pre-release management

{% hint style="info" %}
Please keep in mind that each Deployment Slot is running on the same App Service Plan of your production App and uses the same resources.
{% endhint %}

### pre-release slot

The idea behind the pre-release slot is to have your production App Service running with artifacts stored on your own Storage account and create a new Deployment Slot pointing to our GitHub artifacts. You can find the steps for setting up your custom artifact location in the following article:&#x20;

{% content-ref url="application-artifacts.md" %}
[application-artifacts.md](application-artifacts.md)
{% endcontent-ref %}

Now your production App Service is running with a custom artifacts location and we proceed with the configuration of the new Deployment Slot.

{% hint style="info" %}
Deployment Slot requirements **** (via PS. SCEPman Module):

* SCEPman **2.2** or above
* PS. SCEPman-Module **1.5.1.0** or above&#x20;
{% endhint %}

The following CMDlet command will create a Deployment Slot and configure all required permissions for you.

```
New-SCEPmanDeploymentSlot -SCEPmanAppServiceName <Your SCEPman App Service Name> -DeploymentSlotName <Name For The Deploymentslot> 6>&1
```

**Example**

![](<../.gitbook/assets/2022-06-13 17\_36\_44-DeploymentSlotCommand.png>)

After the deployment is finished successfully, you can check the deployment slot in your SCEPman App Service -> **Deployment slots**

![](<../.gitbook/assets/2022-06-13 11\_53\_59-DeploymentSlot.png>)

Now ensure that your deployment slot points to SCEPman **** Production channel on GitHub:

Navigate to the **Deployment Slot** -> **Configuration** and look for the setting **WEBSITE\_RUN\_FROM\_PACKAGE** and past the [production channel artifacts](application-artifacts.md#production) to the value.

![](<../.gitbook/assets/2022-06-13 12\_01\_16-DeploymentSlotTest.png>)

If you go back to your primary **App Service** and navigate to **Deployment Slots y**ou can see your two slots and can manage the **Traffic %** to root the defined among of request to the new **pre-release** slot.\
Important that this traffic rooting is completely transparent for the application and handled by the App Service. We recommend setting the **Traffic %** to **20**. After that, you can compare the two slots in **Application Insights**. In case we are releasing an updated version to our GitHub, you only must restart the **pre-release** slot and after that, you can compare the two different versions in **Application Insights**. After one week or your choice of time, you can upload the new GitHub artifacts to your custom artifacts location and have updated the SCEPman solution.
