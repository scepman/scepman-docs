---
title: Enrollment REST API - Client Prerequisites
---

The following prerequisites must be present on the executing client/host to be able to use the Enrollment REST API.

### [**Azure CLI**](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) **( version 2.61 and above)**

The Azure CLI is used to authenticate the enrolling user to check their eligibility and to retrieve the access token.

### cURL

Used to send the created CSR to the SCEPman Enrollment API Endpoint and receive certificate.

### OpenSSL

OpenSSL is used to generate a private key and create a CSR for enrolling or renewing a certificate.
