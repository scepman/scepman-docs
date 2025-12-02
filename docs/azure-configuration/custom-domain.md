# Custom Domain

## Custom Domain Configuration

If you want to create your own custom domain for your **SCEPman App Service** URL, you have to decide whether you want to add it because it is a requirement to activate the Active Directory Endpoint or only for other reasons.

#### Considerations for an Active Directory Endpoint

If you want your custom domain for the [Active Directory](../certificate-management/active-directory/) endpoint, you need to create an **A record**, because [Kerberos requires this](../certificate-management/active-directory/general-configuration.md#ws_e_endpoint_access_denied). In this case, you must choose "All other domain services", even if you have an App Service Domain. The UI might force you to select **CNAME** as record type depending on your other selections. We have successfully tested that you can still configure the DNS entry as an **A record** and found no problems with this configuration. Otherwise change your settings, such that an **A record** is allowed like using an apex domain or using a certificate other than the App Service Managed Certificate. In this case, you need to find out the inbound IP address of your App Service, which is displayed in the Networking entry of the App Service.

<figure><img src="../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

#### **Adding the Custom Domain**

This description assumes you do not use Azure Domain Services. If you do, you select App Service Domain to profit from the integration of App Services and Azure Domain Services. Otherwise, select All other domain services and add the validation records to your domain provider.

* Domain provider: All other domain services

![](<../.gitbook/assets/2022-12-23 17_01_35-Window.png>)

### Configure the BaseUrl of SCEPman

{% hint style="info" %}
When you add the Custom Domain to enable the Active Directory Endpoint, as an alternative to updating the BaseUrl configuration as described below, you can also change the setting [AppConfig:ActiveDirectory:BaseUrl](../scepman-configuration/application-settings/active-directory/#general-settings). This won't affect things like your AIA, but only the Active Directory endpoints.
{% endhint %}

After configuring the custom domain, make sure to update SCEPman App Service Setting [**AppConfig:BaseUrl**](../scepman-configuration/application-settings/basics.md#appconfig-baseurl) to the new URL, save and restart the App Service.

![](<../.gitbook/assets/scepman-cname4-1 (1).png>)

{% hint style="info" %}
It is not recommended to set a custom domain to Certificate Master. If you still want to set it up, make sure to also do:

* in SCEPman App Service Configuration, update **`AppConfig:CertMaster:URL`** to the new Certificate Master URL
* add the new sign-in URL to the Certificate Master app registration "SCEPman-CertMaster".
{% endhint %}

#### Microsoft Documentation and Managed Certificates

Add a custom domain to an App Service:\
[https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain)

Add and manage TLS/SSL certificates in App Service:\
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate)

Create a free certificate:\
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)
