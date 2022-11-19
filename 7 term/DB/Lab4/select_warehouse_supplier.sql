SELECT
    supplier.name,
    warehouse.address
    FROM warehouse RIGHT OUTER JOIN supplier ON supplier.id = warehouse.supplier_id;