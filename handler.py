import json
import boto3
import uuid
import os
from datetime import datetime

def on_append_driver_daily_metrics(event, context):
    derived_event = {
        "event_id": str(uuid.uuid4()),
        "event_type": "DriverDailyMetricsInserted",
        "metadata": {
            "aws_request_id": context.aws_request_id,
            "function_name": context.function_name,
            "function_version": context.function_version,
            "invoked_function_arn": context.invoked_function_arn,
            "log_group_name": context.log_group_name,
            "log_stream_name": context.log_stream_name
        },
        "payload": {
            "drn": event["drn"],
            "date": event["date"],
            "trips": event["trips"],
            "supply_hours": event["supply_hours"],
            "km_driven": event["km_driven"],
            "cancellation_rate": event["cancellation_rate"],
            "acceptance_rate": event["acceptance_rate"],
            "duration_online": event["duration_online"],
            "total_earned": event["total_earned"],
            "net_earnings": event["net_earnings"],
            "fare": event["fare"],
            "toll": event["toll"],
            "uber_fee": event["uber_fee"],
            "cash_collected": event["cash_collected"],
            "tips": event["tips"],
            "adjusted_fare": event["adjusted_fare"],
            "surge": event["surge"],
            "airport_surcharge": event["airport_surcharge"],
            "cash_payment_count": event["cash_payment_count"],
            "card_payment_count": event["card_payment_count"],
            "rating": event["rating"],
            "wait_time": event["wait_time"],
            "wait_time_duration": event["wait_time_duration"],
            "created_at": event["created_at"]
        },
        "received_at": str(datetime.now())
    }
    print("Publishing Event:", derived_event)

    client = boto3.client('sns')
    response = client.publish(
        TargetArn = os.environ["SNS_TOPIC_ARN"],
        Message = json.dumps({'default': json.dumps(derived_event)}),
        MessageGroupId="driver-daily-metrics-inserted",
        MessageStructure = 'json'
    )

    return {"statusCode": 200, "body": json.dumps(response)}
