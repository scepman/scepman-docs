# Standard Guide

This will guide you through all steps necessary to set up SCEPman in your PoC or Production environment based on our best practices.

## Azure Deployment

Let's start with the requirements and a resource overview.\
Keep in mind that you need to plan a useful Azure resource design.

### Prerequisites

#### Mandatory

* [ ] Azure subscription (at least Contributor rights on that subscription).
* [ ] Azure owner rights (at least on Resource Group level).
* [ ] Microsoft Entra ID (Azure AD) "Global administrator" (Consent to access Graph API).
* [ ] Make sure to define your Azure policies [according to SCEPman requirements](../other/security-faq.md#azure-cis) (e.g. do not enforce TLS).

#### Optional

* [ ] Public Domain CNAME (scepman.yourdomain.com), if a custom domain is used.
* [ ] SSL (Wildcard-) Certificate (or use [App Service Managed Certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)), if a custom domain is used.

### Overview Azure Resource

All these resources are recommended for a production environment.

{% include "../.gitbook/includes/scepman-azure-resources.md" %}

Additionally, if you are using Private Endpoints, you have [seven more Azure Resources.](../azure-configuration/private-endpoints.md#azure-resources-used-for-private-endpoints)

{% include "../.gitbook/includes/private-endpoint-resources.md" %}

## Configuration Steps

{% stepper %}
{% step %}
### Deploy SCEPman Base Services

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To start with the deployment, please follow our deployment instructions:

{% content-ref url="../scepman-configuration/deployment-options/marketplace-deployment.md" %}
[marketplace-deployment.md](../scepman-configuration/deployment-options/marketplace-deployment.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Perform Post-Deployment Steps (Permission Assignments)

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To properly link all components of SCEPman 2, several permissions need to be assigned. Please follow these steps to establish the relevant connections:

{% content-ref url="../scepman-configuration/post-installation-config.md" %}
[post-installation-config.md](../scepman-configuration/post-installation-config.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Add Certificate Master Permissions

{% hint style="success" %}
This is a **mandatory** step for **Enterprise** **Edition** customers. **Community Edition** users may skip this step.
{% endhint %}

The Certificate Master is an **Enterprise Edition** feature that allows administrators to manually generate and revoke certificates. Please follow these steps to provide access to the Certificate Master.

{% content-ref url="../scepman-configuration/rbac/" %}
[rbac](../scepman-configuration/rbac/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Create Root certificate

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

After the deployment and permission assignment is complete, you need to create the root certificate for SCEPman:

{% content-ref url="../scepman-configuration/first-run-root-cert.md" %}
[first-run-root-cert.md](../scepman-configuration/first-run-root-cert.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure a Custom Domain and SSL Certificate

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

To have your SCEPman available under your specific domain you need to create a **Custom Domain** in the **App Service.**

{% content-ref url="../azure-configuration/custom-domain.md" %}
[custom-domain.md](../azure-configuration/custom-domain.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Manual Updates

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

By default, SCEPman adopts an [evergreen approach](../update-strategy.md#evergreen-approach) towards updates. In case you require full control over your SCEPman updates, please configure a deployment slot as described in the following guide under section **Deployment Slot Configuration**.

{% content-ref url="../update-strategy.md" %}
[update-strategy.md](../update-strategy.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Deploy Application Insights

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

The Application Insights can be used to get an overview of the App Service performance and to get deeper insights of the request processing of SCEPman. We recommend to always configure Application Insights to monitor, maintain and optimize the App Service.

{% content-ref url="../azure-configuration/application-insights.md" %}
[application-insights.md](../azure-configuration/application-insights.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure Health Check

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

We can configure a Health Check for the App Service to get direct notifications in case that the SCEPman stops working.

{% content-ref url="../azure-configuration/health-check/" %}
[health-check](../azure-configuration/health-check/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Ensure that SCEPman has sufficient Resources

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

Once you move SCEPman into a production environment, you should ensure that SCEPman is equipped with sufficient computing power. Therefore, please review our Azure Sizing guide and upgrade your App Service Plan tier if need be. You may postpone this until after your PoC or trial phase.

{% content-ref url="../azure-configuration/azure-sizing/" %}
[azure-sizing](../azure-configuration/azure-sizing/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure your MDM Deployment Profiles

{% hint style="success" %}
This is a **recommended** step.
{% endhint %}

With the completion of the above steps, we have a working SCEPman implementation and can now deploy certificates to the devices.

Please use one (or more) of the following articles, to deploy certificates with your preferred MDM solution:

{% content-ref url="../certificate-management/microsoft-intune/" %}
[microsoft-intune](../certificate-management/microsoft-intune/)
{% endcontent-ref %}

{% content-ref url="../certificate-management/jamf/" %}
[jamf](../certificate-management/jamf/)
{% endcontent-ref %}

{% content-ref url="../certificate-management/static-certificates/" %}
[static-certificates](../certificate-management/static-certificates/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Manually Issue Certificates or sign CSRs using the Certificate Master

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

Please follow below link, to learn how to issue TLS server or other certificates or how to sign any CSR using the Certificate Master component.

{% content-ref url="../certificate-management/certificate-master/" %}
[certificate-master](../certificate-management/certificate-master/)
{% endcontent-ref %}


{% endstep %}
{% endstepper %}

