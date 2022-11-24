select fp.destination, fp.name from
    (select f.freight_id, f.product_id, f.destination, product.name from 
        (freight
            inner join freight_product on freight.id = freight_product.freight_id) as f
        inner join product on f.product_id = product.id) as fp
    group by fp.destination, fp.name
    order by fp.destination;