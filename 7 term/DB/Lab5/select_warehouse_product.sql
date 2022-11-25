select wp.address, wp.name, wp.number  from
    (select w.address, product.name, product.number from 
        (warehouse
            inner join warehouse_product on warehouse.id = warehouse_product.warehouse_id) as w
        inner join product on w.product_id = product.id) as wp
    group by wp.address, wp.name, wp.number
    order by wp.address asc;