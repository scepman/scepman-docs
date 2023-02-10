# Health Check

You may configure the health check feature and corresponding alerting for the App Service to get a direct notification in case your SCEPman instance is no longer responsive.

{% hint style="warning" %}
After you have configured the health check and Alerting correctly it takes some time until the alert rule works properly. It is because the metric **Health check status** needs some time to get the information and the dynamic alert rule threshold needs some time to analyze the metric.
{% endhint %}

## Configure Health Check

1. Navigate to your **App Service** and on the left side scroll down to **Health check**
2. Now you can **Enable** the Health check, as probing **path** enter the following: **/probe**
3. Now you can click on **Save**, but keep in mind that **this will restart your App Service**

![Enable Health check](<../.gitbook/assets/2022-12-27 13\_04\_05.png>)

## Configure Alerting

To get an alert from our health check we need to configure alert rules in our App Service.

1. Navigate to your **App Service** and on the left side scroll down to **Alerts**
2. Click on **Create alert rule**
3. In your new alert rule, you will be automatically redirected to **Add condition**
4. Select a signal logic. Search for **Health check status**

![Create alert rule](<../.gitbook/assets/2022-12-27 12\_13\_22.png>)

5\. Now switch the **Threshold** to **Dynamic**\
\*\*\*\*6. Set **Aggregation type** to **Average**\
\*\*\*\*7. Set **Operator** to **Greater or Less than**\
\*\*\*\*8. Change the **Threshold Sensitivity** to **High**\
\*\*\*\*9. Select **5 minutes** to **Check every**\
\*\*\*\*10. And **15 minutes** as the **Lookback period**\
\*\*\*\*11. \*\*\*\* Click on **Next: Actions**

![Alert rule condition](<../.gitbook/assets/2022-12-27 10-34-32 (1).png>)

12\. Now you need to **Select action groups,** If you do not have any action groups available, you can click on **Create action group**

13\. Define an **Action group name** and **Display name**

![Create action group](<../.gitbook/assets/2022-12-27 12\_29\_38.png>)

14\. Next to **Notifications** and add **Notification type**\
15\. In the windows select **Email** and enter your email address that you want to get the notifications\
16\. Then click on **OK**\
17\. Enter a **Name** for the Notification type

![Set notifications to action group](../.gitbook/assets/screen-shot-2021-01-19-at-11.11.40.png)

18\. After that you can click on **Review + create** and then on **Create** to be redirected back to **Actions** in creating the alert rule, Next to **Details**\
\*\*\*\*19. Now you must enter an **Alert rule name**, define the **Severity, Enable alter rule upon creation,** and **Automatically resolve alerts.**\
20\. Click on **Review + Create,** then **Create**

![Create alert rule](<../.gitbook/assets/2022-12-27 12\_41\_27.png>)

![Create alert rule](<../.gitbook/assets/2022-12-27 12\_43\_31.png>)

![View existing alert rules](<../.gitbook/assets/2022-12-27 12\_46\_42.png>)
