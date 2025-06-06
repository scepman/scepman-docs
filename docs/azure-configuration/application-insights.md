# Application Insights

{% hint style="info" %}
We recommend enabling Application Insights to get a very helpful graphical representation of data about your SCEPman instance such as Failed requests, availability, and Server response time for a specific timeslot! This is very helpful in troubleshooting.
{% endhint %}

To activate the Application Insights for your App Service, please follow these instructions:

1. Open your **App Service**
2. On the left side, you can click on **Application Insights** under **Monitoring**

![](<../.gitbook/assets/image (5) (1) (1).png>)

3. On the Application Insights pane, you can click the button Turn on Application Insights
4. You can create a new Application Insights resource or select an existing one in the new context. \
   The dialog automatically wants to create a new Application Insights resource and take the name of the App Service. We recommend creating a new Application Insights resource for SCEPman.

<figure><img src="../.gitbook/assets/2023-10-23 13_39_08-app-scepman-mex6exctu2nzq.png" alt=""><figcaption></figcaption></figure>

5. You need to select **.NET** and select the **Collection level Recommended.** (For Linux based deployment, please choose **.NET Core**)

<figure><img src="../.gitbook/assets/2023-10-23 13_42_16-app-scepman-mex6exctu2nzq.png" alt=""><figcaption></figcaption></figure>

6. **Profiler** and **Snapshot debugger** should be turned on by default already.
7. Leave **Show local variables \[...]** at value _Off_, otherwise, Application Insights may cause startup delays and error messages.
8. Finally, you can click on **Apply**



