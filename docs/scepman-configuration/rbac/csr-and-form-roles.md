# CSR and Form Roles

{% hint style="info" %}
Applicable to SCEPman Certificate Master version 2.11 and above
{% endhint %}

In addition to the roles described in [.](./ "mention"), there are some more that are not added to the Entra application by default as they might only be required in special circumstances.

These roles can be seen as a more granular concept of what the `Request.*]` roles already provide while specifically granting the permissions to request certificates using a CSR or the form.

### CSR Roles

<figure><img src="../../.gitbook/assets/image (97).png" alt=""><figcaption></figcaption></figure>

The following roles permit users to request certificates in their specific section while only being able to provide CSRs to be signed. A certificate creation through the form will not be possible.

* **Request.All.Csr**
* **Request.Client.Csr**
* **Request.CodeSigning.Csr**
* **Request.Server.Csr**
* **Request.SubCa.Csr**
* **Request.User.Csr**

### Form Roles

<figure><img src="../../.gitbook/assets/image (98).png" alt=""><figcaption></figcaption></figure>

The form roles will allow users to create certificates using the built-in form in Certificate Master. Signing CSRs is not possible with these roles.

* **Request.All.Form**
* **Request.Client.Form**
* **Request.CodeSigning.Form**
* **Request.Server.Form**
* **Request.SubCa.Form**
* **Request.User.Form**



## Adding the Roles

All these roles can be added by running the `Complete-SCEPmanInstallation` CMDlet in combination with the `-AddAdditionalCertMasterAppRoles` parameter. This requires version 2.11 or newer of the SCEPman PowerShell module.

#### Example:

{% code overflow="wrap" lineNumbers="true" %}
```powershell
Install-Module SCEPman -Scope CurrentUser -Force
Complete-SCEPmanInstallation app-scepman-contoso -AddAdditionalCertMasterAppRoles
```
{% endcode %}
