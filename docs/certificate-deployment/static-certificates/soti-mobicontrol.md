# SOTI MobiControl

SCEPman can be integrated with SOTI MobiControl as a Certificate Authority. By connecting both systems through SCEPman's Static SCEP interface, MobiControl-enrolled devices can obtain device certificates from SCEPman.

For more general information about 3rd-party MDM solutions and SCEPman integration please check [here](./).

## SCEPman configuration

1. Please do the general setup of SCEPman as described [in our Getting Started Guide](../../scepman-deployment/deployment-guides/).
2. Please enable the Static SCEP interface of SCEPman as described [here](./#scepman-configuration).

## SOTI MobiControl configuration

### Add Certificate Authority

3. In Soti Mobicontrol, navigate to System Settings > Global Settings > Services > Certificate Authority.

<figure><img src="../../.gitbook/assets/image (1).png" alt=""><figcaption><p>Soti MobiControl Certificate Authority Page</p></figcaption></figure>

4. Click the Add button to create a new Certificate Authority.

<figure><img src="../../.gitbook/assets/image.png" alt=""><figcaption><p>Soti MobiControl Certificate Authority Details</p></figcaption></figure>

* Enter a **name** for this Certificate Authority.&#x20;
* Select `Generic SCEP` for **Certificate Type**.&#x20;
* Select `SCEP` for **Configuration Type**.&#x20;
* For the **Service URL**, Copy and Paste the Static MDM URL from your SCEPman Portal.&#x20;
* Enable **Use Static Challenge**.
* Enter the **Static Challenge** that was created during Step 2. above.&#x20;
* Enable **Use SCEP Client**.
* For the **Thumbprint** Copy and Paste the CA Thumbprint from your SCEPman Portal.
* Set the **Retries** and **Retry Delay** as desired (or leave at Default).

### Add Certificate Template

5. Click the Add button to add a **Certificate Template**.

<figure><img src="../../.gitbook/assets/image (2).png" alt=""><figcaption><p>Soti MobiControl Certificate Template Detail</p></figcaption></figure>

* Enter a **name** for this MobiControl Template.
* Enter a **Subject Name**.

{% hint style="info" %}
The format for the **Subject Name** field can only be the following format: “CN=%DEVICENAME%". Clicking the gear selection will display all of the variables that can be used. Be sure to include the “CN=” at the beginning of the entry.
{% endhint %}

* Leave **Alternative Subject** empty.
* **Certificate Target** defaults to `Device`.&#x20;
* Select the desired option for the remaining fields: **Certificate Usage**, **Key Size**, **Remove old certificates upon successful renewal**, and **Key Protection**.
* Click Add, then Save to save the Template

6. Click **Save** to save the Certificate Authority.
7. **Create a Profile** in Soti MobiControl to assign this to your devices. There are multiple ways of achieving this in Soti MobiControl, as such, this document will not detail those methodologies.
