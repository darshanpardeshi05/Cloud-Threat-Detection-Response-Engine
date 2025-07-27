# Cloud Threat Detection & Response Engine - Project Summary

## Project Overview
A fully automated, serverless security pipeline built entirely with native AWS services to detect, analyze, and respond to cloud threats in real-time.

**Key Components**:
- **Detection Layer**: GuardDuty + Macie + AWS Config
- **Response Layer**: Lambda + EventBridge + SNS
- **Forensic Layer**: Athena + Detective + CloudWatch

## Technical Architecture
![System Architecture](architecture-diagrams/architecture.png)

### Core AWS Services
| Service Category       | AWS Services Used               |
|------------------------|---------------------------------|
| Threat Detection       | GuardDuty, Macie, AWS Config    |
| Log Collection         | CloudTrail, VPC Flow Logs       |
| Alerting & Automation  | EventBridge, Lambda, SNS        |
| Analysis & Forensics   | Athena, Detective, CloudWatch   |

## Key Features Implemented

### 1. Threat Detection Capabilities
- **S3 Security**:
  - Public bucket exposure detection
  - Sensitive data classification (PII, credentials)
  - Policy misconfiguration alerts

- **EC2 Security**:
  - Port scanning detection (Nmap simulations)
  - Unauthorized access attempts
  - Instance compromise behaviors

- **IAM Monitoring**:
  - Privilege escalation attempts
  - Anomalous API calls
  - Credential misuse

### 2. Automated Response Workflow
```mermaid
graph TD
    A[GuardDuty Finding] --> B(EventBridge)
    B --> C{Lambda Processor}
    C --> D[SNS Alerts]
    C --> E[Remediation Actions]
    D --> F(Security Team)