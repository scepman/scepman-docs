# Re-enrollment trigger

In some cases, admins want to trigger a re-enrollment for SCEP certificates, in the table below, you will find the effect of changing some properties of a SCEP configuration profile on the re-enrollment procedure

|        Property name        | Re-enrollment triggered |
| :-------------------------: | :---------------------: |
|         Profile name        |            No           |
|     Profile description     |            No           |
|     Subject name format     |           Yes           |
|   Subject alternative name  |           Yes           |
| Certificate validity period |           Yes           |
|  Extended Key Usages (EKU)  |           Yes           |
|      Renewal threshold      |            No           |

{% hint style="info" %}
To understand and troubleshoot the certificate renewal process in Intune, please check the great article [Deep dive of SCEP certificate request/renewal on Intune-managed Windows clients](https://oliverkieselbach.com/2022/09/21/deep-dive-of-scep-certificate-request-renewal-on-intune-managed-windows-clients/) on Oliver Kieselbach's blog.
{% endhint %}
