# Other MDM Solutions

You can use SCEPman to issue certificates via MDM systems other than Intune. You must configure a static challenge password (see [RFC 8894, Section 7.3](https://www.rfc-editor.org/rfc/rfc8894.html#name-challengepassword-shared-se) for the formal specification) in both SCEPman and the MDM system. Virtually all MDM systems support this mode of SCEP authentication.

Note however, that this does not provide the same level of security as the authentication mode employed with Intune. The challenge password authenticates requests from the MDM system, so SCEPman knows they come from a trusted source. But if attackers steal the challenge password, they can authenticate any certificate request and make SCEPman issue them whatever certificate they want.

It is therefore crucial to keep the challenge password secure. This can be achieved when the MDM system acts as the SCEP client and delivers the final package comprising certificate and private key to the end-user devices. This way, the challenge password is used only available to SCEPman and the MDM system, but not on the end-user devices.

## SCEPman Configuration

There are two SCEP endpoints to choose from when configuring SCEPman for MDM systems other than Intune and Jamf Pro:

* Static-AAD
* Static

The Static-AAD endpoint is recommended for MDM systems with Entra ID integration such as Kandji and Google Workspace. _User_ certificates distributed from the Static-AAD endpoint will benefit from [Automatic Revocation](../manage-certificates.md#automatic-revocation) when the respective user has been disabled in Entra ID.&#x20;

The Static endpoint is recommended for all other MDM systems.

{% tabs %}
{% tab title="Static-AAD" %}
Add the following settings to your **SCEPman App Service** > Environment Variables > Add.

Once the settings have been added, save the settings and restart your **SCEPman App Service**.

|                                                                                                                    Setting                                                                                                                   | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                                    [AppConfig:StaticAADValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enabled)                                    | Enable Static-AAD validation                                                                                                                                                                                                                                                                            | _**true**_ to enable, _**false**_ to disable |
|                            [AppConfig:StaticAADValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-requestpassword)                            | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|        <p><a href="../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-validityperioddays">AppConfig:StaticAADValidation:ValidityPeriodDays</a></p><p>(optional)</p>       | Days certificates issued via the Static-AAD endpoint are valid                                                                                                                                                                                                                                          |                      365                     |
| <p><a href="../../scepman-configuration/application-settings/scep-endpoints/staticaad-validation.md#appconfig-staticaadvalidation-enablecertificatestorage">AppConfig:StaticAADValidation:EnableCertificateStorage</a></p><p> (optional)</p> | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |
{% endtab %}

{% tab title="Static" %}
Add the following settings to your **SCEPman App Service** > Environment Variables > Add.

Once the settings have been added, save the settings and restart your **SCEPman App Service**.

|                                                                                                   Setting                                                                                                  | Description                                                                                                                                                                                                                                                                                             |                     Value                    |
| :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :------------------------------------------: |
|                        [AppConfig:StaticValidation:Enabled](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enabled)                       | Enable 3rd-party validation                                                                                                                                                                                                                                                                             | _**true**_ to enable, _**false**_ to disable |
|                [AppConfig:StaticValidation:RequestPassword](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-requestpassword)               | <p>Certificate signing requests sent to SCEPman for signing are authenticated with this secure static password<br><br><strong>Recommendation</strong>: Store this secret in <a href="../../scepman-configuration/application-settings/#secure-configuration-in-azure-key-vault">Azure KeyVault</a>.</p> |      _generate a 32 character password_      |
|       [AppConfig:StaticValidation:ValidityPeriodDays](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-validityperioddays) (optional)       | Days certificates issued via the Static endpoint are valid                                                                                                                                                                                                                                              |                      365                     |
| [AppConfig:StaticValidation:EnableCertificateStorage](../../scepman-configuration/application-settings/scep-endpoints/static-validation.md#appconfig-staticvalidation-enablecertificatestorage) (optional) | Store requested certificates in the Storage Account, in order to show them in SCEPman Certificate Master                                                                                                                                                                                                | _**true**_ to enable, _**false** to disable_ |
{% endtab %}
{% endtabs %}

## MDM Configuration

The specific steps depend on the MDM system you are using. You must add [https://scepman.contoso.de/static](https://scepman.contoso.de/static) as SCEP URL somewhere and you must add the challenge password to your MDM system's SCEP configuration. For security reasons, please make your MDM system a SCEP proxy.

Note that there are two variants of SCEP proxy implementations, only one of which is secure in this configuration:

1. Your MDM system may act as a SCEP client, generate the secret keypair, and deliver the complete package consisting of certificate and private key to the end-user devices. This is secure, as the challenge password is used only between MDM system and SCEPman.
2. Your MDM system relays SCEP messages between end-user device and SCEPman. The end-user device generates the secret keypair and _adds the challenge password_ to the certificate request. This is less secure, as an attacker with control over a single end-user device may steal the challenge password and request all kinds of certificates from SCEPman. Furthermore, the MDM system cannot control whether the client has correctly requested a certificate or whether the certificate request is incorrect, possibly allowing for identity theft or other threats.
