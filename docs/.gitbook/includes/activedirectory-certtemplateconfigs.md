---
title: ActiveDirectory:CertTemplateConfigs
---

# AppConfig:ActiveDirectory:<code class="expression">page.vars.cert_template</code>:TemplateName

_Linux: AppConfig\_\_ActiveDirectory\_\__<code class="expression">page.vars.cert_template</code>_\_\_TemplateName_

**Example**: AppConfig:ActiveDirectory:User:Ksps

**Value:** Certificate template name

**Description:** This setting you to choose a custom template name for this certificate template. It is displayed when you manually enroll a certificate of that template. For maximum compatibility, choose a name witho only alphanumeric characters and no blanks.

# AppConfig:ActiveDirectory:<code class="expression">page.vars.cert_template</code>:GroupFilter

_Linux: AppConfig\_\_ActiveDirectory\_\__<code class="expression">page.vars.cert_template</code>_\_\_GroupFilter_

**Example**: AppConfig:ActiveDirectory:User:Ksps

**Value:** Comma-separated list of AD groups specified by their SID

**Description:** This setting allows to limit which Active Directory group members are allowed to enroll certificates for this certificate template. If configured, it overrides the general setting [AppConfig:ActiveDirectory:GroupFilter](#appconfig-activedirectory-groupfilter).

# AppConfig:ActiveDirectory:<code class="expression">page.vars.cert_template</code>:Ksps

_Linux: AppConfig\_\_ActiveDirectory\_\__<code class="expression">page.vars.cert_template</code>_\_\_Ksps_

**Example**: AppConfig:ActiveDirectory:Computer:Ksps

**Value:** Semicolon-separated list of CSPs/KSPs allowed for key generation

**Description:** You can define the key storage providers in which the certificates private key might be created in. If no value is specified, all KSPs are allowed to be used, and the client decides which KSP suites best. Valid values include:

* **Microsoft Platform Crypto Provider** - Stores the private key in the device's TPM.
* **Microsoft Passport Key Storage Provider**
* **Microsoft Software Key Storage Provider** - Stores the private key on the hard drive, secured with the machine key.
* **Microsoft Smart Card Key Storage Provider** - Stores the private key on a smart card.
