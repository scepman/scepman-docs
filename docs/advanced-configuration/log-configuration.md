# Log configuration

{% hint style="info" %}
In this article, we are recommending **App Service logs** settings, but you can always (depending on your use case) customize the settings to fit your environment.
{% endhint %}

## App Service Logs (Recommended settings)

To retain or archive the log files, we recommend configuring the following settings under **Monitoring** -> **App Service logs** of your SCEPman instance:

1. Activate **Application logging (Filesystem)** and set the **Level** to **Verbose:** this will allow you to see the **Application logs** under **Log stream**
2. Activate **Application logging (Blob)**. This is very helpful to save the **application logging** for long term.
   1. Set the **Level** to **Verbose**.
   2. Set the **Storage settings** to a **Storage account**. You can use the same **Storage account** you already created for Certificate Master, otherwise you can create a new [**Storage account**](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal#create-a-storage-account). If you are configuring this for a [geo-redundant app service](geo-redundancy.md), you must create a new Storage Account, because App Services can log only into Blob Storage Accounts in the same region.
   3. Create a **new Blob Container** for the logs, e.g. _scepman-logs_.
   4. Save the **Application logging** in the Blob Container you have just created.
   5. We recommend 30 days for **Retention Period**.
3. Activate **Web server logging** by selecting **Storage** and the **Storage account** you already have created. This will save the logs of the web server where SCEPman is running and not of the SCEPman application itself. This could be helpful in some special troubleshooting cases. We recommend 30 days for **Retention Period.**
4. Turn on **Detailed error messages** and **Failed request tracing.**
5. Do not forget to **Save.**

Your **App Service logs** settings should be **(in our example)** like:

![](<../.gitbook/assets/2021-09-04 06-40-56-scepman-apppnf42avv2wmis - Microsoft Azure and 4 more pages - C4A8 EHamed - Micr.png>)

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

![](<../.gitbook/assets/2021-09-04 06-49-06-Diagnostic setting - Microsoft Azure and 4 more pages - C4A8 EHamed - Microsoft​.png>)

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

![](<../.gitbook/assets/2021-09-04 06-50-51-Diagnostic setting - Microsoft Azure and 4 more pages - C4A8 EHamed - Microsoft​.png>)