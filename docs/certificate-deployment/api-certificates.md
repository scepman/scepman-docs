# Enrollment REST API

{% hint style="info" %}
This feature requires version **2.3.689** or above.

SCEPman Enterprise Edition only
{% endhint %}

SCEPman features a REST API to enroll certificates. This is an alternative to the SCEP endpoints that require the SCEP-style of authentication, while the REST API uses Microsoft Identities for authentication. The protocol is also much simpler than SCEP.

You need to add a service identity to the Role _CSR.Request.Db_ of the Enterprise App _scepman-api_. If this role does not exist yet but only CSR.Request, you must run the CMDlet Complete-ScepmanInstallation from the [SCEPman Powershell Module (at least version 1.8.10)](https://www.powershellgallery.com/packages/SCEPman) once again to get it. The service identity is then permitted to use the SCEPman certificate enrollment REST API. The easiest way to add a service identity to this role is to call `Register-SCEPmanApiClient -ServicePrincipalId 00000000-0000-0000-0000-000000000000 6>&1` from the [SCEPman PowerShell module](https://www.powershellgallery.com/packages/SCEPman/) version 1.10 and above, where _00000000-0000-0000-0000-000000000000_ in the example is the Object Id of your service principal (e.g. Managed Identity or Enterprise Application).

In SCEPman, you must enabling the feature by setting [AppConfig:DbCSRValidation:Enabled](../advanced-configuration/application-settings/dbcsr-validation.md) to _true_.

Then you can POST a PKCS#10/CMS to your SCEPman with the HTTP path _api/csr_. The HTTP Response will be the freshly issued certificate in DER encoding.

SCEPman will store all issued certificates automatically in its Storage Account, so you can conveniently list and revoke them via the Certificate Master component.

## Examples

See our [Open Source Sample Library on GitHub](https://github.com/scepman/csr-request) to find out how to use SCEPman's REST API.
