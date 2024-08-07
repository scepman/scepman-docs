# Basics

{% hint style="info" %}
This area is under construction!
{% endhint %}

## AppConfig:SCEPman:URL

**Value:** String (URL)

**Description:**\
This is the URL of the SCEPman instance that belongs to this Certificate Master. If you have a geo-redundant setup, this should be the URL of the SCEPman App Service nearest to Certificate Master. Certificate Master will submit certificate requests to this SCEPman instance for signing.

## AppConfig:IntuneCertificateSearchStrategy

**Value:** _Management_, _Reporting_, or _CombineManagementAndReporting_

**Description:**\
Defines which backend API to use when querying Intune for issued certificates.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AzureStorage:TableStorageEndpoint

This defines which Table Storage Endpoint to use to store certificate information.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:RemoteDebug

**Value:** _true_ or _false_

**Description:**\
You can send Debug log information to a cloud-based monitoring solution of our company for support reasons. This can speed up support cases. You can activate and deactivate this feature by changing the value to **true** or **false**.

## WEBSITE\_RUN\_FROM\_PACKAGE

This setting points to the Application Artifacts that will be loaded by starting the App Service.