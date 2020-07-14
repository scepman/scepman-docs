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
9. Finally click on **Save**.

**Your configuration should look like this:**

![](../../../.gitbook/assets/image%20%281%29.png)

## Diagnostic settings



