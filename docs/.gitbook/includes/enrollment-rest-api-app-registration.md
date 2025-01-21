---
title: Enrollment REST API - App Registration
---

{% stepper %}
{% step %}
## App Registration

Create a new _App Registration_ that describes your use case. You application will authenticate as this application against SCEPman.
{% endstep %}

{% step %}
## API Permission

Assign the required permissions by running the **Register-SCEPmanApiClient** cmdlet from the SCEPman PowerShell module.

Example:&#x20;

```powershell
Register-SCEPmanApiClient -ServicePrincipalId 830532c6-9f7b-4bc8-8f3e-43443344ab2d
```

### ServicePrincipalId

The _**Object ID**_ of the complementing _**Enterprise Application**_ of the App Registration we created in the previous step. Note that this does not refer to the Enterprise Application usually named SCEPman-api, which identifies SCEPman itself.

To manually assign this permission you can navigate to _API Permissions_ and add a permission from the _permissions your organization uses_. Assign the _**CSR.Request.Db**_ permission from _**SCEPman-api**_ as an _application permission_.
{% endstep %}

{% step %}
## Client Secret

Create a client secret as a password to authenticate the application later.
{% endstep %}
{% endstepper %}
