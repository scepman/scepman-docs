# Other MDM Solutions

{% hint style="info" %}
This feature requires version **1.6** or above.
{% endhint %}

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

You can use SCEPman to issue certificates via MDM systems other than Intune. You must configure a static challenge password (see [RFC 8894, Section 7.3](https://www.rfc-editor.org/rfc/rfc8894.html#name-challengepassword-shared-se) for the formal specification) in both SCEPman and the MDM system. Virtually all MDM systems support this mode of SCEP authentication.

Note however, that this does not provide the same level of security as the authentication mode employed with Intune. The challenge password authenticates requests from the MDM system, so SCEPman knows they come from a trusted source. But if attackers steal the challenge password, they can authenticate any certificate request and make SCEPman issue them whatever certificate they want.

It is therefore crucial to keep the challenge password secure. This can be achieved when the MDM system acts as the SCEP client and delivers the final package comprising certificate and private key to the end-user devices. This way, the challenge password is used only available to SCEPman and the MDM system, but not on the end-user devices.

## SCEPman Configuration

To enable the feature, you must add two application settings in your SCEPman service. **Please generate a new key/password and store it somewhere safe.** (you will need it in the following steps and later, on the MDM system)

1. Navigate to **App Services**
2. Then choose your SCEPman app
3. Select **New application setting**
4. Type **AppConfig:StaticValidation:Enabled** as Name
5. Type **true** as Value
6. Confirm with **OK**
7. Select **New application setting** again
8. Type **AppConfig:StaticValidation:RequestPassword** as Name
9. Type your **key/password**, that you have generated earlier, as Value
10. Confirm with **OK**
11. Save the application settings

## MDM Configuration

The specific steps depend on the MDM system you are using. You must add [https://scepman.contoso.de/static](https://scepman.contoso.de/static) as SCEP URL somewhere and you must add the challenge password to your MDM system's SCEP configuration. For security reasons, please make your MDM system a SCEP proxy.

Note that there are two variants of SCEP proxy implementations, only one of which is secure in this configuration:

1. Your MDM system may act as a SCEP client, generate the secret keypair, and deliver the complete package consisting of certificate and private key to the end-user devices. This is secure, as the challenge password is used only between MDM system and SCEPman.
2. Your MDM system relays SCEP messages between end-user device and SCEPman. The end-user device generates the secret keypair and _adds the challenge password_ to the certificate request. This is less secure, as an attacker with control over a single end-user device may steal the challenge password and request all kinds of certificates from SCEPman. Furthermore, the MDM system cannot control whether the client has correctly requested a certificate or whether the certificate request is incorrect, possibly allowing for identity theft or other threats.
