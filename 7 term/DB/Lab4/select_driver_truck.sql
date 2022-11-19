SELECT
    driver.name,
    truck.registration_number,
    truck.max_load
    FROM driver INNER JOIN truck ON driver.id = truck.driver_id;
