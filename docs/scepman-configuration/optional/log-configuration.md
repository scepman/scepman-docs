# Log configuration

## App Service Logs

To retain or archive the log files, we can configure the **Application logging \(Blob\)** and **Web server logging** in the **App Service**.

1. Go to your **App Service** and click on **App Service logs**
2. Activate **Application logging \(Blob\)** and set the **Level** to **Verbose**
3. Under **Storage Settings** you can select a storage account and container where you want to store the log files.
4. In the filed **Retention Period \(Days\)** you can enter how long your log files will be retained. Normally we recommend **30** days.
5. The next part is to activate the **Web server logging** by selecting **Storage**.
6. Under **Storage Settings** you can select a storage account and container where you want to store the log files.
7. In the filed **Retention Period \(Days\)** you can enter how long your log files will be retained. Normally we recommend **30** days.
8. The last step is to **activate** the **Detailed error messages** and **Failed request tracing**.
9. Finally, click on **Save**.

**Your configuration should look like this:**

![](../../.gitbook/assets/image%20%281%29.png)

## Diagnostic settings

To retain your diagnostic data, you can configure the streaming export of platform logs and metrics.  
You can choose different destinations as a location.

{% hint style="info" %}
We recommend storing your data in Log Analytics
{% endhint %}

### Log Analytics workspace

1. Create a Log Analytics workspace \(Microsoft Guide [Create a Log Analytics workspace](https://docs.microsoft.com/en-us/azure/azure-monitor/learn/quick-create-workspace#create-a-workspace)\) You can also use an existing one.
2. Go to your **App Service** and click on **Diagnostic settings \(preview\)**
3. In the filed **Diagnostic setting name** you need to put in a name to identify your configuration
4. Please select **Send to Log Analytics** under the **Destination details** and select your **Subscription** and **Log Analytics workspace**
5. The last step is to select the needed data. Normally we recommend **all Categories.**
6. Finally, click on the **Save** button

![](../../.gitbook/assets/image%20%283%29.png)

### Azure Storage

{% hint style="info" %}
If you have created a storage account to store your SCEPman artifacts, you can use the same storage account and skip the first step.
{% endhint %}

1. Create a storage account \(Microsoft Guide [Create a Storage account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal#create-a-storage-account)\)
2. Go to your **App Service** and click on **Diagnostic settings \(preview\)**
3. In the filed **Diagnostic setting name** you need to put in a name to identify your configuration
4. Please select **Archive to a storage account** under the **Destination details** and select your **Subscription** and **Storage account**
5. After you selected the storage account you can see the files **Retention \(days\)** at the **Category details**
6. Select the needed data and type in your retention time in days. Normally we recommend **all Categories** and a retention time of **30** days.
7. Finally, click on the **Save** button.

![](../../.gitbook/assets/image%20%282%29.png)

| Back to Trial Guide | Back to Community Guide | ​[Back to Enterprise Guide](../../getting-started/enterprise-guide.md#step-5-configure-log-collection)​ |
| :--- | :--- | :--- |


