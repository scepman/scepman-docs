# RDP Server Certificate

Using the `RdpServer` template, you can configure computers and servers to make use of managed certificates provided to clients accessing them through the Remote Desktop Protocol.



{% stepper %}
{% step %}
### Create Template Object in Active Directory

During the enrollment and mapping of the certificate, the `SessionEnv` service will lookup the configured certificate template in Active Directory even if the certificate template will be used from the already configured CEP service of SCEPman. To satisfy this lookup we will create an empty certificate template object in the expected location. This requires write permissions to the Public Key Services container in the Forest, for example with the role Enterprise Admin.

{% hint style="info" %}
An Enterprise Admin is required to perform this object creation — unless you have assigned permissions to further roles on the Public Key Services container.
{% endhint %}

{% code lineNumbers="true" %}
```powershell
$ConfigPath = (Get-ADRootDSE).configurationNamingContext
$TemplateContainer = "CN=Certificate Templates,CN=Public Key Services,CN=Services,$ConfigPath"
$Name = "SCEPmanRdpServer"

New-ADObject -Name $Name `
             -Type pKICertificateTemplate `
             -Path $TemplateContainer `
             -OtherAttributes @{
                "displayName" = $Name;
                "msPKI-Cert-Template-OID" = "1.3.6.1.4.1.311.21.8.$(Get-Random 9999999).$(Get-Random 9999999)";
                "msPKI-Template-Schema-Version" = 1;
                "msPKI-Template-Minor-Revision" = 1;
                "msPKI-RA-Signature" = 0;
                "flags" = 0
             }
```
{% endcode %}
{% endstep %}

{% step %}
### Enable Certificate Template in SCEPman

Like other certificate templates, this one can be configured by adding the following environment variables to the the SCEPman app service:

| Setting                                         | Value     | Description                                                                            |
| ----------------------------------------------- | --------- | -------------------------------------------------------------------------------------- |
| AppConfig:ActiveDirectory:RdpServer:Enabled     | true      | Enable the certificate template                                                        |
| AppConfig:ActiveDirectory:RdpServer:GroupFilter | Group SID | Optional: Only allow members of this group to enroll certificates using this template. |
{% endstep %}

{% step %}
### Configure Group Policy

In a Group Policy we configure the certificate template name and instruct machines additionally to enforce a specific security layer during instructions.

<pre data-title="Setting location in Group Policy Management Editor (gpmc.msc)"><code>Computer Configuration

└-Policies
  └-Administrative Templates
    └-Windows Components
      └-Remote Desktop Services
        └-Remote Desktop Session Host
          └-Security
<strong>            └-Server authentication certificate template
</strong><strong>            └-Require use of specific security layer for remote (RDP) connections
</strong></code></pre>

#### Server authentication certificate template

Enter the name of the certificate template to be used for RDP server authentication. By default, this is `SCEPmanRdpServer`.

<figure><img src="../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

#### Require use of specific security layer for remote (RDP) connections

Select SSL here to enforce the use of the used certificate.

<figure><img src="../../../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}

With the configuration in place, the `SessionEnv` service can be restarted to enforce the enrollment and mapping of the certificate.

On the computer itself, you can confirm the used certificate by running the following command:

{% code overflow="wrap" %}
```powershell
(Get-CimInstance -Class Win32_TSGeneralSetting -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").SSLCertificateSHA1Hash
```
{% endcode %}

This will output the thumbprint of the active RDP certificate.

The event log will also show that a new certificate has been used:

{% code title="Show relevant event log entries" overflow="wrap" %}
```powershell
Get-WinEvent -LogName "System" | Where-Object { $_.ProviderName -eq "Microsoft-Windows-TerminalServices-RemoteConnectionManager" } | Select-Object -First 10 | Format-List Message, TimeCreated
```
{% endcode %}

> A new template-based certificate to be used by the RD Session Host server> \
> for Transport Layer Security (TLS) 1.0\Secure Sockets Layer (SSL)> \
> authentication and encryption has been installed. The name for this> \
> certificate is svr01.Conitoso.local. The SHA1 hash of the certificate is> \
> provided in the event data.
