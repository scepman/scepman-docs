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
4. **Profiler** and **Snapshot debugger** should be turned on by default already.
5. Leave **Show local variables \[...]** at value _Off_, otherwise Application Insights may cause startup delays and error messages.
6. Finally, you can click on **Apply**

![](../../.gitbook/assets/image-3.png)
