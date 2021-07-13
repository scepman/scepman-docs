---
category: Deployment (Optional)
title: Load Balancer Deployment
order: 2
---

# Geo-redundancy

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

## Geo-redundant Deployment \(optional\)

This section describes a high availability architecture for production use.

![](../../.gitbook/assets/scepman_loadbalancer1%20%287%29%20%285%29.png)

## Clone App

After successful deployment of SCEPman, Set up a custom domain for this SCEPman instance as described [here](custom-domain.md).

Now you can set up a load balancer for higher availability. Start cloning the app:

* Navigate to **App Service.** 
* Scroll down to **Development Tools** and click **Clone App.** 
* Fill in the required fields as following:

1. **App name:** name for the cloned instance
2. **Resource Group:** create a new Resource Group for the cloned instance of SCEPman
3. **App Service plan/Location:** 

![](../../.gitbook/assets/2021-07-07-10_22_28-scepman02testservicename-microsoft-azure-and-3-more-pages-c4a8-ehamed-micr.png)

4. Click **App Service plan/Location**

1. Then click **Create new** to create a new service plan.
2. Enter a **App Service plan** and select a **Location** \(different of the first app location\) and a **Pricing tier.**

![](../../.gitbook/assets/scepman_cloneapp3%20%287%29%20%287%29.png)

5. Click **OK**  
6. Do not change the **Clone Settings**  
7. Finally click **Create**

Next, you need a managed identity for the cloned app:  
  
1. Go to your cloned web app and click on **Identity**

![](../../.gitbook/assets/scepman_identity1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%284%29.png)

2. Under System assigned switch the **Status** to **On**

![](../../.gitbook/assets/scepman_identity2%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%283%29%20%286%29.png)

3. Click **Save**  
4. This will register your web app into Azure AD

Your **Identity** should look like this:

![](../../.gitbook/assets/scepman_identity3%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%284%29%20%286%29.png)

## Setup Azure Key Vault Access Policy

1. Go to your **Key Vault**  
2. Click on **Access polices, Add new**

![](../../.gitbook/assets/scepman_keyvault1%20%287%29%20%285%29.png)

3. Then click on **Add Access policy,** to add permissions to your new cloned SCEPman instance.

![](../../.gitbook/assets/2021-07-09-15_57_46-gkscep02-keyvault-microsoft-azure-and-4-more-pages-c4a8-ehamed-microsoft-.png)

4. Now add for **Key, Secret and Certificate permissions** all permissions except the **Privileged Certificate Operations** "**Purge"** leave it unchecked, your access policy should look like this:

![](../../.gitbook/assets/scepman_keyvault3%20%287%29%20%284%29.png)

5. now **Select principal**: select the new cloned instance of SCEPman, **Add** and **Save**

![](../../.gitbook/assets/scepman_keyvault2%20%287%29%20%283%29.png)

## Setup Traffic Manager

1. Search **Traffic Manager profile** and click **Create.** 
2. Fill in the fields.

![](../../.gitbook/assets/scepman_trafficmanager1%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%286%29.png)

1. Then click **Create**.
2. After your Traffic Manager is deployed, go to it and click **Configuration** under settings.
3. Change the settings as follows:

![](../../.gitbook/assets/scepman_trafficmanager2%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%282%29%20%286%29%20%282%29.png)

1. Save changes.
2. Then under **Settings** choose **Endpoints**
3. Click **Add** and choose the primary web service.

![](../../.gitbook/assets/scepman_trafficmanager3.png)

Repeat these steps for your second web service.

In the **Overview** your Traffic Manager should like this \(here you find the Traffic Manager URL\):

![](../../.gitbook/assets/scepman_trafficmanager4%20%286%29.png)

* Navigate to your **AppService** for the cloned SCEPman instance
* Under **Custom Domains**, repeat the SSL certificate binding process as described [here](https://docs.scepman.com/scepman-configuration/optional/custom-domain#SSL-Binding)
* Both instances of SCEPman must have the same custom domain
* Navigate to your DNS management service \(e.g. **Azure DNS Zones**\)
* There shall be a CNAME entry for the custom SCEPman domain that maps to the Traffic Manager endpoint. This entry may exist already if you are using Azure DNS and Traffic Manager created the entry for you. If it does not exist, remove any possibly existing wrong CNAME entry and add a CNAME that maps the custom SCEPman domain to the Traffic Manager endpoint now.

{% hint style="info" %}
In **Azure DNS Zone**, in order to modify record, you first have to remove the DNS lock by navigating to **Locks**.
{% endhint %}

| Back to Trial Guide | Back to Community Guide | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-10-configure-geo-redundancy-optional) |
| :--- | :--- | :--- |


