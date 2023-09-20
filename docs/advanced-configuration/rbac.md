# Role-based Authentication (RBAC)

{% hint style="info" %}
Applicable to SCEPman Certificate Master version 2.5 and above

SCEPman Enterprise Edition only
{% endhint %}

When a users access SCEPman Certificate Master, their role determines the actions they can perform and the certificates they can see. The roles are determined through the Enterprise Application *SCEPman-CertMaster* in Azure AD. If you have installed SCEPman before version 2.5, you need to execute the Complete-SCEPmanInstallation CMDlet from the SCEPman PS Module again to see the roles in the Microsoft Entra Portal. The following roles are available:

## Available Roles

 - **Admin.Full**: Members of this role can do anything in SCEPman Certificate Master. If future version of SCEPman Certificate Master add new features, members of this role will have access to those features.


 - **Manage.All**: Members of this role can see and revoke all certificates. This includes certificates in the Certificate Master database as well as certificates enrolled via Intune.

 - **Manage.All.Read**: While members can see all certificates, they cannot revoke them.

 - **Manage.Storage**: Members can see and revoke certificates in the Certificate Master database.

 - **Manage.Storage.Read**: Members can see certificates in the Certificate Master database, but cannot revoke them.

 - **Manage.Intune**: Members can see and revoke certificates enrolled via Intune.

 - **Manage.Intune.Read**: Members can see certificates enrolled via Intune, but cannot revoke them.


 - **Request.All**: Members can request all types of certificates. This includes submitting CSR requests, which can be of any type. If users need to submit CSR requests, this role is required.

 - **Request.Client**: Requests are limited to client certificates, i.e. manually created device certificates. They have the Client Authentication Extended Key Usage (EKU) and a customizable subject.

 - **Request.User**: Members can request only user certificates. They have the Client Authentication EKU and a UPN chosen by the requester. Starting with SCEPman 2.6, the Smart Card Logon EKU is also possible. Keep in mind that somebody with this role can request certificates for other users. If you have Certificate Based Authentication enabled in AD or AAD and added the SCEPman CA as a trusted for this purpose in AD or AAD, this can be used to impersonate other users.

 - **Request.CodeSigning**: Requests can only be for Code Signing certificates.

 - **Request.SubCa**: Members can request certificates for Subordinate CAs. However, the Extended Key Usage limits these CAs to issue Server Authentication certificates only. This allows them to be used for TLS interception as used in Firewalls, but not for other purposes. This is a security feature. If you require a Subordinate CA for other purposes, you must create a CSR and submit that to Certificate Master, which requires the *Request.All* role.

 - **Request.Server**: Members can request only server certificates. They have the Server Authentication EKU.