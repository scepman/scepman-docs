# General

## Storage Account

### How can I programmatically query the Storage Account Table?

For some use cases, it might be necessary to query the storage account table directly. This can be done manually using the [Azure Storage Explorer](https://azure.microsoft.com/en-us/features/storage-explorer/) or programmatically using the [Azure Storage Rest API](https://docs.microsoft.com/en-us/rest/api/storageservices/query-entities). Assign the `Storage Table Data Reader` role to the account you are using. Here is an example of a query that returns all certificates in the Storage Account expiring in the next 30 days:

```powershell
$SCEPManStorageAccountName = "stgscepmanabc"  # Insert your SCEPman Storage Account name here
$expiresBefore = (Get-Date).AddDays(30).ToString("yyyy-MM-ddTHH:mm:ssZ")  # Find all certificates that expire before this date
$now = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ssZ")                        # and                   that expire after this date

$certificatesJson = az storage entity query --table-name Certificates --account-name $SCEPManStorageAccountName --auth-mode login --filter "ExpirationDate lt datetime'$expiresBefore' and ExpirationDate gt datetime'$now' and Revoked eq false"
$certificates = $certificatesJson | ConvertFrom-Json

$certificates.items | Select-Object -Property Subject,Requester,ExpirationDate,FQDNs
```

The Azure CLI must be installed on the machine where the query is run, and it must be logged on to the right account and subscription. This is automatically the case for an Azure Cloud Shell.
