---
description: for SCEPman Enterprise
---

# Licensing

## User-based licensing

{% hint style="success" %}
In general, the subscription for SCEPman Enterprise is **user-based**.&#x20;
{% endhint %}

### User & device certificates

The subscription of a "user" is required for each user, who or whose device is&#x20;

* **enabled to request**,&#x20;
* **using** or&#x20;
* **storing**&#x20;

certificates that are issued by SCEPman for the **user** or the user's **device**(s).

### DC certificates

The subscription of a "user" is required for each user, who is enabled to access resources, that are authenticated by **Active Directory Domain Controllers** by leveraging the **DC certificates** issued by SCEPman.

### Server certificates (SCEPman V2)

The subscription of a "user" is required for each user, who is enabled to access services, that use SCEPman server certificates for the connection with the user's machine or other purposes.

{% hint style="info" %}
In many cases the required number of user subscriptions for server certificates equals the number of users, who have the SCEPman root certificate deployed on one or more of their client devices.
{% endhint %}

### Device limits per user

A single user may have up to 10 personal devices:

* up to 5 desktop devices (Windows or MacOS) and
* up to 5 handheld devices (Android or iOS).

### Subscription scope

A SCEPman subscription may be used for the clients & users of one organization.&#x20;

It is **not** allowed to&#x20;

* use one SCEPman subscription for multiple organizations,
* split one SCEPman subscription and/or re-sell it to multiple organizations.

### Examples

{% hint style="info" %}
In many Microsoft365-based scenarios the required number of users for the SCEPman Enterprise subscription equals the amount of Microsoft Intune subscriptions.
{% endhint %}

#### Example 1

A company has 2,000 users. 500 of those users have user and device certificates issued by SCEPman. The other 1,500 users do not have certificates issued by SCEPman. AD DC and server certificates are not used.

Required number of SCEPman Enterprise user subscriptions: 500

#### Example 2

A company has 2,000 users. 500 of those users have user and device certificates issued by SCEPman. The other 1,500 users do not have certificates issued by SCEPman. All 2,000 users are consuming resources that are authenticated by AD Domain Controllers by leveraging DC certificates issued by SCEPman. Server certificates are not used.

Required number of SCEPman Enterprise user subscriptions: 2,000

#### Example 3

A company has 2,000 users. 500 of those users have user and device certificates issued by SCEPman. The other 1,500 users do not have certificates issued by SCEPman. Server certificates issued by SCEPman are used and 1,500 users (including the 500 users with user & device certificates) have the SCEPman root certificate installed on one or more of their devices. AD DC certificates are not used.

Required number of SCEPman Enterprise user subscriptions: 1,500

## Optional: device-based licensing

{% hint style="danger" %}
The usage of device-based licensing for SCEPman Enterprise must be cleared by the SCEPman team prior to usage in any case.
{% endhint %}

Customers can calculate the needed number of subscription "users" for SCEPman Enterprise based on the number of devices - **applies for some special use cases only**. For those cases one device will be counted as one "user".&#x20;

These special use cases are:

* **Users without IT identity**\
  Devices that are used by more than one user, where the users do not have an IT account (like Azure AD or JAMF).
  * Example: A supermarket has a staff of 1,000 people. The staff does not work with PCs and does not have an Azure AD account. They share 400 barcode scanner devices. SCEPman issues device certificates to the barcode scanners only. \
    Needed subscription: 400 "users"
* **Device Sharing**\
  Environments where the ratio between devices and users is < 0,5.
  * Example: A school has 2,000 students and 600 devices. SCEPman issues device certificates to the 600 devices only.\
    Needed subscription: 600 "users"&#x20;

{% hint style="warning" %}
For all device-based licensing cases, device certificates are allowed only.
{% endhint %}



## Azure Marketplace

### Pricing Model

* Every plan consists of a **base fee** which includes a certain amount of users per month or per year (depending on the renewal interval of the plan). For example, the **base fee** of _SCEPman EE 50 (M)_ includes 50 users per month.
* If more than the included amount of users is required, **additional users** can be added to the  plan. For each additional user, we charge an additional monthly or annual per-user fee, depending on the renewal interval of the underlying plan.&#x20;
* The logic on our landing page will always choose the cheapest user segment based on your desired amount of total users. For example, if you require 300 users on a monthly basis, we will charge you with the _SCEPman EE 250 (M)_ base fee **plus 50 additional users** in the segment _SCEPman EE 250 (M)_.
* You will be prompted for your desired (additional) user count on our landing page during the subscription enrolment process.
* Upon initial subscription enrolment or during an intermediate subscription upgrade, our landing page will inform you about the licensing costs you have to expect to be charged with by Microsoft.&#x20;

### Invoicing

* During the first subscription interval, your subscription fees are not immediately due after completing the subscription enrolment. Instead we will report them to Microsoft after your cancellation grace period has expired.&#x20;
* Upon every renewal date, we will report your fees to Microsoft immediately.
* The related items should appear on your Microsoft invoice (PayAsYouGo) the month after we have reported your fees to Microsoft.

### Plan Overview

| **Plan**                       | **Renewal Interval** |
| ------------------------------ | -------------------- |
| SCEPman Enterprise Edition (M) | Monthly              |
| SCEPman Enterprise Edition (Y) | Annually             |

#### User Segments

All user segments are available for _SCEPman Enterprise Edition (M)_ and _SCEPman Enterprise Edition (Y)._ The annual plan is discounted by 10% in comparison to the monthly plan (calculated over the period of 12 months).

| **User Segment**       | **Included Users in Base Fee** | **Maximum Total User** |
| ---------------------- | ------------------------------ | ---------------------- |
| SCEPman EE (M/Y) 50    | 50                             | 249                    |
| SCEPman EE (M/Y) 250   | 250                            | 999                    |
| SCEPman EE (M/Y) 1000  | 1,000                          | 4,999                  |
| SCEPman EE (M/Y) 5000  | 5,000                          | 9,999                  |
| SCEPman EE (M/Y) 10000 | 10,000                         | unlimited              |

For prices in Euro (EUR), please check out our <mark style="color:green;"></mark> [website](https://www.scepman.com). For prices in _your_ currency, please directly refer to the Azure Marketplace in the [Azure Portal](https://portal.azure.com).

### User Up- and Downgrades

#### Upgrades

* If you would like to upgrade your user count, you can do that any time during the current subscription cycle by navigating to your **SCEPman subscription** in the [Azure SaaS portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.SaaS%2Fresources) <mark style="color:green;"></mark> and by clicking on "Open SaaS Account on publisher's site" (see screenshot below). This will re-direct you to our landing page where the amount of users can be upgraded.
* In case the upgrade occurs within the current subscription interval, only the prorated amount of fees incurred by the additional users will be reported to Microsoft for this interval.
* Our landing page will inform you about the new fees for a **complete** subscription cycle.
* After confirming your choice and once we have updated the license in our backend, you will receive a confirmation email from us.

![](../.gitbook/assets/sample\_subscription\_azure\_saas\_publisher\_link.png)

#### Downgrades

* Downgrading the amount of users is currently not possible without cancelling the subscription.
* If you want to perform a downgrade, please cancel your current subscription from the <mark style="color:green;"></mark> [Azure SaaS portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.SaaS%2Fresources) towards the end of the current cycle by clicking "Cancel subscription" (see screenshot below) and re-subscribe to your desired plan with the desired user amount once the cancellation becomes effective.
* Please do not forget to update the license key in your SCEPman instance afterwards as described in [here](https://docs.scepman.com/scepman-configuration/optional/add-a-license-key).

![](<../.gitbook/assets/sample\_subscription\_azure\_saas\_cancel (3).png>)

#### Change of Renewal Cycle

* Changing the renewal cycle is currently not possible without cancelling the subscription.
* If you want to change the renewal cycle, please cancel your current subscription from your <mark style="color:green;"></mark> [Azure SaaS portal](https://portal.azure.com/#blade/HubsExtension/BrowseResourceBlade/resourceType/Microsoft.SaaS%2Fresources) towards the end of the current cycle by clicking "Cancel subscription" (see screenshot above) and re-subscribe to your desired plan once the cancellation becomes effective.
* Please do not forget to update the license key in your SCEPman instance afterwards as described in [here](https://docs.scepman.com/scepman-configuration/optional/add-a-license-key).

### **Trials**

By default, when you purchase a plan from the Azure Marketplace, we will apply a 30-day trial period, for which we will not charge any subscription fees.&#x20;

This applies only to those customers who have never had a trial period before.

#### **Custom Trials**

In case you have special requirements or constraints that require more than 30 days of testing period, please [get in contact with us](https://glueckkanja.zendesk.com/hc/en-us/categories/360001671880-SCEPman) directly or send us an email to [sales@radiusaas.com](mailto:sales@scepman.com) for an individual trial offer.

### How to Get Started

To get started with your SCEPman subscription,

* Locate SCEPman on the **Marketplace** in your [**Azure Portal**](https://portal.azure.com/#create/glueckkanja-gabag.radiusaas-transactable-prod/preview).&#x20;

![](<../.gitbook/assets/Screenshot 2021-12-06 at 16.25.44.png>)

* Click "Set up + subscribe" and select your preferred plan based on the desired **renewal interval** (monthly or annual). We recommend to keep **Recurring billing** **on** so that you do not have to worry about a manual renewal of your subscription. Click "Review + subscribe" to deploy the subscription to your Azure SaaS.

![](<../.gitbook/assets/image (1).png>)

{% hint style="info" %}
Please not be confused by the random order of the add-ons. This is currently investigated by Microsoft. Later during the the enrolment process, we will provide you with transparent information on the expected licensing fees.
{% endhint %}

* Once you have successfully deployed the SaaS subscription into your Azure SaaS portal, please navigate to our subscription landing page by clicking "Configure account now"

{% hint style="info" %}
You will only be charged by Microsoft, once you have completed the enrolment on our landing page. Until then the subscription will remain in status "Fulfillment pending".
{% endhint %}

* After authenticating on our landing page using your Microsoft credentials, you will be prompted for additional information, such as the desired User amount
* Based on the amount of users provided on our landing page, we will charge the relevant base fee for your user segment as well as additional users, in case you require more than the included amount in your base fee.
* The landing page will show you the licensing fees you have to expect
* If you are happy with it, please complete the enrolment, which triggers us to generate a **SCEPman license key**. You will receive this key as part of our welcome email including all relevant information on the next steps regarding the deployment of SCEPman. This won't take any longer than one business day.

{% hint style="warning" %}
In case you have already deployed SCEPman and are only seeking to update the license key, please follow [this guide](../scepman-configuration/optional/add-a-license-key.md).
{% endhint %}

