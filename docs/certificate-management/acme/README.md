# 🆕 ACME

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.2 and above
{% endhint %}

The Automatic Certificate Management Environment (ACME, [RFC 8555](https://datatracker.ietf.org/doc/html/rfc8555)) is a protocol for automated issuance, renewal, and revocation of TLS server certificates. It is best known from the free public CA Let's Encrypt and is supported by a wide range of clients and platforms, for example certbot, lego, acme.sh, web servers, reverse proxies, and Kubernetes cert-manager.

SCEPman provides an ACME endpoint, so you can use these existing clients to automatically enroll TLS server certificates from your SCEPman CA.

### Why use SCEPman instead of a public ACME CA?

Public CAs like Let's Encrypt are a great choice for publicly reachable services. For internal services, however, they have some limitations:

* **Internal domains**: Public CAs only issue certificates for publicly resolvable domains. They do not issue certificates for internal-only DNS names, for example `app01.corp.contoso.com` or names in a split-horizon DNS zone.
* **Certificate Transparency**: Certificates issued by public CAs are published in public Certificate Transparency logs. This reveals the DNS names of all your services, including internal ones, to anyone.
* **Lifetime and rate limits**: Public CAs define the certificate lifetime and impose rate limits that you cannot influence.

With SCEPman, certificates chain up to your own SCEPman Root CA. They are not published publicly, you decide which domains are allowed, and you control the validity period.

### How it works

1. An ACME client on your server creates an account and an order for one or more DNS names at the SCEPman ACME endpoint.
2. SCEPman responds with a DNS-01 challenge. The client (or you, manually) creates a `TXT` record named `_acme-challenge.<your domain>` with the challenge value.
3. SCEPman queries the configured DNS servers for this `TXT` record. If the value matches, the requestor has proven control over the domain.
4. The client submits a Certificate Signing Request (CSR) and receives the certificate including the certificate chain.
5. Before the certificate expires, the client repeats the process to renew the certificate.

Since SCEPman validates domains via DNS, it does not require a network connection to the server requesting the certificate. It only needs access to DNS servers that can resolve your (internal) domains.

### Which enrollment method should I use?

SCEPman offers several ways to get TLS server certificates. Choose the one that fits your use case:

| Method              | Typical use case                                                                                                                               |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| Certificate Master  | A few certificates that you enroll manually via the web portal.                                                                                |
| Enrollment REST API | Custom scripts and automation that authenticate with Microsoft Entra ID, e.g. via a Managed Identity.                                          |
| ACME                | Servers, appliances, containers, and platforms with built-in ACME support, where proof of domain control via DNS is the natural authorization. |

### Get started

{% content-ref url="configure-acme.md" %}
[configure-acme.md](configure-acme.md)
{% endcontent-ref %}

{% content-ref url="acme-clients.md" %}
[acme-clients.md](acme-clients.md)
{% endcontent-ref %}
