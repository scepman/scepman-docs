# Self Service Enrollment

{% hint style="info" %}
Applicable to SCEPman version 2.9 and above
{% endhint %}

For clients to enroll certificates for themselves without SCEP, they can use the SCEPman REST API. However, they should not be able to enroll any arbitrary certificate, only certificates that are tied to their own identity. Therefore, the SCEPman API has a role that can be assigned to users/groups to enable this.

## Prerequisites

* This role is included from SCEPman 2.9 onwards. If you installed SCEPman prior to this, you need to run the [installation script](../../scepman-configuration/post-installation-config.md#running-the-scepman-installation-cmdlet) again for this role to appear.

## Assigning Self Service Permissions

You can check that the Self Service role exists in the SCEPman-api App Registration:

<figure><img src="../../.gitbook/assets/image (79).png" alt=""><figcaption></figcaption></figure>

You can create role assignments for users and groups in the SCEPman-api Enterprise Application.&#x20;

<figure><img src="../../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>

## Certificate Enrollment Requests

A user with the self-service role can only enroll certificates with the following attributes. (These are the same as the attributes you would select when enrolling certificates via a SCEP profile in [Intune ](../microsoft-intune/)for instance). The certificate's validity will be tied to the device object in Intune or Entra Id or to the user object in Entra Id, analogously to Intune-enrolled certificates.

### Device Certificates

Either the Subject Alternative Name (SAN) must include `IntuneDeviceID://<IntuneDeviceId>` as an URI, where `<IntuneDeviceId>` without the curly braces is the Device Id of the device in Intune. Or the CN field of the Subject must be the Entra ID device ID or the Intune Device Id.

<table><thead><tr><th width="223">Field</th><th>Value</th></tr></thead><tbody><tr><td>Subject</td><td><code>CN=&#x3C;AAD_Device_Id></code> or <code>CN=&#x3C;DeviceId></code>, where the device is one owned by the user.</td></tr><tr><td>SAN (URI)</td><td><code>IntuneDeviceId://&#x3C;IntuneDeviceId></code></td></tr><tr><td>Basic Constraints</td><td><code>Subject Type=End Entity</code></td></tr><tr><td>EKUs</td><td><code>Client Authentication, 1.3.6.1.5.5.7.3.2</code></td></tr></tbody></table>

### User Certificates

<table><thead><tr><th width="221">Field</th><th>Value</th></tr></thead><tbody><tr><td>Subject</td><td><code>CN=&#x3C;DisplayName></code></td></tr><tr><td>SAN (Other Name/UPN)</td><td><code>&#x3C;UserPrincipalName></code></td></tr><tr><td>Basic Constraints</td><td><code>Subject Type=End Entity</code></td></tr><tr><td>EKUs</td><td><code>Client Authentication, 1.3.6.1.5.5.7.3.2</code></td></tr></tbody></table>

## Requesting the Certificate

On Linux, follow the instructions of the [Linux Enrollment Guide](linux-enrollment-guide.md).

For other plattforms, follow our general instructions for using the [Enrollment REST API](./).
