# AWS Services Documentation

## Core Detection Services

### Amazon GuardDuty
- **Purpose**: Threat detection service analyzing AWS logs for malicious activity
- **Key Features**:
  - Monitors CloudTrail, VPC Flow Logs, and DNS logs
  - Detects compromised credentials, EC2 instances, and S3 buckets
  - Uses threat intelligence feeds and machine learning
- **Critical Configurations**:
  ```bash
  aws guardduty create-detector --enable
  aws guardduty update-detector --detector-id <ID> --enable