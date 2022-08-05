# Basics

## AppConfig:BaseUrl

**Value:** _App Service Name_ or [https://customcname.domain.com](https://customcname.domain.com)

**Description:**\
This defines the public OCSP endpoint URL for the certificates. By default, the value contains the **App Service Name**. If you want to use a [Custom Domain](../custom-domain.md), you need to change this value.

## AppConfig:LicenseKey

**Value:** _empty_ **or** _license key_

**Description:**\
If you are using a trial deployment or the community edition this field leaves empty. After you purchased the Enterprise Edition you will receive a license key from us, then you can insert this key into this setting.

## AppConfig:RemoteDebug

**Value:** _true_ or _false_

**Description:**\
You can send Debug log information to a cloud-based monitoring solution of our company for support reasons. This can speed up support cases. You can activate and deactivate this feature by changing the value to **true** or **false**.

{% hint style="info" %}
Do not forget to restart SCEPman App Service after enabling and saving the setting.
{% endhint %}

## WEBSITE\_RUN\_FROM\_PACKAGE

This setting points to the Application Artifacts that will be loaded by starting the App Service.\
Please have a look at these instructions: [Application Artifacts](../application-artifacts.md#change-artifacts).

## AppConfig:AnonymousHomePageAccess

**Value:** _true_ or _false_

**Description:**\
When not configured or set to **true**, anyone on the internet knowing the app service's URL can access the SCEPman Homepage and see status information like the SCEPman version and whether SCEPman is up and running (except if you prevent this with a firewall). We consider this non-sensitive information, but if you want to hide it, set this to **false**. Then, the homepage is deactivated for browser access and this information is not visible anymore.
