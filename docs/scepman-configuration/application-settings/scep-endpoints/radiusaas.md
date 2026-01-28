# RADIUSaaS

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.0 and above
{% endhint %}

## AppConfig:RADIUSaaSValidation:Token

_Linux: AppConfig\_\_RADIUSaaSValidation\_\_Token_

**Value:** _String_

**Description:** A challenge password that you obtain from your RADIUS-as-a-Service portal to enable automatic management of your RADIUS server certificate.

We recommend defining this setting as Secret in Azure Key Vault. The Secret must have the name _AppConfig--RADIUSaaSValidation--Token_.
