# Requesting Certificates via REST API

{% hint style="warning" %}
Experimental Feature
{% endhint %}

{% hint style="info" %}
This feature requires version **2.3.689** or above.

SCEPman Enterprise Edition only
{% endhint %}

SCEPman features a REST API to enroll certificates. This is an alternative to the SCEP endpoints that require the SCEP-style of authentication, while the REST API uses Microsoft Identities for authentication. It is also much simpler than SCEP.

You need to add a service identity to the Role *CSR.Request.Db* of the Enterprise App *scepman-api*. If this role does not exist yet but only CSR.Request, you must run the CMDlet Complete-ScepmanInstallation from the [SCEPman Powershell Module (at least version 1.8.10)](https://www.powershellgallery.com/packages/SCEPman) once again to get it. The service identity is then permitted to use the SCEPman certificate enrollment REST API.

In SCEPman, you must enabling the feature by setting [AppConfig:DbCSRValidation:Enabled](../scepman-configuration/optional/application-settings/dbcsr-validation.md) to *true*.

Then you can POST a PKCS#10/CMS to your SCEPman with the HTTP path *api/csr*. The HTTP Response will be the freshly issued certificate in DER encoding.

SCEPman will store all issued certificates automatically in its Storage Account, so you can conveniently list and revoke them via the Certificate Master component.

## Example

TBD