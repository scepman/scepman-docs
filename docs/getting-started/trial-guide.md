# Trial Guide

This is a quick start guide to get a trial environment.

{% hint style="info" %}
If you want to deploy:

* a community edition environment \(SCEPman CE\), please follow the [Community Guide](community-guide.md)
* enterprise \(SCEPman EE\) environment, please follow the [Enterprise Guide](enterprise-guide.md)
{% endhint %}

## Azure Deployment

Let´s start with the requirements and a resource overview.  
Keep in mind that you need to plan a useful Azure resource design.

### Checklist pre-requirements

* [ ] Azure subscription
* [ ] Azure contributor rights \(at least on Resource Group level\)
* [ ] Azure AD "Global administrator" \(Consent to access Graph API\)

### Overview Azure Resource

All these resources are deployed for a trial environment.

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
  </tbody>
</table>

## Configuration Steps

### Step 1: Azure App Registration

Before we can start the resource deployment, we need to create an "Azure App Registration".

{% page-ref page="../scepman-configuration/azure-app-registration.md" %}

### Step 2: Deploy SCEPman base services

To start with the deployment, you need to follow our Setup instruction:

{% page-ref page="../scepman-configuration/deployment-options/marketplace-deployment.md" %}

### Step 3: Create Root certificate

After the deployment completed you need to create the root certificate:

{% page-ref page="../scepman-configuration/first-run-root-cert.md" %}

{% page-ref page="../scepman-configuration/first-run-root-cert.md" %}

### Step 4: Configure Intune deployment profiles

With the completion of the first steps, we have a working SCEPman implementation and can now deploy certificates to our devices.

In the Endpoint Manager \(Intune\) you can create Configuration profiles for various platforms. Choose your OS platform from the below links:

{% page-ref page="../certificate-deployment/microsoft-intune/windows-10.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/windows-10.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/macos.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/macos.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/ios.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/ios.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/android.md" %}

{% page-ref page="../certificate-deployment/microsoft-intune/android.md" %}

### Step 5: Enjoy the ease of SCEPman certificate deployment

After configuration of the Intune profiles, we will get your certificates to your devices and can start using them. Now enjoy SCEPman and if you have any questions please contact us.   
Further details can be found on [https://scepman.com](https://scepman.com)

After configuration of the Intune profiles, we will get your certificates to your devices and can start using them. Now enjoy SCEPman and if you have any questions please contact us. Further details can be found on [https://scepman.com](https://scepman.com)

