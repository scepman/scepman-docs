# Application Artifacts

## Available SCEPman Channels

We offer three channels for our SCEPman web applications, you can find the actual artifacts also on [Github](https://github.com/scepman/install/tree/master/dist). In order to receive updates from one of the update channels, copy the respective URL from below into the [WEBSITE\_RUN\_FROM\_PACKAGE](application-settings/basics.md#website_run_from_package) setting of your SCEPman App Service.

There are two independent artifact hosts, GitHub and Azure (install.scepman.com). If one of the two should fail, you can switch to the other. Thus, there are two download URLs for each channel. Detecting the used channel when using install.scepman.com requires SCEPman 2.3, but apart from that also works with SCEPman 2.2.

{% tabs fullWidth="false" %}
{% tab title="Windows App Service" %}
### SCEPman Production Channel

* full released version
* function and load-tested
* bugs not expected

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts.zip
```

```
https://install.scepman.com/dist/Artifacts.zip
```

### SCEPman Beta Channel

* next production release
* function tested, but no load-test
* bugs possible

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Beta.zip
```

```
https://install.scepman.com/dist/Artifacts-Beta.zip
```

### SCEPman Internal Channel

* ongoing development
* limited function tested and no load-test
* bugs expected

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Intern.zip
```

```
https://install.scepman.com/dist/Artifacts-Intern.zip
```

### SCEPman Deferred Channel

* second-to-latest version
* function and load-tested
* does not include the latest bugfixes and features

```
https://raw.githubusercontent.com/scepman/install/deferred/dist/Artifacts.zip
```
{% endtab %}

{% tab title="Linux App Service" %}
### SCEPman Production Channel (Linux)

* full released version
* function and load-tested
* bugs not expected

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Linux.zip
```

```
https://install.scepman.com/dist/Artifacts-Linux.zip
```

### SCEPman Beta Channel (Linux)

* next production release
* function tested, but no load-test
* bugs possible

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Linux-Beta.zip
```

```
https://install.scepman.com/dist/Artifacts-Linux-Beta.zip
```

### SCEPman Internal Channel (Linux)

* ongoing development
* limited function tested and no load-test
* bugs expected

```
https://raw.githubusercontent.com/scepman/install/master/dist/Artifacts-Linux-Internal.zip
```

```
https://install.scepman.com/dist/Artifacts-Linux-Internal.zip
```

### SCEPman Deferred Channel (Linux)

* second-to-latest version
* function and load-tested
* does not include the latest bugfixes and features

```
https://raw.githubusercontent.com/scepman/install/deferred/dist/Artifacts-Linux.zip
```
{% endtab %}
{% endtabs %}

## Available SCEPman Certificate Master Channels

We offer three channels for our SCEPman web applications, you can find the actual artifacts also on [Github](https://github.com/scepman/install/tree/master/dist-certmaster). In order to receive updates from one of the update channels, copy the respective URL from below into the [WEBSITE\_RUN\_FROM\_PACKAGE](application-settings-1/basics.md#website_run_from_package) setting of your Certificate Master App Service.

{% tabs fullWidth="false" %}
{% tab title="Windows App Service" %}
### Certificate Master Production Channel

```
https://raw.githubusercontent.com/scepman/install/master/dist-certmaster/CertMaster-Artifacts.zip
```

```
https://install.scepman.com/dist-certmaster/CertMaster-Artifacts.zip
```

### Certificate Master Beta Channel

```
https://raw.githubusercontent.com/scepman/install/master/dist-certmaster/CertMaster-Artifacts-Beta.zip
```

```
https://install.scepman.com/dist-certmaster/CertMaster-Artifacts-Beta.zip
```

### Certificate Master Internal Channel

```
https://raw.githubusercontent.com/scepman/install/master/dist-certmaster/CertMaster-Artifacts-Intern.zip
```

```
https://install.scepman.com/dist-certmaster/CertMaster-Artifacts-Intern.zip
```

### Certificate Master Deferred Channel

```
https://raw.githubusercontent.com/scepman/install/deferred/dist-certmaster/CertMaster-Artifacts.zip
```
{% endtab %}

{% tab title="Linux App Service" %}
### Certificate Master Production Channel (Linux)

```
https://raw.githubusercontent.com/scepman/install/master/dist-certmaster/CertMaster-Artifacts-Linux.zip
```

```
https://install.scepman.com/dist-certmaster/CertMaster-Artifacts-Linux.zip
```

### Certificate Master Beta Channel (Linux)

```
https://raw.githubusercontent.com/scepman/install/master/dist-certmaster/CertMaster-Artifacts-Linux-Beta.zip
```

```
https://install.scepman.com/dist-certmaster/CertMaster-Artifacts-Linux-Beta.zip
```

### Certificate Master Internal Channel (Linux)

```
https://raw.githubusercontent.com/scepman/install/master/dist-certmaster/CertMaster-Artifacts-Linux-Internal.zip
```

```
https://install.scepman.com/dist-certmaster/CertMaster-Artifacts-Linux-Internal.zip
```

### Certificate Master Deferred Channel (Linux)

```
https://raw.githubusercontent.com/scepman/install/deferred/dist-certmaster/CertMaster-Artifacts-Linux.zip
```
{% endtab %}
{% endtabs %}

## Custom Artifact Location

To have full control over the update process and what artifacts are loaded by your App Service you can deploy your own Azure Storage Account. We recommend using one of the update channels, so if this is not required, skip this section.

1\. Start at your **Resource group** where you have deployed SCEPman and click **+ Add**

2\. Search for **storage account** in the Marketplace search bar and click on **Storage account - blob, file, table, queue**

3\. Your Subscription and resource group are pre-selected and you can start with defining **Storage account name, Location Performance, Account kind, Replication and Access tier** (Use settings as shown in the screenshot)

![](<../.gitbook/assets/image (21).png>)

4\. Go to the **Advanced** tab and set the **Blob public access** to **Enabled**

5\. Click on **Review + create** and then on **Create**

6\. After the successful creation of your storage account you can open the Storage account overview and open the **Storage Explorer (preview)**

7\. In the **Storage Explorer (preview)** you can right click on the **BLOB CONTAINERS** and select **Create blob container.** Specify a **Name** and set the **Public access level** to **Blob.** After this you can click on **Create**

![](../.gitbook/assets/screenshot-2020-07-09-at-17.20.42.png)

8\. You need to reload the **Storage Explorer (Preview)** and then you can see your container under **BLOB CONTAINERS**. Now you can download the Artifacts from our GitHub (See [Application Artifacts](application-artifacts.md#available-channels)) and upload the artifacts here.

9\. After the successful upload you can select your blob and click on **Copy URL.** You need this URL in the Part **Change Artifacts (**[**Application Artifacts**](application-artifacts.md#change-artifacts)**)**

## Change Artifacts

To get continuous updates for SCEPman you can point a configuration variable to the [maintained GitHub repository](https://github.com/scepman/install) of SCEPman (**Evergreen Approach)**. During every restart, the Azure Web App will do a check and a copy deployment if necessary.

{% stepper %}
{% step %}
### Go to your Azure Portal
{% endstep %}

{% step %}
### Navigate to App Services
{% endstep %}

{% step %}
### Select your SCEPman App Service
{% endstep %}

{% step %}
### Navigate to Environment Variables
{% endstep %}

{% step %}
### Locate and Edit the parameter WEBSITE\_RUN\_FROM\_PACKAGE

Replace the URL with your chosen [SCEPman Update Channel](application-artifacts.md#available-scepman-channels) or [Custom Artifact Location](application-artifacts.md#custom-artifact-location)

<figure><img src="../.gitbook/assets/image (61).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (62).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Repeat Steps 1 - 5 for the Certificate Master (Optional)

The Certificate Master has the same WEBSITE\_RUN\_FROM\_PACKAGE parameter. This can be changed to a different [Certificate Master Update Channel](application-artifacts.md#available-scepman-certificate-master-channels) or [Custom Artifact Location](application-artifacts.md#custom-artifact-location)
{% endstep %}
{% endstepper %}
