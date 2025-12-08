# SOTI MobiControl

SCEPman can be integrated with SOTI MobiControl as a Certificate Authority. By connecting both systems through SCEPman's Static SCEP interface, MobiControl-enrolled devices can obtain device certificates from SCEPman.

For more general information about other MDM solutions and SCEPman integration please check [here](./).

## Enable SOTI MobiControl Integration

SOTI MobiControl integration of SCEPman can be easily enabled via the following environment variables on SCEPman app service:

{% hint style="info" %}
You can differentiate between the SCEPman App Service and the Certificate Master by looking for the App Service **without** the "-cm" in its name
{% endhint %}

|                                                                                                      Setting                                                                                                     | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                           [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                          | Enable the 3rd-party validation                                                                                                                                                                                                                                                                         |   **true** to enable, **false** to disable   |
|                   [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)                  | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|          [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)          | How many days shall certificates issued via SOTI MobiControl be valid                                                                                                                                                                                                                                   |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |

## SOTI MobiControl Configuration

### Deploy SCEPman RootCA

First, you need to deploy SCEPman RootCA to all endpoints as a trusted root ca, you can download the certificate from SCEPman homepage:

<figure><img src="../../.gitbook/assets/image (2) (2) (1).png" alt=""><figcaption></figcaption></figure>

### Add Certificate Authority

1. In Soti MobiControl, navigate to System Settings > Global Settings > Services > Certificate Authority.

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption><p>Soti MobiControl Certificate Authority Page</p></figcaption></figure>

2. Click the Add button to create a new Certificate Authority.

<figure><img src="../../.gitbook/assets/image (1) (1) (1) (1) (1) (1) (1).png" alt=""><figcaption><p>Soti MobiControl Certificate Authority Details</p></figcaption></figure>

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

3. Click the Add button to add a **Certificate Template**.

<figure><img src="../../.gitbook/assets/image (2) (1) (1) (1) (1).png" alt=""><figcaption><p>Soti MobiControl Certificate Template Detail</p></figcaption></figure>

* Enter a **name** for this MobiControl Template.
* Enter a **Subject Name**.

{% hint style="info" %}
The format for the **Subject Name** field can only be the following format: “CN=%DEVICENAME%". Clicking the gear selection will display all of the variables that can be used. Be sure to include the “CN=” at the beginning of the entry.
{% endhint %}

* Leave **Alternative Subject** empty.
* **Certificate Target** defaults to `Device`.&#x20;
* Select the desired option for the remaining fields: **Certificate Usage**, **Key Size**, **Remove old certificates upon successful renewal**, and **Key Protection**.
* Click Add, then Save to save the Template

4. Click **Save** to save the Certificate Authority.
5. **Create a Profile** in Soti MobiControl to assign this to your devices. There are multiple ways of achieving this in Soti MobiControl, as such, this document will not detail those methodologies.
