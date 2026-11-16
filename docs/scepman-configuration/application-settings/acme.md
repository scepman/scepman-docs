# ACME

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.2 and above
{% endhint %}

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to SCEPman Settings.
{% endhint %}

See [ACME](../../certificate-management/acme/) for an overview of the feature and General Configuration for a step-by-step guide.

### AppConfig:Acme:Enabled

_Linux: AppConfig\_\_Acme\_\_Enabled_

**Value:** _true_ or _false_ (default)

**Description:** This setting enables SCEPman's ACME endpoint ([RFC 8555](https://datatracker.ietf.org/doc/html/rfc8555)) to issue TLS server certificates to ACME clients that prove control over the requested domains via DNS.

* **True**: SCEPman accepts requests on the ACME endpoint with the directory URL `https://<your SCEPman URL>/acme/directory`. Use in conjunction with AppConfig:Acme:AllowedDomains.
* **False** (default): SCEPman does not accept ACME requests.

### AppConfig:Acme:AllowedDomains

_Linux: AppConfig\_\_Acme\_\_AllowedDomains_

**Value:** _string_, comma-separted list of domains, e.g. `corp.contoso.com,*.corp.contoso.com,intranet.contoso.com`

**Description:** The DNS names SCEPman issues certificates for via ACME. SCEPman rejects ACME orders containing at least one DNS name that does not match any entry. This setting is **mandatory**: If it is not configured, SCEPman rejects all ACME orders.

Each entry is either:

* an **exact DNS name**, e.g. `intranet.contoso.com`. It allows certificates only for exactly this name.
* a **wildcard entry** starting with `*.`, e.g. `*.corp.contoso.com`. It allows certificates for all subdomains of `corp.contoso.com` at any depth, e.g. `app01.corp.contoso.com` and `web.dev.corp.contoso.com`, as well as wildcard certificates like `*.corp.contoso.com`. It does **not** include `corp.contoso.com` itself.

Matching is case-insensitive.

### AppConfig:Acme:DnsServers

_Linux: AppConfig\_\_Acme\_\_DnsServers_

**Value:** _string_, comma-separated list of IP addresses and optional ports, e.g. `10.0.0.10,``10.0.0.11:5353``,[fd00::10]:53`

**Description:** The DNS servers SCEPman queries for the `_acme-challenge` `TXT` records ([RFC 8555, Section 8.4](https://datatracker.ietf.org/doc/html/rfc8555#section-8.4)) to validate that a certificate requester controls the requested domains. If you do not specify a port, SCEPman uses port 53. Hostnames are not possible, only IP addresses.

If this setting is not configured, SCEPman uses its default DNS servers. For an App Service, these could be the custom DNS servers of an integrated Virtual Network. Keep in mind that since SCEPman needs network access to the DNS servers, for internal DNS servers, this usually requires [VNet Integration](https://learn.microsoft.com/en-us/azure/app-service/overview-vnet-integration) of the SCEPman App Service.

### AppConfig:Acme:ValidityPeriodDays

_Linux: AppConfig\_\_Acme\_\_ValidityPeriodDays_

**Value:** Positive _Integer_

**Description:** The maximum validity in days of certificates issued via ACME. If this setting is not configured, the global AppConfig:ValidityPeriodDays applies. If neither is configured, certificates are valid for 90 days.

ACME clients may request a shorter validity in their order. Since ACME clients renew certificates automatically, we recommend a short validity, e.g. 90 days.

### AppConfig:Acme:EnableCertificateStorage

_Linux: AppConfig\_\_Acme\_\_EnableCertificateStorage_

**Value:** _true_ or _false_

**Description:** When requesting certificates via ACME, SCEPman stores the issued certificates in the Storage Account in Azure if this is set to _true_. This makes the issued certificates appear in SCEPman Certificate Master, where you can view and revoke them. If set to _false_, SCEPman does not store issued certificates. If this is not set, the global setting AppConfig:EnableCertificateStorage applies. If neither is set, certificates are stored.

### AppConfig:Acme:DefaultEkus

_Linux: AppConfig\_\_Acme\_\_DefaultEkus_

**Value:** Oids of the extended key usages (EKUs) that are added to certificates issued via ACME. The Oids are separated by a comma, semicolon, or space. The default is Server Authentication (1.3.6.1.5.5.7.3.1)

**Description:** SCEPman adds the EKUs defined in this setting to certificates issued via ACME. EKUs requested in the CSR are ignored.

### AppConfig:Acme:DefaultKeyUsage

_Linux: AppConfig\_\_Acme\_\_DefaultKeyUsage_

**Value:** EncipherOnly|CrlSign|KeyCertSign|KeyAgreement|DataEncipherment|_KeyEncipherment_|NonRepudiation|_DigitalSignature_|DecipherOnly (defaults are in _italic_)

**Description:** SCEPman adds the Key Usage defined in this setting to certificates issued via ACME. Key Usages requested in the CSR are ignored.

### AppConfig:Acme:AllowHttpChallenge

_Linux: AppConfig\_\_Acme\_\_AllowHttpChallenge_

**Value:** _true_ or _false_ (default)

**Description:** In addition to the DNS-01 challenge, SCEPman offers the HTTP-01 challenge ([RFC 8555, Section 8.3](https://datatracker.ietf.org/doc/html/rfc8555#section-8.3)) if this is set to _true_.

* **True**: ACME clients can prove control over a DNS name either via DNS or by serving the challenge on `http://<DNS name>/.well-known/acme-challenge/<token>`. SCEPman requires network access to the requesting web server on TCP port 80 via plain HTTP. HTTP-01 is not offered for wildcard certificates.
* **False** (default): SCEPman offers only the DNS-01 challenge.

### AppConfig:Acme:ChallengeValidationTimeoutMilliseconds

_Linux: AppConfig\_\_Acme\_\_ChallengeValidationTimeoutMilliseconds_

**Value:** Positive _Integer_ (default: 3000)

**Description:** The maximum time in milliseconds SCEPman waits for the validation of a challenge, i.e. for the DNS response or the HTTP response. Increase this value if your DNS servers respond slowly. An unsuccessful validation always takes this long.

### AppConfig:Acme:MaxIdentifiersPerOrder

_Linux: AppConfig\_\_Acme\_\_MaxIdentifiersPerOrder_

**Value:** Positive _Integer_ (default: 30)

**Description:** The maximum number of DNS names in a single ACME order, i.e. the maximum number of Subject Alternative Names in a certificate issued via ACME. SCEPman rejects orders with more DNS names.

### AppConfig:Acme:MinimumAccountRsaKeySize

_Linux: AppConfig\_\_Acme\_\_MinimumAccountRsaKeySize_

**Value:** Positive _Integer_ (default: 2048)

**Description:** The minimum size in bits of RSA keys that ACME clients use for their ACME accounts. SCEPman rejects requests signed with smaller RSA account keys. This setting applies to the account key, not to the key of the requested certificate.

### AppConfig:Acme:MinimumAccountEcKeySize

_Linux: AppConfig\_\_Acme\_\_MinimumAccountEcKeySize_

**Value:** Positive _Integer_ (default: 256)

**Description:** The minimum size in bits of ECDSA keys that ACME clients use for their ACME accounts. SCEPman rejects requests signed with smaller ECDSA account keys. This setting applies to the account key, not to the key of the requested certificate.
