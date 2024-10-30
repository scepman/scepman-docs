# License Key

To upgrade a Community Edition to an Enterprise Edition you have to add the license key in the app settings. How this works is explained in the following chapter:

1. Navigate to **App Services**.
2. Then choose your SCEPman app.
3. Next under **Settings** click **Environment variables**.
4. Select **AppConfig:LicenseKey**.
5. Under **Value**, enter your license key.

<figure><img src="../.gitbook/assets/image (77).png" alt=""><figcaption></figcaption></figure>

6. Then, Save the settings, and under Overview, restart your App Service.
7. After the restart, your SCEPman instance homepage will show Enterprise Edition.
8. Ensure that your SCEPman instance homepage shows on the left side that the Storage Account is connected (green bubble). If there are connection issues, the bubble will be red, and your OCSP responder will not work.
