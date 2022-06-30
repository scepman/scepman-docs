# Log configuration

{% hint style="info" %}
In this article, we are recommending **App Service logs** settings, but you can always (depending on your use case) customize the settings to fit your environment.
{% endhint %}

## App Service Logs (Recommended settings)

To retain or archive the log files, we recommend configuring the following settings under **Monitoring** -> **App Service logs** of your SCEPman instance:

1. Activate **Application logging (Filesystem)** and set the **Level** to **Verbose:** this will allow you to see the **Application logs** under **Log stream**
2. Activate **Application logging (Blob)** and set the **Level** to **Verbose,** then **Storage settings** to a **Storage account** (you can use the same **Storage account** you already created for your SCEPman artifacts), otherwise you can create a new [**Storage account**](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal#create-a-storage-account) **** and save the **Application logging** in a Blob Container. This is very helpful to save the **application logging** for long term. We recommend 30 days for **Retention Period.**
3. Activate **Web server logging** by selecting **Storage** and the **Storage account** you already have created. This will save the logs of the web server where SCEPman is running and not of the SCEPman application itself. This could be helpful in some special troubleshooting cases. We recommend 30 days for **Retention Period.**
4. Turn on **Detailed error messages** and **Failed request tracing.**
5. Do not forget to **Save.**

Your **App Service logs** settings should be **(in our example)** like:

![](../../.gitbook/assets/2021-09-04-06\_40\_56-scepman-apppnf42avv2wmis-microsoft-azure-and-4-more-pages-c4a8-ehamed-micr.png)

## Diagnostic settings (Optional settings)

To retain your diagnostic data, you can configure the streaming export of platform logs and metrics.\
You can choose different destinations as a location.

{% hint style="warning" %}
We recommend storing your data in Log Analytics
{% endhint %}

### Log Analytics workspace

1. Create a Log Analytics workspace (Microsoft Guide [Create a Log Analytics workspace](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-create-workspace#create-a-workspace)) You can also use an existing one.
2. Go to your **App Service** and click on **Diagnostic settings**
3. In the filed **Diagnostic setting name** you need to put in a name to identify your configuration
4. Please select **Send to Log Analytics** under the **Destination details** and select your **Subscription** and **Log Analytics workspace**
5. The last step is to select the needed data. We recommend **all Categories.**
6. Finally, click on the **Save** button

![](../../.gitbook/assets/2021-09-04-06\_49\_06-diagnostic-setting-microsoft-azure-and-4-more-pages-c4a8-ehamed-microsoft-.png)

### Archive to storage account (optional)

{% hint style="warning" %}
If you have created a storage account to store your SCEPman artifacts, or for Application logging, you can use the same storage account and skip the first step.
{% endhint %}

1. Create a storage account (Microsoft Guide [Create a Storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal#create-a-storage-account))
2. Go to your **App Service** and click on **Diagnostic settings (preview)**
3. In the filed **Diagnostic setting name** you need to put in a name to identify your configuration
4. Please select **Archive to a storage account** under the **Destination details** and select your **Subscription** and **Storage account**
5. After you selected the storage account you can see the files **Retention (days)** at the **Category details**
6. Select the needed data and type in your retention time in days. We recommend **all Categories** and a retention time of **30** days.
7. Finally, click on the **Save** button.

![](../../.gitbook/assets/2021-09-04-06\_50\_51-diagnostic-setting-microsoft-azure-and-4-more-pages-c4a8-ehamed-microsoft-.png)



