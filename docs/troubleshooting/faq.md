# FAQ

## Can SCEPman be used with an intermediate root?

Yes, but SCEP needs the “key encipherment” and “certificate signing” as key usage. If your existing PKI cannot create such a certificate it will not work. Our recommendation is that you create a SCEPman instance and test this scenario.

To use such a intermediate root just switch the certificate in the Azure Key Vault and update two application settings in your app service.

```text
AppConfig:KeyVaultConfig:RootCertificateConfig:CertificateName
AppConfig:KeyVaultConfig:RootCertificateConfig:Subject
```

## What kind of authentication is required to access the SCEP endpoint of SCEPman to request a certificate?

To access the SCEP endpoint no authentication is required. But any request to the SCEP endpoint needs to be validated from Intune and invalid requests, that are not pushed from your Intune instance, will not get a confirmation. This is exactly the same implementation as the Microsoft on-premises PKI system use for SCEP endpoints.

## Is it possible to block access to the Web Dashboard

Its not possible out-of-the-box at the moment. But on this page you cannot find any sensitive information, that’s why it can be accessed anonymously. The SCEPman endpoint needs to be accessible without authentication on port 80 and 443 for the SCEP and OCSP handling. The same port is used to access the status page.

What you can do is changing the path mapping in your web application. If you only want to hide the status page this would be an option.



