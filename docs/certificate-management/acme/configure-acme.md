---
description: >-
  This article describes how to enable the ACME endpoint in SCEPman and what you
  need to consider for your network and DNS infrastructure.
---

# Configure ACME

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.2 and above
{% endhint %}

### Prerequisites

* DNS servers that can resolve the `_acme-challenge` `TXT` records of the domains you want to issue certificates for, reachable from your SCEPman App Service
* ACME clients that support the **DNS-01** challenge type and can reach your SCEPman URL via HTTPS
* The SCEPman Root CA certificate distributed to all systems that connect to services using the issued certificates

### 1. App Service Settings

Add the following settings to your **SCEPman App Service** > Environment variables > Add.

| Setting                           | Description                                                    | Value                                               |
| --------------------------------- | -------------------------------------------------------------- | --------------------------------------------------- |
| AppConfig:Acme:Enabled            | Enables the ACME endpoint                                      | _**true**_                                          |
| AppConfig:Acme:AllowedDomains     | Domains SCEPman issues certificates for                        | e.g. _**\*.corp.contoso.com,intranet.contoso.com**_ |
| AppConfig:Acme:DnsServers         | DNS servers SCEPman uses for challenge validation (optional)   | e.g. _**10.0.0.10,10.0.0.11:5353**_                 |
| AppConfig:Acme:ValidityPeriodDays | Validity of certificates issued via ACME in days (recommended) | e.g. _**90**_                                       |

Save the settings and restart your **SCEPman App Service**.

{% hint style="danger" %}
`AppConfig:Acme:AllowedDomains` is mandatory. If it is not configured, SCEPman rejects all ACME orders.
{% endhint %}

#### Allowed Domains

Each entry of `AppConfig:Acme:AllowedDomains` is either:

* an **exact DNS name**, e.g. `intranet.contoso.com`. This allows certificates only for exactly this name.
* a **wildcard entry** starting with `*.`, e.g. `*.corp.contoso.com`. This allows certificates for all subdomains of `corp.contoso.com` at any depth, e.g. `app01.corp.contoso.com` or `web.dev.corp.contoso.com`, as well as wildcard certificates like `*.corp.contoso.com`. It does **not** include `corp.contoso.com` itself. Add an additional exact entry if you need certificates for `corp.contoso.com` as well.

See [AppConfig:Acme:AllowedDomains](../../scepman-configuration/application-settings/acme.md#appconfig-acme-alloweddomains) for details.

### 2. DNS and Network

SCEPman supports the **DNS-01** challenge type (validation via HTTP-01 is disabled by default, see [AppConfig:Acme:AllowHttpChallenge](../../scepman-configuration/application-settings/acme.md#appconfig-acme-allowhttpchallenge)). For DNS-01, SCEPman does not need a network connection to the servers requesting certificates, but it needs to query a DNS server that returns the current `_acme-challenge` `TXT` records of your domains.

If your domains are internal, your SCEPman App Service needs network access to your internal DNS servers:

1. Integrate your SCEPman App Service into a Virtual Network that can reach your internal DNS servers (see [VNet Integration](https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration)).
2. Allow DNS traffic (UDP and TCP port 53, or your custom port) from the App Service integration subnet to your DNS servers in all Network Security Groups and firewalls on the way.
3. Either configure your DNS servers in AppConfig:Acme:DnsServers or as custom DNS servers of the Virtual Network. If `AppConfig:Acme:DnsServers` is not set, SCEPman uses the DNS servers of the App Service.

{% hint style="info" %}
Ideally, SCEPman queries the authoritative DNS servers of your zone. If SCEPman queries a caching resolver, a `TXT` record that has been created only recently might not yet be visible or an outdated value might still be cached. In this case, the validation will be retried by the ACME client, but issuance may be delayed.
{% endhint %}

### 3. ACME Directory URL

ACME clients need the URL of the ACME directory. It always has the form:

```
https://<your SCEPman URL>/acme/directory
```

for example `https://scepman.contoso.com/acme/directory`. If enabled, the SCEPman homepage shows the ACME endpoint as **ACME (DNS)** together with this URL.

{% hint style="warning" %}
SCEPman creates all URLs in its ACME responses from AppConfig:BaseUrl. ACME clients sign the URL of each request and SCEPman rejects requests whose signed URL does not match ([RFC 8555, Section 6.4](https://datatracker.ietf.org/doc/html/rfc8555#section-6.4)). Therefore, configure your ACME clients with a directory URL on the host specified in `AppConfig:BaseUrl`. If you use a custom domain for SCEPman, ensure `AppConfig:BaseUrl` contains the custom domain.
{% endhint %}

### 4. Request a certificate

Configure your ACME client with the directory URL and request a certificate. See [ACME Clients](acme-clients.md) for examples of common ACME clients.

The issued certificate contains:

* the first DNS name of the order as Subject Common Name (`CN=`),
* all DNS names of the order as Subject Alternative Names (SAN).

Subject, SANs, and Extended Key Usages included in the CSR are ignored. The certificate chain returned to the client contains the issued certificate and the SCEPman CA certificate(s).

### Security considerations

* **Anybody who can write `TXT` records** for a domain in `AppConfig:Acme:AllowedDomains` and reach your ACME endpoint can enroll a certificate for that domain. Restrict write access to your DNS zones accordingly and keep `AppConfig:Acme:AllowedDomains` as narrow as possible.
* SCEPman does not support External Account Binding (EAB). Every client can create an ACME account.
* A wildcard entry like `*.contoso.com` in `AppConfig:Acme:AllowedDomains` also allows wildcard certificates like `*.contoso.com`. If you want to avoid wildcard certificates, list exact DNS names instead.
* ACME account keys must be RSA (at least 2048 bits by default) or ECDSA (P-256, P-384, or P-521).

### Revocation

You can revoke certificates enrolled via ACME:

* in Certificate Master, or via the Management REST API,
* with your ACME client, for example `certbot revoke`. SCEPman accepts revocation requests signed by the ACME account that enrolled the certificate or by the private key of the certificate itself.

### Troubleshooting

| Symptom                                                                       | Cause and resolution                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `serverInternal` error "AllowedDomains configuration is missing"              | `AppConfig:Acme:AllowedDomains` is not configured.                                                                                                                                                                                                                                                                              |
| `unsupportedIdentifier` error "The following DNS identifiers are not allowed" | The requested name does not match any entry of `AppConfig:Acme:AllowedDomains`. Remember that `*.contoso.com` does not include `contoso.com` itself.                                                                                                                                                                            |
| Validation stays pending or fails although the `TXT` record exists            | SCEPman cannot reach the DNS server or the DNS server does not return the record. Check VNet integration, firewall rules, and `AppConfig:Acme:DnsServers`. With log level _Debug_, the SCEPman logs show the DNS server that responded and the values it returned. Keep the `TXT` record until the certificate has been issued. |
| `badNonce` error "Nonce has expired"                                          | Nonces are valid for a short time only. ACME clients usually retry automatically with a fresh nonce. This happens especially in manual DNS mode, when creating the record takes a while.                                                                                                                                        |
| `unauthorized` error "JWS 'url' header ... does not match request URI"        | The client uses a different host name than configured in `AppConfig:BaseUrl`. Use the directory URL on the host of `AppConfig:BaseUrl`.                                                                                                                                                                                         |
| Order is no longer valid when finalizing                                      | Orders and authorizations expire 10 minutes after creation. Create the `TXT` record and finalize the order within this time. Use DNS automation of your ACME client instead of manual DNS mode where possible.                                                                                                                  |
| Go-based clients (e.g. lego) fail with `tls: no renegotiation`                | The App Service requests client certificates via TLS renegotiation, which Go does not support. In your SCEPman App Service > Configuration > General settings > **Incoming client certificates**, add `/acme` to the **Certificate exclusion paths**.                                                                           |
