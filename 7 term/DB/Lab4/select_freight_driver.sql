SELECT
    driver.name,
    driver.passport_number,
    freight.start_date,
    freight.end_date,
    freight.destination
    FROM driver INNER JOIN freight ON freight.id = driver.freight_id
    WHERE freight.end_date BETWEEN '2017-01-01' AND '2023-01-01'
    ORDER BY freight.end_date ASC;
