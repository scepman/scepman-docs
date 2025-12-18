---
layout:
  width: default
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
---

# General Configuration

To allow SCEPman to handle incoming SOAP requests successfully, we need to take a few steps:

{% stepper %}
{% step %}
## Create Service Principal

Use the `New-SCEPmanADPrincipal` Cmdlet of the SCEPman Powershell module to create the service principal in your on-prem Active Directory domain. It will also export a keytab from this account and encrypt it to SCEPman's CA certificate.

Execute this Cmdlet with an account that has Domain Administrator permissions and network access to a Domain Controller. The variant below also outgoing HTTPS network access your SCEPman instance.

{% hint style="info" %}
If your computer with access to a Domain Controller doesn't have network access, there are variants of the CMDlet that work without it, but require some additional preparation, especially downloading the SCEPman CA certificate and copying to the machine that runs the CMDlet.
{% endhint %}

{% code overflow="wrap" lineNumbers="true" expandable="true" %}
```powershell
Install-Module SCEPman -Force
New-SCEPmanADPrincipal -Name "SCEPmanAD" -AppServiceUrl "scepman.contoso.com" -OU "OU=Example,DC=contoso,DC=local"
```
{% endcode %}

Running this command will perform the following:

1. Create a computer object in the `OU=ServiceAccounts,DC=contoso,DC=com` Organizational Unit.
2. Download SCEPman's CA certificate to encrypt the keytab in step 5.
3. Add a service principal name (SPN) to the computer object.
4. Create a keytab for the computer account containing the encryption key based on the computer's password.
5. Encrypt the keytab with the CA certificate of SCEPman, so only SCEPman can decrypt it again using the CA private key.
6. Output the encrypted keytab, so it can be transferred to SCEPmans configuration.

The Base64 encoded output must then be transferred to the environment variable **AppConfig:ActiveDirectory:Keytab** of your SCEPman app service.
{% endstep %}

{% step %}
## Add Keytab to SCEPman

The integration can easily be enabled by adding the following environment variables in the **SCEPman App Service.** Depending on your use case, enable one or more of the available certificate templates:

_Example with all certificate templates enabled:_

<table data-full-width="true"><thead><tr><th>Setting</th><th>Value</th></tr></thead><tbody><tr><td>AppConfig:ActiveDirectory:Keytab</td><td>Base64 encoded keytab for the service principal created in Step 1</td></tr><tr><td>AppConfig:ActiveDirectory:Computer:Enabled</td><td>true</td></tr><tr><td>AppConfig:ActiveDirectory:User:Enabled</td><td>true</td></tr><tr><td>AppConfig:ActiveDirectory:DC:Enabled</td><td>true</td></tr></tbody></table>
{% endstep %}

{% step %}
### Ensure Custom Domain and BaseUrl

For successful authentication with SCEPman, ensure that a custom domain using an `A record` is pointed to the app service. Otherwise, the client will fail to request a valid Kerberos ticket from the domain controller.

{% hint style="info" %}
See the below known issue about [WS\_E\_ENDPOINT\_ACCESS\_DENIED](general-configuration.md#ws_e_endpoint_access_denied) for more information on this.
{% endhint %}

Ensure that SCEPman is configured to be accessible using a custom domain:

{% content-ref url="../../azure-configuration/custom-domain.md" %}
[custom-domain.md](../../azure-configuration/custom-domain.md)
{% endcontent-ref %}

The same requirement also applies after the initial policy request (listing the certificate templates) to enroll certificates. To allow a successful authentication here, make sure to also setup the [AppConfig:BaseUrl](../../scepman-configuration/application-settings/basics.md#appconfig-baseurl) variable to your custom domain or use the dedicated [AppConfig:ActiveDirectory:BaseUrl](../../scepman-configuration/application-settings/active-directory/general.md#appconfig-activedirectory-baseurl) setting if require the AD Endpoint to be accessible on a different Url than your other SCEPman endpoints are.
{% endstep %}
{% endstepper %}

## Known Issues

#### WS\_E\_ENDPOINT\_ACCESS\_DENIED

```
Error: WS_E_ENDPOINT_ACCESS_DENIED 
Hex: 0x803d0005
Dec: -2143485947
```

This error is known to occur during the validation of the CEP server when you are using the default URIs of the Azure app service. This error is caused by the Kerberos protocol asking for a service principal name of the A record of the service that is to be accessed. In the case of the default app service domains, for example `contoso.azurewebsites.net` is just a CNAME and points to an A record similar to:

```
waws-prod-ab1-234-c56d.westeurope.cloudapp.azure.com
```

As this A record of an infrastructure host is not guaranteed to be consistent in the future, adding a service principal name for this host is **not recommended**.

Make sure to add a custom domain to your app service and use an A record within your DNS provider to point it to the app service instead of a CNAME.

{% content-ref url="../../azure-configuration/custom-domain.md" %}
[custom-domain.md](../../azure-configuration/custom-domain.md)
{% endcontent-ref %}

#### ERROR\_INVALID\_PARAMETER

```
Error: ERROR_INVALID_PARAMETER
Hex: 0x80070057
Dec: -2147024809
```

This error occurs during the CEP server registration if you enter an URI that begins with `http://`. Make sure to only register a CEP server using `https://`

#### ERROR\_ACCESS\_DENIED

```
Error: ERROR_ACCESS_DENIED
Hex: 0x80070005
Dec: -2147024891
```

When registering a CEP server in machine context, the acting user (the account that started `gpmc.msc`) needs to be a member of the local Administrators group on the computer while editing the GPO.

Make sure to start `gpmc.msc` with elevated permissions in this case.
