# Enterprise Guide

This will guide you through all steps to get a recommended Enterprise \(SCEPman EE\) production environment.

{% hint style="info" %}
If you want to make a test deployment or want to use the Community Edition \(SCEPman CE\) please follow this Guide: [Test and Community Guide](community-guide.md)
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
Please follow this setup instructions: [Azure App Registration](../documentation/setup/01_azure_app_registration.md)

### Step 2: Deploy SCEPman base services

To start with the deployment, you need to follow our Setup instruction: [Enterprise deployment](../documentation/setup/deployment-options/enterprise-deployment.md)

### Step 3: Configure a Custom Domain and SSL certificate

To have your SCEPman available under your specific domain you need to create a **Custom Domain** in the **App Service.** Follow this instruction to configure the Custom Domain and SSL certificate configuration: [Custom Domain](../documentation/setup/03_customdomain.md)

### Step 4: Deploy Storage Account and change Artifacts

The next step is to configure the Storage account and change the Artifact location in your App Service.  
Follow this instruction to do this: [Application Artifacts](../documentation/setup/optional/application-artifacts.md)

{% hint style="info" %}
Not worth to mention, but we recommend the production channel.
{% endhint %}

### Step 5: Configure Log collection

You can configure two different logging parts in your App Service. The one part is the **App Service Logs**, which will save all application and IIS server-based log data. The other part is the Diagnostic 

To retain your log files for later use or support purpose you can configure the **App Service Logs**.  
Follow this instruction to do this: [Log configuration](../documentation/setup/optional/app-service-logging.md#app-service-logs)

{% hint style="info" %}
Use the storage account we created in **Step 4** and create two new blob containers. This blob containers can be selected in the **App Service Logs** instructions.
{% endhint %}

### Step 6: Configure Diagnostic settings

To log all diagnostic logs \(\) from your App Service you can configure the Diagnostic settings.  
Follow this instruction to do this: [Log configuration](../documentation/setup/optional/app-service-logging.md#diagnostic-settings)

### Step 7: Deploy Application Insights







### 

