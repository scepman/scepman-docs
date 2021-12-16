# Application Insights

{% hint style="info" %}
We recommend enabling Application Insights to get a very helpful graphical representation of data about your SCEPman instance such as Failed requests, availability, and Server response time for a specific timeslot! This is very helpful by troubleshooting.
{% endhint %}

To activate the Application Insights for your App Service, please follow this instruction:

1. Open your **App Service**
2. On the left side you can click on **Application Insights** under **Settings**

![](<../../../.gitbook/assets/image (5).png>)

1. On the Application Insights pane you can click the button Turn on Application Insights
2. In the new context you can create a new Application Insights resource or select existing one. _(See frame **1** in Screenshot)_\
   The dialog automatically wants to create a new Application Insights resource and take the name of the App Service. We recommend creating a new Application Insights resource for SCEPman.
3. You need to select **.NET** and select the **Collection level Recommended.** _(See frame **2** in Screenshot)_
4. Turn on the **Profiler**, **Snapshot debugger** and **Show local variables \[...]** _(See frame **2** in Screenshot)_
5. Finally, you can click on **Apply**

![](<../../../.gitbook/assets/image (7).png>)

| Back to Trial Guide | [Back to Community Guide](../../scepman-deployment/community-guide.md#step-7-deploy-application-insights) | ​[Back to Enterprise Guide​](../../scepman-deployment/enterprise-guide.md#step-7-deploy-application-insights) |
| ------------------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
