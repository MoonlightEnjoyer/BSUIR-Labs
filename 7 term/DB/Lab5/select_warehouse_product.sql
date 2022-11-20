select wp.warehouse_id, wp.product_id  from
    (select w.warehouse_id, w.product_id, w.address from 
        (warehouse
            inner join warehouse_product on warehouse.id = warehouse_product.warehouse_id) as w
        inner join product on w.product_id = product.id) as wp;
Joins seem to work correctly, result should be grouped.