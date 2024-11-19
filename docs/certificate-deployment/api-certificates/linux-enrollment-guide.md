---
description: A guide for enrolling Linux devices with automatically renewing certificates
---

# Linux Enrollment Guide

## Step 1: Assign Linux users with self-service role

Create a group of users who will be using the Linux devices and assign this group with the Self Service role so that they can enroll certificates to their own device using the Enrollment REST API.

{% content-ref url="self-service-role.md" %}
[self-service-role.md](self-service-role.md)
{% endcontent-ref %}

## Step 2: Enroll certificates

Use the bash script described in the page below to enroll a certificate on the Linux machine. This script can either be deployed using Intune (for compatible Linux OSes, a guide for enrollment can be found [here](https://learn.microsoft.com/en-us/mem/intune/user-help/enroll-device-linux). A guide for configuring the scripts can be found [here](https://learn.microsoft.com/en-us/mem/intune/configuration/custom-settings-linux). Note that you will have to hardcode the command line arguments to get this to work). Of course, the script can also be run manually. Certificates can also be installed manually using Certificate Master

{% content-ref url="renewal-script.md" %}
[renewal-script.md](renewal-script.md)
{% endcontent-ref %}

## Step 3: Set up automatic renewal

When the above bash script is run and detects that a certificate has already been enrolled, it will renew the certificate (if it is close to expiry) using mTLS. If the script is run regularly, this will ensure the certificate is renewed when it gets close to expiry. This can be done using Intune (by setting the 'Execution Frequency' for the Intune script to an appropriate value). Or you could set up a cronjob. The below command is an example of how this could be done. It will set up a cronjob to run the command daily (if the system is powered on) and a cronjob to run the command on reboot.

<pre><code><strong>(crontab -l ; echo @daily /path/to/enrolrenewcertificate.sh https://scepman.contoso.com/ api://123guid certname /cert/directory /key/directory /path/to/root.pem 10 ; echo @reboot  /path/to/enrolrenewcertificate.sh https://scepman.contoso.com/ api://123guid certname /cert/directory /key/directory /path/to/root.pem 10 ) | crontab -
</strong></code></pre>

Since commands run by Cron will not necessarily be run from the directory that the script/certificates are in, it is important to provide the absolute paths to the script/certificates.&#x20;
