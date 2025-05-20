---
title: Enrollment REST API - App Registration
---

{% stepper %}
{% step %}
## App Registration

Create a new _App Registration_ that describes your use case. You application will authenticate as this application against SCEPman.
{% endstep %}

{% step %}
## API Permissions

### CSR.Request.Db

Assign the required permissions by running the **Register-SCEPmanApiClient** cmdlet from the SCEPman PowerShell module.

Example:&#x20;

```powershell
Register-SCEPmanApiClient -ServicePrincipalId xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```

_ServicePrincipalId_

The _**Object ID**_ of the complementing _**Enterprise Application**_ of the App Registration we created in the previous step. Note that this does not refer to the Enterprise Application usually named SCEPman-api, which identifies SCEPman itself.

To manually assign this permission you can navigate to _API Permissions_ and add a permission from the _permissions your organization uses_. Assign the _**CSR.Request.Db**_ permission from _**SCEPman-api**_ as an _application permission_.

### Application.Read.All (Optional)

_Service Principals_ will also require the Graph permission _**Application.Read.All**_ to allow automatic retrieval of SCEPman's API scope for authentication.

The permission can be added manually like so:

<figure><img src="../assets/image (71) (1).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
## Client Secret

Create a client secret under "Certificates & Secrets." The Client Secret will be used as a password to authenticate the application later.
{% endstep %}
{% endstepper %}
