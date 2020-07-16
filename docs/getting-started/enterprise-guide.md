# Enterprise Guide

This will guide you through all steps to get a recommended Enterprise \(SCEPman EE\) production environment.

{% hint style="info" %}
If you want to deploy a trial environment, please follow the [Trial Guide](trial-guide.md)
{% endhint %}

{% hint style="info" %}
If you want to deploy a production community environment \(SCEPman CE\), please follow the [Community Guide](community-guide.md)
{% endhint %}

## Azure Deployment

Let´s start with the requirements and a resource overview.  
Keep in mind that you need to plan a useful Azure resource design.

### Checklist pre-requirements

* [ ] Azure resource naming convention
* [ ] Azure subscription
* [ ] Azure contributor rights \(at least on Resource Group level\)
* [ ] Azure AD "Global administrator" \(Consent to access Graph API\)
* [ ] Public Domain CNAME \("scepman.yourdomain.com"\)
* [ ] SSL \(Wildcard-\)Certificate \(or use [App Service Managed Certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)\)

### Overview Azure Resource

All these resources are recommended but not needed for a production environment.

<table>
  <thead>
    <tr>
      <th style="text-align:left">Type</th>
      <th style="text-align:left">Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left">App Service</td>
      <td style="text-align:left">The running SCEPman application and provides a UI to configure different
        <br
        />application specific settings like CNAME, SSL certificate and App Settings.</td>
    </tr>
    <tr>
      <td style="text-align:left">App Service Plan</td>
      <td style="text-align:left">
        <p>A virtual set of compute resources and configurations for the &quot;App
          Service&quot;.</p>
        <p>Here you can configure the pricing tier and resource scaling.</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">Key Vault</td>
      <td style="text-align:left">
        <p>Tool to store securely secrets and certificates. The SCEPman application</p>
        <p>will generate and save the root certificate in your Key Vault.</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">Application Insights</td>
      <td style="text-align:left">
        <p>Application Performance Management (APM) tool to get insights of the</p>
        <p>SCEPman applications and requests. Needed to measure performance</p>
        <p>and good for service optimization.</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">Storage account</td>
      <td style="text-align:left">
        <p>Storage platform to upload the SCEPman artifacts and save log files.</p>
        <p>The &quot;App Service&quot; will load the artifacts from a public blob
          store URI and</p>
        <p>save all the application and web server logs in a blob container.</p>
      </td>
    </tr>
    <tr>
      <td style="text-align:left">Log Analytics workspace</td>
      <td style="text-align:left">
        <p>A centralized and cloud-based log storage. The &quot;App Service&quot;
          will save all</p>
        <p>platform logs and metrics into this workspace.</p>
      </td>
    </tr>
  </tbody>
</table>

## Configuration Steps

### Step 1: Azure App Registration

Before we can start the resource deployment, we need to create an "Azure App Registration".

{% page-ref page="../scepman-configuration/azure-app-registration.md" %}

### Step 2: Deploy SCEPman base services

To start with the deployment, you need to follow our Setup instruction:

{% page-ref page="../scepman-configuration/deployment-options/enterprise-deployment.md" %}

### Step 3: Configure a Custom Domain and SSL certificate

To have your SCEPman available under your specific domain you need to create a **Custom Domain** in the **App Service.**

{% page-ref page="../scepman-configuration/custom-domain.md" %}

### Step 4: Deploy Storage Account and change Artifacts

The next step is to configure the Storage account and change the Artifact location in your App Service.

{% page-ref page="../scepman-configuration/optional/application-artifacts.md" %}

{% hint style="info" %}
Not worth to mention, but we recommend the production channel.
{% endhint %}

### Step 5: Configure Log collection

You can configure two different logging parts in your App Service, to retain your log data. The one part is the **App Service Logs**, which will save all application and IIS server-based log data. The other part is the **Diagnostic settings**, this contains platform logs and metrics data.

{% page-ref page="../scepman-configuration/optional/log-configuration.md" %}

{% hint style="info" %}
Use the storage account we created in **Step 4** and create two new blob containers. This blob containers can be selected in the **App Service Logs** instructions. In the **Diagnostic settings** you can directly choose the storage account and blob containers will be created automatically.
{% endhint %}

### Step 6: Deploy Application Insights

The Application Insights can be used to get an overview of the App Service performance and to get deeper insights of the request processing of SCEPman. We recommend to always configure Application Insights to monitor, maintain and optimize the App Service.

{% page-ref page="../scepman-configuration/optional/application-insights.md" %}

### Step 7: Configure Autoscaling

The SCEPman solution has two different tasks and performance requirements.  
One task is the certificate issuance process: After the configuration of the SCEPman solution we need to deploy certificates to all devices \(user and/or device certificates\), but this is a one-time-task and after the initial deployment this only happens when a new device is enrolled or the certificates needs to be renewed. In those situations, the SCEPman will face a peek of SCEP requests.  
The second task is the certificate validation: After we deployed certificates to devices, those certificates needs to be validated each time we use them. For every certificated-based authentication the clients, gateways or RADIUS system \(depends on what you use\) will send an OCSP request to the SCEPman App Service. This will cause a permanent request load on the App Service.

To have an optimized performance and take care of the costs we recommend to setup the Autoscaling functionality of the App Service. With this feature your application can scale-out and scale-in based on metrics.

{% page-ref page="../scepman-configuration/optional/autoscaling.md" %}

### Step 8: Configure Geo-redundancy \(Optional\)

Coming soon!



### 

