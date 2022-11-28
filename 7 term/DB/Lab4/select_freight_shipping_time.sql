SELECT
    freight.start_date,
    freight.end_date,
    AGE(freight.end_date, freight.start_date) AS shipping_time,
    freight.destination
    FROM freight
    ORDER BY shipping_time DESC;
