select ss.shipper_name, ss.supplier_name  from
    (select shp.name as shipper_name, supplier.name as supplier_name from 
        (shipper
            inner join supplier_shipper on shipper.id = supplier_shipper.shipper_id) as shp
        inner join supplier on shp.supplier_id = supplier.id) as ss
    group by ss.shipper_name, ss.supplier_name
    order by ss.shipper_name asc;