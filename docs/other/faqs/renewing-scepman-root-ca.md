# Renewing SCEPman Root CA

The SCEPman Root CA has an expiry of 10 years. Once expired, SCEPman will need to be re-deployed and there is currently no method to extend the expiry past 10 years or to renew the existing Root CA. \
A redeployment has the advantage that the new Root CA will live up to the security standards (key size, algorithms etc.) that are relevant to that time in the future.

{% stepper %}
{% step %}
### Deploy a secondary SCEPman instance&#x20;

Use any preferred [deployment option](../../scepman-configuration/deployment-options/).
{% endstep %}

{% step %}
### Set up the secondary SCEPman instance as needed

The second instance should be set up identically to your primary instance or in a way that's ready to use.

This may include:

* Additional MDM Configurations
* Health Checks
* Environment Variables
* Custom Domains and Geo-redundancy (Save this until **after** the cutover if you plan to re-use the existing custom domain)
* Update Strategy
{% endstep %}

{% step %}
### Set up MDM profiles

MDMs should begin distributing the Root CA and SCEP certificates from the secondary SCEPman instance **in parallel** to the certificates to the primary instance.
{% endstep %}

{% step %}
### Prepare Systems and Applications

Most systems and applications can be configured to accept multiple Root CAs. The Secondary Root CA should be added now in preparation of the cutover.
{% endstep %}

{% step %}
### Cutover to your Secondary SCEPman

_Only begin this step once all endpoint devices have received Root and SCEP certificates from the secondary instance._

MDMs configuration profiles should now point to the Secondary SCEPman instance for cases such as WiFi authentication.

Custom Domain and Geo-Redundancy should be set up now if you are re-using your initial custom domain.

Make adjustments on systems/applications as necessary.
{% endstep %}

{% step %}
### Delete (old) primary SCEPman Instance

Resources related to the old SCEPman Instance can now be removed including:

* Azure resources
* MDM configuration profiles pointing to the old instance
* Root CAs and configurations on systems/applications relevant to the old instance
{% endstep %}
{% endstepper %}
