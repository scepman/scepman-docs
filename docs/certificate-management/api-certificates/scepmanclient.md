# SCEPmanClient

SCEPmanClient is a PowerShell module intended to interact with SCEPmans REST API. Being platform independent and compatible with Windows PowerShell v5, you can use this module to request certificates for all use cases the REST API can be used for:

* Automatic issuance of server certificates
* Client certificates for unmanaged devices
* Enrollment of certificates to Linux devices

## Installation

The SCEPmanClient module is available from the PowerShell Gallery and can be installed using the following command:

```powershell
Install-Module -Name SCEPmanClient
```

{% hint style="info" %}
Follow Microsoft's guide on how to install PowerShell on [Linux](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-linux?view=powershell-7.5) or [MacOS](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.5).
{% endhint %}

## Prerequisites

For the module to be functioning as expected you will need to add a small modification to your SCEPman deployment:

{% stepper %}
{% step %}
### Add Home page URL

Add SCEPman's App Service URL: Navigate to the `Branding & Properties` section of the app registration. Add SCEPman's App Service URL to the Home page URL field:

<figure><img src="../../.gitbook/assets/image (66).png" alt=""><figcaption></figcaption></figure>

This is required for the module to be able to automatically look up the App Registrations client id that is needed for access token retrieval.
{% endstep %}

{% step %}
### Allow Azure PowerShell to interact with the App Registration

In the App Registration, navigate to _Expose an API_ and create a custom scope that can be used to authorize the client Id `1950a258-227b-4e31-a9cf-717495945fc2` (Microsoft Azure PowerShell)

<figure><img src="../../.gitbook/assets/image (67).png" alt=""><figcaption><p>Example information for a custom API scope</p></figcaption></figure>

After creating an API scope, the Azure PowerShell application can be authorized:

<figure><img src="../../.gitbook/assets/image (68).png" alt=""><figcaption><p>Authorized Microsoft Azure PowerShell application</p></figcaption></figure>
{% endstep %}

{% step %}
### Enable EST endpoint

{% include "../../.gitbook/includes/enrollment-rest-api-app-service-settings.md" %}
{% endstep %}
{% endstepper %}

## Permissions

SCEPman has different roles that will allow different kinds of certificates to be enrolled. You can assign those in the _SCEPman-api_ (default name) Enterprise Application:

#### CSR DB Requesters

This role is only assignable to service principals (App Registrations for example) by default and allows to request certificates with arbitrary subjects and usages.

{% content-ref url="api-enrollment/" %}
[api-enrollment](api-enrollment/)
{% endcontent-ref %}

#### CSR Self Service

This role can be assigned to users and will allow certificates to be enrolled with the following restrictions:

* Only ClientAuth EKU
* User certificates need to match the users UPN in either the subject or UPN subject alternative name
* Device certificates need to have a subject or SAN that SCEPman can map to a device object owned by the authenticated user

{% content-ref url="self-service-enrollment/" %}
[self-service-enrollment](self-service-enrollment/)
{% endcontent-ref %}

## Usage Examples

### Use Azure Authentication

#### Interactive Authentication

When requesting a new certificate without specifying the authentication mechanism, the user will be authenticated interactively by default. By using the `-SubjectFromUserContext` parameter, the certificate's subject and UPN SAN will be automatically populated based on the logged-in user's context:

```powershell
New-SCEPmanCertificate -Url 'scepman.contoso.com' -SubjectFromUserContext -SaveToStore CurrentUser
```

#### Device Login

If you want to request a new certificate on a system without any desktop environment you can use the `-DeviceCode` parameter to perform the actual authentication on another session:

```powershell
New-SCEPmanCertificate -Url 'scepman.contoso.com' -DeviceCode -SubjectFromUserContext -SaveToFolder /home/user/certificates
```

#### Service Principal Authentication

In fully automated scenarios an App Registration can be used for authentication. Inferring the subject from the authenticated context will not be possible in this case.

Parameter splatting will also make the execution more readable:

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

### Authenticate using certificates

Once a certificate has been issued using an authenticated context we can use it to renew it without providing any context again.

#### CertificateBySubject

_Interacting with keystores is only possible on Windows_

When providing the `CertificateBySubject` parameter, the module will automatically try find a suitable certificate for renewal in the _CurrentUser_ and _LocalMachine_ keystores.

The entered value will be regex matched against the subjects in all available certificates.

```powershell
New-SCEPmanCertificate -CertificateBySubject 'WebServer' -SaveToStore 'LocalMachine'
```

#### Provide a specific certificate

```powershell
$Certificate = Get-ChildItem Cert:\LocalMachine\My | Where-Object Thumbprint -eq '9B08EA68B16773CEF3C49D5D95BE50B784638984'

New-SCEPmanCertificate -Certificate $Certificate -SaveToStore LocalMachine
```

#### CertificateFromFile

On Linux system a certificate renewal can be performed by passing the paths of the existing certificate and its private key.

```powershell
New-SCEPmanCertificate -CertificateFromFile '~/certs/myCert.pem' -KeyFromFile '~/certs/myKey.key' -SaveToFolder '~/certs'
```

When using an encrypted private key you will asked for the password. You can also directly pass the keys password using the `PlainTextPassword` parameter.

#### Using SCEPman with a Azure Web Application Firewall

With SSL Profiles enabled, the WAF will terminate the TLS connections. This will in turn break certificate renewals using EST as the procedure relies on mTLS for authentication. In this case the `UseSCEPRenewal` parameter can be used to instead perform a certificate renewal complying with the SCEP protocol.

```powershell
New-SCEPmanCertificate -CertificateBySubject 'WebServer' -SaveToStore 'LocalMachine' -UseSCEPRenewal
```

Please note that this requires additional SCEPman configuration regarding the static SCEP endpoint:

* AppConfig:StaticValidation:Enabled : true
* AppConfig:StaticValidation:AllowRenewals : true
* AppConfig:StaticValidation:ReenrollmentAllowedCertificateTypes: Static (Depending on the types intended for renewal)
