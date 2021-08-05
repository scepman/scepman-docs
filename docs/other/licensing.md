# Licensing

## User-based licensing

{% hint style="success" %}
In general, the subscription for SCEPman Enterprise is **user-based**. 
{% endhint %}

The subscription of a "user" is required for each user, who or whose device is 

* **enabled to request**, 
* **using** or 
* **storing** 

certificates that are issued by SCEPman for the user or the user's device\(s\).

A single user may have up to 10 personal devices:

* up to 5 desktop devices \(Windows or MacOS\) and
* up to 5 handheld devices \(Android or iOS\).

{% hint style="info" %}
In many Microsoft365-based scenarios the required number of users for the SCEPman Enterprise subscription equals the amount of Microsoft Intune subscriptions.
{% endhint %}

## Optional: device-based licensing

{% hint style="danger" %}
The usage of device-based licensing for SCEPman Enterprise must be cleared with the SCEPman team prior to usage in any case.
{% endhint %}

Customers can calculate the needed number of subscription "users" for SCEPman Enterprise based on the number of devices - **applies for some special use cases only**. For those cases one device will be counted as one "user". 

These special use cases are:

* **Users without IT identity** Devices that are used by more than one user, where the users do not have an IT account \(like Azure AD or JAMF\).
  * Example: A supermarket has a staff of 1,000 people. The staff does not work with PCs and does not have an Azure AD account. They share 400 barcode scanner devices. SCEPman issues device certificates to the barcode scanners only.  Needed subscription: 400 "users"
* **Device Sharing** Environments where the ratio between devices and users is &lt; 0,5.
  * Example: A school has 2,000 students and 600 devices. SCEPman issues device certificates to the 600 devices only. Needed subscription: 600 "users" 

{% hint style="warning" %}
For all device-based licensing cases, device certificates are allowed only.
{% endhint %}



