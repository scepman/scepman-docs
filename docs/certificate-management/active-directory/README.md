# 🆕 Active Directory

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.0 and above
{% endhint %}

SCEPman can be configured to handle SOAP requests coming from Windows client to allow for an easy deployment option for Active Directory joined clients that can only be configured using group policies.

By creating a service principal in your on-premises AD-environment, we can allow SCEPman to accept SOAP requests of a domain-joined Windows client requesting a certificate. With Kerberos being used as authentication protocol the identity of the requester can be ensured and SCEPman will respond with a valid certificate.

All supported versions of Windows supports this enrollment method natively and no additional software is required on these computers.

{% content-ref url="general-configuration.md" %}
[general-configuration.md](general-configuration.md)
{% endcontent-ref %}

{% content-ref url="group-policy.md" %}
[group-policy.md](group-policy.md)
{% endcontent-ref %}
