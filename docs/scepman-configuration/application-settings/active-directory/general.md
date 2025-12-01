# General

## AppConfig:ActiveDirectory:Keytab

_Linux: AppConfig\_\_ActiveDirectory\_\_Keytab_

**Value:** Output from New-SCEPmanADPrincipal

**Description:** The encoded Kerberos keytab of the service principal created by New-SCEPmanADPrincipal. The keytab is encrypted using the public key of SCEPmans CA certificate which allows for a secure transfer of this information. Technically, the encryption is a PKCS#7 encrypted to the CA certificate's private key.

While the keytab itself is sensitive information, this encypted value can only be decrypted by the CA certificate and SCEPman holds the keytab only in memory, so it requires no special security precautions like configuring this value in a Key Vault secret instead of an environment variable.

## AppConfig:ActiveDirectory:GroupFilter

_Linux: AppConfig\_\_ActiveDirectory\_\_GroupFilter_

**Value:** Comma-separated list of AD groups specified by their SID

**Description:** This setting allows to limit the usage of the endpoint to members of the specified Active Directory groups.

## AppConfig:ActiveDirectory:RenewalThresholdPercentage

_Linux: AppConfig\_\_ActiveDirectory\_\_RenewalThresholdPercentage_

**Value:** Floating point number of the percentage. Default is 0.2 (20%)

**Description:** If the remaining validity of a certificate falls below this percentage of the total certificate validity, a renewal should be triggered on the client side.
