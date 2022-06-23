# Geo-redundancy

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

This reference architecture shows how to run an Azure App Service application in multiple regions to achieve high availability.

## Architecture

![](<../../.gitbook/assets/2022-06-23 12\_32\_59-GeoRedundancy.png>)

As you can see in this diagram it will utilize an Azure Traffic Manager instance globally, and then we have duplicated SCEPman App Service for each region, which are communicating with the existing Key Vault, Storage Account and AAD of the main SCEPman instance deployment.

Microsoft discusses in [this article](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/app-service-web-app/multi-region) three different Geo-Redundancy strategies that can be used to manage this type of architecture. However, In our case we will use the **Active/Active** approach. This means both regions are active, and requests are load-balanced between them. If one region becomes unavailable or has some latency for any reason, Traffic Manager will route the traffic to the second App Service.

## Workflow

* First we will start with cloning the App Service
* Then configuring the custom domains for both App Services
* Finally create and configure the Traffic Manager and its Endpoints

### Clone App

To clone an App Service, first you need to create a new **App Service Plan** in a second Geo location, this is where the cloned App will be deployed. You can create it in the same SCEPman Resource group or in a new one. See screenshot below

![Creation of a new App Service Plan with Windows](<../../.gitbook/assets/2022-06-15 13\_29\_57-Create App Service Plan.png>)

{% hint style="info" %}
App Service Clone requirements (via [SCEPman PowerShell Module](../post-installation-config.md#acquire-and-run-the-scepman-installation-powershell-module)):

* SCEPman **2.2** or above
* SCEPman PowerShell Module **1.6.3.0** or above
* Global Admin permissions
{% endhint %}

The following CMDlet command will clone your SCEPman App Service and configure all required permissions

```
New-SCEPmanClone -SourceAppServiceName <Your SCEPman App Service Name> -TargetAppServiceName <Your cloned App Service Name> -TargetAppServicePlan <Your second App Service Plan in the second Geo Location> -SearchAllSubscriptions 6>&1
```

**SourceAppServiceName:** The name of the existing SCEPman App Service.

**TargetAppServiceName:** The name of the new cloned SCEPman App Service.

**TargetAppServicePlan:** The name of the App Service Plan for the cloned SCEPman instance. The App Service Plan must exist already in the TargetResourceGroup.

**SourceResourceGroup:** (Optional) The Azure resource group hosting the existing SCEPman App Service. Leave empty for auto-detection.

**TargetResourceGroup:** (Optional) The Azure resource group hosting the new SCEPman App Service. Leave empty to auto-detect the resource group of the App Service Plan.

**SourceSubscriptionId:** (Optional) The ID of the Subscription where SCEPman is installed. Can be omitted if it is pre-selected in az already or use the SearchAllSubscriptions flag to search all accessible subscriptions

**TargetSubscriptionId:** (Optional) The ID of the Subscription where SCEPman shall be installed. Can be omitted if it is the same as SourceSubscriptionId.

**SearchAllSubscriptions:** (Optional) Set this flag to search all subscriptions for the SCEPman App Service. Otherwise, pre-select the right subscription in az or pass in the correct SubscriptionId.

**Example**

Clone an existing SCEPman App Service "as-scepman-nrg5reuov63vk"

```
New-SCEPmanClone -SourceAppServiceName as-scepman-nrg5reuov63vk -TargetAppServiceName as-scepman-clone -TargetAppServicePlan asp-scepman-geo2 -SearchAllSubscriptions 6>&1
```

![](<../../.gitbook/assets/2022-06-15 14\_29\_28-SCEPmanCloneApp.png>)

After the deployment is finished successfully, navigate to the cloned app and check the SCEPman homepage that all permissions are set correctly and everything is green and connected (this could take \~ 3 minutes after the deployment is done).

![](<../../.gitbook/assets/2022-06-21 10\_32\_37.png>)

{% hint style="warning" %}
Cloning an app service has some restrictions such as **autoscale** settings, **backup schedule** settings, **App Insights, logging**, etc.. so you have to configure them again (if needed) for the new cloned app service. For more info visit [https://docs.microsoft.com/en-us/azure/app-service/app-service-web-app-cloning#current-restrictions](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-app-cloning#current-restrictions)
{% endhint %}

### Custom Domain configuration

After a successful deployment of the cloned SCEPman App Service, you need to set up a custom domain for this SCEPman instance as described [here](custom-domain.md).

### Setup Traffic Manager

Follow the steps below to create and configure the Traffic Manager and balance the traffic between both SCEPman instances:

1. Search **Traffic Manager profile** and click **Create**.
2. Fill in the fields.

![](<../../../.gitbook/assets/scepman\_trafficmanager1 (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (6) (7) (5) (1) (1) (1) (1) (1) (1) (1) (6).png>)

1. Then click **Create**.
2. After your Traffic Manager is deployed, go to it and click **Configuration** under settings.
3. Change the settings as follows:

![](../../.gitbook/assets/ReplaceTrafficManagerSS.png)

1. Save changes.
2. Then under **Settings** choose **Endpoints**
3. Click **Add** and choose the primary App Service.

![](<../../../.gitbook/assets/scepman\_trafficmanager3 (1).png>)

Repeat these steps for your second App Service.

In the **Overview** your Traffic Manager should like this (here you find the Traffic Manager URL):

![](<../../../.gitbook/assets/scepman\_trafficmanager4 (1) (1) (1) (1) (1) (1) (1) (6).png>)

* Navigate to your **App Service** for the cloned SCEPman instance
* Under **Custom Domains**, repeat the SSL certificate binding process as described [here](https://docs.scepman.com/scepman-configuration/optional/custom-domain#SSL-Binding)
* Both instances of SCEPman must have the same custom domain
* Navigate to your DNS management service (e.g. **Azure DNS Zones**)
* There shall be a CNAME entry for the custom SCEPman domain that maps to the Traffic Manager endpoint. This entry may exist already if you are using Azure DNS and Traffic Manager created the entry for you. If it does not exist, remove any possibly existing wrong CNAME entry and add a CNAME that maps the custom SCEPman domain to the Traffic Manager endpoint now.

{% hint style="info" %}
In **Azure DNS Zone**, in order to modify a record, you first have to remove the DNS lock by navigating to **Locks**.
{% endhint %}
