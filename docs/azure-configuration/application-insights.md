# Application Insights

{% hint style="info" %}
We recommend enabling Application Insights to receive a graphical representation of data about your SCEPman instance such as Failed requests, Availability, and Server response time over a given duration.
{% endhint %}

To activate the Application Insights for your App Service, please follow these instructions:

{% stepper %}
{% step %}
### Navigate to your SCEPman App Service

Azure > App Services > your SCEPman App Service (default name `app-scepman-<suffix>`)
{% endstep %}

{% step %}
### Select and Turn on Application Insights

On the lefthand menu, expand Monitoring > Application Insights

<figure><img src="../.gitbook/assets/image (11).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Create a new Application Insights resource

<figure><img src="../.gitbook/assets/image (4) (1) (1) (1).png" alt=""><figcaption></figcaption></figure>

#### Configure instrumentation

Under **Instrument your application**, select the **.NET Core (Linux)** or **.NET (Windows)** tab and set:

* **Collection level:** Recommended
* **Profiler:** On (default)
* **Snapshot debugger:** On (default)
* **Show local variables for exceptions:** Off

{% hint style="warning" %}
Keep **Show local variables** off. It delays SCEPman startup and can cause error messages.
{% endhint %}

<figure><img src="../.gitbook/assets/image (5) (1).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Apply settings

You're now set to use Application Insights for SCEPman!
{% endstep %}
{% endstepper %}
