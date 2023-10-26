---
description: for SCEPman Enterprise
---

# Licensing

{% hint style="info" %}
SCEPman does not display your license consumption. Please ensure compliance with the licensing terms below by reviewing the [Example](./#examples) section and by monitoring the profile assignments in your MDM solution on a regular basis.
{% endhint %}

## User-based Licensing

{% hint style="success" %}
In general, the subscription for SCEPman Enterprise is **user-based**.
{% endhint %}

User subscriptions are required but not limited to the following main use-cases, which are defined in detail in the following paragraphs:

* User & device certificates
* DC certificates
* Server certificates

The minimum amount of users that can be subscribed for one organization is 50.

A user subscription is bound to a single user for at least one calendar month and cannot be shared with other users.

### User & Device Certificates

The subscription of a "user" is required for each user, who or whose device is

* **enabled to request**,
* **using** or
* **storing**

certificates that are issued by SCEPman for the **user** or the user's **device**(s).

### DC Certificates

The subscription of a "user" is required for each user, who is enabled to access resources, that are authenticated by **Active Directory Domain Controllers** by leveraging the **DC certificates** issued by SCEPman.

### Server Certificates (SCEPman V2)

The subscription of a "user" is required for each user, who is enabled to access services, that use SCEPman server certificates for the connection with the user's machine or other purposes.

{% hint style="info" %}
In many cases the required number of user subscriptions for server certificates equals the number of users, who have the SCEPman root certificate deployed on one or more of their client devices.
{% endhint %}

### Code Signing Certificates (SCEPman V2.3)

The subscription of a "user" is required for each user, who is using & validating apps, scripts and other digital data, that were signed with code signing certificates issued by SCEPman.

{% hint style="info" %}
In many cases the required number of user subscriptions for code signing certificates equals the number of users, who have the SCEPman root certificate deployed on one or more of their client devices.
{% endhint %}

## Device Limits per User

A single user may have up to 10 personal devices:

* up to 5 desktop devices (Windows or MacOS) and
* up to 5 handheld devices (Android or iOS).

## Subscription Scope

A SCEPman subscription may be used for the clients & users of one organization.

It is **not** allowed to

* use one SCEPman subscription for multiple organizations,
* split one SCEPman subscription and/or re-sell it to multiple organizations.

## Examples

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

## Optional: Device-based Licensing

{% hint style="danger" %}
The usage of device-based licensing for SCEPman Enterprise must be cleared by the SCEPman team prior to usage in any case.
{% endhint %}

Customers can calculate the needed number of subscription "users" for SCEPman Enterprise based on the number of devices - **applies for some special use cases only**. For those cases one device will be counted as one "user".

These special use cases are:

* **Users without IT identity**\
  Devices that are used by more than one user, where the users do not have an IT account (like Azure AD or JAMF).
  * Example: A supermarket has a staff of 1,000 people. The staff does not work with PCs and does not have an Azure AD account. They share 400 barcode scanner devices. SCEPman issues device certificates to the barcode scanners only.\
    Needed subscription: 400 "users"
* **Device Sharing**\
  Environments where the ratio between devices and users is < 0,5.
  * Example: A school has 2,000 students and 600 devices. SCEPman issues device certificates to the 600 devices only.\
    Needed subscription: 600 "users"

{% hint style="warning" %}
For all device-based licensing cases, device certificates are allowed only.
{% endhint %}
