import json
import boto3

sns = boto3.client('sns')
SNS_TOPIC_ARN = 'arn:aws:sns:us-east-1:YOUR_ACCOUNT_ID:threat-alerts-darshan'

def lambda_handler(event, context):
    detail = event.get("detail", {})
    finding_type = detail.get("type", "Unknown")
    description = detail.get("description", "No description")
    severity = detail.get("severity", "Unknown")
    region = detail.get("region", "Unknown")
    account = detail.get("accountId", "Unknown")

    message = f"""
    🚨 GuardDuty Finding 🚨
    Type: {finding_type}
    Severity: {severity}
    Region: {region}
    Account: {account}
    Description: {description}
    """

    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Subject="🚨 GuardDuty Alert",
        Message=message
    )
    return {'statusCode': 200}