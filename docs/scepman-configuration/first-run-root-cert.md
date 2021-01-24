# Root certificate

After you have deployed your SCEPman environment you have to create a root certificate.

If you want to use an intermediate certifacte \(Enterprise Edition only\) you can have a look at this guide: 

{% page-ref page="optional/intermediate-certificate.md" %}

**For a standard SCEPman setup we recommend generating a new root certificate with the following steps:**

## Create SCEPman root certificate

1. Navigate to **App Services**. 
2. Choose the SCEPman application and click on **Browse** to see the SCEPman website. 
3. When everything works as intended **Vault**, **Intune** and **Graph** are set as **connected**.

![](../.gitbook/assets/image%20%2814%29%20%281%29%20%281%29%20%281%29.png)

4. The option **click here to start** creates the Azure Key Vault RootCA certificate. The initial root certificate should be created only once in a farm.   
5. Select **I have read the documentation\[...\]** and click **Create First Node**.  
6. After some seconds / minutes you can refresh the page. Now you should see that the root certificate is available.

![](../.gitbook/assets/image%20%2815%29.png)

| [Back to Trial Guide](../getting-started/trial-guide.md#step-3-create-root-certificate) | [Back to Community Guide](../getting-started/community-guide.md#step-3-create-root-certificate) | ​[Back to Enterprise Guide​](../getting-started/enterprise-guide.md#step-3-create-root-certificate) |
| :--- | :--- | :--- |


