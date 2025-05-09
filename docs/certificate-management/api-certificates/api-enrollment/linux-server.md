# Linux Server

{% hint style="info" %}
This feature requires version **2.3.689** or above.
{% endhint %}

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

While the other of SCEPmans use cases provide the ability to interactively authenticate a user to then only allow them to enroll user certificates for their account or their devices you might want to be able to non-interactively enroll certificates for arbitrary subjects.

To accomplish this we can authenticate a service principal and allow that to leverage SCEPman's Enrollment REST API.

## Prerequisites

Please refer to the API Enrollment article on how to create a service principal that can be used for authentication:

{% content-ref url="./" %}
[.](./)
{% endcontent-ref %}

## Powershell Module SCEPmanClient

### Initial Requests

You can use the SCEPmanClient PowerShell module to request certificates on your Linux server:

```powershell
$Parameters = @{
    'Url'              = 'scepman.contoso.com'
    'ClientId'         = '569fbf51-aa63-4b5c-8b26-ebbcfcde2715'
    'TenantId'         = '8aa3123d-e76c-42e2-ba3c-190cabbec531'
    'ClientSecret'     = 'csa8Q~aVaWCLZTzswIBGvhxUiEvhptuqEyJugb70'
    'Subject'          = 'CN=LinuxServer'
    'IP'               = '10.22.11.8'
    'ExtendedKeyUsage' = 'ServerAuth'
    'SaveToFolder'     = '/etc/ssl/scepman'
    'IncludeRootCA'    = $true
}

New-SCEPmanCertificate @Parameters
```

### Certificate Renewal

You can also use the PowerShell module to renew already existing certificates. This will also spare the requirement to use a service principal for authentication:

```powershell
$Parameters = @{
    'CertificateFromFile' = '/home/user/.certs/server.pem'
    'KeyFromFile'         = '/home/user/.certs/server.key'
    'SaveToFolder'        = '/home/user/.certs'
}

New-SCEPmanCertificate @Parameters
```

## Enrollment and Renewal Script

If the PowerShell module is not an option for you, the [enrollrenewcertificate.sh](https://github.com/scepman/csr-request/blob/main/enroll-certificate/enrollrenewcertificate.sh) script can be used to initially receive a certificate as well as to verify it and attempt a renewal in case it is about to expire.

### Client Prerequisites

{% include "../../../.gitbook/includes/enrollment-rest-api-client-prerequisites.md" %}



Example:

{% code overflow="wrap" %}
```bash
./enrollrenewcertificate.sh -s https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 ~/certs/ "myCertificate" "myKeyName" 30 edbc406b-7384-414e-af8b-1a3b187b3f7e [Client_Secret] 736e80bb-3102-479b-83ba-e45c80ef723b "/CN=SubjectName,O=Organization" "DNS:webserver.contoso.com"
```
{% endcode %}

#### 1. Command

Defines the behavior of the script

For this use case we can use the following options:

**-s** for server certificate with auto-detection whether it is an initial enrollment or renewal

**-y** for initial enrollment of a server certificate

**-c** for submitting a present certificate signing request



For Client Authentication use cases see:

{% content-ref url="../self-service-enrollment/unmanaged-linux-client.md" %}
[unmanaged-linux-client.md](../self-service-enrollment/unmanaged-linux-client.md)
{% endcontent-ref %}



#### 2. App Service URL

The URL of the SCEPman app service.

_Example: "https://scepman.contoso.net/"_

#### 3. API Scope

This is the _**Application ID URI**_ of the _**SCEPman-api**_ app registration in your environment.

_Example: "api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436"_

<figure><img src="../../../.gitbook/assets/image (6).png" alt=""><figcaption></figcaption></figure>

#### 4. Certificate Filename

The filename (without extension) of the certificate that will be created or read for renewal.

_Example: "myCertificate"_

#### 5. Certificate Directory

The directory the certificate will be created or tried to be renewed.

_Example: \~/certs/_

#### 8. Renewal Threshold

The amount of days the certificate will need to expire in for the script to begin the renewal process.

_Example: 30_

### _Additional parameters for Server Certificates:_

#### 9. Service Principal Client Id

The Application (Client) Id of the app registration we want to authenticate.

#### 10. Service Principal Client Secret

The created client secret of the app registration we want to authenticate.

#### 11. Service Principal Tenant Id

The tenant id of our app registration.

#### 12. Certificate Subject

The subject you want to enroll the certificate with.

_Format: /CN=SubjectName,O=Organization_

#### 13. Certificate Extension

This will be added as subject alternative name

_Example: DNS:webserver.contoso.com_



### _Usage example for CSR signing (-c command)_&#x20;

{% code overflow="wrap" %}
```bash
# Generate a private key
openssl genrsa -out myKey.rsa 4096

# Create a csr for a user certificate for client authentication
openssl req -new -key myKey.rsa -sha256 -out myCSR -subj "/CN=John Smith" -addext "subjectAltName=otherName:1.3.6.1.4.1.311.20.2.3;UTF8:john.smith@contoso.net" -addext "extendedKeyUsage=1.3.6.1.5.5.7.3.2"

./enrollrenewcertificate.sh -c https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 ~/certs "myCertificate" myKey.rsa 30 edbc406b-7384-414e-af8b-1a3b187b3f7e [Client_Secret] 736e80bb-3102-479b-83ba-e45c80ef723b myCSR

```
{% endcode %}



#### Considerations

* This script does not encrypt the generated keys (this requires passphrase input, so encryption has been omitted to allow for automatic renewal.)
* If you are renewing passphrase-protected certificates from Certificate Master, you will need to input this passphrase in order to renew them.

## Set up automatic renewal

When the above bash script is run and detects that a certificate has already been enrolled, it will renew the certificate (if it is close to expiry) using mTLS. If the script is run regularly, this will ensure the certificate is renewed when it gets close to expiry. You can set up a cronjob to achieve this. The below command is an example of how this could be done. It will set up a cronjob to run the command daily (if the system is powered on) and a cronjob to run the command on reboot.

{% code overflow="wrap" %}
```
(crontab -l ; echo @daily /path/to/enrollrenewcertificate.sh -s https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 /path/to/certs "myCertificate" "myKeyName" 30 edbc406b-7384-414e-af8b-1a3b187b3f7e [Client_Secret] 736e80bb-3102-479b-83ba-e45c80ef723b "/CN=SubjectName,O=Organization" "DNS:webserver.contoso.com" ; echo @reboot /path/to/enrollrenewcertificate.sh -s https://scepman.contoso.net/ api://a7a1d6c8-51b9-48ec-9ca0-a363dc2c8436 /path/to/certs "myCertificate" "myKeyName" 30 edbc406b-7384-414e-af8b-1a3b187b3f7e [Client_Secret] 736e80bb-3102-479b-83ba-e45c80ef723b "/CN=SubjectName,O=Organization" "DNS:webserver.contoso.com") | crontab -
```
{% endcode %}

Since commands run by Cron will not necessarily be run from the directory that the script/certificates are in, it is important to provide the absolute paths to the script/certificates.&#x20;

