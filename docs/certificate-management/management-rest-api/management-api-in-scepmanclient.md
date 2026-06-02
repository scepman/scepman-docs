# Management API in SCEPmanClient

Use `Find-SCEPmanCertificate` to search for issued certificates in SCEPman and `Revoke-SCEPmanCertificate` to revoke a certificate when it is no longer trusted or no longer needed.

### Requirements

Before you can search for or revoke certificates, ensure that your identity has the **Manage.All** role.

Also ensure to have setup the general prerequisites for SCEPmanClient usage: [https://app.gitbook.com/o/-LhPlvZ6dc8XcqY7tdZw/s/-LoGejQeUQcw7lqnQ3WX/\~/edit/\~/changes/863/certificate-management/api-certificates/scepmanclient#prerequisites](../api-certificates/scepmanclient.md#prerequisites)

{% hint style="info" %}
If you update from an earlier SCEPman version, you might not yet have the Manage.All role. Run `Complete-SCEPmanInstallation` again in a cloud shell to automatically add it to your SCEPman-api application.
{% endhint %}

### Find certificates

Use `Find-SCEPmanCertificate` to search for certificates by their serial number, subject or requester.

If at least one certificate is found, an object is returned resembling the following JSON structure:

```json
{
  "items": [
    {
    "serialNumber":  "507AEAC03CCEF83F106914418D9222E466A629C1",
    "subject":  "CN=device01.contoso.local",
    "sans":  null,
    "upn":  null,
    "issuanceDate":  "2026-05-28T10:57:22Z",
    "expirationDate":  "2028-05-28T10:57:22Z",
    "revocationDate":  null,
    "revocationReason":  null,
    "revokedBy":  null,
    "requester":  "pkiAdmin@contoso.com",
    "source":  "CertificateMaster",
    "certificateType":  "Static"
    }
  ],
  "continuationToken": "..."
}
```

#### Example: Find a single certificate by serial number

```powershell
Find-SCEPmanCertificate -Url scepman.conitoso.com `
    -SearchText '5056BB9B823132CB26210A4C90A62FB3C25E38D0' `
    | Select-Object -ExpandProperty items

serialNumber     : 5056BB9B823132CB26210A4C90A62FB3C25E38D0
subject          : CN=clara.oswald@contoso.com
sans             : clara.oswald@contoso.com
upn              : clara.oswald@contoso.com
issuanceDate     : 2026-05-28T11:06:11Z
expirationDate   : 2028-05-28T11:06:11Z
revocationDate   :
revocationReason :
revokedBy        :
requester        : pkiAdmin@contoso.com
source           : CertificateMaster
certificateType  : Static
```

### Understand paged results

If the result set is large, `Find-SCEPmanCertificate` can return a continuation token. Use this token to request the next page.

#### Example: first page with continuation token

```powershell
$result = Find-SCEPmanCertificate -Url scepman.contoso.com -SearchText "CN=device"
$result
```

Example output:

```powershell
ContinuationToken : 1!48!ODY2OURBN0QtQzk0My00QjU3LUI5OEYtNzA5RjY5MDlCRDkw
Items             : {@{serialNumber=60B26DD32CF07F30D6760848A5233CBAE90DCDBC; subject=CN=device01.contoso.local},
                    @{serialNumber=50F1754E85238752527C3140ABD0CEF2C7DC9439; subject=CN=device02.contoso.local}}
```

#### Show returned certificates in detail

```powershell
$result = Find-SCEPmanCertificate -Url scepman.contoso.com -SearchText "CN=device"
$result.Items
```

Example output:

```powershell
serialNumber                             subject
------------                             -------
60B26DD32CF07F30D6760848A5233CBAE90DCDBC CN=device01.contoso.local
50F1754E85238752527C3140ABD0CEF2C7DC9439 CN=device02.contoso.local
```

#### Request the next page with the continuation token

```powershell
$firstPage = Find-SCEPmanCertificate -Url scepman.contoso.com -SearchText "CN=device"
$nextPage = Find-SCEPmanCertificate -Url scepman.contoso.com -ContinuationToken $firstPage.ContinuationToken
$nextPage.Items
```

Example output:

```powershell
serialNumber                             subject
------------                             -------
5048D2541F7F401C42B7E943A7C82FB37A179F83 CN=device03.contoso.local
50BCCDA973AEEA55E00FAF4A9A088DFB7564F263 CN=device04.contoso.local
```

### Revoke a certificate

Use `Revoke-SCEPmanCertificate` to revoke a certificate by its serial number that was previously issued.

```powershell
Revoke-SCEPmanCertificate -SerialNumber "480552CEBBE40FD5D4417532033728F353040000" -RevocationReason CessationOfOperation
```

#### Example: Find a certificate and revoke it

```powershell
$result= Find-SCEPmanCertificate -Url scepman.contoso.com -SearchText "480552CEBBE40FD5D4417532033728F353040000"
$cert = $result.items

Revoke-SCEPmanCertificate -SerialNumber $cert.Items[0].serialNumber
```

Example output:

```powershell
Revoke-SCEPmanCertificate: Certificate 480552CEBBE40FD5D4417532033728F353040000 revoked successfully.
```

