# Azure AD

## AppConfig:AuthConfig:ApplicationId

The [Application (client) ID](../../scepman-deployment/permissions/azure-app-registration.md#basic-app-registration-application-id) from your Azure AD App registration. This setting is configured during the setup.

{% hint style="warning" %}
Please do not mix this up with the "Client Secret ID**"**. We need the "Application (client) ID", here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:ApplicationKey

The [Application Key (client secret **value**)](../../scepman-deployment/permissions/azure-app-registration.md#azure-app-registration-client-secret) from your Azure AD App registration. This setting is configured during the setup.

{% hint style="warning" %}
Please do not mix this up with the "Client Secret **ID"**. We need the "Client Secret **Value"**, here.
{% endhint %}

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:AuthConfig:TenantName

The Azure AD Tenant ID. This setting is automatically configured during the setup.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:SCEPResponseEncryptionAlgorithm

The algorithm used to encrypt SCEP responses. Reasonable values include "2.16.840.1.101.3.4.1.42" for AES-256-CBC (the default) and "2.16.840.1.101.3.4.1.2" for AES-128-CBC.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}
