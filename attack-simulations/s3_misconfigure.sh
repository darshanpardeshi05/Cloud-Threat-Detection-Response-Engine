#!/bin/bash
# AWS S3 Security Misconfiguration Simulator
# Triggers GuardDuty Findings: 
# - Policy:S3/BucketAnonymousAccessGranted
# - Policy:S3/BucketPublicAccessGranted
# - Stealth:S3/BucketPublicAccessGranted

BUCKET_NAME="threat-logs-darshan"
TEST_FILE="sensitive_data.txt"

echo "[+] Starting S3 Security Misconfiguration Simulation"
echo "[!] This will trigger GuardDuty and Macie findings within 5-15 minutes"

# Create test file with mock sensitive data
echo "Creating test file with mock PII..."
cat <<EOF > $TEST_FILE
Customer Records (Mock Data)
---------------------------
Name: John Doe
Email: john.doe@example.com 
Phone: +1-555-123-4567
Credit Card: 4111 1111 1111 1111 (Test Visa)
SSN: 123-45-6789 (Test Data)
Credentials: admin/password123
EOF

# Upload to S3 bucket
echo "[1/3] Uploading sensitive data to S3 bucket..."
aws s3 cp $TEST_FILE s3://$BUCKET_NAME/

# Disable all public access blocks
echo "[2/3] Disabling S3 Block Public Access..."
aws s3api put-public-access-block \
    --bucket $BUCKET_NAME \
    --public-access-block-configuration \
    "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"

# Apply dangerous bucket policy allowing public access
echo "[3/3] Applying public read bucket policy..."
aws s3api put-bucket-policy \
    --bucket $BUCKET_NAME \
    --policy '{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "PublicReadGetObject",
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::'$BUCKET_NAME'/*"
            }
        ]
    }'

# Verification steps
echo ""
echo "[✓] Simulation Complete. Expected Detections:"
echo "- GuardDuty: 'Policy:S3/BucketAnonymousAccessGranted' (Medium Severity)"
echo "- Macie: 'Sensitive data discovered in publicly accessible S3 bucket'"
echo ""
echo "[!] Remember to revert these changes after testing:"
echo "1. Delete the test file: aws s3 rm s3://$BUCKET_NAME/$TEST_FILE"
echo "2. Re-enable block public access"
echo "3. Remove the bucket policy"
echo ""
echo "Monitor findings in:"
echo "- Amazon GuardDuty Console"
echo "- Amazon Macie Console"