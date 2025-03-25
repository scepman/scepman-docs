# API Enrollment

{% hint style="info" %}
This feature requires version **2.3.689** or above.
{% endhint %}

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

SCEPman features a REST API to enroll certificates. This is an alternative to the SCEP endpoints that require the SCEP-style of authentication, while the REST API uses Microsoft Identities for authentication. The protocol is also much simpler than SCEP.

## Prerequisites

### 1. Service Principal

{% include "../../../.gitbook/includes/enrollment-rest-api-app-registration.md" %}

### 2. App Service Settings

{% include "../../../.gitbook/includes/enrollment-rest-api-app-service-settings.md" %}



## Enrolling certificates

After you have prepared the prerequisites, you can POST a PKCS#10/CMS to your SCEPman with the HTTP path _api/csr_. The HTTP Response will be the freshly issued certificate in DER encoding.

SCEPman will store all issued certificates automatically in its Storage Account, so you can conveniently list and revoke them via the Certificate Master component.



## Examples

See our [Open Source Sample Library on GitHub](https://github.com/scepman/csr-request) to find out how to use SCEPman's REST API.

