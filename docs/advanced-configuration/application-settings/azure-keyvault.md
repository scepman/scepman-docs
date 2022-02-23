# Azure KeyVault

## AppConfig:KeyVaultConfig:RootCertificateConfig:AddExtendedKeyUsage

{% hint style="info" %}
Applicable to version 1.8 and above
{% endhint %}

**Value:** _true_ or _false_

**Description:** This setting determines whether SCEPman generates its CA certificates with an Extended Key Usage extension. The extension is not required by the standards, but Cisco ISE sometimes requires it to make OCSP work.

**True** \(default for 1.9 and above\): SCEPman adds an Extended Key Usage extension to newly generated CA certificates.

**False** \(default for 1.8 and before\): SCEPman generates a CA certificate without Extended Key Usage extension.

## AppConfig:KeyVaultConfig:KeyVaultURL

The Azure Key Vault URL. This setting is automatically configured during the setup.

You must define this setting in the configuration of your App Service. It is NOT possible to define this setting as a Secret in Azure Key Vault!

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName

The Root Certificate Name. This setting is automatically configured during the Root CA creation.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

## AppConfig:KeyVaultConfig:RootCertificateConfig:Subject

The Root Certificate Subject. This setting is automatically configured during the Root CA creation.

{% hint style="danger" %}
Changes can harm your service!
{% endhint %}

