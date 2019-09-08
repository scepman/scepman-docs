---
category: Deployment (Optional)
title: Custom Domain
order: 1
---

# 03\_customdomain

> SCEPman Enterprise Edition only

## Custom Domain Configuration \(optional\)

If you want to create your own custom domain for your web app URL, follow these steps:

| Task | Image |
| :--- | :--- |
| 1. Choose web app, on the left select **Custom domains** |  |
| 2. Click **Add custom domain** |  |
| 3. Enter your custom domain \(1\) and click **Validate** |  |
| 4. If CNAME is set correct \(2\) domain ownership is validated \(3\) | [![AddCustomDomain](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname1.png) |
| 5. Click **Add custom domain** to finish this configuration |  |
| 6. When the domain is added, create a SSL binding |  |
| 7. Click **Add binding** on the custom domain screen | [![AddBinding](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname2.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname2.png) |
| 8. On the TLS/SSL Binding submenu click **Upload PFX Certificate** |  |
| 9. After uploading select your certificate and the binding type |  |
| 10. Click **Add binding** | [![TLS/SSL](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname3.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname3.png) |
| 11. After completing these steps, **Application settings** needs to be updated |  |
| 12. Choose web app, click **Configuration** |  |
| 13. Then, click Application Settings and edit the setting **AppConfig:BaseUrl** |  |
| 14. Enter your custom domain, click **OK** | [![EditAppSetting](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname4_1.png)](https://github.com/glueckkanja/gk-scepman-docs/tree/98c2c2fb5f8b976146bae6f1bea75e9f890303fc/media/scepman_cname4.png) |
| 15. Finally, click **Save** |  |

