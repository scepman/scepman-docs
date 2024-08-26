# Health Check

You can monitor the health of SCEPman using

* the [Health check feature of the Azure App Services](./#health-check-in-azure-app-services)  (recommend) \
  or
* a [3rd party monitoring tool](using-3rd-party-monitoring.md).

## Health Check in Azure App Services

You may configure the health check feature and corresponding alerting for the App Service to get a direct notification in case your SCEPman instance is no longer responsive.

### Configure Health Check

1. Navigate to your **App Service** and on the left side scroll down to **Health check**
2. Now you can **Enable** the Health check, as probing **path** enter the following: **/probe**
3. Now you can click on **Save**, but keep in mind that **this will restart your App Service**

![Enable Health check](<../../.gitbook/assets/2022-12-27 13\_04\_05.png>)

### Configure Alerting

To get an alert from our health check we need to configure alert rules in our App Service.

1. Navigate to your **App Service** and on the left side scroll down to **Alerts**
2. Click on **Create alert rule**
3. In your new alert rule, you will be automatically redirected to **Add condition**
4. Select a signal logic. Search for **Health check status**

![Create alert rule](<../../.gitbook/assets/2022-12-27 12\_13\_22.png>)

5. Configure the alert as specified below:

| **Threshold**        | Static     |
| -------------------- | ---------- |
| **Aggregation type** | Average    |
| **Operator**         | Less than  |
| **Unit**             | Count      |
| **Threshold value**  | 70         |
| **Check every**      | 5 minutes  |
| **Loopback period**  | 15 minutes |

<figure><img src="../../.gitbook/assets/image (46).png" alt=""><figcaption><p>Alert rule condition</p></figcaption></figure>

6. Click on **Next: Actions**
7. Select **Create action group**

{% hint style="info" %}
If you have existing action groups, choose **Select action groups**, select an action group and move to step 14.
{% endhint %}

8. Define an **Action group name** and **Display name**

![Create action group](<../../.gitbook/assets/2022-12-27 12\_29\_38.png>)

9. Next to **Notifications** and add **Notification type**
10. In the window, tick the **Email** checkbox and enter the email address you wish to receive notifications on
11. Then click on **OK**
12. Enter a **Name** for the Notification type

![Set notifications to action group](../../.gitbook/assets/screen-shot-2021-01-19-at-11.11.40.png)

13. After that you can click on **Review + create** and then on **Create.** You will be redirected back to **Actions** in creating the alert rule
14. Next to D**etails**, configure the following
    * **Resource group**
    * **Severity**
    * **Alert rule name**
    * Enable: **Enable upon creation**
    * Enable: **Automatically resolve alerts**

<figure><img src="../../.gitbook/assets/2023-10-23 13_51_20-Create an alert rule.png" alt=""><figcaption><p>Alert details</p></figcaption></figure>

15. Click on **Review + Create,** then **Create**

<figure><img src="../../.gitbook/assets/2023-10-23 13_55_02-Create an alert rule.png" alt=""><figcaption></figcaption></figure>

16. View your existing **Alert rules** as shown

![View existing alert rules](<../../.gitbook/assets/2022-12-27 12\_46\_42.png>)
