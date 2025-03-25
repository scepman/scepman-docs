# Using 3rd Party Monitoring

You can use 3rd party monitoring systems to poll the /probe endpoint of SCEPman.

### URL

The probe URL is: `<your-SCEPman-URL>/probe`

### Status codes

* `200`: SCEPman is up & running
* `5xx`: At least one SCEPman component is not working

{% hint style="info" %}
To avoid any impact on the performance of your SCEPman service, we recommend a minimum poll rate setting of 60 seconds.
{% endhint %}
