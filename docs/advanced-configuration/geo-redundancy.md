# Geo-Redundancy

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

This reference architecture shows how to run an Azure App Service application in multiple regions to achieve high availability.

{% hint style="info" %}
Geo-redundancy / high-availability is currently only available for (main) SCEPman App Service. Rationale: The users of Certificate Master are administrators with typically non-time-critical certificate workloads and knowledge of procedures to handle such scenarios.
{% endhint %}

## Architecture

![](<../.gitbook/assets/2022-06-23 12\_32\_59-GeoRedundancy.png>)

As illustrated above, the geo-redundant deployment leverages an Azure Traffic Manager profile, that routes (DNS-based) requests to the SCEPman CA to a pair of SCEPman instances that are deployed in different geolocations. The individual SCEPman instances communicate with the same KeyVault, Storage Account and AAD and thus share the same Root CA. Besides load-balancing traffic based on a set of routing algorithms that you can choose from, Traffic Manager also constantly probes both instances of SCEPman. In case an instance becomes unavailable, all traffic will automatically be routed to the available instance.

Microsoft discusses in [this article](https://docs.microsoft.com/en-us/azure/architecture/reference-architectures/app-service-web-app/multi-region) three different Geo-Redundancy strategies that can be used to manage this type of architecture. However, In our case, we will use the **Active/Active** approach. This means both regions are active, and requests are load-balanced between them. If one region becomes unavailable or has some latency for any reason, Traffic Manager will route the traffic to the second App Service.

## Workflow

* First, the SCEPman App Service will be cloned into another geolocation.
* Then, the Traffic Manager is configured and its Endpoints are added and connected to both SCEPman App Services.
* Then, the custom domains for both App Services are configured.
* Finally, the DNS CNAME record is configured, pointing your custom domain to the Traffic Manager.

### Clone App

To clone an App Service, first you need to create a new **App Service Plan** in a second geolocation, this is where the cloned App will be deployed. You can create it in the same SCEPman Resource group or in a new one. See screenshot below:

![Creation of a new App Service Plan with Windows](<../.gitbook/assets/2022-06-15 13\_29\_57-Create App Service Plan.png>)

{% hint style="info" %}
App Service Clone requirements (via [SCEPman PowerShell Module](../scepman-deployment/permissions/post-installation-config.md#acquire-and-run-the-scepman-installation-powershell-module)):

* SCEPman **2.2** or above
* SCEPman PowerShell Module **1.6.3.0** or above
* Global Admin permissions
{% endhint %}

The following CMDlet command will clone your SCEPman App Service and configure all required permissions:

```
New-SCEPmanClone -SourceAppServiceName <Your SCEPman App Service Name> -TargetAppServiceName <Your cloned App Service Name> -TargetAppServicePlan <Your second App Service Plan in the second Geo Location> -SearchAllSubscriptions 6>&1
```

* **SourceAppServiceName:** The name of the existing SCEPman App Service.
* **TargetAppServiceName:** The name of the newly cloned SCEPman App Service.
* **TargetAppServicePlan:** The name of the App Service Plan for the cloned SCEPman instance. The App Service Plan must exist already in the TargetResourceGroup.
* **SourceResourceGroup:** (Optional) The Azure resource group hosting the existing SCEPman App Service. Leave empty for auto-detection.
* **TargetResourceGroup:** (Optional) The Azure resource group hosting the new SCEPman App Service. Leave empty to auto-detect the resource group of the App Service Plan.
* **SourceSubscriptionId:** (Optional) The ID of the Subscription where SCEPman is installed. Can be omitted if it is pre-selected in az already or use the SearchAllSubscriptions flag to search all accessible subscriptions
* **TargetSubscriptionId:** (Optional) The ID of the Subscription where SCEPman shall be installed. Can be omitted if it is the same as SourceSubscriptionId.
* **SearchAllSubscriptions:** (Optional) Set this flag to search all subscriptions for the SCEPman App Service. Otherwise, pre-select the right subscription in az or pass in the correct SubscriptionId.

### **Example**

Clone an existing SCEPman App Service "as-scepman-nrg5reuov63vk"

```
New-SCEPmanClone -SourceAppServiceName as-scepman-nrg5reuov63vk -TargetAppServiceName as-scepman-clone -TargetAppServicePlan asp-scepman-geo2 -SearchAllSubscriptions 6>&1
```

![](<../.gitbook/assets/2022-06-15 14\_29\_28-SCEPmanCloneApp.png>)

After the deployment has finished successfully, navigate to the cloned App Service and check the SCEPman homepage that all permissions are set correctly and everything is green and connected (this could take up to 3 minutes after the deployment is done).

![](<../.gitbook/assets/2022-06-21 10\_32\_37.png>)

{% hint style="info" %}
To avoid a single point of failure, we recommend setting the [WEBSITE\_RUN\_FROM\_PACKAGE](application-artifacts.md) of the cloned App Service to the second independent artifact host on Azure.

Production channel:

`https://install.scepman.com/dist/Artifacts.zip`

The original App Service should have the first artifact host by default, which points to a GitHub repository. For more information please check [Application Artifacts](application-artifacts.md).
{% endhint %}

{% hint style="warning" %}
Cloning an App Service has some restrictions such as **autoscale** settings, **backup schedule** settings, **App Insights**, etc.. Configurations that cannot be cloned, must be manually configured again on the cloned App Service. Additionally, changes to the settings of one AppService will not be synchronized automatically to the second App Service if performed after the cloning operation. For more info visit [https://docs.microsoft.com/en-us/azure/app-service/app-service-web-app-cloning#current-restrictions](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-app-cloning#current-restrictions)
{% endhint %}

### Setup Traffic Manager

Follow the steps below to create and configure the Traffic Manager and balance the traffic between both SCEPman instances:

1. Search in the Marketplace for **Traffic Manager profile** and click **Create**.
2. Fill in the fields and choose your SCEPman resource group

![](<../.gitbook/assets/scepman\_trafficmanager1 (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (2) (6) (7) (5) (7).png>)

1. Then click **Create**.
2. After your Traffic Manager is deployed, open it and click on **Configuration**
3. Change the settings as follows and save

![Traffic Manager Configuration](../.gitbook/assets/ReplaceTrafficManagerSS.png)

#### Adding Endpoints

#### First Endpoint

1. Then under **Settings** choose **Endpoints**
2. Choose "Azure Endpoint" as **Type**, provide a name for the first Endpoint, and "App Service" as **Target resource type**
3. Choose your primary SCEPman App Service as **Target resource**

![Traffic Manager, Endpoint Configuration](<../.gitbook/assets/scepman\_trafficmanager3 (1).png>)

#### Second Endpoint

Repeat the same steps for the second endpoint and choose the second (cloned) SCEPman App Service as a **Target resource**

### Custom Domain Configuration

After a successful deployment and configuration of the Traffic Manager Endpoints, you need to set up the **same** custom domain for **both** SCEPman instances as described [here](custom-domain.md).

Make sure to change the value of the setting **AppConfig:BaseUrl** for **both** SCEPman App Services after the custom domains have been created.

### DNS Configuration

In the Traffic Manager **Overview,** you will find the DNS name, that needs to be added to your DNS

![Traffic Manager Overview](<../.gitbook/assets/scepman\_trafficmanager4 (7).png>)

* Navigate to your DNS management service (e.g. **Azure DNS Zones**)
* Remove any possibly existing wrong CNAME entries pointing to one of the Azure App Service instances and add a CNAME that maps the created SCEPman custom domain to the Traffic Manager DNS name. In the example below the CNAME should point to **gk-blueprint-scepman.trafficmanager.net**.

{% hint style="info" %}
In **Azure DNS Zone**, in order to modify a record, you first have to remove the DNS lock by navigating to **Locks**.
{% endhint %}

{% hint style="info" %}
Upon completing the configuration, ensure to update the SCEP Server URL in your SCEP profile(s) in Intune. The new URL should be the custom domain you've created with "/certsrv/mscep/mscep.dll" at the end.

Example: [https://scepman.contoso.com/certsrv/mscep/mscep.dll](https://scepman.contoso.com/certsrv/mscep/mscep.dll)
{% endhint %}

### Storage Account Geo-Redundancy

The Storage Account used for SCEPman should also be configured for redundancy. The default SCEPman setup uses Locally Redundant Storage (LRS), which uses only a single region. For example, configure Geo-redundant storage (GRS).

![Storage account redundancy dialog on Azure Portal](<../.gitbook/assets/storage-account-redundancy (1).png>)
