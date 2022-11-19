SELECT *
    FROM product
    WHERE product.price BETWEEN 2::money AND 5::money
    ORDER BY product.price  ASC;
