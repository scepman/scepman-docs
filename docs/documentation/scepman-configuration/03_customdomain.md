---
category: Deployment (Optional)
title: Custom Domain
order: 1
---

# Custom Domain

## Custom Domain Configuration

If you want to create your own custom domain for your **App Service** URL, follow these steps:

| Task | Image |
| :--- | :--- |
| 1. Choose your **App Service**, on the left select **Custom domains** |  |
| 2. Click **Add custom domain** |  |
| 3. Enter your custom domain **\(1\)** and click **Validate** |  |
| 4. If CNAME is set correct **\(2\)** domain ownership is validated **\(3\)** | [![AddCustomDomain](../../.gitbook/assets/scepman_cname1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cname1.png) |
| 5. Click **Add custom domain** to finish this configuration |  |
| 6. When the domain is added, create a SSL binding |  |
| 7. Click **Add binding** on the custom domain screen | [![AddBinding](../../.gitbook/assets/scepman_cname2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cname2.png) |
| 8. On the TLS/SSL Binding submenu click **Upload PFX Certificate** |  |
| 9. After uploading select your certificate and the binding type |  |
| 10. Click **Add binding** | [![TLS/SSL](../../.gitbook/assets/scepman_cname3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cname3.png) |
| 11. After completing these steps, **Application settings** needs to be updated |  |
| 12. Choose web app, click **Configuration** |  |
| 13. Then, click Application Settings and edit the setting **AppConfig:BaseUrl** |  |
| 14. Enter your custom domain, click **OK** | [![EditAppSetting](../../.gitbook/assets/scepman_cname4_1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/8dd5e83c3dd91576810d6a7f58bb173cb6cc9536/docs/media/scepman_cname4.png) |
| 15. Finally, click **Save** |  |

### Microsoft Documentation and Managed Certificates

Add custom domain to an App Service:  
[https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain](https://docs.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain)

Add and manage TLS/SSL certificates in App Service:  
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate)

Create a free certificate:  
[https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate\#create-a-free-certificate-preview](https://docs.microsoft.com/en-us/azure/app-service/configure-ssl-certificate#create-a-free-certificate-preview) 

