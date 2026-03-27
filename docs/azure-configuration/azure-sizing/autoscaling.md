---
description: >-
  Autoscaling automatically adjusts the number of running instances based on
  demand to maintain performance and control costs.
---

# Autoscaling

## Instructions

{% stepper %}
{% step %}
### Navigate to your App Service Plan's Autoscale Settings

Azure Portal > App Service Plans > _Your SCEPman App Service Plan_ > Settings > Scale out

<figure><img src="../../.gitbook/assets/image (122).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
{% hint style="warning" %}
Please ensure that your App Service plan uses at least the **S1 or P0V3** pricing tier. Lower tiered plans may not provide multiple instances.
{% endhint %}

### Select Rules Based Autoscaling

Select **Rules Based**, then **Configure** to proceed.

<figure><img src="../../.gitbook/assets/image (123).png" alt=""><figcaption></figcaption></figure>


{% endstep %}

{% step %}
### Configure Autoscale Settings

To scale the instance count based on the current load of the service there must be two scaling rule conditions added. One rule to increase the instance count on heavy load and one rule to decrease the instance count after the load is reduced again.

<figure><img src="../../.gitbook/assets/image (127).png" alt=""><figcaption></figcaption></figure>

1. Select **Custom autoscale**
2. Type in an appropriate name in **Autoscale setting name**
3. Select **Scale based on a metric** to enable autoscaling based on a defined rule set
4. Set the instance limits in line with your business requirements:
   * Minimum
   * Maximum
   * Default
5. Select **Add a rule** once you're ready to configure your Autoscaling rules
{% endstep %}

{% step %}
### Configure Autoscaling Rules

{% hint style="info" %}
We recommend the following settings of the increase and decrease rules.\
But please keep in mind that this can depend on your workload and needs to be monitored and optimized!
{% endhint %}

#### Increase Instance Count Rule

1. **Enable metric divided by instance count**
2. Choose **Greater than** as the Operator and set the threshold to **70** (percent)
3. Set the duration to **10** (minutes)
4. Ensure that the **Time grain statistic** is set to **Average**
5. Ensure that the **Operation** is set to **Increase count by**
6. Set the **Cool down (minutes)** to **15** (minutes)
7. Check the **Instance count (1)** that will be added to the current instances
8. Click **Add** when done

<figure><img src="../../.gitbook/assets/image (129).png" alt=""><figcaption></figcaption></figure>



#### Decrease Instance Count Rule

1. Select **Add a rule** to add an additional rule
2. **Enable metric divided by instance count**
3. Choose **Less than** as the Operator and set the threshold to **35** (percent)
4. Set the duration to **20** (minutes)
5. Ensure that the **Time grain statistic** is set to **Average**
6. Ensure that the **Operation** is set to **Decrease count by**
7. Set the **Cool down (minutes)** to **30** (minutes)
8. Check the **Instance count (1)** that will be removed from the current instances
9. Click **Add** when done

<figure><img src="../../.gitbook/assets/image (128).png" alt=""><figcaption></figcaption></figure>


{% endstep %}

{% step %}
### Save Autoscale Settings

Congratulations! Your App Service Plan will now scale up and down in accordance with your rules.

<figure><img src="../../.gitbook/assets/image (130).png" alt=""><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}
