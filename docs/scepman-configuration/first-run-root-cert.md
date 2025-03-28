# Root CA

After you have deployed your SCEPman environment you have to create a root certificate.

If you want to use an intermediate certificate (Enterprise Edition only) you can have a look at this guide:

{% content-ref url="../scepman-deployment/intermediate-certificate.md" %}
[intermediate-certificate.md](../scepman-deployment/intermediate-certificate.md)
{% endcontent-ref %}

**For a standard SCEPman setup, we recommend generating a new root certificate with the following steps:**

## Create SCEPman root certificate

1. Navigate to **App Services**.
2. Choose the SCEPman application and click on **Browse** to see the SCEPman website.
3. When everything works as intended **Intune**, **Read AAD, Read Intune,** and **Storage Account** are set in green as **connected**.

![](../.gitbook/assets/2022-04-04SCEPmanAfterNewDeployment.png)

4\. The option **click here to start** creating the Azure Key Vault RootCA certificate. The initial root certificate should be created only once on a farm.\
5\. Select **I have read the documentation\[...]** and click **Create First Node**.\
6\. After some seconds/minutes you can refresh the page. Now you should see that the root certificate is available.

<figure><img src="../.gitbook/assets/2024-04-17 16_11_52.png" alt=""><figcaption></figcaption></figure>

Now you are ready to start! Check [Certificate Deployment via Microsoft Intune](../certificate-management/microsoft-intune/)
