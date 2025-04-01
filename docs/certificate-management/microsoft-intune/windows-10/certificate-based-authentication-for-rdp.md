# Certificate Based Authentication for RDP

You can use SCEPman to issue Smart Card Login certificates to your users. By enrolling them to Windows Hello for Business (_Microsoft Passport Key Storage Provider_) they can use these certificates to authenticate to on premises resources using their Hello PIN or biometric options.

This will allow users for example to connect to other clients over the Remote Desktop Protocol (RDP) using their Windows Hello for Business credentials.



## Setup Active Directory

### Requirements

* SCEPman's CA certificate must be published in the **NTAuth** store to authenticate users to Active Directory
* Domain Controllers need to have a domain controller certificate to authenticate smartcard users
* Domain Controllers and target machines need to trust SCEPmans Root CA



Follow our guide on Domain Controller certificates to publish the SCEPman Root CA certificate to the **NTAuth** store and issue certificates to your domain controllers:

{% content-ref url="../../domain-controller-certificates.md" %}
[domain-controller-certificates.md](../../domain-controller-certificates.md)
{% endcontent-ref %}



You can create a **Group Policy Object** to handle the distribution of the root certificate to the involved machines:[ To distribute certificates to client computers by using Group Policy](https://learn.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/distribute-certificates-to-client-computers-by-using-group-policy#to-distribute-certificates-to-client-computers-by-using-group-policy)

The certificate needs to be deployed to all Domain Controllers handling the authentications and all target machines that users want to connect to using this method.

{% hint style="danger" %}
Please be aware that once SCEPmans root certificate is published in the NTAuth store, users who can influence the content of certificates issued by SCEPman (e.g. Intune administrators) are able to impersonate any Active Directory principal.
{% endhint %}



## Deploy the Smart Card Certificates using Intune

### Trusted Certificate Profile

Your clients will need to [trust the root certificate of SCEPman](https://docs.scepman.com/certificate-deployment/microsoft-intune/windows-10#root-certificate).

If you already use SCEPman to deploy certificates to your clients you will already have this profile in place.

### Smart Card Certificate

Create a profile for **Windows 10 and later** with type **SCEP certificate** in Microsoft Intune and configure the profile as described:

<details>

<summary>Certificate type: <code>User</code></summary>



</details>

<details>

<summary>Subject name format: <code>CN={{UserPrincipalName}}</code></summary>

If the targeted users UPN suffix in Entra ID happens to be different to the one used in Active Directory you should use `CN={{OnPrem_Distinguished_Name}}`

</details>

<details>

<summary>Subject alternative name: UPN value: <code>{{UserPrincipalName}}</code> and URI value: <code>{{OnPremisesSecurityIdentifier}}</code></summary>

The URI with the SID is necessary to have a [Strong Certificate Mapping](../../../scepman-configuration/application-settings/certificates.md#appconfig-addsidextension) in AD. Alternatively, you can configure SCEPman to [add a extension with the SID](../../../scepman-configuration/application-settings/scep-endpoints/intune-validation.md#appconfig-intunevalidation-waitforsuccessnotificationresponse) to user certificates and not configure the URI.

</details>

<details>

<summary>Key storage provider (KSP): <code>Enroll to Windows Hello for Business, otherwise fail (Windows 10 and later)</code></summary>



</details>

<details>

<summary>Key usage: <code>Digital signature</code> and <code>Key encipherment</code></summary>



</details>

<details>

<summary>Key size (bits): <code>2048</code></summary>



</details>

<details>

<summary>Hash algorithm: <code>SHA-2</code></summary>



</details>

<details>

<summary>Root Certificate: <code>Profile from previous step (Trusted Certificate Profile)</code></summary>



</details>

<details>

<summary>Extended key use: <code>Client Authentication</code> and <code>Smart Card Log</code>in</summary>

`Client Authentication, 1.3.6.1.5.5.7.3.2`

`Smart Card Logon, 1.3.6.1.4.1.311.20.2.2`

</details>

<details>

<summary>SCEP Server URLs: Open the SCEPman portal and copy the URL of <a href="certificate-based-authentication-for-rdp.md#device-certificates">Intune MDM</a></summary>



</details>



### Use Windows Hello for Business to connect to remote hosts

With the certificate deployed to the authenticating client, just connect to the remote host and select the configured Windows Hello for Business credential provider.&#x20;

<figure><img src="../../../.gitbook/assets/image (43).png" alt=""><figcaption></figcaption></figure>
