# Custom Domain

## Custom Domain Configuration

If you want to create your own custom domain for your **App Service** URL, there are two options depending on your domain provider:

**The first option** is to go with Azure Domain (existing one or creating a new one)

* Domain provider: in this case App Service Domain
* TLS/SSL certificate: select App Service Managed Certificate if you want to create and bind the certificate to your custom domain automatically, this certificate is managed by Azure and will be automatically renewed at no cost
* TLS/SSL type: SNI SSL Binding is free of cost and supported by most modern browsers
* App Service Domain: Choose an existing Azure Domain or create a new one
* Domain type: in the example below we choose a Subdomain

By clicking on add, the custom domain and the SSL Managed Certificate will be created and bound automatically

<figure><img src="../../.gitbook/assets/2022-12-23 15_12_15-Window.png" alt=""><figcaption></figcaption></figure>

**The second option** is to go with your non-Azure domain and add the validation records to your domain provider

* Domain provider: All other domain services

<figure><img src="../../.gitbook/assets/2022-12-23 17_01_35-Window.png" alt=""><figcaption></figcaption></figure>

After configuring the custom domain, make sure to update SCEPman App Service Setting [**AppConfig:BaseUrl**](application-settings/basics.md#appconfig-baseurl) to the new URL, save and restart the App Service

![](<../../../.gitbook/assets/scepman-cname4-1 (1).png>)

{% hint style="info" %}
It is not recommended to set a custom domain to Certificate Master. If you still want to set it up please make sure to:

* in SCEPman App Service Configuration, update **`AppConfig:CertMaster:URL`** to the new Certificate Master URL
* in Certificate Master App Service Configuration, update **`AppConfig:SCEPman:URL`** to the new SCEPman URL
{% endhint %}

#### Microsoft Documentation and Managed Certificates

Add a custom domain to an App Service:\
[https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain)

Add and manage TLS/SSL certificates in App Service:\
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate)

Create a free certificate:\
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)
