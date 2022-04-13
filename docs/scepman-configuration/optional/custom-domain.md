# Custom Domain

## Custom Domain Configuration

If you want to create your own custom domain for your **App Service** URL, follow these steps:

1. Choose your **App Service,** on the left select **Custom domain**.&#x20;
2. Click **Add custom domain.**&#x20;
3. Enter your custom domain and click **Validate**
4. If the domain is on your Azure, **CNAME** and **TXT** records will be generated automatically, otherwise, if the domain is not running on Azure DNS you need to add them manually (see [here](custom-domain.md#undefined)).

![](<../../.gitbook/assets/2022-04-13 17\_09\_38-Add custom domain0.png>)

### Create App Service Managed Certificate <a href="#53264c4d-2e8e-482b-9522-b7023144f9f7" id="53264c4d-2e8e-482b-9522-b7023144f9f7"></a>

To use it for HTTPS

1. Go to TLS/SSL settings
2. Click on Private Key Certificates (.pfx)
3. Create App Service Managed Certificate for your custom domain

![](<../../.gitbook/assets/image (35).png>)

### SSL Binding

1. Click **Add custom domain** to finish this configuration.
2. When the domain is added, create an SSL binding.
3. Click **Add binding** on the custom domain screen.

![](<../../../.gitbook/assets/scepman\_cname2 (1) (1) (1).png>)

1. On the TLS/SSL Binding submenu click **Upload PFX Certificate.**
2. After uploading select your certificate and the binding type.
3. Next click **Add binding.**

![](<../../../.gitbook/assets/scepman\_cname3 (1) (2) (2) (2) (2) (2) (4) (4) (4) (4) (4) (1) (1) (1) (2) (3).png>)

1. After completing these steps, **Application settings** need to be updated
2. Choose app service and click **Configuration**
3. Then click **Application Settings** and edit the setting **AppConfig:BaseUrl**
4. Enter your custom domain and click **OK**.

![](<../../../.gitbook/assets/scepman\_cname4\_1 (1).png>)

1. Finally click **Save**.

### Add CNAME and TXT manually to the DNS

If you want to add a custom domain for a domain outside Azure DNS (or your permissions), you need to add the CNAME and TXT records manually

![](<../../.gitbook/assets/2022-04-13 16\_51\_49-Add custom domain.png>)

### Microsoft Documentation and Managed Certificates

Add a custom domain to an App Service:\
[https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain)

Add and manage TLS/SSL certificates in App Service:\
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate)

Create a free certificate:\
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview)

| Back to Trial Guide | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-4-configure-a-custom-domain-and-ssl-certificate) | ​[Back to Enterprise Guide​](broken-reference) |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------- |
