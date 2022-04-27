CREATE OR REPLACE FUNCTION fn_cdc_driverdailymetrics_inserted()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS
$$
BEGIN
    PERFORM * FROM aws_lambda.invoke(
        aws_commons.create_lambda_function_arn(
            TG_ARV[0],
            'eu-west-1'
        ), 
        CONCAT('{"drn": "', NEW.drn, '", "date": "', NEW.date, '", "trips": ', NEW.trips, ', "supply_hours": ', COALESCE(NEW.supply_hours, 0.00),
        ', "km_driven": ', COALESCE(NEW.km_driven, 0.00), ', "cancellation_rate": ', COALESCE(NEW.cancellation_rate, 0.00), 
        ', "acceptance_rate": ', COALESCE(NEW.acceptance_rate, 0.00),
        ', "duration_online": ', COALESCE(NEW.duration_online, 0.00), ', "total_earned": ', COALESCE(NEW.total_earned, 0.00), 
        ', "net_earnings": ', COALESCE(NEW.net_earnings, 0.00),
        ', "fare": ', COALESCE(NEW.fare, 0.00), ', "toll": ', COALESCE(NEW.toll, 0.00), 
        ', "uber_fee": ', COALESCE(NEW.uber_fee, 0.00), ', "cash_collected": ', COALESCE(NEW.cash_collected, 0.00),
        ', "tips": ', COALESCE(NEW.tips, 0.00), ', "adjusted_fare": ', COALESCE(NEW.adjusted_fare, 0.00), ', "surge": ', COALESCE(NEW.surge, 0.00), 
        ', "airport_surcharge": ', COALESCE(NEW.airport_surcharge, 0.00),
        ', "cash_payment_count": ', COALESCE(NEW.cash_payment_count, 0), ', "card_payment_count": ', COALESCE(NEW.card_payment_count, 0), 
        ', "rating": ', COALESCE(NEW.rating, 0.00),
        ', "wait_time": ', COALESCE(NEW.wait_time, 0), 
        ', "wait_time_duration": ', COALESCE(NEW.wait_time_duration, 0.00), ', "created_at": "', NEW.created_at, '"}')::json
    );
    RETURN NEW;
END
$$;