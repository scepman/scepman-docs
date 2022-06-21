# The Certifried Security Vulnerability

In May 2022, [Oliver Lyak described a Privilege Escalation vulnerability](https://research.ifcr.dk/certifried-active-directory-domain-privilege-escalation-cve-2022-26923-9e098fe298f4) he had discovered using certificate authentication. He describes that an attacker might enroll a certificate which lets him authenticate as Domain Controller computer account and thereby take over an AD domain (and an AAD tenant, if connected). There are [CVE-2022-26921](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-26921) and [CVE-2022-26923](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2022-26923) describing the vulnerabilities and Microsoft tackled them with [a patch in KB5014754](https://support.microsoft.com/en-us/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16#bkmk_certmap). This article descirbes how this affects organizations running SCEPman, and how SCEPman can help to mitigate the security problem.

## Executive Summary

- SCEPman certificates cannot be used for Certifried attacks in most cases
- Using SCEPman helps to mitigate Certifried attacks, because contrary to Microsoft CA certificates, SCEPman CA certificates usually need not to be in the NTAuth store
- Microsoft's patch will not affect SCEPman installations in most cases. In these cases, enabling Full Enforcement mode is a good idea.

## Consequences of Microsoft's Patch

The patch in [KB5014754](https://support.microsoft.com/en-us/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16#bkmk_certmap) just adds some additional audit events by default. Full Enforcement mode starts on May 9, 2023 or sooner when manually enabling it. With Full Enforcement mode, certificates can be used for user and device authentication only if they either contain the SID of an account or, in the case of user certificates, if the AD object of the user contains a reference to the specific certificate. The former requires a new proprietary X.509 extension, the latter is called Certificate Mapping and uses the altSecurityIdentities attribute.

Generally speaking, this has an effect on AD authentications only. It required adding the CA certificate to the Forest's NTAuth Store. By default, SCEPman is not added to the NTAuth Store if you do not do this explicitely and manually. If you have not done this yet and do not plan to do it, the patch has no effect on your SCEPman instance. There is one use case where the SCEPman Docs recommend adding the SCEPman CA certificate to the NTAuth Store, which is when you want to [let SCEPman issue Domain Controller certificates for Kerberos Authentication](../../certificate-deployment/other-1/domain-controller-certificates.md#trust-the-ca-certificate-in-the-domain-for-kerberos-authentication).

### Intune Device Certificates

Device Certificates might be usable for [Windows Hello for Business Certificate Trust](https://docs.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-hybrid-cert-trust). If you added the AD DNS name to device certificates to use them for Certificate Trust, you might be affected. This requires a device object in both AAD and AD. For this seldom use case, we recommend switching to [WHfB Cloud Trust](https://docs.microsoft.com/en-us/windows/security/identity-protection/hello-for-business/hello-hybrid-cloud-trust).

### Intune User Certificates

User Certificates can be used for Windows Hello for Business Certificate Trust. They could also be used for other ways of certificate-based AD authentication like RDP sessions to domain-joined machines or WiFi authentication based on NPS. SCEPman itself does not write to the altSecurityIdentities attribute to provide the strong Certificate Mapping. The SCEPman logs do contain the serial numbers of issued certificates, which might be used to write them with some sort of external tool. Furthermore, Intune does not offer a way to include a SID into the certificate request and SCEPman itself also does not provide a way to lift that restriction, so SIDs are not possible when enrolling SCEPman certificates via Intune. In summary: Do not use Certificate Trust, but Key Trust. And the patch is one argument more for using [RADIUS-as-a-Service](https://www.radius-as-a-service.com/) instead of NPS.

### DC Certificates

Domain Controller certificates are not affected by the vulnerability and therefore generally also aren't affected by the patch. It might happen that DC certificates are used for Client Authentication, for which they were permitted previously. This will not work anymore once Full Enforcement is activated. Look for [Audit events](https://support.microsoft.com/en-us/topic/kb5014754-certificate-based-authentication-changes-on-windows-domain-controllers-ad2c23b0-15d8-4340-a468-4d4f3b188f16#bkmk_auditevents) after patching to find out whether this might affect you. In most cases, this shouldn't be a problem.

## Attacks using SCEPman Certificates

The Certifried attack can be used only with CA certificates in the NTAuth store. By default, this is not the case for the SCEPman CA certificate. Thus, if you are using SCEPman to enroll certificates via Intune instead of Microsoft Active Directory Certificate Services, chances are, that your environment is immune to the attack. However, if your SCEPman issues Domain Controller certificates, your SCEPman CA certificate is in the NTAuth store and you should continue reading.

An attacker needs a certificate with either a faked UPN in the Subject Alternative Name (SAN) extension and the Extended Key Usage (EKU) Smart Card Logon, or a faked DNS name in the SAN and the EKU Client Authentication.

### Intune User Certificates

Assume an attacker takes control over an AAD user account to let SCEPman enroll a user certificate. How could the attacker make SCEPman issue a certificate usable for the attack?

User Certificates usually contain the EKU Client Authentication. But if you follow the recommendations, they do not contain a DNS name in the SAN. Therefore, these certificates cannot be used.

If you configured the EKU Smart Card Logon, the certificate can be used for authentication, but only for the account in the UPN. The UPN comes from AAD is verfied, so the attacker cannot get an UPN of an account into the certificate that the attacker hasn't got hold of anyway.

### Intune Device Certificates

Following our basic recommendations, device certificates have the EKU Client Authentication. Their SAN contains an URI entry in the SAN, which cannot be used for the exploit. However, you may add a DNS name to the SAN in addition, for example DeviceName.contoso.com. If you did also import the SCEPman CA certificate into the NTAuth Store, these certificates can be used to authenticate on-prem as a device with the same DNS name. Because users may define their device names as they want, they could name their device "PrimaryDomainController" and authenticate on-prem as PrimaryDomainController.contoso.com, even if such a computer exists in the AD already. This is not SCEPman-specific, by the way, and would affect other SCEP implemenations like NDES as well.

Therefore, you should not add DNS name entries based on user-controlled data like the device name with domain names that are also used for on-prem domains if you use the same SCEPman instance also for DC certificates! If you still need this, you must enable Full Enforcement mode to prevent the elevation attack. You might also run two separate SCEPman instances, one for DC certificates, and one for Intune enrollment.

### Jamf User and Device Certificates

Certificates issued via Jamf will have the EKU Client Authentication. If you follow our documentation, no type of certificate will have a DNS name in the SAN. Hence, these certificates are unusable for a Certifried attack. If you do have the SCEPman CA in your AD's NTAuthStore, for example because you issue DC certificates, you should not add DNS names to the SAN or make sure that you enable Full Enforcement mode in your AD domain.

### Certificate Master Certificates

There are three ways to issue certificates via the Certificate Master component as of SCEPman version 2.1.

[**TLS Server Certificates**](../../certificate-deployment/certificate-master/tls-server-certificate-pkcs-12.md) are unaffected, as they contain neither Smart Card Logon nor Client Authentication as EKU.

[**Manual Client Certificates**](../../certificate-deployment/certificate-master/client-certificate-pkcs-12.md) are also unaffected. They contain the Client Authentication EKU, but no DNS SAN entry.

[**Custom CSR Requests**](../../certificate-deployment/certificate-master/certificate-signing-request-csr.md) are freely configurable and include authentication certificates. As anybody having access to the Certificate Master application may issue such a certificate you should take at least one of the following precautions:
- Make sure that only priviledged accounts can access Certificate Master. You could, for example, [grant access to the Certificate Master component](../../scepman-configuration/post-installation-config.md#granting-the-rights-to-request-certificates-via-the-certificate-master-website) only to a single AAD Group that you design as [Priviledged Access group](https://docs.microsoft.com/en-us/azure/active-directory/privileged-identity-management/groups-features).
- Use separate SCEPman instances and CA certificates for DC Certificates (whose CA certificate is in the NTAuth Store) and Certificate Master.
- Enable Full Enforcement mode in your AD domain.

### Domain Controller Certificates

If an attacker has the required access rights to issue Domain Controller certificates, this attacker likely has control over a Domain Controller and owns the domain already. The attacker does not need the Certifried attack.