# Extended Guide

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

This will guide you through all steps to deploy SCEPman for an enterprise-grade environment with advanced requirements, e.g. naming conventions, redundancy or auto-scaling.

## Azure Deployment

Let's start with the requirements and a resource overview.\
Keep in mind that you need to plan a useful Azure resource design.

### Prerequisites

#### Mandatory

* [ ] Azure resource naming convention.
* [ ] Azure subscription (at least Contributor rights on that subscription).
* [ ] Azure owner rights (at least on Resource Group level).
* [ ] Microsoft Entra ID (Azure AD) "Global administrator" (Consent to access Graph API).
* [ ] Make sure to define your Azure policies [according to SCEPman requirements](../../other/security-faq.md#azure-cis) (e.g. do not enforce TLS).
* [ ] Public Domain CNAME (_scepman.yourdomain.com_), only if geo-redundancy is used.
* [ ] SSL (Wildcard-) Certificate (or use [App Service Managed Certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)), only if geo-redundancy is used.
* [ ] SCEPman Enterprise Edition License Key.

#### Optional

* [ ] Public Domain CNAME (_scepman.yourdomain.com_), only if a custom domain is used.
* [ ] SSL (Wildcard-) Certificate (or use [App Service Managed Certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)), only if a custom domain is used.

### Overview Azure Resource

All these resources are recommended for a production environment.

{% include "../../.gitbook/includes/scepman-azure-resources.md" %}

Additionally, if you are using Private Endpoints, you have [seven more Azure Resources.](../../azure-configuration/private-endpoints.md#azure-resources-used-for-private-endpoints)

{% include "../../.gitbook/includes/private-endpoint-resources.md" %}

## Configuration Steps

{% stepper %}
{% step %}
### Deploy SCEPman Base Services

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

Make your choice on whether you'd like to deploy with a **Windows** or **Linux** App Service Plan. Both deployment methods will allow you to choose your Operating System.

To start with the deployment, you need to follow our setup instructions leveraging an **ARM Template**

{% content-ref url="../../scepman-configuration/deployment-options/enterprise-deployment.md" %}
[enterprise-deployment.md](../../scepman-configuration/deployment-options/enterprise-deployment.md)
{% endcontent-ref %}

or alternatively our **Terraform** script:

{% content-ref url="../../scepman-configuration/deployment-options/terraform-deployment.md" %}
[terraform-deployment.md](../../scepman-configuration/deployment-options/terraform-deployment.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Perform Post-Deployment Steps (Permission Assignments)

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To properly link all components of SCEPman, several permissions need to be assigned. Please follow these steps to establish the relevant connections:

{% content-ref url="../../scepman-configuration/post-installation-config.md" %}
[post-installation-config.md](../../scepman-configuration/post-installation-config.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Add Certificate Master Permissions

{% hint style="success" %}
This is a **mandatory** step for **Enterprise** **Edition** customers. **Community Edition** users may skip this step.
{% endhint %}

The Certificate Master is an **Enterprise Edition** feature that allows administrators to manually generate and revoke certificates. Please follow these steps to provide access to the Certificate Master.

{% content-ref url="../../scepman-configuration/rbac/" %}
[rbac](../../scepman-configuration/rbac/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Create Root Certificate

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

After the deployment and permission assignment is complete, you need to create the root certificate for SCEPman:

{% content-ref url="../../scepman-configuration/first-run-root-cert.md" %}
[first-run-root-cert.md](../../scepman-configuration/first-run-root-cert.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure a Custom Domain and SSL Certificate

{% hint style="success" %}
This is a **recommended** step. However, **skip** this step if you are implementing geo-redundancy / high-availability.
{% endhint %}

To have your SCEPman available under your specific domain you need to create a **Custom Domain** in the **App Service.**

{% content-ref url="../../azure-configuration/custom-domain.md" %}
[custom-domain.md](../../azure-configuration/custom-domain.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Manual Updates

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

By default, SCEPman adopts an [evergreen approach](../../update-strategy.md#evergreen-approach) towards updates. In case you require full control over your SCEPman updates, please configure a deployment slot as described in the following guide under section **Deployment Slot Configuration**.

{% content-ref url="../../update-strategy.md" %}
[update-strategy.md](../../update-strategy.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Deploy Application Insights

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

The Application Insights can be used to get an overview of the App Service performance and to get deeper insights of the request processing of SCEPman. We recommend to always configure Application Insights to monitor, maintain and optimize the App Service.

{% content-ref url="../../azure-configuration/application-insights.md" %}
[application-insights.md](../../azure-configuration/application-insights.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure Health Check

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

Health Checks can be configured to notify administrators in the event the SCEPman App Service is unresponsive.

{% content-ref url="../../azure-configuration/health-check/" %}
[health-check](../../azure-configuration/health-check/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Ensure that SCEPman has sufficient resources

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

Once you move SCEPman into a production environment, you should ensure that SCEPman is equipped with sufficient computing power. Therefore, please review our Azure Sizing guide and upgrade your App Service Plan tier if need be. You may postpone this until after your PoC or trial phase.

{% content-ref url="../../azure-configuration/azure-sizing/" %}
[azure-sizing](../../azure-configuration/azure-sizing/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure Autoscaling

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

The SCEPman solution has two different tasks and performance requirements.\
One task is the certificate issuance process: After the configuration of the SCEPman solution we need to deploy certificates to all devices (user and/or device certificates), but this is a one-time-task and after the initial deployment this only happens when a new device is enrolled, or the certificates needs to be renewed. In those situations, the SCEPman will face a peek of SCEP requests.

The second task is the certificate validation: After we deployed certificates to devices, those certificates need to be validated each time we use them. For every certificated-based authentication the clients, gateways, or RADIUS system (depends on what you use) will send an OCSP request to the SCEPman App Service. This will cause a permanent request load on the App Service.

To have an optimized performance and take care of the costs we recommend to setup the Autoscaling functionality of the App Service. With this feature your application can scale-out and scale-in based on metrics.

{% content-ref url="../../azure-configuration/azure-sizing/autoscaling.md" %}
[autoscaling.md](../../azure-configuration/azure-sizing/autoscaling.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure Geo-Redundancy

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

Configuring a geo-redundant instance for SCEPman can enhance service availability and resilience by distributing workloads across multiple Azure regions.&#x20;

However, it's important to note that this setup may lead to increased Azure costs due to the additional resources and data replication involved. Microsoft provides an SLA of 99.95% for Azure App Services, which is adequate in most scenarios.

{% content-ref url="../../azure-configuration/geo-redundancy.md" %}
[geo-redundancy.md](../../azure-configuration/geo-redundancy.md)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Configure your MDM Deployment Profiles

{% hint style="success" %}
This is a **recommended** step.
{% endhint %}

With the completion of the above steps, we have a working SCEPman implementation and can now deploy certificates to the devices.

Please use one (or more) of the following articles, to deploy certificates with your preferred MDM solution:

{% content-ref url="../../certificate-management/microsoft-intune/" %}
[microsoft-intune](../../certificate-management/microsoft-intune/)
{% endcontent-ref %}

{% content-ref url="../../certificate-management/jamf/" %}
[jamf](../../certificate-management/jamf/)
{% endcontent-ref %}

{% content-ref url="../../certificate-management/static-certificates/" %}
[static-certificates](../../certificate-management/static-certificates/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Manually Issue Certificates or sign CSRs using the Certificate Master <a href="#manually-issue-certificates-or-sign-csrs-using-the-certificate-master" id="manually-issue-certificates-or-sign-csrs-using-the-certificate-master"></a>

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

Please follow below link, to learn how to issue TLS server certificates based on a list of FQDNs or sign any CSR using the Certificate Master component.

{% content-ref url="../../certificate-management/certificate-master/" %}
[certificate-master](../../certificate-management/certificate-master/)
{% endcontent-ref %}


{% endstep %}

{% step %}
### Issue Certificates using the Enrollment REST API

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

SCEPman features a REST API to enroll certificates. This is an alternative to the SCEP endpoints that require the SCEP-style of authentication, while the REST API uses Microsoft Identities for authentication. The protocol is also much simpler than SCEP.

{% content-ref url="../../certificate-management/api-certificates/" %}
[api-certificates](../../certificate-management/api-certificates/)
{% endcontent-ref %}


{% endstep %}
{% endstepper %}



