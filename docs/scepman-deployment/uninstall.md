# SCEPman Deinstallation

How you uninstall SCEPman depends on whether there is only one SCEPman instance in your tenant and whether the SCEPman instance has been used productively or not, e.g., as a PoC. If productive certificates were enrolled, you must plan whether you want to softly fade out of this SCEPman instance's usage, and keep some parts of SCEPman running for some time, or whether you want to shut down hard.

If you have multiple SCEPman installations in a single tenant and want to uninstall only some of them, you must pay attention that you keep the components used by the live instances. This is especially the case for the App Registrations, which by default are shared by all instances.

This guide is not intended for situations where you have a [geo-redundant setup](../scepman-configuration/optional/geo-redundancy.md) and want to keep SCEPman, but remove an instance for a specific region. Please contact our support in this situation if you have questions.

## Intune/Jamf/Other Configuration Profiles

For all platforms that you have used SCEPman on, you will probably have configuration profiles for

- The distribution of the SCEPman Root CA,
- enrollment of client certificates via SCEP, and
- WiFi or VPN profiles that use this client certificate.

Each type of profile in the preceding list depends on the ones above it. Thus, you should delete them from bottom to top, so you don't have any open dependencies.

Note that [Intune will remove the enrolled certificates from the client as soon as you remove the SCEP enrollment profiles](https://learn.microsoft.com/en-us/mem/intune/protect/remove-certificates), so there is no gentle phasing out of the certificate usage, but a hard cut.

## Azure Resources

In many cases, there is a single dedicated Azure Resource Group for all SCEPman-related resources. Thus, you can just delete the whole Resource Group to get rid of all SCEPman resources. In case of a [geo-redundant SCEPman installation](../scepman-configuration/optional/geo-redundancy.md), there might be additional resource groups for the extra App Services and App Services plans. In this case, you also have a Traffic Manager somewhere.

In order to delete the resource groups, it might be necessary to remove Delete Locks from the Azure Key Vault and/or Storage Account.

SCEPman configures [soft-delete](https://learn.microsoft.com/en-us/azure/key-vault/general/soft-delete-overview) and Purge Protection for 90 days by default for its Azure Key Vault. Thus, even if you delete the whole Resource Group, the CA key SCEPman used will be recoverable for the configured time frame. Afterwards, the CA key is gone and you cannot recover it. This means that there is no way to restore this SCEPman instance and since there is no instance to create valid OCSP responses, all issued certificates are invariably considered invalid.

Deleting the Storage Account results in information about manually created SCEPman Certificate Master certificates being lost, especially revocation information. Since deleting you SCEPman instances invalidates all issued certificates due to the failing OCSP responses anyway, this might not be an issue.

Your Storage Account might also [contain SCEPman's log files](../scepman-configuration/optional/log-configuration.md#app-service-logs-recommended-settings). If you want to keep them, either keep the Storage Account and only delete the other Azure Resources or copy the log files to another location before deleting the Storage Account.

## Custom Domain

You may have registered a custom domain for SCEPman like scepman.contoso.de. Remove this entry from DNS to make it clear that it is not required for any service anymore.

## App Registrations

SCEPman and SCEPman Certificate Master each use an app registration. By default, all SCEPman instances in a tenant share these two app registrations, so only delete them if this is the only SCEPman instance in your tenant -- except when you have used the optional `AzureADAppNameForSCEPman` and `AzureADAppNameForCertMaster` parameters in the SCEPman Powershell module to make your other SCEPman instances use different app registrations.

The default names of the app registrations are SCEPman-api and SCEPman-CertMaster. You can find and delete them by navigating to [App registrations in the Azure Portal](https://portal.azure.com/#view/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/~/RegisteredApps). Switch to "All applications" to search for them.