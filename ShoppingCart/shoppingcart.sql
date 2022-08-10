
--CREATING THE PRODUCTS TABLE

CREATE TABLE products
(  
  product_id bigserial NOT NULL,
  description varchar(100) NOT NULL,
  price_inrands decimal(10,2) NOT NULL,
  PRIMARY KEY (product_id)
);
DROP TABLE products;
SELECT * FROM products;

--INSERTING INTO THE PRODUCTS TABLE

INSERT INTO products(description,price_inrands)
VALUES ('New LP1s TWS Bluetooth Wireless Headphones 5.0 By Bennedict',120.20),
('Redragon K617 Wired RGB Gaming Keyboard By Bennedict',639.68),
('200ml Cute Kawaiil Aroma Diffuser By Bennedict',79.59),
('SitopWear Smart Watch 2022 By Bennedict',450.99),
('Personalized Fabric Mouse Pad With Art By Bennedict',165.90),
('Flame Humidifier with USB Smart Timing LED Electric Aromatherapy Diffuser By Bennedict',180.90);

--CREATING THE CART TABLE

CREATE TABLE cart (
   product_id bigint PRIMARY KEY NOT NULL,
   quantity bigint NOT NULL CHECK (quantity > -1)
);




CREATE TABLE cart (
product_id bigint NOT NULL,
quantity int CHECK (quantity >= 0) NOT NULL
);
DROP TABLE cart
SELECT * FROM cart;


--INSERTING VALUES INTO THE CART TABLE

INSERT INTO cart (product_id,quantity)
VALUES (1,2),(2,3),(3,1),(4,3),(5,2),(6,1);



--ADD TO CART

 update cart set cart.quantity = cart.quantity+1

where exists (SELECT 1 FROM cart  WHERE cart.product_id=5)--IF THIS PRODUCT EXISTS THEN THE UPDATE WILL BE DONE

and cart.product_id=5;


--SHOW CART
UPDATE cart SET cart.quantity = cart.quantity + 1 
WHERE EXISTS(SELECT 1
             FROM cart
             WHERE cart.product_id=1)
             AND cart.product_id = 1;

SELECT description,quantity,price_inrands,quantity*price_inrands AS subtotal FROM cart
INNER JOIN products ON cart.product_id=products.product_id;


--REMOVING FROM THE CART

update cart set cart.quantity = cart.quantity-1

where exists (SELECT 1 FROM cart c WHERE c.product_id=1)--IF THIS PRODUCT EXISTS THEN THE UPDATE WILL BE DONE

and cart.product_id=1;

SELECT description,quantity,price_inrands,quantity*price_inrands AS subtotal FROM cart
INNER JOIN products ON cart.product_id=products.product_id;


-- IF Quantity = 0 add product to Cart table --
insert into cart (product_id, quantity)
select 
    4,1
where not exists (
    select 1 from cart where product_id = 4);

SELECT description, quantity, price_inrands, quantity*price_inrands AS subtotal FROM cart
INNER JOIN products ON cart.product_id=products.product_id;

--DELETE IF THE QUANTITY = 0

DELETE FROM cart WHERE cart.quantity <= 0;

--GRAND TOTAL
SELECT sum(cart.quantity * products.price_inrands) AS grandtotal FROM cart
INNER JOIN products ON products.product_id = cart.product_id;



