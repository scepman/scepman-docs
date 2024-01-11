# Azure Sizing

## Basics

SCEPman depends mainly on the CPU resources. Memory and disc are less important.

A SCEPman 2.5 instance in one Azure P1V2 App Service Plan (210 ACUs) can serve around 2000 requests per minute under usual conditions. SCEPman 2.4 and earlier served about 400 requests per minute on one S1 App Service Plan (100 ACUs). Requests are

* SCEP issuing requests and
* OCSP requests.

## Dependencies

The load for your SCEPman service has several dependencies and varies in the different environments. Important dependencies are:

1. Distribution of requests
2. Frequency of logins to network resources
3. Frequency of certificate requests/renewals

Especially the distribution of the requests has a high importance. If all clients do requests at the same time, your SCEPman instances get heavy load.

{% hint style="warning" %}
Please do not assign SCEP profiles to a large number of users devices at once, since this may result in a request-peak at your SCEPman instances.
{% endhint %}

## Recommendation

We recommend the following sizing in Azure Compute Units (ACU) for the Azure App Service Plans as a starting point:

| Amount of users/clients |             Singular design            |                Redundant design                |
| :---------------------: | :------------------------------------: | :--------------------------------------------: |
|      < 2000 clients     |    <p>100 ACUs<br>(e.g. 1 x S1)</p>    |     <p>2 x 100 ACUs</p><p>(e.g. 2 x S1)</p>    |
|      < 5000 clients     |  <p>200 ACUs</p><p>(e.g. 1 x P1V2)</p> |    <p>2 x 200 ACUs</p><p>(e.g. 2 x P1V2)</p>   |
|     < 10.000 clients    |  <p>400 ACUs</p><p>(e.g. 1 x P1V3)</p> |     <p>2 x 400 ACUs<br>(e.g. 2 x P1V3)</p>     |
|     < 25.000 clients    |  <p>800 ACUs</p><p>(e.g. 1 x P2V3)</p> |     <p>2 x 800 ACUs<br>(e.g. 2 x P2V3)</p>     |
|     < 50.000 clients    | <p>1600 ACUs</p><p>(e.g. 1 x P3V3)</p> |   <p>2 x 1600 ACUs</p><p>(e.g. 2 x P3V3)</p>   |
|    < 100.000 clients    | <p>3200 ACUs</p><p>(e.g. 2 x P3V3)</p> | <p>2 x 3200 ACUs</p><p>(e.g. 2 x 2 x P3V3)</p> |

## Fine tuning

Every environment has its own load distribution over the day. In many environments the morning (start of work) generates a peak in terms of load at your SCEPman.

### Manual Scale

You can adapt the computing power for your App Service to your individual daily load distribution with the Azure App Service Scale Out features. E.g. you could define 2 x S1 in the morning from 08:00-10:00 to cover the morning peak, while you reduce to 1 x S1 for the rest of the day.

### Auto Scale

Alternatively you can use the Azure App Autoscaling feature to adapt to needed resources. Learn more about that in [Autoscaling](../scepman-configuration/optional/autoscaling.md).

### Manual vs. Auto Scale

If you are able to predict your load well (e.g. derived from load history), we recommend Manual Scale over Auto Scale, since Auto Scale has to behave lazy (hysteresis) to prevent flapping between scales.
