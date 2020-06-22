# Change channel

To get continuous updates for SCEPman you can point a configuration variable to the [maintained GitHub repository](https://github.com/glueckkanja/gk-scepman) of SCEPman. During every restart, the Azure Web App will do a check and a copy deployment if necessary. To configure this do the following:

1. Go to your Azure AD
2. Navigate to **App Service**
3. Choose your SCEPman app
4. Then, click **Configuration** \(submenu **Setting**\)
5. Look for **WEBSITE\_RUN\_FROM\_PACKAGE** and click on it

![](../.gitbook/assets/scepman_optional2%20%281%29%20%281%29.png)

1. Then replace the URL with the SCEPman GitHub URL:

   `https://github.com/glueckkanja/gk-scepman/raw/master/dist/Artifacts.zip`

![](../.gitbook/assets/scepman_optional3%20%281%29%20%281%29.png)

## Available Channels

