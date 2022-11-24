select wp.name, sum(wp.number) from
    (select w.warehouse_id, w.product_id, product.name, product.number from 
        (warehouse
            inner join warehouse_product on warehouse.id = warehouse_product.warehouse_id) as w
        inner join product on w.product_id = product.id) as wp
    group by wp.name;