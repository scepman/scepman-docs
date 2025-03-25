# Enrollment REST API

{% hint style="warning" %}
SCEPman Enterprise Edition only
{% endhint %}

SCEPman features a REST API to enroll certificates. This is an alternative to the SCEP endpoints that require the SCEP-style of authentication, while the REST API uses Microsoft Identities for authentication. The protocol is also much simpler than SCEP.

The REST API features two different authentication models.

### Self Service Enrollment

As a user, you can interactively authenticate if you have the CSR.SelfService role. This allows you to request certificates for yourself and your devices. See [Self Service Enrollment](self-service-enrollment/) for more details.

### API Enrollment

You can also authenticate as a service principal that has the CSR.Request.Db role. This allows you to automate certificate enrollment to servers, IoT devices, or in other use cases. See [API Enrollment](api-enrollment/) for details.
