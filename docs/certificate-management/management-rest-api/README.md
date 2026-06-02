# 🆕 Management REST API

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.1 and above
{% endhint %}

The Management API provides administrative access to issued certificates in SCEPman. It is intended for management and operational workflows such as locating certificates and revoking them when needed.

These endpoints are available under `/api/manage` and require an authenticated user with the **Manage.All** role in SCEPman-api.

{% hint style="info" %}
If you update from an earlier SCEPman version, you might not yet have the Manage.All role. Run `Complete-SCEPmanInstallation` again in a cloud shell to automatically add it to your SCEPman-api application.
{% endhint %}

### Authentication

The API uses Entra authentication. The easiest way to authenticate is often the Microsoft Authentication Library (MSAL).

One way to get a bearer token for the Management API is with the Azure CLI. The required value for the \`--resource\` parameter is the Application ID URI of your SCEPman-api app registration (usually its Application ID prefixed with `api://`).

```bash
az account get-access-token --resource api://[APPLICATION-ID] --query accessToken --output tsv
```

For example:

```bash
TOKEN=$(az account get-access-token \
  --resource api://16b6a4d1-0a20-4b41-bf58-12783034cad3 \
  --query accessToken \
  --output tsv)
```

You can then use that token in the API calls:

```bash
curl -X GET "https://scepman.contoso.com/api/manage/search?searchText=ABC123&pageSize=10&certValidity=Any&certType=Any" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/json"
```

### Search API

**`GET /api/manage/search`**

Searches issued certificates and returns a paginated result set.

#### Search parameters

**`searchText`**

Free-text search term used to find matching certificates. This is typically used for substring-based lookups, for example matching requester or other searchable certificate metadata.

**`pageSize`**

Maximum number of certificates returned in a single response page.

* Default: 50

**`continuationToken`**

Optional pagination token used to request the next page of results.\
Pass back the `continuationToken` returned by a previous search response to continue fetching more certificates.

**`certValidity`**

Filters certificates by validity state.

* Default: `Any`

Valid values are `Any`, `Active`, `Expired`, `Revoked`.

**`certType`**

Filters certificates by certificate type.

* Default: `Any`

This can be used to restrict the result set to specific certificate categories. Valid values are `Static`, `DC`, `User`, `Device`, and `Any`.

**`Sources`**

Filters certificates by the endpoint through which they have been issued. You can specify this filter multiple times, once per source.

* Default: No restriction

Valid values are shown in the table below, you must specify the source using their integer values:

| Source            | Value                                   |
| ----------------- | --------------------------------------- |
| CertificateMaster | 0                                       |
| Intune            | 1 or 9 (use both to ensure finding all) |
| Static            | 3                                       |
| StaticAAD         | 4                                       |
| Jamf              | 5                                       |
| DomainController  | 6                                       |
| API               | 7                                       |
| RadiusAPI         | 8                                       |
| Active Directory  | 10                                      |

The response is a paginated list of certificate records plus a continuation token for fetching the next page.

**Example**

```bash
curl -X GET "https://scepman.contoso.com/api/manage/search?searchText=507AEAC03CCEF83F106914418D9222E466A629C1&pageSize=10&certValidity=Any&certType=Any" \
  -H "Authorization: Bearer <token>" \
  -H "Accept: application/json"
```

**Example response**

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

### **Revocation API**

**`PATCH /api/manage/revoke/{serialNumber}`**

Revokes a certificate identified by its serial number.

The request body contains:

* `revocationReason` - an integer for the reason of revocation. See the table below for possible values
* `revoker` _(optional)_ - a free-text identifier for the person or system requesting revocation

{% hint style="info" %}
If specified, we recommend to use the UPN for the revoker field. If not specified, the logged on user's UPN will be used. Even if specified, the logged on user's UPN is still added in the form "{revoker} through API user ${logged on user}".

This value is used for auditing and in searches.
{% endhint %}

**Example**

```bash
curl -X PATCH "https://scepman.contoso.com/api/manage/revoke/ABC123" \
  -H "Authorization: Bearer <token>" \
  -H "Content-Type: application/json" \
  -d '{
    "revocationReason": 4,
    "revoker": "pkiAdmin@contoso.com"
  }'
```

**Successful response**

```http
HTTP/1.1 200 OK
```

**Certificate not found**

```http
HTTP/1.1 404 Not Found
Content-Type: application/json
```

```json
{
  "errorMessage": "Certificate not found.",
  "errorCode": 7012
}
```

**Already revoked**

```http
HTTP/1.1 409 Conflict
Content-Type: application/json
```

```json
{
  "errorMessage": "The certificate is already revoked.",
  "errorCode": 5013
}
```

#### Supported revocation reasons

The API supports the revocation reasons specified in [RFC 5280](https://datatracker.ietf.org/doc/html/rfc5280#section-5.3.1):

| Value | Revocation Reason    |
| ----- | -------------------- |
| 0     | Unspecified          |
| 1     | KeyCompromise        |
| 2     | CACompromise         |
| 3     | AffiliationChanged   |
| 4     | Superseded           |
| 5     | CessationOfOperation |
| 6     | CertificateHold      |
| 8     | RemoveFromCrl        |
| 9     | PrivilegeWithdrawn   |
| 10    | AACompromise         |
