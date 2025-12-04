# App Service Sizing

## Basics

SCEPman depends mainly on the CPU resources. Memory and disk are much less important.

One SCEPman instance (version 3.0 and newer) in one Azure P0V3 App Service Plan (195 ACUs) can serve around 4000 requests per minute under usual conditions. Requests are

* SCEP issuing requests and
* OCSP requests.

This means that SCEPman can serve about 20 requests per minute per ACU.

Since a certificate is enrolled once, but its validity is checked many times, there will be much more OCSP requests than SCEP requests in total. Hence, you should size your SCEPman instance based on your OCSP requests.

## Dependencies

The load for your SCEPman service has several dependencies and varies in the different environments. Important dependencies are:

1. Distribution of requests
2. Frequency of logins to network resources
3. Frequency of certificate requests/renewals

Especially the distribution of the requests has a high importance. If all clients do requests at the same time, your SCEPman instances get heavy load. You should strive to let SCEPman answer to SCEP requests in less than a minute in all cases.

{% hint style="warning" %}
Please do not assign SCEP profiles to a large number of users/devices at once, since this may result in a request-peak at your SCEPman instances.
{% endhint %}

## Recommendation

We recommend the following sizing in Azure Compute Units (ACU) for the Azure App Service Plans as a starting point:

| Amount of users/clients |             Singular design             |               Geo-Redundant design              |
| :---------------------: | :-------------------------------------: | :---------------------------------------------: |
|      < 5000 clients     |    <p>~100 ACUs<br>(e.g. 1 x S1)</p>    |     <p>2 x ~100 ACUs</p><p>(e.g. 2 x S1)</p>    |
|     < 10.000 clients    |  <p>~200 ACUs</p><p>(e.g. 1 x P0V3)</p> |    <p>2 x ~200 ACUs</p><p>(e.g. 2 x P0V3)</p>   |
|     < 25.000 clients    |  <p>~400 ACUs</p><p>(e.g. 2 x P0V3)</p> |     <p>2 x ~400 ACUs<br>(e.g. 4 x P0V3)</p>     |
|     < 50.000 clients    |  <p>~800 ACUs</p><p>(e.g. 4 x P0V3)</p> |     <p>2 x ~800 ACUs<br>(e.g. 8 x P0V3)</p>     |
|    < 100.000 clients    | <p>~1600 ACUs</p><p>(e.g. 4 x P1V3)</p> |   <p>2 x ~1600 ACUs</p><p>(e.g. 8 x P1V3)</p>   |
|    > 100.000 clients    | <p>~3200 ACUs</p><p>(e.g. 4 x P2V3)</p> | <p>2 x ~3200 ACUs</p><p>(e.g. 2 x 4 x P2V3)</p> |

Based on these recommendations, you can monitor your traffic and see whether you can scale down as described in the Section [Fine Tuning](./#fine-tuning) below.

## Azure Cost Prognosis

The main Azure costs will be for the Azure Apps Service Plan(s). You can derive your cost from the requirements in the table above and [your Azure pricelist](https://azure.microsoft.com/en-us/pricing/calculator/) or the generic undiscounted [App Service Pricing](https://azure.microsoft.com/en-us/pricing/details/app-service/windows/) overview.

The additional Azure resources (Key Vault, Storage Account, Log Analytics, network resources for private endpoints) play a minor role in the cost. Depending on the use cases in your environment, you should expect an additional 5% to 25% on top of the App Service Plan cost for these additional Azure resources.

{% hint style="info" %}
This cost projection is just a rule of thumb to help you estimate the cost of Azure. It can vary significantly in different environments.
{% endhint %}

## Fine Tuning

Every environment has its own load distribution over the day. In many environments the morning (start of work) generates a peak in terms of load at your SCEPman.

### Manual Scale

You can adapt the computing power for your App Service to your individual daily load distribution with the Azure App Service Scale Out features. E.g. you could define 2 x S1 in the morning from 08:00-10:00 to cover the morning peak, while you reduce to 1 x S1 for the rest of the day.

### Auto Scale

Alternatively you can use the Azure App Autoscaling feature to adapt to needed resources. Learn more about that in [Autoscaling](autoscaling.md).

### Manual vs. Auto Scale

If you are able to predict your load well (e.g. derived from load history), we recommend Manual Scale over Auto Scale, since Auto Scale has to behave lazy (hysteresis) to prevent flapping between scales.
