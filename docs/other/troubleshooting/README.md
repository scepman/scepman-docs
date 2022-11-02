# Troubleshooting

Please see the list of [Common Problems](general.md) if something is not working as you expect it. This page describes how to create and access the logs if you need more information about what's happening behind the scenes.

## Access SCEPman Logs

Check Azure Web App log files via **Advanced Tools**:

1. Go to **Kudu**
2. Use **CMD**
3. Navigate to **LogFiles**
4. Then, **Application**

Click on the download icon on the latest .txt file and review it

![](<../../../.gitbook/assets/event32\_3 (2) (7) (4) (1) (1) (1) (10) (13).png>)

![](<../../../.gitbook/assets/event32\_3 (2) (7) (4) (1) (1) (1) (10) (14).png>)

### Additional way of logging

1. Configure the **App Services Logs**
2. Check the **Log Stream** of the **App Service**.

![](<../../../.gitbook/assets/event32\_5 (2) (3) (3) (3) (3) (3) (2) (1) (1) (1) (1) (2) (3).png>)

![](<../../../.gitbook/assets/event32\_6 (3) (3) (3) (3) (3) (3) (2) (1) (1) (1) (1) (2) (2).png>)

1. Monitor the log stream
2. Reproduce the error
3. Look for the log starting with **Request validation unsuccessful, as Intune validation threw an exception**
4. These message should have more details
