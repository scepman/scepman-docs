# Standard Guide

This will guide you through all steps necessary to set up SCEPman in your PoC or Production environment based on our best practices.

## Azure Deployment

Let's start with the requirements and a resource overview.\
Keep in mind that you need to plan a useful Azure resource design.

### Checklist pre-requirements

* [ ] _Mandatory -_ Azure subscription (at least Contributor rights on that subscription)
* [ ] _Mandatory -_ Azure owner rights (at least on Resource Group level)
* [ ] _Mandatory -_ Microsoft Entra ID (Azure AD) "Global administrator" (Consent to access Graph API)
* [ ] _Mandatory_ - Make sure to define your Azure policies [according to SCEPman requirements](../../other/faqs/security-faq.md#azure-cis) (e.g. do not enforce TLS)
* [ ] _Optional_ - Public Domain CNAME (_scepman.yourdomain.com_)
* [ ] _Optional_ - SSL (Wildcard-) Certificate (or use [App Service Managed Certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview))

### Overview Azure Resource

All these resources are recommended for a production environment.

| Type                    | Description                                                                                                                                                                                                                                                                                                    |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| App Service(s)          | <p>A virtual Azure environment to run the SCEPman Core and Cert Master applications and provides a UI to configure different<br>application specific settings like CNAME, SSL certificate and App Settings.</p>                                                                                                |
| App Service Plan        | <p>A virtual set of compute resources and configurations for the "App Service(s)".</p><p>Here you can configure the pricing tier and resource scaling.</p>                                                                                                                                                     |
| Key Vault               | <p>Tool to securely store secrets and certificates. The SCEPman application</p><p>will generate and save the root certificate in your Key Vault.</p>                                                                                                                                                           |
| Application Insights    | <p>Application Performance Management (APM) tool to get insights of the</p><p>SCEPman applications and requests. Needed to measure performance</p><p>and good for service optimization.</p>                                                                                                                    |
| Storage account         | <p>Storage platform used by SCEPman's Certificate Master component to store certain attributes of the manually issued TLS server certificates for revocation purposes.<br><br><em>Optional:</em></p><p>The "App Service" will load the artifacts from a blob storage URI if manual updates are configured.</p> |
| Log Analytics workspace | <p>A centralized and cloud-based log storage. The "App Service" will save all</p><p>platform logs and metrics into this workspace.</p>                                                                                                                                                                         |

{% hint style="warning" %}

{% endhint %}

## Configuration Steps

### Step 1: Deploy SCEPman Base Services

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To start with the deployment, please follow our deployment instructions:

{% content-ref url="../deployment-options/marketplace-deployment.md" %}
[marketplace-deployment.md](../deployment-options/marketplace-deployment.md)
{% endcontent-ref %}

### Step 2: Perform Post-Deployment Steps (Permission Assignments)

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To properly link all components of SCEPman 2.X, several permissions need to be assigned. Please follow these steps to establish the relevant connections:

{% content-ref url="../permissions/post-installation-config.md" %}
[post-installation-config.md](../permissions/post-installation-config.md)
{% endcontent-ref %}

### Step 3: Create Root certificate

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

After the deployment and persmission assignment is complete, you need to create the root certificate for SCEPman:

{% content-ref url="../first-run-root-cert.md" %}
[first-run-root-cert.md](../first-run-root-cert.md)
{% endcontent-ref %}

### Step 4: Configure a Custom Domain and SSL Certificate

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

To have your SCEPman available under your specific domain you need to create a **Custom Domain** in the **App Service.**

{% content-ref url="../../advanced-configuration/custom-domain.md" %}
[custom-domain.md](../../advanced-configuration/custom-domain.md)
{% endcontent-ref %}

### Step 5: Manual Updates

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

By default, SCEPman's update strategy is configured to the [Evergreen approach](../../advanced-configuration/update-strategy.md#evergreen-approach) / auto-updates. In case you require full control over your SCEPman updates, please configure a deployment slot as described in the following guide under section **Deployment Slot Configuration**.

{% content-ref url="../../advanced-configuration/update-strategy.md" %}
[update-strategy.md](../../advanced-configuration/update-strategy.md)
{% endcontent-ref %}

### Step 6: Deploy Application Insights

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

The Application Insights can be used to get an overview of the App Service performance and to get deeper insights of the request processing of SCEPman. We recommend to always configure Application Insights to monitor, maintain and optimize the App Service.

{% content-ref url="../../advanced-configuration/application-insights.md" %}
[application-insights.md](../../advanced-configuration/application-insights.md)
{% endcontent-ref %}

### Step 7: Configure Health Check

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

We can configure a Health Check for the App Service to get direct notifications in case that the SCEPman stops working.

{% content-ref url="../../advanced-configuration/health-check.md" %}
[health-check.md](../../advanced-configuration/health-check.md)
{% endcontent-ref %}

### Step 8: Configure your MDM Deployment Profiles

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

With the completion of the above steps, we have a working SCEPman implementation and can now deploy certificates to the devices.

Please use one (or more) of the following articles, to deploy certificates with your preferred MDM solution:

{% content-ref url="../../certificate-deployment/microsoft-intune/" %}
[microsoft-intune](../../certificate-deployment/microsoft-intune/)
{% endcontent-ref %}

{% content-ref url="../../certificate-deployment/jamf/" %}
[jamf](../../certificate-deployment/jamf/)
{% endcontent-ref %}

### Step 9: Issue TLS Server Certificates or sign CSRs using Cert Master

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

Please follow below link, to learn how to issue TLS server certificates based on a list of FQDNs or sign any CSR using the Cert Master component.

{% content-ref url="../../certificate-deployment/certificate-master/" %}
[certificate-master](../../certificate-deployment/certificate-master/)
{% endcontent-ref %}
