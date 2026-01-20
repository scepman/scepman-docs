# Windows Server

{% hint style="info" %}
Applicable to SCEPman version 2.9 and above
{% endhint %}

You can use the SCEPmanClient PowerShell module to request certificates for your Windows server. Please refer to the main article of the module for the prerequisites:

{% content-ref url="../scepmanclient.md" %}
[scepmanclient.md](../scepmanclient.md)
{% endcontent-ref %}

## Use Case Description

While the module is capable of initially requesting certificates, it might not be desirable to store the service principal credentials on a machine that could be used to request arbitrary certificates.

So if your scenario includes the deployment of a certificate using Certificate Master you can automatically renew it using _SCEPmanClient_ by providing an already existing certificate for authentication:

<pre class="language-powershell"><code class="lang-powershell"><strong>$Subject = $env:COMPUTERNAME
</strong><strong>$ValidityThreshold = 30
</strong><strong>
</strong><strong>$CertificateToRenew = Get-ChildItem Cert:\LocalMachine\My `
</strong>                        | Where-Object NotAfter -lt (Get-Date).AddDays($ValidityThreshold) `
                        | Where-Object Subject -match $Subject

New-SCEPmanCertificate -Certificate $CertificateToRenew -SaveToStore 'LocalMachine'

# With the new certificate in place we can remove the old one
# Remove-Item $CertificateToRenew.PSPath
</code></pre>

This example will find certificates expiring in the next month and use it to authenticate the renewal request.

## Initial Request

If you want to request certificates on your server initially you can do so by supplying a service principal for authentication that has the role **CSR DB Requesters** assigned. Please refer to the following guide on how to implement such a service principal:

{% content-ref url="./" %}
[.](./)
{% endcontent-ref %}

```powershell
$Parameters = @{
    'Url'              = 'scepman.contoso.com'
    'ClientId'         = '569fbf51-aa63-4b5c-8b26-ebbcfcde2715'
    'TenantId'         = '8aa3123d-e76c-42e2-ba3c-190cabbec531'
    'ClientSecret'     = 'csa8Q~aVaWCLZTzswIBGvhxUiEvhptuqEyJugb70'
    'Subject'          = 'CN=WebServer'
    'DNSName'          = 'Webserver.domain.local'
    'ExtendedKeyUsage' = 'ServerAuth'
    'SaveToStore'      = 'LocalMachine'
}

New-SCEPmanCertificate @Parameters
```

If we now want to renew a certificate we can disregard the service principal and use an already issued certificate for authentication. This will use the existing certificates details to construct a new CSR and issue it to SCEPman for a new certificate.
