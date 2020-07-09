# Application Resources

## Change Artifacts

To get continuous updates for SCEPman you can point a configuration variable to the [maintained GitHub repository](https://github.com/glueckkanja/gk-scepman) of SCEPman. During every restart, the Azure Web App will do a check and a copy deployment if necessary.   
If you want to have more control about the updates you can use your own location.   
\(See [Application Resources](change-channel.md#custom-artifact-location)\)

To configure this, do the following:

1. Go to your Azure AD
2. Navigate to **App Service**
3. Choose your SCEPman app
4. Then, click **Configuration** \(submenu **Setting**\)
5. Look for **WEBSITE\_RUN\_FROM\_PACKAGE** and click on it

![](../../../.gitbook/assets/scepman_optional2%20%281%29%20%281%29.png)

1. Then replace the URL with the SCEPman GitHub URL:

![](../../../.gitbook/assets/scepman_optional3%20%281%29%20%281%29.png)

## Custom Artifact location

To have full control about the update process and what artifacts loaded by your App Service you can deploy your own Azure Storage Account.

Follow this instruction to create a storage account:



## Available Channels

We offer three channels for our SCEPman application. 

Production  
- full released version  
- function and load-tested  
- bugs not expected  
  
Beta  
- next production release  
- function tested, but no load-test  
- bugs possible  
  
Intern  
- ongoing development  
- limited function tested and no load-test  
- bugs expected

{% tabs %}
{% tab title="Production" %}
```text
https://raw.githubusercontent.com/glueckkanja/gk-scepman/master/dist/Artifacts.zip
```
{% endtab %}

{% tab title="Beta" %}
```
https://raw.githubusercontent.com/glueckkanja/gk-scepman/master/dist/Artifacts-Beta.zip
```
{% endtab %}

{% tab title="Intern" %}
```
https://raw.githubusercontent.com/glueckkanja/gk-scepman/master/dist/Artifacts-Intern.zip
```
{% endtab %}
{% endtabs %}

