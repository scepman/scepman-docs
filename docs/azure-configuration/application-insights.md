# Application Insights

{% hint style="info" %}
We recommend enabling Application Insights to receive a graphical representation of data about your SCEPman instance such as Failed requests, Availability, and Server response time over a given duration.
{% endhint %}

To activate the Application Insights for your App Service, please follow these instructions:

{% stepper %}
{% step %}
### Navigate to your SCEPman App Service

Azure > App Services > app-scepman-xxxxxx
{% endstep %}

{% step %}
### Select and Turn on Application Insights

On the lefthand menu, expand Monitoring > Application Insights

\
![](<../.gitbook/assets/image (3).png>)
{% endstep %}

{% step %}
### Create a new Application Insights resource

<figure><img src="../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>

For Windows based deployments, select **.NET** and select the **Collection level Recommended.** (For Linux based deployment, please choose **.NET Core**)

**Profiler** and **Snapshot debugger** should be turned on by default already.

Leave **Show local variables \[...]** as _Off_, otherwise, Application Insights may cause startup delays and error messages.

<figure><img src="../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Apply settings

You're now set to use Application Insights for SCEPman!
{% endstep %}
{% endstepper %}



