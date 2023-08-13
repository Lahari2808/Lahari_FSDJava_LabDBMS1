#Q3 ANSWER IS AS FOLLOWS
SELECT COUNT(TEST.CUS_GENDER) AS NoOfCustomer, TEST.CUS_GENDER FROM
(
	SELECT C.CUS_ID,CUS_NAME,CUS_GENDER,ORD_ID,ORD_AMOUNT FROM `ORDER` AS O
	INNER JOIN CUSTOMER AS  C
	ON O.CUS_ID = C.CUS_ID
	HAVING O.ORD_AMOUNT>=3000
) AS TEST 
GROUP BY TEST.CUS_GENDER;

#4)	Display all the orders along with product name ordered by a customer having Customer_Id=2
#Q4 ANSWER IS AS FOLLOWS
SELECT C.CUS_ID,C.CUS_NAME, T2.ORD_ID,T2.ORD_DATE,T2.ORD_AMOUNT, T2.PRO_NAME FROM CUSTOMER AS C
INNER JOIN
(
	SELECT T1.ORD_ID,T1.ORD_DATE,T1.ORD_AMOUNT,T1.CUS_ID, P.PRO_ID , P.PRO_NAME FROM PRODUCT AS P
	INNER JOIN
	(
		SELECT O.ORD_ID,O.ORD_DATE,O.ORD_AMOUNT,O.CUS_ID, SP.PRO_ID FROM `order` AS O
		INNER JOIN supplier_pricing AS SP
		ON O.PRICING_ID=SP.PRICING_ID
	) AS T1 ON T1.PRO_ID = P.PRO_ID
) AS T2 ON T2.CUS_ID = C.CUS_ID AND C.CUS_ID=2;

#5)	Display the Supplier details who can supply more than one product.
#Q5 ANSWER IS AS FOLLOWS
SELECT supplier.* FROM supplier
WHERE supplier.supp_id IN (SELECT supp_id FROM supplier_pricing GROUP BY supp_id HAVING COUNT(supp_id) > 1)
GROUP BY supplier.supp_id;

#6)	Find the least expensive product from each category and print the table with category id, name, product name and price of the product
#Q6 ANSWER IS AS FOLLOWS

select t5.cat_id, t5.cat_name,p.pro_name, Min_Price from (
select * from 
(SELECT category.cat_id, category.cat_name, MIN(t3.min_price) AS Min_Price FROM category 
INNER JOIN 
(
	SELECT product.cat_id, product.pro_name, t2.* FROM product
    INNER JOIN 
    (
		SELECT pro_id, MIN(supp_price) AS Min_Price FROM supplier_pricing  GROUP BY pro_id
	) AS t2 WHERE t2.pro_id = product.pro_id
) AS t3 WHERE t3.cat_id = category.cat_id
GROUP BY t3.cat_id) as t4 
inner join supplier_pricing as sp 
on t4.Min_Price = sp.SUPP_PRICE
) as t5 inner join product as p 
on t5.pro_id = p.pro_id;

#7)	Display the Id and Name of the Product ordered after “2021-10-05”.
#Q7 ANSWER IS AS FOLLOWS

SELECT product.pro_id, product.pro_name,`order`.ord_date FROM `order`
INNER JOIN supplier_pricing 
ON supplier_pricing.pricing_id = `order`.pricing_id
INNER JOIN product 
ON product.pro_id = supplier_pricing.pro_id
WHERE `order`.ord_date > '2021-10-05';

#8)	Display customer name and gender whose names start or end with character 'A'.
#Q8 ANSWER IS AS FOLLOWS

SELECT c.CUS_NAME,c.CUS_GENDER FROM customer AS c WHERE (c.CUS_NAME LIKE  'A%' OR c.CUS_NAME LIKE  '%A');

#9)	Create a stored procedure to display supplier id, name, rating and Type_of_Service. 
#For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, 
#If rating >2 print “Average Service” else print “Poor Service”.
#Q9 ANSWER IS AS FOLLOWS

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `SUP_RATTINGS`()
BEGIN
    SELECT report.supp_id, report.supp_name, report.Average,
        CASE
            WHEN report.Average = 5 THEN 'Excellent Service'
            WHEN report.Average > 4 THEN 'Good Service'
            WHEN report.Average > 2 THEN 'Average Service'
            ELSE 'Poor Service'
        END AS Type_of_Service
    FROM (
        SELECT final.supp_id, supplier.supp_name, final.Average
        FROM (
            SELECT test2.supp_id, SUM(test2.rat_ratstars) / COUNT(test2.rat_ratstars) AS Average
            FROM (
                SELECT supplier_pricing.supp_id, test.ORD_ID, test.RAT_RATSTARS
                FROM supplier_pricing
                INNER JOIN (
                    SELECT `order`.pricing_id, rating.ORD_ID, rating.RAT_RATSTARS
                    FROM `order`
                    INNER JOIN rating ON rating.`ord_id` = `order`.ord_id
                ) AS test ON test.pricing_id = supplier_pricing.pricing_id
            ) AS test2
            GROUP BY supplier_pricing.supp_id
        ) AS final
        INNER JOIN supplier ON final.supp_id = supplier.supp_id
    ) AS report;
END //
DELIMITER ;

# calling  Stored PROCEDURE
call ecommerce_db.SUP_RATTINGS();