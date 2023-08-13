INSERT INTO supplier(SUPP_NAME,SUPP_CITY,SUPP_PHONE)
VALUES
	("Rajesh Retails","Delhi",'1234567890'),
	("Appario Ltd.","Mumbai",'2589631470'),
	("Knome products","Banglore",'9785462315'),
	("Bansal Retails","Kochi",'8975463285'),
	("Mittal Ltd.","Lucknow",'7898456532');
 
 
 INSERT INTO customer(CUS_NAME,CUS_PHONE,CUS_CITY,CUS_GENDER) VALUES
("AAKASH",'9999999999',"DELHI",'M'),
("AMAN",'9785463215',"NOIDA",'M'),
("NEHA",'9999999999',"MUMBAI",'F'),
("MEGHA",'9994562399',"KOLKATA",'F'),
("PULKIT",'7895999999',"LUCKNOW",'M');

INSERT INTO category(CAT_NAME) VALUES("BOOKS");
INSERT INTO category(CAT_NAME) VALUES("GAMES");
INSERT INTO category(CAT_NAME) VALUES("GROCERIES");
INSERT INTO category(CAT_NAME) VALUES ("ELECTRONICS");
INSERT INTO category(CAT_NAME) VALUES("CLOTHES");

INSERT INTO PRODUCT VALUES(1,"GTA V","Windows 7 and above with i5 processor and 8GB RAM",2);
INSERT INTO PRODUCT VALUES(2,"TSHIRT","SIZE-L with Black, Blue and White variations",5);
INSERT INTO PRODUCT VALUES(3,"ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4);
INSERT INTO PRODUCT VALUES(4,"OATS","Highly Nutritious from Nestle",3);
INSERT INTO PRODUCT VALUES(5,"HARRY POTTER","Best Collection of all time by J.K Rowling",1);
INSERT INTO PRODUCT VALUES(6,"MILK","1L Toned MIlk",3);
INSERT INTO PRODUCT VALUES(7,"Boat EarPhones","1.5Meter long Dolby Atmos",4);
INSERT INTO PRODUCT VALUES(8,"Jeans","Stretchable Denim Jeans with various sizes and color",5);
INSERT INTO PRODUCT VALUES(9,"Project IGI","compatible with windows 7 and above",2);
INSERT INTO PRODUCT VALUES(10,"Hoodie","Black GUCCI for 13 yrs and above",5);
INSERT INTO PRODUCT VALUES(11,"Rich Dad Poor Dad","Written by RObert Kiyosaki",1);
INSERT INTO PRODUCT VALUES(12,"Train Your Brain","By Shireen Stephen",1);


INSERT INTO supplier_pricing(PRO_ID,SUPP_ID,SUPP_PRICE) 
VALUES((SELECT PRO_ID FROM PRODUCT WHERE PRO_NAME='ROG LAPTOP'),(SELECT SUPP_ID FROM supplier WHERE SUPP_PHONE='7898456532'),30000), 
((SELECT PRO_ID FROM PRODUCT WHERE PRO_NAME='GTA V'),2,1500), 
 (5,1,3000), 
 (2,3,2500),
 (4,1,1000), 
 (12,2,780),
 (12,4,789), 
 (3,1,31000), 
 (1,5,1450),
 (4,2,999), 
 (7,3,549), 
 (7,4,529), 
 (6,2,105), 
 (6,1,99),
 (2,5,2999), 
 (5,2,2999);
 
 INSERT INTO `ORDER`(ORD_ID,ORD_AMOUNT,ORD_DATE, CUS_ID, PRICING_ID) 
VALUES 
(101,1500,"2021-10-06",(SELECT CUS_ID FROM CUSTOMER WHERE CUS_PHONE='9785463215'),1), 
(102,1000,"2021-10-12",3,5), 
(103,30000,"2021-09-16",5,2), 
(104,1500,"2021-10-05",1,1), 
(105,3000,"2021-08-16",4,3), 
(106,1450,"2021-08-18",1,9),
(107,789,"2021-09-01",3,7),
(108,780,"2021-09-07",5,6), 
(109,3000,"2021-09-10",5,3), 
(110,2500,"2021-09-10",2,4), 
(111,1000,"2021-09-15",4,5), 
(112,789,"2021-09-16",4,7),
(113,31000,"2021-09-16",1,8), 
(114,1000,"2021-09-16",3,5),
(115,3000,"2021-09-16",5,3), 
(116,99,"2021-09-17",2,14);

INSERT INTO rating(ORD_ID,RAT_RATSTARS) 
VALUES
(101,4),
(102,3), 
(103,1), 
(104,2), 
(105,4), 
(106,3), 
(107,4), 
(108,4), 
(109,3), 
(110,5), 
(111,3), 
(112,4), 
(113,2), 
(114,1), 
(115,1), 
(116,0);
