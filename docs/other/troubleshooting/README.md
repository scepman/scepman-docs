# Troubleshooting

Please see the list of [Common Problems](general.md) if something is not working as you expect it. This page describes how to create and access the logs if you need more information about what's happening behind the scenes.

## Access SCEPman Logs

You can use the [log archive in blob storage](../../scepman-configuration/optional/log-configuration.md) to access SCEPman's logs. However, if you don't want to configure this or just want to have a quicker look into the logs, it might be easier to use one of the two methods described below: Downloading logs from the App Service's file system or monitoring the Log Stream.

### Downloading the Logs

Configure the **App Services Logs**

![](<../../../.gitbook/assets/event32\_5 (2) (3) (3) (3) (3) (3) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (2).png>)

Check Azure Web App log files via **Advanced Tools**:

1. Go to **Kudu**
2. Use **CMD**
3. Navigate to **LogFiles**
4. Then, **Application**

Click on the download icon on the latest .txt file and review it

![](<../../../.gitbook/assets/event32\_3 (2) (7) (4) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (11) (9).png>)

### Live Log Monitor

Check the **Log Stream** of the **App Service**:

![](<../../../.gitbook/assets/event32\_6 (3) (3) (3) (3) (3) (3) (2) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (1) (3).png>)

1. Monitor the log stream.
2. Reproduce the error.
3. Look for the log starting with **Request validation unsuccessful, as Intune validation threw an exception**.
4. These message should have more details.
