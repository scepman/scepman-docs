# Certificate-based Authentication for Entra ID

Certificate-based authentication offers a strong security alternative for accessing Entra ID resources. This article provides a walkthrough of how to configure this method, utilizing SCEPman as the Certificate Authority to streamline certificate management.

## Enable SCEPman CRL

Entra ID will require a CRL to validate the certificates. Make sure to set the following environment variables in your app service for the CRL to be available:

[AppConfig:CRL:RequestToken](https://docs.scepman.com/scepman-configuration/application-settings/crl#appconfig-crl-requesttoken)

Set this to a custom string that will be used in the URL to allow the CRL to be downloaded.

[AppConfig:CRL:Source](https://docs.scepman.com/scepman-configuration/application-settings/crl#appconfig-crl-source)

This is the source that SCEPman builds the CRL from. Make sure that this is set to `Storage`

## Setup Entra ID

{% stepper %}
{% step %}
### Create PKI in Entra Security Center

In Entra ID, navigate to **Protection** > **Security Center** > [**Public Key Infrastructure**](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/SecurityMenuBlade/~/PublicKeyInfrastructure/menuId/SecurityCenter/fromNav/)**,** click on _Create PKI_ and select a matching display name.
{% endstep %}

{% step %}
### Add Certificate Authority

Navigate to the newly created PKI and click on _Add certificate authority_ to upload the CA certificate of your SCEPman instance. This certificate can be obtained from its homepage in the menu on the right side (_Get CA Certificate_).

For the Certificate revocation list URL you can enter the URL in the following format:

```
https://scepman.contoso.com/crl/pem/{YourCrlRequestToken}
```

{% hint style="warning" %}
Make sure to include the `/pem/` path in your URL as Entra might have compatibility issues when using the default DER format.
{% endhint %}

This should now leave you with a certificate authority similar to the following:

<figure><img src="../../../.gitbook/assets/image (89).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Enable CBA in Authentication Methods

With the CA in place, we can go on and enable certificate based authentication in **Protection** > **Authentication methods** > [**Policies**](https://entra.microsoft.com/#view/Microsoft_AAD_IAM/AuthenticationMethodsMenuBlade/~/AdminAuthMethods/fromNav/)

Go to the _Certificate-based authentication_ policy, enable it and allow either all users or specific groups to use this method:

![](<../../../.gitbook/assets/image (90).png>)
{% endstep %}

{% step %}
### Configure Certificate-based Authentication

Switch to the _Configure_ tab and go through the options:

**Require CRL validation**: ✅

This is an essential part of the security this method provides as the CRL will tell Entra ID which certificates have been revoked and shall therefore not be allowed for authentication.

**Issuer Hints** : ✅

Enabling the issuer hints will only show certificates during authentication, that are issued by the configured CA.

Leave the default settings for authentication binding and go on to create a rule to allow the earlier created certificate authority:

<figure><img src="../../../.gitbook/assets/image (91).png" alt=""><figcaption></figcaption></figure>

**Authentication strength**:

This defines the weight of the authentication using this CA. If you select _Single-factor authentication_, another authentication method can be necessary depending on the application to be accessed.



**Affinity binding**:

The affinity binding defines the required details in the certificate, that needs to match correlating data in the user object, for the authentication to be allowed. As SCEPman can currently not add any certificate information in user object we recommend to set this to **Low** unless you configure the required information manually.

{% hint style="warning" %}
The authentication strength and affinity binding settings highly depend on the specific use case and the kind of accounts you want to protect with this authentication method. In case you want to secure highly privileged users you should think of manually adding the certificate information in their user accounts for a high affinity.
{% endhint %}
{% endstep %}
{% endstepper %}

## Usage

With the configuration being in place, a user can select _Use a certificate or smart card_:

<figure><img src="../../../.gitbook/assets/image (94).png" alt=""><figcaption></figcaption></figure>

Which will in turn ask for the certificate to be used for authentication.

<figure><img src="../../../.gitbook/assets/image (93).png" alt=""><figcaption></figcaption></figure>

## Manually adding certificate mapping for high affinity binding

In case you want to enable CBA only using high affinity binding you can manually enter the certificates details in the authorized information of the user.

Navigate to the users properties in Entra ID, edit them and now edit the **Certificate user IDs**:

<figure><img src="../../../.gitbook/assets/image (92).png" alt=""><figcaption></figcaption></figure>

The required format of these IDs depends on the fields that have been configured in the authentication methods user binding. A list of formats can be found in the corresponding [Microsoft documentation](https://learn.microsoft.com/en-us/entra/identity/authentication/concept-certificate-based-authentication-certificateuserids#supported-patterns-for-certificate-user-ids).

Example for the _SHA1PublicKey_ binding:

```
X509:<SHA1-PUKEY>9600e49d740011187e5c734bab4a3d5d18d2a87a
```

This is using the certificates thumbprint to strongly map the identity of the user.
