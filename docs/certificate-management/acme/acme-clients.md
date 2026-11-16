# ACME Clients

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.2 and above
{% endhint %}

You can use any ACME client that complies with [RFC 8555](https://datatracker.ietf.org/doc/html/rfc8555), supports the **DNS-01** challenge, and lets you configure a custom ACME directory URL. This article shows examples for common clients.

Before you start, enable and configure the ACME endpoint in SCEPman. In all examples, replace:

* `https://scepman.contoso.com/acme/directory` with the ACME directory URL of your SCEPman instance,
* `web01.corp.contoso.com` with the DNS name(s) you want to enroll a certificate for. They must be allowed by AppConfig:Acme:AllowedDomains,
* `admin@contoso.com` with a contact email address for the ACME account.

{% hint style="info" %}
Most ACME clients support two ways to create the `_acme-challenge` `TXT` record:

* **Manual mode**: The client displays the record and waits until you have created it. This is useful for testing, but does not allow automatic renewal.
* **DNS provider integration**: The client creates and deletes the record automatically via the API of your DNS provider, e.g. Azure DNS. Use this for production, so certificates are renewed without user interaction.

Orders expire 10 minutes after creation. In manual mode, create the record within this time.
{% endhint %}

{% tabs %}
{% tab title="certbot" %}
[certbot](https://certbot.eff.org/) is the ACME client of the Electronic Frontier Foundation and available for most Linux distributions.

#### Manual mode

```bash
certbot certonly \
  --manual \
  --preferred-challenges dns \
  --server https://scepman.contoso.com/acme/directory \
  --domain web01.corp.contoso.com \
  --email admin@contoso.com \
  --agree-tos \
  --no-eff-email
```

certbot displays the name and value of the `TXT` record. Create the record in your DNS zone, wait until it is resolvable by the DNS servers SCEPman uses, and press _Enter_. certbot stores the certificate and private key in `/etc/letsencrypt/live/web01.corp.contoso.com/`.

You can request a certificate for several DNS names by repeating `--domain`. The first name becomes the Common Name of the certificate.

#### Automation and renewal

For automatic renewal, certbot must be able to create the `TXT` record without user interaction. Use a [DNS plugin](https://eff-certbot.readthedocs.io/en/stable/using.html#dns-plugins) for your DNS provider, or specify your own scripts with `--manual-auth-hook` and `--manual-cleanup-hook`. certbot passes the domain and the challenge value to the scripts in the environment variables `CERTBOT_DOMAIN` and `CERTBOT_VALIDATION`.

```bash
certbot certonly \
  --manual \
  --preferred-challenges dns \
  --manual-auth-hook /etc/letsencrypt/scepman-hooks/create-txt.sh \
  --manual-cleanup-hook /etc/letsencrypt/scepman-hooks/delete-txt.sh \
  --server https://scepman.contoso.com/acme/directory \
  --domain web01.corp.contoso.com \
  --email admin@contoso.com \
  --agree-tos \
  --no-eff-email \
  --non-interactive
```

certbot remembers the server and hooks for each certificate. `certbot renew`, which most distributions run automatically via a systemd timer or cron job, renews certificates 30 days before they expire.

#### Revocation

```bash
certbot revoke \
  --server https://scepman.contoso.com/acme/directory \
  --cert-name web01.corp.contoso.com
```
{% endtab %}

{% tab title="lego" %}
[lego](https://go-acme.github.io/lego/) is an ACME client written in Go with integrations for many DNS providers. The examples use the lego v4 command line syntax.

#### Manual mode

```bash
lego \
  --server https://scepman.contoso.com/acme/directory \
  --email admin@contoso.com \
  --domains web01.corp.contoso.com \
  --dns manual \
  --dns.resolvers 10.0.0.10:53 \
  run
```

lego displays the `TXT` record and waits until you have created it and pressed _Enter_. Before it asks SCEPman to validate the challenge, lego checks itself whether the record is resolvable. For internal zones, use `--dns.resolvers` to specify a DNS server that can resolve your internal zone. lego stores the certificate and private key in the `.lego/certificates` folder of the current directory.

#### Azure DNS

If your zone is hosted in Azure DNS, lego can create the `TXT` record automatically. The identity lego uses needs the **DNS Zone Contributor** role on the DNS zone.

On Azure workloads, we recommend a Managed Identity:

```bash
export AZURE_AUTH_METHOD="msi"
export AZURE_SUBSCRIPTION_ID="<subscription id of the DNS zone>"
export AZURE_RESOURCE_GROUP="<resource group of the DNS zone>"

lego \
  --server https://scepman.contoso.com/acme/directory \
  --email admin@contoso.com \
  --domains web01.corp.contoso.com \
  --dns azuredns \
  run
```

Alternatively, you can use a service principal with the environment variables `AZURE_CLIENT_ID`, `AZURE_CLIENT_SECRET`, and `AZURE_TENANT_ID`. See the [lego Azure DNS documentation](https://go-acme.github.io/lego/dns/azuredns/) for all options and other DNS providers.

#### Renewal

Run the same command with `renew` instead of `run` regularly, e.g. daily via cron. lego renews the certificate if it expires within the number of days given by `--days`:

```bash
lego \
  --server https://scepman.contoso.com/acme/directory \
  --email admin@contoso.com \
  --domains web01.corp.contoso.com \
  --dns azuredns \
  renew --days 30
```

{% hint style="info" %}
lego uses Go's TLS implementation, which does not support TLS renegotiation. If lego fails with `tls: no renegotiation`, add `/acme` to the client certificate exclusion paths of your SCEPman App Service as described in Troubleshooting.
{% endhint %}
{% endtab %}
{% endtabs %}

### Wildcard certificates

To enroll a wildcard certificate, request the wildcard name, e.g. `--domain "*.corp.contoso.com"` for certbot or `--domains "*.corp.contoso.com"` for lego. The `TXT` record for the challenge is `_acme-challenge.corp.contoso.com`, i.e. without the `*.` prefix. Wildcard certificates are always validated via DNS-01. To allow wildcard certificates, AppConfig:Acme:AllowedDomains must contain a matching wildcard entry, e.g. `*.contoso.com` or `*.corp.contoso.com`.

### Trust

Systems connecting to services that use certificates enrolled via ACME must trust your SCEPman Root CA. Distribute the Root CA certificate to these systems, e.g. via Intune or Group Policy. The ACME client itself connects to SCEPman using the TLS certificate of your App Service, so the client does not need to trust the SCEPman Root CA to enroll certificates.
