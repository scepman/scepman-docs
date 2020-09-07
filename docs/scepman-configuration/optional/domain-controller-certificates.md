# Kerberos certificates for Domain Controllers

You can use SCEPman to issue Kerberos authentication certificates to your domain controllers. This allows your AAD or hybrid-joined devices to authenticate seamlessly when accessing on-premises resources.

{% hint style="info" %}
This feature requires version 1.6 or above (currently pre-beta)
{% endhint %}

To enable this setting you must add two application settings in your SCEPman service:

1. Navigate to **App Services**
2. Then choose your SCEPman app
3. Next under **Settings** click **Configuration**
4. Select **New application setting**
5. Type **AppConfig:DCValidation:Enabled** as Name
6. Type **true** as Value
7. Confirm with **OK**

8. Select **New application setting** again
9. Type **AppConfig:DCValidation:RequestPassword** as Name
10. Choose a secure password for the Value and store it somewhere safe (you will need it later on the domain Controllers)
11. Confirm with **OK**

12. Save the application settings

Then you must download our SCEP client software SCEPClientCore. It requires .NET Core 3.1 to be installed on the target systems.

Distribute this software on your domain controllers and add a Scheduled task that executes the following command:

```
ScepClientCore.exe newdccert https://your-scepman-domain/dc RequestPassword
```

You must add the SCEPman URL in the previous command, but keep the path `/dc`. Replace `RequestPassword` with the secure password you chose in step 9.

Note that we recommend to use HTTPS with TLS encryption, but it is not required to keep the request password secret. The request password is encrypted with SCEPman's CA certificate, so only SCEPman can read it, whether or not you use HTTPS. Domain Controller certificates are only issued with the correct request password.