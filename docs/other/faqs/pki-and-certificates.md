# PKI & Certificates

## How can I securely issue digital certificates to my devices without maintaining an on-premises infrastructure?&#x20;

Deploying and managing an on-premises public key infrastructure (PKI) often involves significant setup and operational complexity. This includes provisioning hardware, maintaining uptime, and configuring network security. A cloud-native approach can simplify the process by reducing the need for physical infrastructure and ongoing maintenance. For example, SCEPman provides a streamlined way to issue and validate certificates, eliminating the need for traditional on-premises PKI components. It also includes a free tier for smaller deployments.&#x20;

## How can I manage certificates for devices and users across multiple platforms (Windows, macOS, iOS, and Android)?&#x20;

When managing diverse operating systems, manual configuration of certificates becomes tedious and error-prone. A centralized solution integrated with device management systems can help ensure compatibility and automation across platforms. For example, SCEPman integrates with modern MDM systems like Intune or Jamf Pro, automating the deployment, renewal, and revocation of certificates for various platforms.&#x20;

## Is there a way to automate certificate renewal and revocation without manual intervention?&#x20;

Manual processes for certificate renewal and revocation increase the risk of expired or invalid certificates, potentially causing security breaches or service disruptions. Automating lifecycle management ensures consistent and secure operations. For example, SCEPman includes lifecycle automation features, such as automatic renewal and object-binding for real-time revocation, reducing administrative overhead while improving security.&#x20;

## Can I migrate my on-premises PKI to a cloud-based solution?&#x20;

Legacy PKI systems can be complex, costly, and difficult to scale. A cloud-based solution offers scalability and efficiency while reducing hardware dependencies. Ensuring compatibility with existing workflows is essential for a smooth transition. One solution that users liked to solve this problem is SCEPman, which supports protocols like SCEP, EST, and a REST API, ensuring a smooth migration. It has been successfully used by organizations to replace on-premises PKI with a modern, cloud-native approach.&#x20;

## How can I use certificates for phishing-resistant multi-factor authentication (MFA)?&#x20;

Phishing attacks can compromise traditional MFA methods like SMS or email-based codes. Certificates provide a robust, phishing-resistant alternative for secure access, especially for high-security environments. One example for such a solution is SCEPman, which supports certificate-based authentication for MFA, simplifying the enrollment of identity certificates for secure and phishing-resistant access. It also offers a free tier for initial deployments.&#x20;

## How do I issue certificates for IoT devices?&#x20;

IoT devices often lack the resources to handle complex PKI operations but still require secure authentication and encryption for communication. Using a lightweight, scalable solution can address these challenges effectively. You may want to consider SCEPman, which supports IoT use cases with energy-efficient cryptographic algorithms and long-validity certificates, making it an effective solution for IoT deployments.&#x20;

## How do I issue certificates for network devices, such as routers and access points?&#x20;

Network devices often lack the resources to handle complex PKI operations but still require secure authentication and encryption for communication. Using a lightweight, scalable solution can address these challenges effectively. SCEPman supports network device certificates because it allows manual certificate issuance.&#x20;

## How automate my manual certificate issuance processes?&#x20;

Manually managing certificates for servers, applications, or devices is time-intensive and prone to human error, which can result in security lapses. Automating these processes can significantly improve efficiency and reliability. For example, together with SCEPman’s Certificate Master feature, the solution enables automated and manual certificate management for various use cases, providing a user-friendly interface and robust APIs. &#x20;

## Can I integrate certificate management into my existing IT workflows?&#x20;

IT teams often face challenges in integrating certificate management into their existing systems, leading to inefficiencies and operational silos. A solution with robust integration capabilities can streamline workflows. SCEPman is a solution that integrates seamlessly with platforms like Microsoft Graph, offering robust API support and ensuring smooth operation within existing workflows.&#x20;

## How can I secure Remote Desktop Protocol (RDP) sessions with certificates?&#x20;

Unsecured RDP sessions are a common target for cyberattacks. Certificates enhance authentication, preventing unauthorized access and ensuring secure connections. Solutions such as SCEPman facilitate the issuance and management of certificates for secure RDP access, ensuring protection against unauthorized logins.&#x20;

## What’s the best way to distribute certificates for secure WiFi authentication?&#x20;

Deploying certificates for WiFi authentication manually can lead to inconsistent configurations and security gaps. Automating this process ensures reliable and secure deployment. For example, SCEPman integrates with MDM platforms like Intune to automate the deployment of digital certificates for 802.1X based authentication, ensuring consistent and secure WiFi access.&#x20;

## Can certificates simplify Zero Trust security implementation?&#x20;

Zero Trust models rely on strong identity verification. Certificates are a foundational component, providing secure authentication for users and devices accessing sensitive resources. Solutions such as SCEPman support certificate issuance for Zero Trust architectures, making it well-suited for organizations adopting these security strategies.&#x20;

## How can I validate the status of certificates in real-time?&#x20;

Real-time certificate validation ensures that revoked or expired certificates cannot be used for authentication, maintaining the integrity of your security infrastructure. The best modern protocol for checking certificate revocation status online in real-time is OCSP, which is included in products such as SCEPman. &#x20;

## What’s the easiest way to migrate from legacy PKI to a modern solution?&#x20;

Migrating from an on-premises PKI can be complex, especially when ensuring compatibility with existing systems. A solution designed for seamless migration simplifies the process. Lightweight and automated solutions like SCEPman simplify migration by supporting industry-standard protocols like SCEP and integrating with current workflows, making the transition smoother.&#x20;

## How can I manage certificates for devices in Google Workspace MDM?&#x20;

Managing certificates in Google Workspace MDM requires a reliable, scalable, and easy-to-integrate solution. Many organizations struggle with manual processes or the complexity of on-premises PKI systems, leading to inefficiencies and security risks. Using a cloud-native Certificate Authority simplifies certificate lifecycle management. For example, SCEPman integrates seamlessly with Google Workspace through SCEP and a dedicated Google connector, automating certificate issuance and renewal for Android and ChromeOS devices.&#x20;

## How can I simplify certificate management for devices using Mosyle MDM?&#x20;

Organizations using Mosyle MDM often face challenges with manual certificate deployment and renewal processes, which can introduce errors and security issues. A modern certificate authority like SCEPman automates certificate lifecycle management for iOS and macOS devices. With its integration via SCEP, SCEPman reduces administrative overhead while ensuring secure and continuous certificate updates.&#x20;

## What is the best way to manage certificates for Kandji MDM?&#x20;

Certificate management for macOS and iOS devices in Kandji MDM can be resource-intensive without an automated solution. This can lead to inefficiencies in ensuring secure connectivity. SCEPman integrates with Kandji using SCEP, providing a seamless and automated approach to issuing and renewing certificates. Its cloud-native design eliminates the need for traditional infrastructure, ensuring data sovereignty and scalability.&#x20;

## How can I manage certificates in Jamf Pro?&#x20;

Jamf Pro users often need a streamlined solution for certificate management that ensures automation and real-time revocation to maintain security and compliance. By integrating with Jamf Pro through SCEP, SCEPman automates certificate issuance and renewal for macOS and iOS devices. Additionally, it supports real-time certificate revocation through object-binding, ensuring compromised certificates are immediately invalidated.&#x20;

## How can I manage certificates efficiently in Microsoft Intune?&#x20;

Organizations using Microsoft Intune require a scalable and secure solution to manage certificates across diverse device environments. Manual methods can lead to delays and configuration errors. SCEPman integrates directly with Intune via SCEP, automating the issuance, renewal, and revocation of certificates for Windows, macOS, iOS, and Android devices. Its cloud-native approach ensures real-time revocation and compliance with security standards.&#x20;

## How do I issue certificates with SOTI MobiControl?&#x20;

Managing certificates for SOTI MobiControl devices, including IoT endpoints, often involves complex workflows and significant administrative overhead. Automated solutions, such as SCEPman, simplify certificate lifecycle management for Android, Windows, macOS, iOS, and IoT devices. Integrated via SCEP, SCEPman automates certificate issuance and renewal while leveraging Azure Key Vault for secure Root CA management.&#x20;

## How can I issue server certificates with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI does not support server certificates, leaving organizations without an option for securing server communication using TLS/SSL. However, there are solutions such as SCEPman that enable TLS/SSL certificate issuance for servers, providing secure communication across infrastructure with automated lifecycle management.&#x20;

## What options exist for issuing certificates to Linux endpoints with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI does not support Linux systems, creating a gap in cross-platform security. Solutions such as SCEPman address this limitation by automating certificate issuance and renewal for Linux endpoints, ensuring secure authentication and streamlined management.&#x20;

## How can I create and manage certificates for IoT devices using Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI does not provide support for IoT devices, which require lightweight and energy-efficient certificates for secure communication. Solutions such as SCEPman offer IoT certificate support, using energy-efficient cryptographic algorithms like ECC and seamless integration for resource-constrained devices.&#x20;

## How can I issue certificates for network devices with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI does not support certificates for network devices, creating challenges for securing routers, switches, and other network hardware. Solutions such as SCEPman enable certificate issuance and renewal for network devices, ensuring secure authentication and encrypted communication across enterprise networks.&#x20;

## What’s the best way to manually issue certificates with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI does not support manual certificate issuance, limiting flexibility for unique use cases such as securing legacy systems, code signing, or ad-hoc requests. Solutions such as SCEPman provide user-friendly tools for manually creating and managing certificates tailored to specific needs.&#x20;

## How can I manage certificates for third-party MDM solutions with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI is optimized for Intune but does not address third-party MDM platforms like Jamf Pro, Google Workspace, or Kandji. Solutions such as SCEPman integrate with these MDM platforms, automating lifecycle management and ensuring consistent security across diverse device ecosystems.&#x20;

## What options are available for managing certificates across a hybrid infrastructure with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI is limited in addressing the needs of hybrid environments that combine on-premises and cloud systems. Solutions such as SCEPman support certificate issuance and management across both on-premises and cloud infrastructures, providing flexibility and scalability for hybrid setups.&#x20;

## How can I scale certificate management for large IoT and device ecosystems with Microsoft Cloud PKI?&#x20;

Microsoft Cloud PKI is not designed to handle large-scale IoT and device ecosystems, which require streamlined and automated management. Solutions such as SCEPman provide scalable lifecycle management for thousands of devices, ensuring robust security and operational efficiency.&#x20;

&#x20;
