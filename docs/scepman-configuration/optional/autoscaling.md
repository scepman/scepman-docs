# Autoscaling

To activate autoscaling navigate to the **Scale out \(App Service plan\)** in the navigation pane of your SCEPman App Service.

![](../../.gitbook/assets/image%20%284%29.png)

{% hint style="info" %}
Please ensure that your App Service plan uses at least the **S1** pricing tier. Otherwise the App Service plan will not provide multiple instances.
{% endhint %}

### Autoscale Conditions

To scale the instance count based on the current load of the service there must be two scaling rule conditions added. One rule to increase the instance count on heavy load and one rule to decrease the instance count after the load is reduced again.

![](../../.gitbook/assets/image%20%288%29.png)

* Select **Custom autoscale**
* Type in a appropriate name in **Autoscale setting name**
* Select **Scale based on a metric** to enable autoscaling based on a defined rule set
* Set the instance limits:
  * Minimum
  * Maximum
  * Default
* **Add a rule** once to increase the instance count and once to decrease the instance account

#### Increase Instance Count Rule

This is an example of a rule which increases the instance count by one instance when the average CPU usage is higher than 70% for 10 minutes. Adjust the criteria and metrics regarding your specific needs. 

![](../../.gitbook/assets/image%20%2812%29.png)

#### Decrease Instance Count Rule

![](../../.gitbook/assets/image%20%2810%29.png)

To decrease the instance count dynamically again a second rule is necessary which negates the first one. In this example the instance count is decreased by one instance when the average CPU usage is less than 20% for 10 minutes.

<table>
  <thead>
    <tr>
      <th style="text-align:left">
        <p></p>
        <p>Back to Trial Guide</p>
      </th>
      <th style="text-align:left">Back to Community Guide</th>
      <th style="text-align:left">&#x200B;<a href="../../getting-started/enterprise-guide.md#step-8-configure-autoscaling">Back to Enterprise Guide&#x200B;</a>
      </th>
    </tr>
  </thead>
  <tbody></tbody>
</table>

