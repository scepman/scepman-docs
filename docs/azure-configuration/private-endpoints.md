# Private Endpoints

When installing SCEPman 2.8 or newer, the Storage Account and Key Vault will be connected to a VNET through Private Endpoints. Access to the data of these two Azure Resources is only possible through this VNET, unless you define exceptions.

This VNET is located in the same resource group as the other SCEPman components. The SCEPman and SCEPman Certificate Master App Services are connected to the VNET and, on a network level, have access to the Storage Account and the Key Vault.

After installation, there are no exceptions configured, so no other entity can access the Key Vault certificates and keys or the Table Storage of the Storage Account. If required, for example when [generating a Subordinate CA](../scepman-deployment/intermediate-certificate.md) or when[ querying the Storage Account](../other/faqs/general.md#how-can-i-programmatically-query-the-storage-account-table), you need to add exceptions under the Networking blade of the respective Azure Resource.

Access to the management interface of the Key Vault and Storage Account is unaffected, i.e. you don't need to add your admin machines to the exception list to perform functions such as changing the SKU of your Storage Account or inspecting the access logs of your Key Vault.&#x20;

The SCEPman and SCEPman Certificate Master App Services do not have Private Endpoints, even if you install SCEPman 2.8 or newer. They can still be accessed from the Internet without networking restrictions. We recommend not restricting access to SCEPman on a networking level, as SCEPman is usually part of the infrastructure used to establish network connections and should therefore be available even if you are not yet connected.

If needed, Conditional Access can be employed to limit access to SCEPman Certificate Master with various restrictions, including networking conditions. SCEPman usually does not use Conditional Access, as the two endpoints SCEP and OCSP do not use Entra authentication. However, you might use Conditional Access to restrict access to [SCEPman's REST API](../certificate-management/api-certificates/).

## Azure Resources Used for Private Endpoints

{% include "../.gitbook/includes/private-endpoint-resources.md" %}

## Adding Private Endpoints to Existing SCEPman Installations

If you have installed SCEPman 2.7 or older, your Key Vault and Storage Account won't automatically have Private Endpoints, even if you update to SCEPman 2.8 or newer. You have to add them manually after a conscious decision. Please follow this guide to do so:

{% stepper %}
{% step %}
### Create Virtual Network

* In the SCEPman resource group, create a new Virtual Network using default settings or as required by your organisation. This should include a **default subnet**.
* Create an additional subnet in the new **Virtual Network** with default settings and set **"Subnet Delegation"** as **Microsoft.Web/serverFarms**

<figure><img src="../.gitbook/assets/image (2).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Create KeyVault Private Endpoint



1. Navigate to your SCEPman's Resource Group > **KeyVault** > Settings > Networking > Private endpoint connections, and create a private endpoint
2. Select resource type: **Microsoft.KeyVault/vaults**
3. Select your **KeyVault** by Resource and **vault** for Target sub-resource
4. Choose the virtual network and the default subnet (not the subnet created in the first step)
5. Enable **Integrate with private DNS zone** to automatically create and connect the Private DNS zone
{% endstep %}

{% step %}
### Create Storage Account Private Endpoint



1. Navigate to your SCEPman's Resource Group > **Storage Account** > Security + Networking > Networking > Private endpoints and create a Private Endpoint
2. By resource, set target sub-resource to **table**
3. Choose your virtual network and default subnet
4. Enable **Integrate with private DNS zone** to automatically create and connect the Private DNS zone
{% endstep %}

{% step %}
### Integrate SCEPman App Service



1. Navigate to **SCEPman App service** > Networking > Add virtual network integration to the **Outbound traffic configuration** by clicking on "Not configured"
2. Select the virtual network and the created subnet from the first step.
3. Uncheck the option "Outbound internet traffic" and apply

<figure><img src="../.gitbook/assets/image (1) (3).png" alt=""><figcaption></figcaption></figure>

<figure><img src="../.gitbook/assets/image (2) (2).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Integrate Certificate Master App Service



* By adding the virtual network integration to the second app service, you can select the previous connection from the list, you don't have to create a new connection.
* If enabled, uncheck the option "Outbound internet traffic" and apply

<figure><img src="../.gitbook/assets/image (3).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Verify Private Endpoint Approval

Check both KeyVault and Storage Account Private Endpoints are in an Approved state

<figure><img src="../.gitbook/assets/image (4).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
### Testing and Results

Once confirmed, you can disable public access for both Key Vault and Storage account.

<figure><img src="../.gitbook/assets/image (100).png" alt=""><figcaption></figcaption></figure>

If connected properly, the SCEPman homepage should display all its connections as "Connected"\
![](<../.gitbook/assets/image (101).png>)

Test that your implementation of private endpoints is successful by deploying certificates using your MDM or [Certificate Master.](../certificate-management/certificate-master/)
{% endstep %}
{% endstepper %}







