# Sub-CA

{% hint style="warning" %}
Comming soon!
{% endhint %}

## Creating Intermediate Certificate via API

### Authenticate against Microsoft to retrieve a Token

```text
POST https://login.microsoftonline.com/{TenantID}/oauth2/v2.0/token
```

Body:

```text
grant_type:client_credentials
client_id:{YourApplicationID}
client_secret:{YourApplicationKey}
scope:https://vault.azure.net/.default
```

```text
curl --location --request POST 'https://login.microsoftonline.com/{TenantID}/oauth2/v2.0/token' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--header 'Cookie: stsservicecookie=ests; x-ms-gateway-slice=estsfd; fpc=AoCLD8T8y4pCqKTyeXDaIptk-OLhAQAAAIs4H9cOAAAA' \
--data-urlencode 'grant_type=client_credentials' \
--data-urlencode 'client_id={YourApplicationID}' \
--data-urlencode 'client_secret={YourApplicationKey}' \
--data-urlencode 'scope=https://vault.azure.net/.default'
```

Copy the *access_token* from the answer and use this as Token for the next request.


### Send new cert request to KeyVault API 

```text
POST https://{YourKeyVaultName}.vault.azure.net/certificates/{NewCertName}/create?api-version=7.1
```

Authorization:

The token from the first request.

Body:

```text
{
  "policy": {
    "key_props": {
      "exportable": true,
      "kty": "RSA",
      "key_size": 2048,
      "reuse_key": false
    },
    "secret_props": {
      "contentType": "application/x-pkcs12"
    },
    "x509_props": {
      "subject": "CN={NewCertName}, OU={TenantID}, O={CompanyName}",
      "ekus": [
                "1.3.6.1.5.5.7.3.1",
                "1.3.6.1.5.5.7.3.2"
            ],
        "key_usage": [
                "cRLSign",
                "digitalSignature",
                "keyCertSign",
                "keyEncipherment"
            ],
            "validity_months": 120,
            "basic_constraints": {
                "ca": true
            }
    },
    "lifetime_actions": [
            {
                "trigger": {
                    "lifetime_percentage": 80
                },
                "action": {
                    "action_type": "EmailContacts"
                }
            }
        ],
    "issuer": {
            "name": "Unknown",
            "cert_transparency": false
        }
  }
}
```

cURL Code:

```text
curl --location --request POST 'https://{YourKeyVaultName}.vault.azure.net/certificates/{NewCertName}/create?api-version=7.1' \
--header 'Authorization: Bearer {YourAuthToken}' \
--header 'Content-Type: application/json' \
--data-raw '{
  "policy": {
    "key_props": {
      "exportable": true,
      "kty": "RSA",
      "key_size": 2048,
      "reuse_key": false
    },
    "secret_props": {
      "contentType": "application/x-pkcs12"
    },
    "x509_props": {
      "subject": "CN={NewCertName}, OU={TenantID}, O={CompanyName}",
      "ekus": [
                "1.3.6.1.5.5.7.3.1",
                "1.3.6.1.5.5.7.3.2"
            ],
        "key_usage": [
                "cRLSign",
                "digitalSignature",
                "keyCertSign",
                "keyEncipherment"
            ],
            "validity_months": 120,
            "basic_constraints": {
                "ca": true
            }
    },
    "lifetime_actions": [
            {
                "trigger": {
                    "lifetime_percentage": 80
                },
                "action": {
                    "action_type": "EmailContacts"
                }
            }
        ],
    "issuer": {
            "name": "Unknown",
            "cert_transparency": false
        }
  }
}'
```

| Back to Trial Guide | Back to Community Guide | Back to Enterprise Guide​ |
| :--- | :--- | :--- |


