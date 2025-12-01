# Active Directory

{% hint style="warning" %}
SCEPman Enterprise Edition only

Applicable to version 3.0 and above
{% endhint %}

{% hint style="info" %}
These settings should only be applied to the SCEPman App Service, not the Certificate Master. Please refer to [SCEPman Settings](../).
{% endhint %}

## General Settings

The following settings affect the behavior of the Active Directory endpoint in general.

{% content-ref url="general.md" %}
[general.md](general.md)
{% endcontent-ref %}

## Certificate Templates

Aside from the general settings of the endpoint, the certificate templates can be configured independently. The format of those variable names follow the scheme `AppConfig:ActiveDirectory:[Template]:[Setting]` where `[Template]` is to be replaced with User, Computer or DC and `[Setting]` is to be replaced with the respective setting name. You can find the configuration options for the certificate templates in the following pages.

{% content-ref url="user-template.md" %}
[user-template.md](user-template.md)
{% endcontent-ref %}

{% content-ref url="computer-template.md" %}
[computer-template.md](computer-template.md)
{% endcontent-ref %}

{% content-ref url="dc-template.md" %}
[dc-template.md](dc-template.md)
{% endcontent-ref %}
