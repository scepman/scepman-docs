# Enterprise Guide V2.x

This will guide you through all steps to deploy SCEPman 2.x into an enterprise-grade environment.

## Azure Deployment

Let's start with the requirements and a resource overview.\
Keep in mind that you need to plan a useful Azure resource design.

### Checklist: Prerequisites

* [ ] Azure resource naming convention
* [ ] Azure subscription
* [ ] Azure contributor rights (at least on Resource Group level)
* [ ] Azure AD "Global administrator" (Consent to access Graph API)
* [ ] Public Domain CNAME (_scepman.yourdomain.com_)
* [ ] SSL (Wildcard-) Certificate (or use [App Service Managed Certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview))

### Overview Azure Resource

All these resources are recommended for a production environment.

| Type                    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| App Service(s)          | <p>A virtual Azure environment to run the SCEPman Core and Cert Master applications and provides a UI to configure different<br>application specific settings like CNAME, SSL certificate and App Settings.</p>                                                                                                                                                                                                                            |
| App Service Plan        | <p>A virtual set of compute resources and configurations for the "App Service(s)".</p><p>Here you can configure the pricing tier and resource scaling.</p>                                                                                                                                                                                                                                                                                 |
| Key Vault               | <p>Tool to securely store secrets and certificates. The SCEPman application</p><p>will generate and save the root certificate in your Key Vault.</p>                                                                                                                                                                                                                                                                                       |
| Application Insights    | <p>Application Performance Management (APM) tool to get insights of the</p><p>SCEPman applications and requests. Needed to measure performance</p><p>and good for service optimization.</p>                                                                                                                                                                                                                                                |
| Storage account         | <p>Storage platform used by SCEPman's Cert Master component to store certain attributes of the manually issued TLS server certificates for revocation purposes.<br><em></em><br><em>Optional:</em></p><p>Storage platform to upload the SCEPman artifacts and save log files.</p><p>The "App Service" will load the artifacts from a public blob store URI and</p><p>save all the application and web server logs in a blob container.</p> |
| Log Analytics workspace | <p>A centralized and cloud-based log storage. The "App Service" will save all</p><p>platform logs and metrics into this workspace.</p>                                                                                                                                                                                                                                                                                                     |

## Configuration Steps

### Step 1: Deploy SCEPman V2.x Beta Base Services

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To start with the deployment, you need to follow our Setup instruction:

{% content-ref url="../scepman-2.x-deployment.md" %}
[scepman-2.x-deployment.md](../scepman-2.x-deployment.md)
{% endcontent-ref %}

### Step 2: Perform Post-Deployment Steps (Permission Assignments)

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

To properly link all components of SCEPman 2.X Beta, several permissions need to be assigned. Please follow these steps to establish the relevant connections:

{% content-ref url="../../scepman-configuration/post-installation-config.md" %}
[post-installation-config.md](../../scepman-configuration/post-installation-config.md)
{% endcontent-ref %}

### Step 3: Create Root certificate

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

After the deployment and persmission assignment is complete, you need to create the root certificate for SCEPman:

{% content-ref url="../../scepman-configuration/first-run-root-cert.md" %}
[first-run-root-cert.md](../../scepman-configuration/first-run-root-cert.md)
{% endcontent-ref %}

### Step 4: Configure a Custom Domain and SSL Certificate

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

To have your SCEPman available under your specific domain you need to create a **Custom Domain** in the **App Service.**

{% content-ref url="../../scepman-configuration/optional/custom-domain.md" %}
[custom-domain.md](../../scepman-configuration/optional/custom-domain.md)
{% endcontent-ref %}

### Step 5: Deploy Storage Account and change Artifacts

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

The next step is to configure the Storage account and change the Artifact location in your App Service. This is only relevant if you would like to have full control over the update cycle of SCEPman.

{% content-ref url="../../scepman-configuration/optional/application-artifacts.md" %}
[application-artifacts.md](../../scepman-configuration/optional/application-artifacts.md)
{% endcontent-ref %}

{% hint style="warning" %}
SCEPman V2.x is currently only available in our Beta-Channel. Hence, the Beta-Channel has to be chosen for the application artifcats in this step.
{% endhint %}

### Step 6: Configure Log Collection

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

You can configure two different logging parts in your App Service, to retain your log data. The one part is the **App Service Logs**, which will save all application and IIS server-based log data. The other part is the **Diagnostic settings**, this contains platform logs and metrics data.

{% content-ref url="../../scepman-configuration/optional/log-configuration.md" %}
[log-configuration.md](../../scepman-configuration/optional/log-configuration.md)
{% endcontent-ref %}

{% hint style="info" %}
Use the storage account we created in **Step 4** and create two new blob containers. This blob containers can be selected in the **App Service Logs** instructions. In the **Diagnostic settings** you can directly choose the storage account and blob containers will be created automatically.
{% endhint %}

### Step 7: Deploy Application Insights

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

The Application Insights can be used to get an overview of the App Service performance and to get deeper insights of the request processing of SCEPman. We recommend to always configure Application Insights to monitor, maintain and optimize the App Service.

{% content-ref url="../../scepman-configuration/optional/application-insights.md" %}
[application-insights.md](../../scepman-configuration/optional/application-insights.md)
{% endcontent-ref %}

### Step 8: Configure Health Check

{% hint style="success" %}
This is **recommended** step.
{% endhint %}

We can configure a Health Check for the App Service to get direct notifications in case that the SCEPman stops working.

{% content-ref url="../../scepman-configuration/optional/health-check.md" %}
[health-check.md](../../scepman-configuration/optional/health-check.md)
{% endcontent-ref %}

### Step 9: Configure Autoscaling

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

The SCEPman solution has two different tasks and performance requirements.\
One task is the certificate issuance process: After the configuration of the SCEPman solution we need to deploy certificates to all devices (user and/or device certificates), but this is a one-time-task and after the initial deployment this only happens when a new device is enrolled, or the certificates needs to be renewed. In those situations, the SCEPman will face a peek of SCEP requests.\
The second task is the certificate validation: After we deployed certificates to devices, those certificates need to be validated each time we use them. For every certificated-based authentication the clients, gateways, or RADIUS system (depends on what you use) will send an OCSP request to the SCEPman App Service. This will cause a permanent request load on the App Service.

To have an optimized performance and take care of the costs we recommend to setup the Autoscaling functionality of the App Service. With this feature your application can scale-out and scale-in based on metrics.

{% content-ref url="../../scepman-configuration/optional/autoscaling.md" %}
[autoscaling.md](../../scepman-configuration/optional/autoscaling.md)
{% endcontent-ref %}

### Step 10: Configure Geo-Redundancy

{% hint style="info" %}
This is an **optional** step.
{% endhint %}

{% content-ref url="../../scepman-configuration/optional/geo-redundancy.md" %}
[geo-redundancy.md](../../scepman-configuration/optional/geo-redundancy.md)
{% endcontent-ref %}

### Step 11: Configure Intune Deployment Profiles

{% hint style="warning" %}
This is a **mandatory** step.
{% endhint %}

With the completion of the above steps, we have a working SCEPman implementation and can now deploy certificates to the devices.

In the Endpoint Manager (Intune) you can create Configuration profiles for various platforms. Choose your OS platform from the below links:

{% content-ref url="../../certificate-deployment/microsoft-intune/windows-10.md" %}
[windows-10.md](../../certificate-deployment/microsoft-intune/windows-10.md)
{% endcontent-ref %}

{% content-ref url="../../certificate-deployment/microsoft-intune/macos.md" %}
[macos.md](../../certificate-deployment/microsoft-intune/macos.md)
{% endcontent-ref %}

{% content-ref url="../../certificate-deployment/microsoft-intune/ios.md" %}
[ios.md](../../certificate-deployment/microsoft-intune/ios.md)
{% endcontent-ref %}

{% content-ref url="../../certificate-deployment/microsoft-intune/android.md" %}
[android.md](../../certificate-deployment/microsoft-intune/android.md)
{% endcontent-ref %}

### Step 12: Enjoy the ease of SCEPman Certificate Deployment

After configuration of the Intune profiles, we will get your certificates to your devices and can start using them. Now enjoy SCEPman and if you have any questions please contact us. \
Further details can be found on [https://scepman.com](https://scepman.com)

After configuration of the Intune profiles, we will get your certificates to your devices and can start using them. Now enjoy SCEPman and if you have any questions please contact us. \
Further details can be found on [https://scepman.com](https://scepman.com)

### Step 13: Issue TLS Server Certificates using Cert Master

While the Cert Master interface was designed to be self-explanatory, we will publish a guide soon.
