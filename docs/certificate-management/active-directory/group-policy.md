# Group Policy

This certificate enrollment founds on the [XCEP](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-xcep) and [WSTEP](https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-wstep/) protocols that all recent Windows versions natively support. In Active Directory environments, the necessary settings can be applied via group policies (GPO), to make AD-joined computers enroll certificates from SCEPman.

In this scenario, two group policies are required for a fully automated certificate deployment.

{% stepper %}
{% step %}
### Registration of the CEP server

The CEP (Certificate Enrollment Policy) server (part of SCEPman) will provide an authenticated client a policy containing all certificate templates configured on SCEPman for Active Directory enrollment. The CEP server needs to be added on the clients in the registry. Windows includes GPO templates to configure the necessary settings in the GUI.

#### Policy Configuration

For the certificate templates `Device` and `DC`, you have to go into the _Computer Configuration_ hive. For `User`, navigate in the _User Configuration_ hive. If you use certificate templates of both kinds, you'll have to configure both. In that case, you'll usually use two GPOs, one applied to the users with the User Configuration and one applied to computers with the Computer Configuration.

<pre data-title="Setting location in Group Policy Management Editor (gpmc.msc)"><code>Computer Configuration / User Configuration
└-Policies
  └-Windows Settings
    └-Security Settings
      └-Public Key Policies
<strong>        └-Certificate Services Client - Certificate Enrollment Policy Server
</strong></code></pre>

In the setting, add a new CEP server in the list and enter the policy server URI in the respective input. You can copy this URI from your SCEPman's homepage. It follows the scheme of `https://scepman.contoso.com/step/policy`. After entering and validating the CEP server you can finish the setting by adding it and confirming the dialog.

{% hint style="warning" %}
In the configuration process, the client already makes a validation call to the CEP server. Therefore, the account context used for the configuration must have permission to access SCEPman's CEP endpoint, i.e. authenticate with Kerberos, and outgoing network access to SCEPman port 443.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (116).png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
Please see the [Known Issues](general-configuration.md#known-issues) section in case you receive an error during the CEP server validation.
{% endhint %}

<figure><img src="../../.gitbook/assets/image (117).png" alt=""><figcaption></figcaption></figure>

{% hint style="info" %}
If you are using the SCEPman CEP server in parallel to your existing ADCS, you need to choose a default server and make sure you keep the existing enrollment policy.
{% endhint %}
{% endstep %}

{% step %}
### Enable Auto-Enrollment

With the registered CEP server, your users/computers can request certificates from SCEPman. Usually, you want them to do this automatically without user interaction and for this, you have to enable Auto-Enrollment. Note that it may already be enabled if you were using Autoenrollment before with Microsoft Active Directory Certificate Services (AD CS).

<pre data-title="Setting location in Group Policy Management Editor (gpmc.msc)"><code>Computer Configuration / User Configuration
└-Policies
  └-Windows Settings
    └-Security Settings
      └-Public Key Policies
<strong>        └-Certificate Services Client - Auto-Enrollment
</strong></code></pre>

Make sure to check `Update certificates that use certificate templates` to enable the automatic enrollment.

<figure><img src="../../.gitbook/assets/image (118).png" alt=""><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}
