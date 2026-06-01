---
layout:
  width: default
  title:
    visible: true
  description:
    visible: true
  tableOfContents:
    visible: true
  outline:
    visible: true
  pagination:
    visible: true
  metadata:
    visible: true
  tags:
    visible: true
  actions:
    visible: true
---

# General Configuration

To allow SCEPman to handle incoming SOAP requests successfully, we need to take a few steps:

## Known Issues

### WS\_E\_ENDPOINT\_ACCESS\_DENIED

```
Error: WS_E_ENDPOINT_ACCESS_DENIED 
Hex: 0x803d0005
Dec: -2143485947
```

This error is known to occur during the validation of the CEP server when you are using the _default_ URIs of the Azure App Service. This error is caused by the Kerberos protocol asking for a service principal name of the A record of the service that is to be accessed. In the case of the default app service domains, for example `contoso.azurewebsites.net` is just a CNAME and points to an A record similar to:

```
waws-prod-ab1-234-c56d.westeurope.cloudapp.azure.com
```

As this A record of an infrastructure host is not guaranteed to be consistent in the future, adding a service principal name for this host is **not recommended**.

Make sure to add a custom domain to your app service and use an A record within your DNS provider to point it to the app service instead of a CNAME.

{% content-ref url="../../azure-configuration/custom-domain.md" %}
[custom-domain.md](../../azure-configuration/custom-domain.md)
{% endcontent-ref %}

### ERROR\_INVALID\_PARAMETER

```
Error: ERROR_INVALID_PARAMETER
Hex: 0x80070057
Dec: -2147024809
```

This error occurs during the CEP server registration if you enter an URI that begins with `http://`. Make sure to only register a CEP server using `https://`

### ERROR\_ACCESS\_DENIED

```
Error: ERROR_ACCESS_DENIED
Hex: 0x80070005
Dec: -2147024891
```

When registering a CEP server in machine context, the acting user (the account that started `gpmc.msc`) needs to be a member of the local Administrators group on the computer while editing the GPO.

Make sure to start `gpmc.msc` with elevated permissions in this case.
