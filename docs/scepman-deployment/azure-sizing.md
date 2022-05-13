# Azure Sizing

## Basics

SCEPman depends mainly on the CPU resources. Memory and disc are less important.&#x20;

A SCEPman instance in one Azure S1 App Service Plan can serve up to 400 requests per minute. Requests are

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

We recommend the following sizing for the Azure App Service Plans as a starting point:

| Amount of users/clients |                Singular design                |                      Redundant design                     |
| :---------------------: | :-------------------------------------------: | :-------------------------------------------------------: |
|      < 2000 clients     |                     1 x S1                    |                         2 x 1 x S1                        |
|      < 5000 clients     |         <p>1 x S2<br>or<br>2 x S1</p>         |           <p>2 x 1 x S2<br>or<br>2 x 2 x S1</p>           |
|     < 10.000 clients    | <p>1 x S3<br>or<br>2 x S2<br>or<br>4 x S1</p> | <p>2 x 1 x S3<br>or<br>2 x 2 x S2<br>or<br>2 x 4 x S1</p> |
|     < 25.000 clients    |         <p>2 x S3<br>or<br>4 x S2</p>         |           <p>2 x 2 x S3<br>or<br>2 x 4 x S2</p>           |
|     < 50.000 clients    |                     4 x S3                    |                         2 x 4 x S3                        |
|    < 100.000 clients    |                     8 x S3                    |                         2 x 8 x S3                        |

## Fine tuning

Every environment has its own load distribution over the day. In many environments the morning (start of work) generates a peak in terms of load at your SCEPman.

### Manual Scale

You can adapt the computing power for your App Service to your individual daily load distribution with the Azure App Service Scale Out features. E.g. you could define 2 x S1 in the morning from 08:00-10:00 to cover the morning peak, while you reduce to 1 x S1 for the rest of the day.

### Auto Scale

Alternatively you can use the Azure App Autoscaling feature to adapt to needed resources. Learn more about that in [Autoscaling](../scepman-configuration/optional/autoscaling.md).

### Manual vs. Auto Scale

If you are able to predict your load well (e.g. derived from load history), we recommend Manual Scale over Auto Scale, since Auto Scale has to behave lazy (hysteresis) to prevent flapping between scales.
