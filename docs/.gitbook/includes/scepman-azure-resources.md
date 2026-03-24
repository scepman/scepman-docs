---
title: SCEPman Azure Resources
---

| Type                    | Description                                                                                                                                                                                                                                                          |
| ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| App Service (x2)        | <p>A virtual Azure environment to run the SCEPman Core and Cert Master applications and provides a UI to configure different<br>application specific settings like CNAME, SSL certificate and App Settings.</p>                                                      |
| App Service Plan        | <p>A virtual set of compute resources and configurations for the "App Service(s)".</p><p>Here you can configure the pricing tier and resource scaling.</p>                                                                                                           |
| Key Vault               | Tool to securely store secrets and certificates. The SCEPman application will generate and save the root certificate in your Key Vault.                                                                                                                              |
| Application Insights    | Application Performance Management (APM) tool to get insights of the SCEPman applications and requests. Needed to measure performance and good for service optimization.                                                                                             |
| Storage account         | <p>Storage platform used by SCEPman's Certificate Master component to store certificates attributes for revocation purposes.<br><br><em>Optional:</em></p><p>The "App Service" will load the artifacts from a blob storage URI if manual updates are configured.</p> |
| Log Analytics workspace | <p>A centralized and cloud-based log storage. The "App Service" will save all</p><p>platform logs and metrics into this workspace.<br><br>Since v3.0, SCEPman writes logs to the Log Analytics Workspace using Microsoft's Log Ingestion API.</p>                    |

