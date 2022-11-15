DROP DATABASE labetskiydb;
CREATE DATABASE labetskiydb;
\c labetskiydb
CREATE TABLE IF NOT EXISTS Supplier(
	ID INT,
	NAME VARCHAR(50) NOT NULL,
	ADDRESS VARCHAR(250) NOT NULL,
	PHONE_NUMBER VARCHAR(30) NOT NULL,
	PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Shipper(
        ID INT,
        NAME VARCHAR(50) NOT NULL,
        ADDRESS VARCHAR(250) NOT NULL,
        POSTAL_CODE VARCHAR(30) NOT NULL,
        PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Customer(
        ID INT,
        NAME VARCHAR(50) NOT NULL,
        ADDRESS VARCHAR(250) NOT NULL,
        PHONE_NUMBER VARCHAR(30) NOT NULL,
        PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Warehouse(
	ID INT,
	ADDRESS VARCHAR(250) NOT NULL,
	PHONE_NUMBER VARCHAR(30) NOT NULL,
	SUPPLIER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_SUPPLIER
		FOREIGN KEY(SUPPLIER_ID)
			REFERENCES SUPPLIER(ID)
);
CREATE TABLE IF NOT EXISTS Product(
	ID INT,
	NAME VARCHAR(50) NOT NULL,
	PRICE MONEY NOT NULL,
	NUMBER INT NOT NULL,
	PRIMARY KEY(ID)
);
CREATE TABLE IF NOT EXISTS Freight(
	ID INT,
	START_DATE DATE NOT NULL,
	END_DATE DATE NOT NULL,
	DESTINATION VARCHAR(250) NOT NULL,
	CUSTOMER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_CUSTOMER
		FOREIGN KEY(CUSTOMER_ID)
			REFERENCES CUSTOMER(ID)
);
CREATE TABLE IF NOT EXISTS Driver(
	ID INT,
	NAME VARCHAR(50) NOT NULL,
	PASSPORT_NUMBER VARCHAR(20) NOT NULL,
	FREIGHT_ID INT,
	SHIPPER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_FREIGHT
		FOREIGN KEY(FREIGHT_ID)
			REFERENCES FREIGHT(ID),
	CONSTRAINT FK_SHIPPER
		FOREIGN KEY(SHIPPER_ID)
			REFERENCES SHIPPER(ID)
);
CREATE TABLE IF NOT EXISTS Truck(
	ID INT,
	REGISTRATION_NUMBER VARCHAR(10) NOT NULL,
	MAX_LOAD INTEGER NOT NULL,
	DRIVER_ID INT,
	PRIMARY KEY(ID),
	CONSTRAINT FK_DRIVER
		FOREIGN KEY(DRIVER_ID)
			REFERENCES DRIVER(ID)
);
CREATE TABLE IF NOT EXISTS Supplier_Shipper(
	ID INT,
	SUPPLIER_ID INT,
	SHIPPER_ID INT,
	PRIMARY KEY (ID),
	CONSTRAINT FK_SUPPLIER
		FOREIGN KEY(SUPPLIER_ID)
			REFERENCES SUPPLIER(ID),
	CONSTRAINT FK_SHIPPER
		FOREIGN KEY (SHIPPER_ID)
			REFERENCES SHIPPER(ID)
);

CREATE TABLE IF NOT EXISTS Warehouse_Product(
        ID INT,
        WAREHOUSE_ID INT,
        PRODUCT_ID INT,
        PRIMARY KEY (ID),
        CONSTRAINT FK_WAREHOUSE
                FOREIGN KEY(WAREHOUSE_ID)
                        REFERENCES WAREHOUSE(ID),
        CONSTRAINT FK_PRODUCT
                FOREIGN KEY (PRODUCT_ID)
                        REFERENCES PRODUCT(ID)
);

CREATE TABLE IF NOT EXISTS Freight_Product(
        ID INT,
        FREIGHT_ID INT,
        PRODUCT_ID INT,
        PRIMARY KEY (ID),
        CONSTRAINT FK_FREIGHT
                FOREIGN KEY(FREIGHT_ID)
                        REFERENCES FREIGHT(ID),
        CONSTRAINT FK_PRODUCT
                FOREIGN KEY (PRODUCT_ID)
                        REFERENCES PRODUCT(ID)
);

INSERT INTO product (id, name, price, number) VALUES ('0', ' Camembert Pierrot
', '2.91', '4188440');
INSERT INTO product (id, name, price, number) VALUES ('1', ' Teatime Chocolate Biscuits
', '2.43', '1565747');
INSERT INTO product (id, name, price, number) VALUES ('2', ' Uncle Bobs Organic Dried Pears
', '4.59', '6593001');
INSERT INTO product (id, name, price, number) VALUES ('3', ' Original Frankfurter grüne Soße
', '0.13', '2348823');
INSERT INTO product (id, name, price, number) VALUES ('4', '
', '8.46', '304162');
INSERT INTO product (id, name, price, number) VALUES ('5', ' Tarte au sucre
', '0.19', '7147702');
INSERT INTO product (id, name, price, number) VALUES ('6', ' Uncle Bobs Organic Dried Pears
', '7.03', '5607220');
INSERT INTO product (id, name, price, number) VALUES ('7', ' Pavlova
', '6.92', '5035224');
INSERT INTO product (id, name, price, number) VALUES ('8', ' Aniseed Syrup
', '9.23', '6884701');
INSERT INTO product (id, name, price, number) VALUES ('9', ' Spegesild
', '3.21', '1774900');
INSERT INTO product (id, name, price, number) VALUES ('10', ' Sasquatch Ale
', '6.54', '9259752');
INSERT INTO product (id, name, price, number) VALUES ('11', ' Mishi Kobe Niku
', '7.61', '8745551');
INSERT INTO product (id, name, price, number) VALUES ('12', ' Uncle Bobs Organic Dried Pears
', '5.46', '5301672');
INSERT INTO product (id, name, price, number) VALUES ('13', ' Gorgonzola Telino
', '8.49', '5294653');
INSERT INTO product (id, name, price, number) VALUES ('14', ' Vegie-spread
', '3.63', '3879701');
INSERT INTO product (id, name, price, number) VALUES ('15', ' Tunnbrod
', '0.86', '5939608');
INSERT INTO product (id, name, price, number) VALUES ('16', ' Ikura
', '6.73', '5768821');
INSERT INTO product (id, name, price, number) VALUES ('17', ' Northwoods Cranberry Sauce
', '6.9', '4558448');
INSERT INTO product (id, name, price, number) VALUES ('18', ' Wimmers gute Semmelknodel
', '3.16', '8039499');
INSERT INTO product (id, name, price, number) VALUES ('19', ' Steeleye Stout
', '4.6', '638905');
INSERT INTO product (id, name, price, number) VALUES ('20', ' Konbu
', '1.53', '3107416');
INSERT INTO product (id, name, price, number) VALUES ('21', ' Mozzarella di Giovanni
', '8.92', '3580155');
INSERT INTO product (id, name, price, number) VALUES ('22', ' Valkoinen suklaa
', '6.95', '4125355');
INSERT INTO product (id, name, price, number) VALUES ('23', ' Laughing Lumberjack Lager
', '6.89', '486364');
INSERT INTO product (id, name, price, number) VALUES ('24', ' Vegie-spread
', '3.0', '1316680');
INSERT INTO product (id, name, price, number) VALUES ('25', ' Mascarpone Fabioli
', '9.13', '5854783');
INSERT INTO product (id, name, price, number) VALUES ('26', ' Guarana Fantastica
', '5.34', '8623334');
INSERT INTO product (id, name, price, number) VALUES ('27', ' Longlife Tofu
', '7.62', '6716258');
INSERT INTO product (id, name, price, number) VALUES ('28', ' Tunnbrod
', '6.72', '2636076');
INSERT INTO product (id, name, price, number) VALUES ('29', ' Côte de Blaye
', '4.17', '6025366');
INSERT INTO product (id, name, price, number) VALUES ('30', ' Chang
', '2.12', '8262775');
INSERT INTO product (id, name, price, number) VALUES ('31', ' Gravad lax
', '7.67', '7068062');
INSERT INTO product (id, name, price, number) VALUES ('32', ' Genen Shouyu
', '8.79', '6519644');
INSERT INTO product (id, name, price, number) VALUES ('33', ' Tunnbrod
', '9.53', '133779');
INSERT INTO product (id, name, price, number) VALUES ('34', ' Louisiana Hot Spiced Okra
', '2.88', '5041790');
INSERT INTO product (id, name, price, number) VALUES ('35', ' Longlife Tofu
', '3.81', '6657272');
INSERT INTO product (id, name, price, number) VALUES ('36', ' Gravad lax
', '2.01', '835735');
INSERT INTO product (id, name, price, number) VALUES ('37', ' Jack New England Clam Chowder
', '0.12', '1801527');
INSERT INTO product (id, name, price, number) VALUES ('38', ' Nord-Ost Matjeshering
', '8.95', '4706384');
INSERT INTO product (id, name, price, number) VALUES ('39', ' Chocolade
', '6.71', '5934238');
INSERT INTO product (id, name, price, number) VALUES ('40', ' Longlife Tofu
', '2.73', '9094509');
INSERT INTO product (id, name, price, number) VALUES ('41', ' Sir Rodneys Marmalade
', '7.87', '1195144');
INSERT INTO product (id, name, price, number) VALUES ('42', ' Boston Crab Meat
', '2.78', '8272991');
INSERT INTO product (id, name, price, number) VALUES ('43', ' Outback Lager
', '4.26', '3440600');
INSERT INTO product (id, name, price, number) VALUES ('44', ' Inlagd Sill
', '6.13', '6096078');
INSERT INTO product (id, name, price, number) VALUES ('45', ' Camembert Pierrot
', '9.79', '262158');
INSERT INTO product (id, name, price, number) VALUES ('46', ' Mishi Kobe Niku
', '3.87', '8341065');
INSERT INTO product (id, name, price, number) VALUES ('47', ' Inlagd Sill
', '2.64', '6774421');
INSERT INTO product (id, name, price, number) VALUES ('48', ' Gudbrandsdalsost
', '8.68', '1795525');
INSERT INTO product (id, name, price, number) VALUES ('49', ' Gula Malacca
', '3.84', '4838447');
INSERT INTO product (id, name, price, number) VALUES ('50', ' Scottish Longbreads
', '3.8', '1694115');
INSERT INTO product (id, name, price, number) VALUES ('51', ' Singaporean Hokkien Fried Mee
', '1.21', '1503945');
INSERT INTO product (id, name, price, number) VALUES ('52', ' Ravioli Angelo
', '1.77', '7731901');
INSERT INTO product (id, name, price, number) VALUES ('53', ' Gorgonzola Telino
', '2.5', '9475750');
INSERT INTO product (id, name, price, number) VALUES ('54', ' Mishi Kobe Niku
', '1.45', '4570669');
INSERT INTO product (id, name, price, number) VALUES ('55', ' Escargots de Bourgogne
', '0.08', '4426226');
INSERT INTO product (id, name, price, number) VALUES ('56', ' Singaporean Hokkien Fried Mee
', '3.79', '7368610');
INSERT INTO product (id, name, price, number) VALUES ('57', ' Genen Shouyu
', '6.17', '3916016');
INSERT INTO product (id, name, price, number) VALUES ('58', 'Rogede sild
', '7.32', '2408821');
INSERT INTO product (id, name, price, number) VALUES ('59', ' Laughing Lumberjack Lager
', '8.76', '314589');
INSERT INTO product (id, name, price, number) VALUES ('60', ' Gula Malacca
', '3.3', '1829971');
INSERT INTO product (id, name, price, number) VALUES ('61', ' Inlagd Sill
', '2.24', '7270849');
INSERT INTO product (id, name, price, number) VALUES ('62', ' Camembert Pierrot
', '1.53', '8176316');
INSERT INTO product (id, name, price, number) VALUES ('63', ' Pavlova
', '4.02', '8869311');
INSERT INTO product (id, name, price, number) VALUES ('64', ' Scottish Longbreads
', '7.43', '1178134');
INSERT INTO product (id, name, price, number) VALUES ('65', ' Filo Mix
', '5.31', '5241182');
INSERT INTO product (id, name, price, number) VALUES ('66', ' Teatime Chocolate Biscuits
', '1.61', '3504295');
INSERT INTO product (id, name, price, number) VALUES ('67', ' Louisiana Hot Spiced Okra
', '1.56', '8358421');
INSERT INTO product (id, name, price, number) VALUES ('68', ' Louisiana Hot Spiced Okra
', '8.64', '3734377');
INSERT INTO product (id, name, price, number) VALUES ('69', ' Genen Shouyu
', '3.97', '4012384');
INSERT INTO product (id, name, price, number) VALUES ('70', ' Louisiana Fiery Hot Pepper Sauce
', '4.97', '203967');
INSERT INTO product (id, name, price, number) VALUES ('71', ' Filo Mix
', '4.52', '3570013');
INSERT INTO product (id, name, price, number) VALUES ('72', ' Gula Malacca
', '6.51', '3331124');
INSERT INTO product (id, name, price, number) VALUES ('73', ' Chef Antons Gumbo Mix
', '3.14', '830917');
INSERT INTO product (id, name, price, number) VALUES ('74', 'Rogede sild
', '5.53', '3113311');
INSERT INTO product (id, name, price, number) VALUES ('75', ' Côte de Blaye
', '4.6', '4915529');
INSERT INTO product (id, name, price, number) VALUES ('76', 'Chai
', '6.6', '6417252');
INSERT INTO product (id, name, price, number) VALUES ('77', ' Camembert Pierrot
', '0.98', '8429263');
INSERT INTO product (id, name, price, number) VALUES ('78', ' Queso Cabrales
', '3.75', '7065516');
INSERT INTO product (id, name, price, number) VALUES ('79', ' Aniseed Syrup
', '5.34', '4704113');
INSERT INTO product (id, name, price, number) VALUES ('80', 'Chai
', '9.1', '8526258');
INSERT INTO product (id, name, price, number) VALUES ('81', ' Grandmas Boysenberry Spread
', '2.28', '1268176');
INSERT INTO product (id, name, price, number) VALUES ('82', ' Carnarvon Tigers
', '3.33', '9291139');
INSERT INTO product (id, name, price, number) VALUES ('83', ' Chartreuse verte
', '5.39', '2984137');
INSERT INTO product (id, name, price, number) VALUES ('84', ' Vegie-spread
', '9.65', '7555481');
INSERT INTO product (id, name, price, number) VALUES ('85', ' Zaanse koeken
', '4.14', '2120737');
INSERT INTO product (id, name, price, number) VALUES ('86', ' Gudbrandsdalsost
', '8.07', '624319');
INSERT INTO product (id, name, price, number) VALUES ('87', ' Inlagd Sill
', '6.88', '5734774');
INSERT INTO product (id, name, price, number) VALUES ('88', ' Rössle Sauerkraut
', '3.89', '651737');
INSERT INTO product (id, name, price, number) VALUES ('89', ' Gravad lax
', '0.56', '9856869');
INSERT INTO product (id, name, price, number) VALUES ('90', ' Inlagd Sill
', '6.1', '5106915');
INSERT INTO product (id, name, price, number) VALUES ('91', 'Rogede sild
', '3.7', '1670508');
INSERT INTO product (id, name, price, number) VALUES ('92', ' Sir Rodneys Scones
', '8.49', '8227650');
INSERT INTO product (id, name, price, number) VALUES ('93', ' Boston Crab Meat
', '5.84', '7962833');
INSERT INTO product (id, name, price, number) VALUES ('94', ' Sir Rodneys Scones
', '4.89', '643193');
INSERT INTO product (id, name, price, number) VALUES ('95', ' Sir Rodneys Marmalade
', '9.67', '8898318');
INSERT INTO product (id, name, price, number) VALUES ('96', ' Tarte au sucre
', '0.17', '5227530');
INSERT INTO product (id, name, price, number) VALUES ('97', ' Mascarpone Fabioli
', '4.67', '1822929');
INSERT INTO product (id, name, price, number) VALUES ('98', ' Laughing Lumberjack Lager
', '9.24', '1022667');
INSERT INTO product (id, name, price, number) VALUES ('99', ' Grandmas Boysenberry Spread
', '7.31', '4335272');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('0', 'Lozano PLC', '152 Richard Route
Johnhaven, IL 52358', '+1-412-303-7389x50170');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('1', 'Cole, Anderson and Callahan', '170 Michele Mission Suite 242
Donnaburgh, FM 28142', '003.836.2786');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('2', 'Rose, Sanchez and Torres', 'PSC 6369, Box 0742
APO AE 12398', '(416)543-8540');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('3', 'Freeman Inc', '7866 Stone Walk
West Stephanie, DC 09153', '785.489.6845x9791');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('4', 'Hanson LLC', '46552 Ryan Alley Apt. 122
North Nicole, TN 24575', '(771)575-8260');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('5', 'Prince, Joseph and Lopez', 'USCGC Carson
FPO AE 80490', '001-449-718-1253x794');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('6', 'Padilla-Alexander', 'USNV Brock
FPO AA 06583', '(219)468-0936x083');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('7', 'Delgado, Rodriguez and Smith', 'USS Miller
FPO AP 44737', '+1-627-964-4139');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('8', 'Rodriguez-Thomas', '99994 Kelsey Ridge
North Kaylaville, CT 25559', '001-760-746-4808x489');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('9', 'Vasquez and Sons', '153 Catherine Squares
Poncefurt, MI 51388', '071.985.9046x06572');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('10', 'Little, Webb and Kim', '5763 Roy Plains
Rebekahfurt, NH 32582', '+1-195-004-6647x3950');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('11', 'Trevino and Sons', '07449 Lang Valleys Apt. 015
North Dawnfurt, ME 18073', '001-026-319-1125x229');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('12', 'Underwood-Yu', '7054 Kennedy Run
New Sarah, VA 47662', '695-247-0262x529');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('13', 'Craig, Rosales and Munoz', '88739 Turner Trafficway Suite 788
North Angelafort, MA 93654', '+1-597-170-4513x583');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('14', 'Ramirez LLC', 'Unit 4312 Box 7114
DPO AA 42594', '827-295-9686');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('15', 'Turner, Thomas and Norris', '59452 Solis Port
Kimberlymouth, NM 32781', '001-088-108-7024x57452');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('16', 'Burke and Sons', '199 John Lights Suite 305
Kaitlynburgh, TX 66474', '782-251-7508x05652');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('17', 'Gonzalez-Sullivan', '706 Andrea Stream Suite 831
New Roger, NJ 84630', '290-759-6250');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('18', 'Leach, Myers and Lewis', '019 Richard Well Apt. 125
Leblancshire, VA 82513', '+1-472-202-1788x343');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('19', 'Miller, Joyce and Johnson', '2796 Nicole Underpass Suite 447
Lake Kellychester, FM 70436', '710.491.4418');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('20', 'King, Shelton and Hull', '1266 Charles Lakes Apt. 782
Jonestown, PW 37633', '8777607437');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('21', 'Moore Inc', '06830 Mcdaniel Ranch Suite 951
New Mark, MS 05802', '270-269-2113');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('22', 'Murphy PLC', '61013 Parrish Groves Apt. 932
South Michaelstad, FL 91722', '(857)263-8534x123');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('23', 'Jones-Jones', '677 Michele Fields
New Marystad, MS 51450', '043-284-2067x995');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('24', 'Ellis, Spencer and Taylor', '5199 Baker Groves Apt. 338
Allisontown, DE 34683', '683-437-1905x429');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('25', 'Hill-Jordan', '77540 Sanders Fort Suite 174
Gregoryton, MP 43941', '(280)186-8457x379');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('26', 'King Inc', '7704 Humphrey Track Suite 476
Baldwinborough, OK 14013', '428-736-7750x41040');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('27', 'Jones, Hawkins and Peterson', '4533 Myers Port Apt. 380
Smithmouth, MI 90313', '848.651.4563');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('28', 'Hudson-Durham', '7443 Kristi Road Apt. 812
Donaldshire, MI 60356', '(786)692-3450x07463');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('29', 'Glover-Compton', '8171 Robinson Ports
Lake Rebeccachester, ID 14606', '629-798-3926');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('30', 'Jenkins-Decker', '8594 Beth Lake
Mercerchester, MH 35006', '+1-910-797-1487');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('31', 'Figueroa Group', '5060 Caldwell Bridge
Aprilland, RI 94400', '(030)282-0617');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('32', 'Camacho LLC', '3829 John Mews
New Marie, AL 23634', '001-571-954-3563x24264');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('33', 'Smith-Warren', '728 Wallace Ferry Apt. 524
Johnmouth, CO 25659', '570-700-7728x9965');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('34', 'Smith, Schmidt and Stone', '13305 Rogers Grove
Lake Jonathan, MD 27996', '934-955-4736x902');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('35', 'Cole and Sons', '34286 Ramos Light
North Mitchell, AR 75177', '606-529-5393x2093');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('36', 'Stone-Hoffman', '09478 Potts River Apt. 127
Port Brookeberg, WY 23851', '423-266-2201x4679');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('37', 'Terrell PLC', '68728 Brent Mission
Heatherton, FM 68908', '001-588-542-6962x0004');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('38', 'Thompson-Sanford', '080 Carpenter Club Apt. 230
Port Thomas, NY 92616', '454.253.3709');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('39', 'Jackson, Johnson and Freeman', '31816 Hamilton Trafficway
Olsenmouth, DE 84480', '(502)083-3885');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('40', 'Hahn, Price and Mayer', '96054 Kathryn Club Apt. 839
Sandersland, MP 10623', '902.786.9753');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('41', 'Hayden, Rodriguez and Bailey', '271 Cabrera Spur
Cliffordport, ND 39077', '897.674.8859');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('42', 'Coleman Inc', '76298 Kimberly Mill Suite 625
South Francisco, DC 87348', '(765)394-2756x94316');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('43', 'Smith-Bradley', '7464 Thomas Glens
Lake Kimberly, NV 44606', '001-863-284-5934x40318');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('44', 'Gates, Henson and Guerrero', 'Unit 6845 Box 8039
DPO AE 77338', '328.146.1375x029');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('45', 'Fernandez-Anthony', '67021 Branch Key
Wallaceton, OK 02269', '3210675084');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('46', 'Higgins, Jones and Cole', '1363 Alexis Branch Suite 754
Lisatown, FL 14912', '932.498.7359');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('47', 'Olsen, Rodriguez and Lowery', '329 Kyle Ports
Delacruzside, FM 33813', '9048552555');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('48', 'Harris Ltd', '456 Olson Place Apt. 555
Bobbyburgh, DC 84552', '+1-582-978-5652');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('49', 'Jones, Cunningham and Elliott', '3784 Kristopher Freeway Apt. 676
West Virginiaville, NM 29055', '923-330-5722x9327');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('50', 'Leon, Newman and Jones', '427 Walter Way Apt. 303
Rhondaton, AS 23290', '497-206-8065');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('51', 'Byrd, Silva and James', '336 Chad Hills Suite 402
Brycechester, UT 07536', '+1-150-171-3629');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('52', 'Perez-Shepard', '128 Davis Orchard
Jillbury, AZ 67179', '320.977.6805');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('53', 'Blackwell, Brewer and Lee', '186 William Cape Suite 503
Adamborough, MD 87988', '+1-493-081-7895x88338');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('54', 'Frost-Smith', '28427 Steven Mount
West Alexander, AZ 62521', '620.619.0375x94765');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('55', 'Johnson-Brown', '8904 Ryan Ferry Suite 150
Walkerborough, MT 51091', '216-527-1055');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('56', 'Peterson Ltd', '128 Marissa Way Suite 678
North Mary, DC 10725', '773-722-3852x3880');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('57', 'Jones, Blair and Baker', 'USCGC Mcmahon
FPO AE 90460', '001-337-214-2646');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('58', 'Combs, Lucero and Watts', 'PSC 1745, Box 2401
APO AP 11894', '+1-493-651-0966x5771');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('59', 'Porter-Cooper', '6412 Patel Causeway
North Laurahaven, ND 42265', '(070)111-2590x02947');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('60', 'Lopez, Mitchell and Lee', '816 Vargas Canyon
East Mackenzieville, FL 43403', '001-382-888-7977x865');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('61', 'Smith, Simmons and Ferguson', '759 Schultz Cliff Suite 761
Hoffmanside, NJ 95009', '022-365-9640');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('62', 'Sutton, Mccoy and Palmer', '685 Gallegos Underpass
New Pamelaborough, ME 12921', '997.600.8809');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('63', 'Stone-Thompson', '588 Moore Plaza
Montoyashire, WV 51612', '292.898.2255x213');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('64', 'Holder-Gonzalez', '538 Hall Mount
Port Katherineborough, WA 83799', '201-669-5695x203');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('65', 'Decker LLC', '258 Mary Rapid Suite 765
Weaverborough, IA 43163', '315-341-4171x4396');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('66', 'Brown Inc', '559 Juarez Mountains
New Randallport, IA 78675', '+1-457-922-0407');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('67', 'Shepherd-Deleon', 'Unit 8200 Box 8346
DPO AA 98623', '507.859.1043');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('68', 'Elliott LLC', '434 Courtney Rue Suite 359
East Michael, KS 68042', '793.886.1382x1342');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('69', 'Torres LLC', '2795 Adams Rapid Apt. 415
New Davidfurt, RI 49521', '826.091.2282x711');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('70', 'Martin Group', '5224 Baker Spring Apt. 197
Port Lauraberg, ID 02455', '626-643-7744x80958');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('71', 'Barry-Stone', '496 Curtis Club
New Tina, KS 10441', '120-825-7642x83482');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('72', 'Benton LLC', '823 Ramos Valleys
Campbellport, IN 16059', '022-720-6712x980');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('73', 'Hawkins, Howell and Gonzalez', '64758 Peter Inlet Suite 907
North Jared, WV 06108', '4959773973');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('74', 'Stewart, Fry and Garcia', '843 Dixon River
South Jessica, OH 26844', '317.214.5684x12120');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('75', 'Moody Ltd', '486 Marquez Island
Leefort, AS 59968', '1381437079');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('76', 'Rios-Ward', 'Unit 1743 Box 9912
DPO AP 43942', '+1-379-386-6895x928');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('77', 'Pace and Sons', '11462 Nancy Vista Suite 549
Santanamouth, NH 61772', '+1-988-373-8486');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('78', 'Brown, Coleman and Price', 'PSC 7048, Box 3229
APO AA 34203', '(915)686-5715x058');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('79', 'Nicholson-Butler', '9423 Nguyen Fields Suite 245
Estradastad, KS 54334', '+1-596-397-9324x7554');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('80', 'Perez, Mccoy and Rogers', '58871 Vanessa Road
South Autumnview, OH 42309', '+1-851-470-3053');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('81', 'Dawson, Stewart and Holt', '13967 Bennett Lake
Petershire, VT 70775', '+1-294-158-9937x02533');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('82', 'Moore, Pennington and Cortez', '7958 Peters Mill Suite 312
Tinafort, NV 61878', '056.815.3676x38909');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('83', 'Dillon and Sons', '829 Timothy Circle Suite 758
New Christianville, UT 39780', '001-737-255-6191x1399');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('84', 'Ramirez, Gonzalez and Williams', 'USNV Charles
FPO AE 54803', '001-422-500-9844x9493');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('85', 'Cooley-Wise', '203 Daniel Knolls
Sandrabury, KY 76654', '(611)605-5518x29286');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('86', 'Young Inc', '167 Santos Stream
Castroton, KS 28834', '988-912-7275');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('87', 'Swanson, Davidson and Jennings', '51839 Jay Plain Apt. 595
South Jerry, GU 75275', '604.938.1112');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('88', 'Norman Group', '46597 Fletcher Ridge
Jeanetteberg, IL 06704', '(714)536-8156');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('89', 'Burke, Farrell and Costa', '502 Anthony Crossroad Suite 819
Wongmouth, IL 61748', '219.987.5554x952');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('90', 'Pineda, Stone and Morales', '32719 Charles Inlet
Lake Alexis, AR 26909', '+1-726-039-7034x15042');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('91', 'Burns-Matthews', '56265 Elizabeth Drives Apt. 013
Charlestown, GA 11578', '2925145328');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('92', 'Smith PLC', 'USNS Rodriguez
FPO AE 99914', '(943)512-9119');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('93', 'Torres, Pena and Melendez', '20273 Buchanan Locks
South Michaelland, MH 47901', '001-263-438-3864');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('94', 'White-Brown', '6419 Kidd Dam
Port Tonya, IL 41259', '+1-233-216-3027x53999');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('95', 'James-Lewis', 'PSC 0622, Box 3747
APO AA 11022', '+1-289-981-3079x7627');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('96', 'Boyd, Watson and Hobbs', '229 Karen Field
Lake Lucasside, TN 84949', '449.259.3744x510');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('97', 'Campbell PLC', '9889 Gomez Radial Apt. 290
South Amanda, HI 21174', '1757563277');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('98', 'Robinson LLC', '72980 Laurie Forge
Lake Brian, NY 52658', '001-435-122-6173');
INSERT INTO supplier (id, name, address, phone_number) VALUES ('99', 'Watkins-Miles', '608 Patricia Field
North Josephbury, PR 03236', '(851)684-7623');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('0', 'Clements, Ryan and Wright', '569 Johnson Tunnel
Collinmouth, RI 33511', '418020');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('1', 'Patterson Inc', '1303 Jackson Lane
Port Howardside, PR 51831', '487885');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('2', 'Martinez, Ramirez and Guerra', '15074 Kelly Canyon
Gonzalezland, IA 91013', '238531');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('3', 'Parks, Brown and Johnson', '82208 Dylan Ways Apt. 494
Evanchester, KS 09316', '946355');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('4', 'Thomas-Montgomery', '94750 Cristina Mountains
East Destinymouth, ND 55663', '841306');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('5', 'Ruiz, Petersen and Dorsey', '7823 Richard Trail
Port Courtney, RI 89657', '151293');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('6', 'Duncan-Aguilar', '571 Garza Fords
East Samuelmouth, RI 48622', '676051');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('7', 'Peterson Group', '84170 Smith Views
West Amandashire, AK 02801', '167059');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('8', 'Ramirez-Meyer', '51074 Steven Mountain
North Randyland, WI 49290', '865061');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('9', 'Lee and Sons', '330 Savannah Camp Suite 116
Lewisview, NC 22956', '985685');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('10', 'Stewart Inc', '1382 Cheryl Hollow
Nicholasport, HI 36838', '765939');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('11', 'Ramirez LLC', '92334 Misty Coves
Port Annastad, CO 30903', '825110');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('12', 'Brown, Martin and Pena', '51920 John Garden
Port Johnnytown, VI 50345', '237928');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('13', 'Larson-Chavez', '5174 Case Passage
Mercadoton, MI 45068', '826873');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('14', 'Meyer Group', '9196 Erin Ports
North Kevin, AR 65044', '564806');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('15', 'Valenzuela Inc', 'Unit 8180 Box 2506
DPO AA 46818', '815903');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('16', 'Franklin-Herrera', '682 Michele Mews Apt. 946
Karaborough, IA 94587', '583259');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('17', 'Williams-King', 'USNV Jones
FPO AP 72729', '947817');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('18', 'Williams LLC', '7920 Conley Via
New Toni, OK 35048', '537705');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('19', 'Mcdonald, Phillips and Robinson', '546 Joseph Vista
New Alison, ID 85228', '821689');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('20', 'Thompson, Holloway and Johnson', '3458 Frost Curve
North Brandon, RI 40893', '562189');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('21', 'Leach-Hunter', '95208 Schroeder Parkway
Brownville, AR 03377', '517212');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('22', 'Morgan, Newton and Owens', '5796 Kevin Crossing Apt. 702
Wheelerfurt, RI 07566', '209476');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('23', 'Hart, Schultz and Hernandez', '6768 Aaron Fall
Davisport, FM 19790', '960626');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('24', 'Lynch-Roberts', 'Unit 6915 Box 0947
DPO AE 71865', '926408');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('25', 'Brown and Sons', '6375 Kathryn Bridge Suite 215
East Stephen, NE 39424', '425000');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('26', 'Johnson, Pugh and Guerrero', '037 Casey Haven
Cookhaven, VA 35744', '936414');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('27', 'Rogers, Price and Morales', '0426 Tyler Forges Suite 654
East Sharon, CO 09576', '528070');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('28', 'Bell-Garcia', '804 Jerry Stream
Campbellmouth, WI 18382', '982305');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('29', 'Chen LLC', '2958 Hernandez Pines Apt. 763
Moorefort, GA 72763', '229639');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('30', 'West, Salas and Sloan', '4095 Martin Station Apt. 555
Parksborough, DE 18646', '142577');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('31', 'Lee-Barnes', '33265 Lindsey Fords Suite 336
Williamstad, OH 38748', '772740');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('32', 'Friedman-Landry', '456 Hanson Park
Alexandraburgh, RI 79018', '921656');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('33', 'Rocha, Martinez and Garza', '9516 Lawson Orchard
Youngmouth, IN 13548', '327194');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('34', 'May, Perez and Jackson', '91605 Zavala Expressway
Lake Adrianaton, PA 48542', '829753');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('35', 'Burch-Wood', '219 Wilcox Summit Apt. 599
Port Taylor, FL 28850', '922027');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('36', 'Carpenter-Jones', '24364 William Keys
Thomasport, VT 28033', '096514');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('37', 'Estrada-Macias', '9490 Evans Rue Suite 085
North Brian, AS 35582', '445882');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('38', 'Williams-Barber', '22413 Wise Landing
Lake Nicholas, KY 73074', '028155');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('39', 'Palmer, Lutz and Mendez', '0659 Ramos Shores Suite 534
Lopezport, VA 99123', '307775');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('40', 'Cooper-Bush', '369 Douglas Club
West Cassandra, OH 44443', '730169');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('41', 'Hayes, Medina and Clark', '4353 Samantha Brook Suite 523
New Ruth, DC 85992', '008600');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('42', 'Bennett Ltd', '207 Bowers Field Apt. 490
West Christinafurt, VT 48973', '842712');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('43', 'Bowers PLC', '853 Robert Run Suite 109
Petersenhaven, PA 21636', '599677');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('44', 'Rodriguez-Kelley', '5328 David Throughway Suite 142
Murrayfort, MP 00782', '168006');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('45', 'Willis, James and Rivera', '68074 Simpson Corners
Gregoryfort, PR 96767', '851355');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('46', 'Wong-Miller', '77102 Michelle Flat
New Jessica, VI 87438', '402424');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('47', 'Garcia-Lee', '2500 Benson Extension
Codyview, MS 42288', '918913');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('48', 'Elliott-Malone', '0462 Michelle Highway Suite 538
North Jamiemouth, AR 53498', '776302');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('49', 'Calderon-Moore', '1492 Amy Lake Apt. 429
Davidtown, OH 36224', '834192');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('50', 'Brown, Hutchinson and Wilson', '6970 Randy Canyon Suite 679
Lake Jamesberg, ME 15198', '169776');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('51', 'Hart and Sons', '2415 Bradley Glen
West Daniel, AZ 98796', '004465');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('52', 'Austin-Williamson', '85821 Michael Circles Apt. 958
Jessicachester, VT 24044', '157015');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('53', 'Garcia LLC', 'Unit 7825 Box 2125
DPO AA 65338', '399596');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('54', 'Sullivan, Beard and Johnson', '990 Orr Orchard
Lake Elizabeth, CA 67792', '189513');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('55', 'Alvarez-Henry', '86867 Tina Islands Suite 978
Gregoryberg, VT 90213', '596449');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('56', 'Burns, Green and Stanley', '3551 Jeremy Hollow Apt. 466
Perrybury, WI 75289', '334119');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('57', 'Wilson and Sons', '13243 Choi Station
Leebury, GA 75573', '575852');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('58', 'Terrell PLC', '723 Cindy Trafficway Suite 488
Alvaradoborough, HI 23787', '190136');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('59', 'Martin-Watkins', '4699 Bradley Centers
Port Mary, AS 58703', '633755');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('60', 'Bass-Webb', '308 Dawn Shoals Suite 523
East Carolinebury, TN 28670', '619934');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('61', 'Jones, Nichols and Wagner', '9241 Carr Forest Apt. 654
South Todd, KY 30879', '927019');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('62', 'Wilcox-Schmitt', '877 Kimberly Springs
Ramirezbury, AS 46251', '047251');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('63', 'Brown-Keller', '054 Brandon Falls
Daniellemouth, LA 77884', '112110');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('64', 'Reese-Dickerson', '470 Roberta Trace
Smithfort, NC 43812', '314388');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('65', 'Shannon-Jackson', '9003 Mccormick Vista
South Jennifer, TX 60698', '479529');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('66', 'Fox and Sons', '9678 Clarke Street Suite 665
Port Lindsey, NH 38682', '866680');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('67', 'Dean, Maynard and Bradley', '5385 Kane Via
Stevenmouth, AR 09373', '711920');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('68', 'Martin-Collins', '434 Nichole Prairie
North Darlenemouth, GU 16190', '720655');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('69', 'Green Ltd', 'Unit 1684 Box 2690
DPO AP 66010', '043326');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('70', 'Wilson Ltd', '590 Megan Brooks
Helentown, GU 94108', '823944');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('71', 'Davis-Shaw', '1851 Deborah Brooks
Campbellborough, PW 28132', '228998');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('72', 'Smith-Wolfe', '3527 Thomas Gateway Apt. 312
Danielmouth, ND 99888', '521390');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('73', 'Frost, Mcdonald and Stevens', 'Unit 4415 Box 6931
DPO AP 71266', '429797');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('74', 'Palmer, Nolan and Chambers', 'USNS Anderson
FPO AP 81651', '828592');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('75', 'Fuller LLC', '027 Melissa Spring Apt. 758
Beckfort, KS 15297', '529273');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('76', 'Davis, Roman and Whitaker', '19123 Patricia Station
Lindamouth, NH 33998', '635350');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('77', 'Benson, Hunter and Hansen', '707 Ramsey Ways
Davishaven, TN 48881', '530349');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('78', 'Graham and Sons', '5224 Knapp Lane Suite 155
North Jeremy, FM 05768', '187485');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('79', 'Allison, Duke and Baker', '4874 Tracy Ramp Apt. 903
Leemouth, NC 75700', '712921');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('80', 'Watson PLC', '576 Cain Landing
East Coreybury, GU 90478', '735825');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('81', 'Lucas, Hamilton and Benson', '38229 John Groves
Port Travisfurt, MT 21425', '702965');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('82', 'King LLC', '94397 Jenna Trafficway
Lake Molly, MI 91526', '792365');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('83', 'Reyes-Jacobs', '92014 Wagner Crescent
Justinside, HI 54223', '983268');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('84', 'Miller LLC', '4562 Hicks Shore Apt. 207
Jonathonhaven, GA 77362', '886206');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('85', 'Morrow-Moon', '71585 Lori Fall
Jacksonborough, RI 87331', '282956');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('86', 'Garcia, Hammond and Smith', '878 Amanda Skyway
New John, DC 24418', '015304');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('87', 'Knox-Meyers', '290 Gonzalez Island Suite 307
Friedmanborough, IL 63574', '756078');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('88', 'Sharp-Mcgee', '33502 Shaffer Ridges Apt. 160
North Thomasshire, SD 03581', '878984');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('89', 'Hicks Ltd', '9257 Matthew Radial
West Robert, MA 38381', '956549');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('90', 'Rose-Martinez', '458 Johnson Corner
Lake Nicoleton, ND 07420', '884319');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('91', 'Howe-Rhodes', '58896 Castaneda Route
East Laura, ID 53025', '264663');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('92', 'West, Morales and Dodson', '6086 Taylor Harbor Apt. 609
Mcdonaldport, TN 97868', '526516');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('93', 'Serrano, Griffith and Santiago', 'USNV Young
FPO AA 67096', '397185');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('94', 'Smith-Singleton', '9659 John Ports Suite 453
Stephenberg, IL 58601', '811597');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('95', 'Gill LLC', '195 Davila Landing Suite 835
Dianeborough, AR 39246', '440552');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('96', 'Crane-Bennett', '957 Jordan Springs Suite 718
Richardsonshire, NH 57282', '158786');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('97', 'Jenkins, Meyer and Mendoza', '427 James Plaza
Smithville, OH 42674', '772557');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('98', 'York Inc', '684 Taylor Knoll Suite 359
Olsontown, NC 44551', '839278');
INSERT INTO shipper (id, name, address, postal_code) VALUES ('99', 'Erickson Group', '3203 Short Harbors Apt. 339
New Jade, KY 05934', '281100');
INSERT INTO customer (id, name, address, phone_number) VALUES ('0', 'Heather Shepard', '8549 Stephen Gardens Apt. 221
Tonychester, VI 43865', '001-085-373-1472x97013');
INSERT INTO customer (id, name, address, phone_number) VALUES ('1', 'William Douglas', '632 Lori Islands
Theresaborough, MS 44690', '592-310-2265x3100');
INSERT INTO customer (id, name, address, phone_number) VALUES ('2', 'William Moreno', '970 Meyers Road
Williamtown, NV 90891', '(222)725-8579x4862');
INSERT INTO customer (id, name, address, phone_number) VALUES ('3', 'Erika Brandt', '668 Jenkins Stravenue Apt. 270
Ronaldville, UT 30981', '001-858-508-3708x276');
INSERT INTO customer (id, name, address, phone_number) VALUES ('4', 'Jeffrey Velasquez Jr.', '3622 Young Hills
South Tracieside, KS 92492', '408-598-7605x3314');
INSERT INTO customer (id, name, address, phone_number) VALUES ('5', 'Alan Nelson', '383 Angela Landing Apt. 172
Jonesberg, HI 52906', '760.478.5227x7803');
INSERT INTO customer (id, name, address, phone_number) VALUES ('6', 'Jennifer Williams', '47395 Brian Key Apt. 684
Thomaschester, AR 22469', '001-920-807-6567x996');
INSERT INTO customer (id, name, address, phone_number) VALUES ('7', 'William Miles', '5312 Barrett Spring Apt. 343
North Heather, IA 26891', '(205)728-3763x979');
INSERT INTO customer (id, name, address, phone_number) VALUES ('8', 'Alan Moore', '1596 Ponce Rest
Dustinport, GA 81100', '(427)090-0601');
INSERT INTO customer (id, name, address, phone_number) VALUES ('9', 'Frederick Scott', '44893 Schmidt Fords
Port Lisa, SC 62126', '412.166.9162');
INSERT INTO customer (id, name, address, phone_number) VALUES ('10', 'Samantha Garcia', 'USCGC Murphy
FPO AE 83692', '001-832-254-0703x21991');
INSERT INTO customer (id, name, address, phone_number) VALUES ('11', 'Timothy Price', '146 Jennifer Rapid Apt. 722
Crystalborough, NM 22521', '250-125-2292x60166');
INSERT INTO customer (id, name, address, phone_number) VALUES ('12', 'Gloria Clark', 'PSC 2932, Box 6866
APO AA 40917', '417-359-4259x417');
INSERT INTO customer (id, name, address, phone_number) VALUES ('13', 'Christine George', '979 Torres Lake Suite 536
Fuentesberg, VT 92382', '(007)919-1413x6652');
INSERT INTO customer (id, name, address, phone_number) VALUES ('14', 'Brenda Holland', '6896 Lowery Terrace Suite 608
Tylertown, MO 90429', '(815)041-1634x57106');
INSERT INTO customer (id, name, address, phone_number) VALUES ('15', 'Keith Diaz', '4913 Tran Junction Apt. 820
Castanedaborough, MN 88296', '963-106-2757x25132');
INSERT INTO customer (id, name, address, phone_number) VALUES ('16', 'Nicole Mcpherson', '19737 Smith Stravenue
Bentonborough, MT 68648', '445-346-9363x842');
INSERT INTO customer (id, name, address, phone_number) VALUES ('17', 'Tony Brown', '139 Christopher Stravenue
Kurtside, WY 24823', '240-008-7735x646');
INSERT INTO customer (id, name, address, phone_number) VALUES ('18', 'Madeline Franklin', '0705 Jacqueline Pine Suite 887
Williamborough, PW 32057', '2030056348');
INSERT INTO customer (id, name, address, phone_number) VALUES ('19', 'Christina Hill', '8533 Jennifer Estates
Port Beckyfort, AK 46579', '791-249-5603x87564');
INSERT INTO customer (id, name, address, phone_number) VALUES ('20', 'Diana Hunter', '07809 Heather Ranch
Cobbstad, MI 77652', '3832940507');
INSERT INTO customer (id, name, address, phone_number) VALUES ('21', 'Ricky Sullivan', '96279 Barton Fall
East Reginaldbury, PR 16056', '331-019-7683x0509');
INSERT INTO customer (id, name, address, phone_number) VALUES ('22', 'Brandy Mccoy', '4970 April Coves Apt. 179
West Lukehaven, CT 48768', '227.801.1939x59226');
INSERT INTO customer (id, name, address, phone_number) VALUES ('23', 'Daniel Ramirez', '661 Brewer Mission Apt. 455
Ronaldshire, UT 11798', '989-696-9541');
INSERT INTO customer (id, name, address, phone_number) VALUES ('24', 'Mr. Kenneth Garcia', 'Unit 0483 Box 1417
DPO AP 18724', '883.698.0860x11336');
INSERT INTO customer (id, name, address, phone_number) VALUES ('25', 'Jason Flynn', '6486 Victoria Lock Suite 385
Jasonside, GU 88528', '001-920-932-8797x15864');
INSERT INTO customer (id, name, address, phone_number) VALUES ('26', 'Mrs. Jennifer Bolton', '7029 Lisa Trail Apt. 635
Leebury, WV 43475', '+1-881-958-7929x67243');
INSERT INTO customer (id, name, address, phone_number) VALUES ('27', 'Elizabeth Smith', '6865 Tabitha Mount Suite 925
Lozanoshire, LA 24466', '486-627-9740x63825');
INSERT INTO customer (id, name, address, phone_number) VALUES ('28', 'Alicia Tucker', '050 Perry Greens
Davidberg, VI 34447', '102-064-5275x184');
INSERT INTO customer (id, name, address, phone_number) VALUES ('29', 'Russell Olsen', '313 Anderson Crossing
West Tylertown, MI 70867', '(419)201-7418');
INSERT INTO customer (id, name, address, phone_number) VALUES ('30', 'Elizabeth Bates', '23145 Small Parkways Apt. 062
Madelinemouth, WY 29294', '001-198-713-7379x43246');
INSERT INTO customer (id, name, address, phone_number) VALUES ('31', 'Sheila Andrews', '66868 Harrison Key
Philipton, TX 77658', '001-633-486-2955x41281');
INSERT INTO customer (id, name, address, phone_number) VALUES ('32', 'Michelle Bolton', '72886 King Mission Apt. 846
South Erik, DE 11238', '+1-111-405-1013');
INSERT INTO customer (id, name, address, phone_number) VALUES ('33', 'Gilbert Carpenter', '02849 Leah Wall Apt. 460
South Danielle, IL 85026', '344.119.3952');
INSERT INTO customer (id, name, address, phone_number) VALUES ('34', 'Lindsey Lee', '498 Rebecca Manor Suite 243
West Melissastad, NJ 57011', '192-084-2258x79316');
INSERT INTO customer (id, name, address, phone_number) VALUES ('35', 'Janice Stone', '654 Wright Isle Suite 358
Leblancborough, IA 35760', '001-121-119-7005x55564');
INSERT INTO customer (id, name, address, phone_number) VALUES ('36', 'Carla Gonzalez', '32244 Melissa Bypass Apt. 287
Kristinton, MO 50499', '918-158-8425x87250');
INSERT INTO customer (id, name, address, phone_number) VALUES ('37', 'Emily Miller', '83490 Frank Ways Apt. 914
East Jamesview, CO 32907', '765.660.7751');
INSERT INTO customer (id, name, address, phone_number) VALUES ('38', 'Sarah Hernandez', '94864 Neal Stream Suite 559
Lake Douglas, MI 63842', '293.148.1946');
INSERT INTO customer (id, name, address, phone_number) VALUES ('39', 'Wanda Turner', '43951 Alisha Ville Suite 180
Lake Jesse, AK 34205', '+1-021-546-6306');
INSERT INTO customer (id, name, address, phone_number) VALUES ('40', 'Jason Kelly', '620 Joseph Stravenue Apt. 388
North Cristina, ND 84621', '094.323.9512');
INSERT INTO customer (id, name, address, phone_number) VALUES ('41', 'Jonathan Barnett', '7642 Smith Fork
Cheryltown, MT 81770', '(755)703-3753');
INSERT INTO customer (id, name, address, phone_number) VALUES ('42', 'Michael Hatfield', 'USS Davis
FPO AE 39640', '915-845-7064');
INSERT INTO customer (id, name, address, phone_number) VALUES ('43', 'Randy Byrd', '6202 Perez Pass Apt. 979
East Frank, KS 94934', '001-181-357-6782x3498');
INSERT INTO customer (id, name, address, phone_number) VALUES ('44', 'Connor Thomas', '686 Rowe Causeway Apt. 988
Aaronmouth, OK 90243', '(526)468-7280');
INSERT INTO customer (id, name, address, phone_number) VALUES ('45', 'Lisa Cole', '4543 Vaughn Path
Brandonhaven, AL 57778', '(664)845-8338x93907');
INSERT INTO customer (id, name, address, phone_number) VALUES ('46', 'Danielle Hall', 'USS Alvarado
FPO AP 37854', '+1-243-502-0714x911');
INSERT INTO customer (id, name, address, phone_number) VALUES ('47', 'Courtney Hutchinson', 'Unit 7830 Box 7390
DPO AP 13841', '3615592672');
INSERT INTO customer (id, name, address, phone_number) VALUES ('48', 'Crystal Martinez', '1623 Adams Glen
Coffeyport, MN 95496', '7197533846');
INSERT INTO customer (id, name, address, phone_number) VALUES ('49', 'Madison Vaughn DDS', 'USNS Smith
FPO AA 94658', '(317)173-9401');
INSERT INTO customer (id, name, address, phone_number) VALUES ('50', 'Tiffany Roberts', '3097 Carrie Overpass
South Cindy, TN 07964', '(326)692-5136x46150');
INSERT INTO customer (id, name, address, phone_number) VALUES ('51', 'Jennifer Lee', '6963 Jonathan Island Apt. 219
Pittmanburgh, ID 08297', '+1-876-475-3934x9676');
INSERT INTO customer (id, name, address, phone_number) VALUES ('52', 'Belinda Griffin', '9081 Carl Cove
Jefferychester, OK 49337', '001-278-123-2103');
INSERT INTO customer (id, name, address, phone_number) VALUES ('53', 'Paula Baxter', '9464 Jacob Hollow
Weaverberg, TN 36706', '+1-252-665-2059x325');
INSERT INTO customer (id, name, address, phone_number) VALUES ('54', 'Michael Howard', '64951 Perez Lake Apt. 188
Vanessaport, AR 77845', '547-123-6968x9247');
INSERT INTO customer (id, name, address, phone_number) VALUES ('55', 'John Hernandez', 'Unit 8842 Box 0904
DPO AP 97006', '(740)100-9122');
INSERT INTO customer (id, name, address, phone_number) VALUES ('56', 'Austin Wright', '2013 Kristin Bridge Apt. 313
Port Randyshire, SC 17504', '220.462.3472');
INSERT INTO customer (id, name, address, phone_number) VALUES ('57', 'Christopher Schmidt', '16138 Evans Gateway
North Lee, NJ 78471', '(746)987-1273');
INSERT INTO customer (id, name, address, phone_number) VALUES ('58', 'Glenda Meadows', '0775 Clark Mill
Deanberg, FM 81542', '406-136-7788x8632');
INSERT INTO customer (id, name, address, phone_number) VALUES ('59', 'Courtney Turner', '9503 Sarah Isle Suite 304
Christopherport, FL 01208', '001-800-586-4457x53110');
INSERT INTO customer (id, name, address, phone_number) VALUES ('60', 'Kathleen Moreno', '151 Megan Grove
Craigshire, WA 96792', '001-691-344-0498x97099');
INSERT INTO customer (id, name, address, phone_number) VALUES ('61', 'Patricia Gonzales', '712 Vasquez Burg Suite 391
West Christopher, WY 62929', '320-002-6625');
INSERT INTO customer (id, name, address, phone_number) VALUES ('62', 'Daniel Smith', '83794 Sanchez Mount Apt. 844
West Jerry, NM 97588', '334.936.8599x32130');
INSERT INTO customer (id, name, address, phone_number) VALUES ('63', 'Ryan Day', 'Unit 1102 Box 8311
DPO AA 62836', '(568)269-4747');
INSERT INTO customer (id, name, address, phone_number) VALUES ('64', 'Monica Frost', 'USNS Williams
FPO AE 96429', '+1-104-472-4497');
INSERT INTO customer (id, name, address, phone_number) VALUES ('65', 'David Harrison', '62307 Leonard Way
Port Brianmouth, NY 27997', '474.814.6833x638');
INSERT INTO customer (id, name, address, phone_number) VALUES ('66', 'Samantha Wheeler', '90549 Kelly Squares Suite 250
South Allison, AS 06376', '+1-026-764-1763');
INSERT INTO customer (id, name, address, phone_number) VALUES ('67', 'Caleb Morse', '3123 Danielle Green
Danielberg, AR 41265', '866-802-6788x38403');
INSERT INTO customer (id, name, address, phone_number) VALUES ('68', 'Carol Wright', '57958 Murphy Summit
Ericshire, CO 18906', '+1-960-692-2241x0331');
INSERT INTO customer (id, name, address, phone_number) VALUES ('69', 'Brandon Bird', '054 Ortiz Isle Apt. 545
Derrickhaven, AR 31777', '(097)321-7746x32056');
INSERT INTO customer (id, name, address, phone_number) VALUES ('70', 'Jason Krueger', '177 Rose Viaduct Suite 957
New Ralphchester, UT 30071', '(559)660-5553');
INSERT INTO customer (id, name, address, phone_number) VALUES ('71', 'Terry Bradshaw', '51697 Shannon Forks Apt. 552
South Jessica, ND 33902', '138.348.0024');
INSERT INTO customer (id, name, address, phone_number) VALUES ('72', 'Julia Patterson', '11986 Angela Shore Apt. 793
Lake Jessica, CO 76982', '152-835-1749x6809');
INSERT INTO customer (id, name, address, phone_number) VALUES ('73', 'Kathleen Kelly', 'USNS Harris
FPO AA 63487', '(224)857-4375');
INSERT INTO customer (id, name, address, phone_number) VALUES ('74', 'Karla Munoz', '8637 Taylor Rapids Apt. 145
Veronicashire, SD 59146', '088-471-6465x915');
INSERT INTO customer (id, name, address, phone_number) VALUES ('75', 'Ronnie Lewis', 'Unit 1831 Box 4931
DPO AP 48019', '544.562.3177x5858');
INSERT INTO customer (id, name, address, phone_number) VALUES ('76', 'Ryan Johnson', '09391 Tanya Wall Suite 906
South Stephen, MH 06502', '340.616.2057');
INSERT INTO customer (id, name, address, phone_number) VALUES ('77', 'Amanda Collins', '0365 Ruth Drive
Port Daniel, WA 98300', '530-424-8865x9216');
INSERT INTO customer (id, name, address, phone_number) VALUES ('78', 'Charles Olson', '956 Rice Garden
Josephbury, VA 31140', '796-464-0760x20945');
INSERT INTO customer (id, name, address, phone_number) VALUES ('79', 'Fernando Mercado', '36609 Michelle Turnpike Apt. 512
Lake Christophermouth, WY 99642', '378.320.2270x4889');
INSERT INTO customer (id, name, address, phone_number) VALUES ('80', 'Christy Hart', '6139 Burns Views
Kristinaton, NY 81318', '992.156.6881x475');
INSERT INTO customer (id, name, address, phone_number) VALUES ('81', 'Scott Lynn', '216 Nelson Turnpike
New Joseph, KS 29699', '317.778.1969x07550');
INSERT INTO customer (id, name, address, phone_number) VALUES ('82', 'Jon Thompson', '226 Eric Fort Suite 583
North Brandon, ND 58095', '074.142.4982x72872');
INSERT INTO customer (id, name, address, phone_number) VALUES ('83', 'William Klein', '757 Bianca Ways
East Jonport, DE 94322', '+1-231-481-9609');
INSERT INTO customer (id, name, address, phone_number) VALUES ('84', 'Nicole Hughes', '357 Guzman Extension Suite 827
Kingport, CA 43240', '018-626-8149');
INSERT INTO customer (id, name, address, phone_number) VALUES ('85', 'Dakota Fowler', '2836 Francisco Lakes Suite 724
Port Matthewport, DC 12115', '185-242-3401');
INSERT INTO customer (id, name, address, phone_number) VALUES ('86', 'Ashley Cruz', 'USNS Mayer
FPO AE 42665', '900-560-2765');
INSERT INTO customer (id, name, address, phone_number) VALUES ('87', 'Alicia Stanton', '76053 Wesley Route Apt. 804
Port Leah, GA 02327', '452.092.6953');
INSERT INTO customer (id, name, address, phone_number) VALUES ('88', 'Hunter Hutchinson', '6989 Gonzalez Villages Apt. 996
Shortside, OR 35770', '001-457-497-1358');
INSERT INTO customer (id, name, address, phone_number) VALUES ('89', 'Marcus Young Jr.', '62791 Wells Terrace
West Alisonmouth, NY 70456', '(768)695-8630x93221');
INSERT INTO customer (id, name, address, phone_number) VALUES ('90', 'Kevin Riley', '5983 Gardner Circle
Rodriguezburgh, AR 12121', '+1-611-036-9548x793');
INSERT INTO customer (id, name, address, phone_number) VALUES ('91', 'Michelle Alvarez', '930 Michael Dale Apt. 234
Jeffreyborough, FM 58467', '(914)846-1924');
INSERT INTO customer (id, name, address, phone_number) VALUES ('92', 'Matthew Williams', '00984 Callahan Pine Apt. 573
New Micheal, MP 12881', '227-838-7702x9270');
INSERT INTO customer (id, name, address, phone_number) VALUES ('93', 'William Reyes', '717 Roberts Greens Apt. 047
Kennedyview, IL 07752', '327-915-9064');
INSERT INTO customer (id, name, address, phone_number) VALUES ('94', 'Jennifer Mitchell', '401 Ryan Key Suite 806
Gentrystad, RI 03942', '(102)098-0065x079');
INSERT INTO customer (id, name, address, phone_number) VALUES ('95', 'Susan Mathews', '6729 Ryan Stream Suite 111
Jasonland, ME 53366', '+1-644-714-3069x74014');
INSERT INTO customer (id, name, address, phone_number) VALUES ('96', 'Dustin Mcguire', '9841 Walters Cliff
East Luis, MT 25592', '001-716-499-2460x68259');
INSERT INTO customer (id, name, address, phone_number) VALUES ('97', 'Katherine Ramirez', '46755 Leonard Park
West Deanchester, WV 68965', '9521171375');
INSERT INTO customer (id, name, address, phone_number) VALUES ('98', 'Eric Trujillo', '1049 Heather Forks Suite 662
Lake Jessica, VT 60486', '(936)392-8784x4594');
INSERT INTO customer (id, name, address, phone_number) VALUES ('99', 'Sean Tanner', '22135 Drew Inlet Suite 736
Schneiderport, RI 06188', '5025576741');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('0', 'PSC 1068, Box 4504
APO AA 77208', '561-813-3698', '17');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('1', '2576 Smith Lakes
New Deborah, TN 59240', '+1-554-332-8638x02333', '72');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('2', '1543 Donald Mount
East Vincent, NV 09244', '8799291458', '97');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('3', '206 Melissa Burg Suite 357
Lake Jamieberg, LA 71488', '060.633.5875x7889', '8');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('4', '5143 Ross Roads Apt. 149
Randallbury, FL 08687', '+1-661-553-3317x0868', '32');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('5', '75132 Jessica Canyon
Philipmouth, WI 31993', '189.440.9937x138', '15');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('6', 'PSC 1513, Box 0534
APO AP 64140', '414-150-8968x097', '63');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('7', '744 Harris Spur
Mcknightton, MI 05802', '(550)541-6035', '97');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('8', '0126 Samuel Falls Suite 246
Port Marie, NV 37663', '+1-911-522-8890x7926', '57');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('9', '5555 Katie Station Apt. 092
New Malik, VT 40491', '(302)702-5194x33043', '60');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('10', '561 Hall Walks
Marcusburgh, OH 24340', '655-357-5658', '83');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('11', '413 Hayley Glens Suite 035
New Michael, MS 50722', '(361)195-0533x52760', '48');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('12', '939 Pope Walk
New Davidville, NY 93281', '(612)920-6946', '26');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('13', '3028 Bradford Extension Suite 076
Moralesmouth, WY 43238', '426.867.6064', '12');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('14', '207 Jeffrey Circle
Port Ricardo, VA 08219', '001-030-535-8832x1021', '62');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('15', '390 Fitzgerald Mews
Allisonside, ND 40358', '9132473302', '3');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('16', '7914 Justin Motorway Apt. 740
Wardhaven, CO 41110', '275-786-3884x979', '49');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('17', '88731 Cortez Manors Suite 896
Jessicaborough, ME 70518', '+1-150-660-3480x62453', '55');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('18', '3972 Trujillo Mission Suite 473
Port Crystal, FM 09930', '5208317486', '77');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('19', '74032 Oneill Estate Apt. 132
Annatown, MS 54992', '216-088-0499', '97');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('20', '6556 William Lake
West Jerry, VT 19013', '704.069.8685x66570', '98');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('21', '76124 Joseph Street Suite 542
Lake Johnathan, FM 86734', '(490)421-9361x94334', '0');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('22', '49875 Tiffany Shores Apt. 638
Denisemouth, SD 07788', '(519)037-0936x8786', '89');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('23', '687 Kathleen Meadows Apt. 814
New Laurenfort, VA 32329', '+1-763-413-2315x9630', '57');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('24', '9650 Ward Spring Suite 185
Port Ryan, NJ 36300', '001-871-431-1650x4188', '34');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('25', '69997 Jason Estate
Anitamouth, CA 84287', '4698137551', '92');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('26', '040 Moore Views Suite 857
Richardsonmouth, UT 19127', '(189)572-6234x8925', '29');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('27', 'USNV Lopez
FPO AA 22645', '+1-429-006-1536x00514', '75');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('28', '667 Samuel Shoals Suite 632
North Sandraview, WV 10100', '001-245-123-8269', '13');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('29', '037 Summers Path
North Michaelstad, MI 23301', '001-971-676-5092x82577', '40');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('30', 'USCGC Cooper
FPO AA 34719', '(742)927-6569x9040', '3');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('31', '01396 Paul Mall Suite 433
New Bradley, VI 48374', '+1-705-332-8968x6059', '2');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('32', '57437 Jordan Junctions Suite 028
Angelaland, AK 24625', '+1-889-444-1284', '3');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('33', 'PSC 0603, Box 1075
APO AA 74482', '530-222-8451x448', '83');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('34', '088 Johns Oval
Christopherchester, ME 47685', '5903019640', '69');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('35', '61293 Tracy Valley Suite 339
North Aaronshire, MI 93553', '655-004-3934x270', '1');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('36', '984 Romero Islands
Chrisberg, AK 62751', '823.589.5498x93354', '48');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('37', '23109 Cynthia Unions
Quinnbury, ND 32729', '(439)127-8523x5590', '87');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('38', '23837 French Estates Suite 236
Debbiechester, CA 29464', '235.287.5188x9169', '27');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('39', '292 Micheal Points
Port Kenneth, HI 50354', '(332)542-0575', '54');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('40', '11616 Adams Road
Morganhaven, AZ 70079', '816.513.1140x28856', '92');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('41', '413 Whitney Street
Mollyport, KY 80574', '(281)010-8612x0352', '3');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('42', '84561 Jones Isle Suite 837
West Michael, VT 81436', '921-699-1942', '67');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('43', '74553 Austin Club Suite 708
Brianbury, CA 62226', '+1-021-824-6340x365', '28');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('44', '9462 Gonzalez Crossroad
Taylorfort, MT 10031', '690-221-0499', '97');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('45', '506 Flynn Via Suite 761
Nathanland, FL 61339', '(909)254-0197x84184', '56');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('46', '496 Amy Groves
Stevemouth, OK 49431', '001-372-759-1903x5442', '63');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('47', '208 Erika Plaza Apt. 077
East Christinaberg, NV 06881', '(627)924-3332', '70');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('48', '4610 Summers Lock Suite 403
Allisonberg, ID 97557', '919-734-3781x68585', '29');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('49', '093 Carrillo Ports Suite 173
Haleshire, AS 58124', '+1-814-378-6266', '44');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('50', 'PSC 3357, Box 0261
APO AP 75310', '754.324.6121x78951', '29');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('51', 'PSC 8624, Box 3245
APO AP 08503', '+1-697-736-6877', '86');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('52', '04862 Jones Causeway Suite 722
Evansland, NC 88054', '989.228.8319x979', '28');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('53', '7575 Nathaniel Ports
Guerreromouth, GA 43084', '606.338.0166x7564', '97');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('54', '35742 David Motorway
Markbury, WV 98899', '262.796.4392x30171', '58');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('55', '96950 Small Lock Suite 976
Elizabethhaven, WV 34578', '+1-563-987-5491x0774', '37');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('56', '09936 Michael Ville Suite 746
Smithhaven, CO 69578', '(058)589-2671x14641', '2');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('57', '49120 Carrie Mission
New Fredhaven, MI 75391', '168-343-7025', '53');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('58', '7892 Monique Centers Apt. 307
West Christopher, FM 08485', '526-286-8870x83387', '71');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('59', '084 Campbell Ridges
Lake Todd, DE 46173', '(268)579-8902x521', '82');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('60', '065 Mooney Skyway Suite 295
East Jennifer, NY 37252', '761.483.0594x4282', '12');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('61', '0354 Craig Ford
Anthonyfurt, NC 11732', '381.664.6447', '23');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('62', '453 Charles Ford
Fitzpatrickmouth, IA 57152', '618.915.2168x9432', '80');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('63', 'PSC 1041, Box 1835
APO AA 92418', '+1-098-388-2098x892', '92');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('64', '491 Solis Branch Suite 904
Huntermouth, AK 93773', '713.843.4009', '37');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('65', '104 Russell Coves Apt. 797
New Nicholasmouth, NY 09261', '670.422.9187x4242', '15');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('66', '797 Stephen Square Apt. 875
South Mike, PA 10002', '+1-365-158-9636x2724', '95');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('67', '5332 Jesus Walk
West Sierramouth, VA 54800', '615.332.2920x28036', '42');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('68', '37884 Lopez Prairie Suite 171
Delacruzstad, VT 60073', '+1-854-512-5157', '92');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('69', '6701 Christian Passage Suite 598
Lake Derrickton, ID 21516', '733-056-9892', '91');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('70', '5898 Summers Village
Washingtonville, OR 33639', '052-937-1653', '64');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('71', '62119 Stacey Skyway Apt. 230
West Joan, MA 70380', '238-475-5227x8491', '54');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('72', '27295 Jerry Land Apt. 770
South Frederickville, CT 68735', '(239)630-1701', '64');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('73', '71445 Goodwin Island Apt. 181
Weberchester, SD 62476', '(288)845-3436x214', '85');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('74', '75695 Jackson Motorway
Gravesstad, AS 02631', '(068)890-3978', '24');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('75', '407 Mitchell Freeway
Angelaburgh, MN 99135', '495-356-8167x1962', '38');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('76', '7093 Aguirre Trail
Douglasport, AL 12455', '+1-123-107-6958', '36');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('77', '542 Johnston River Apt. 616
South Kylechester, PR 77008', '915-500-4941', '75');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('78', '906 Alicia Tunnel Apt. 990
West Joyceview, MI 42957', '+1-655-510-6935x9724', '63');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('79', '3039 Clark Shores Apt. 647
West Ryan, VT 85593', '4107554066', '64');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('80', '6897 Randall Rue
Davidberg, WA 19299', '(756)060-3463x94396', '50');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('81', '37099 Ian Key
Morganmouth, WI 45871', '001-357-394-7093x9139', '75');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('82', '016 Laura Lodge Apt. 705
Weissland, NC 14815', '(785)501-1837', '4');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('83', '73756 Young Lock Apt. 822
Troymouth, MT 44082', '001-735-318-3177x687', '61');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('84', '573 Michael Ferry
Jonesville, FM 10868', '262-155-8347x3408', '31');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('85', '813 Strickland Walks
Ericburgh, ID 17859', '390.860.0734x49120', '95');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('86', '2179 Schmidt Ford
Davidshire, OH 47777', '980.016.3017x31485', '51');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('87', '815 King Valleys Apt. 574
Phillipsfurt, FL 02580', '001-970-408-6517', '53');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('88', '463 Conley Drive
Turnerfurt, MS 08157', '967.952.9432', '85');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('89', '4559 Phillips Oval Suite 458
Codybury, GA 73264', '434-914-2908x34526', '22');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('90', 'Unit 0350 Box 6827
DPO AA 13133', '4328277581', '46');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('91', '2282 Julia Islands Suite 463
Gardnerburgh, MA 18575', '130-458-8884', '70');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('92', '0953 Lance Lock
Austinfort, NV 98601', '(474)929-8125', '89');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('93', '36954 Clark Stream
Edwardport, IA 86721', '+1-488-100-8320x9652', '99');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('94', '252 Christopher Stream Apt. 772
Lake Roy, AR 57648', '+1-897-732-9323x9184', '86');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('95', '0363 Donald Bypass
Bretttown, HI 04764', '666-829-5104x36448', '94');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('96', '4941 William Spurs Suite 527
West Scott, PA 12597', '619.223.9457x8062', '47');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('97', '4768 Vazquez Views
Robertsfort, AS 71409', '(466)335-8886x670', '11');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('98', '031 Acevedo Park Apt. 633
Evanstown, GA 53485', '264-936-6576x53922', '56');
INSERT INTO warehouse (id, address, phone_number, supplier_id) VALUES ('99', '87622 Obrien Station Apt. 436
Port Wendytown, MT 30333', '931-696-5961', '84');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('0', '2013-01-05', '2013-03-31', 'Unit 9083 Box 3903
DPO AP 48067', '97');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('1', '2011-06-01', '2011-07-16', '271 Ford Neck
Willieland, FL 30079', '15');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('2', '2021-02-10', '2021-04-21', 'USS Carlson
FPO AA 98126', '60');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('3', '2018-07-07', '2018-08-15', '168 Hannah Plains
Weekschester, RI 48072', '12');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('4', '2020-12-10', '2020-12-26', '42743 Diana Drives Suite 468
Amandaburgh, MH 00557', '49');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('5', '2019-09-16', '2019-12-15', '5650 Mathews Lodge Suite 583
North Robert, UT 71021', '97');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('6', '2010-01-18', '2010-03-29', 'Unit 9889 Box 0196
DPO AE 70666', '34');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('7', '2015-02-18', '2015-05-17', '56477 Mikayla Camp Apt. 917
East Dianatown, AS 78277', '13');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('8', '2017-02-13', '2017-03-01', 'PSC 5694, Box 4058
APO AA 18774', '2');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('9', '2010-07-28', '2010-10-18', '2072 Rice Skyway Suite 521
West Barbarahaven, ME 24755', '1');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('10', '2018-07-20', '2018-08-29', '61203 Austin Course Suite 913
Barkerborough, NC 19072', '54');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('11', '2010-08-26', '2010-11-14', '9945 Amy Roads Apt. 471
South Jasonborough, PW 74440', '28');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('12', '2019-10-28', '2020-01-12', '83027 Rebecca Gateway
Michaelfurt, MN 21055', '70');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('13', '2015-03-25', '2015-05-21', '64640 Brenda Station Apt. 086
Tammyside, TN 87218', '29');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('14', '2014-11-28', '2015-02-07', '197 Orr Ridge
North Mark, OH 37438', '37');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('15', '2010-06-26', '2010-08-31', '9601 Gibbs Springs
New Anthony, GU 00525', '71');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('16', '2012-03-30', '2012-05-05', '8246 Bryant Plaza Suite 624
Fisherport, SD 99844', '80');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('17', '2016-08-25', '2016-09-22', '316 Williams Meadow
New Nicolestad, VI 78973', '95');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('18', '2017-06-18', '2017-09-03', '40870 Spencer Cliffs Suite 243
South Cassandraville, NY 56722', '54');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('19', '2021-05-22', '2021-06-28', '7717 Erik Ford Suite 979
North Monicamouth, WI 36196', '38');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('20', '2016-05-16', '2016-08-12', '06656 Christopher Course
South Julie, NE 61881', '63');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('21', '2021-05-02', '2021-07-04', '4353 Orr Drive
South Douglasside, MS 11367', '75');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('22', '2010-10-10', '2010-12-23', '495 Jackson Gardens
Andrewton, NC 73870', '31');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('23', '2019-01-25', '2019-04-01', '74422 Sara Spring
Laurenburgh, MN 39290', '85');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('24', '2013-11-18', '2014-01-16', '6384 Cook Landing Apt. 825
Andrewton, UT 56619', '70');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('25', '2018-05-28', '2018-06-21', '695 White Ridges Apt. 985
South Douglas, CT 36393', '56');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('26', '2021-05-28', '2021-06-23', '699 Bryan Street Suite 754
Port Kevin, VA 93355', '99');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('27', '2013-09-03', '2013-11-21', 'Unit 9961 Box 2347
DPO AE 78889', '50');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('28', '2018-04-24', '2018-07-08', '7797 Earl Inlet Suite 485
Turnershire, PR 63068', '93');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('29', '2010-08-31', '2010-11-12', '19173 Brandon Groves Apt. 858
Samanthafurt, KY 24594', '5');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('30', '2016-12-02', '2017-03-03', '84774 Torres Common Apt. 252
Wandaton, MO 28749', '75');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('31', '2018-10-30', '2018-12-03', '81946 Gardner Village
Marymouth, CT 97329', '21');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('32', '2021-04-07', '2021-05-19', '378 Alexandra Point Apt. 334
Harrishaven, WI 06675', '1');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('33', '2014-06-23', '2014-09-13', '34959 Jones Isle Suite 291
Corymouth, AR 83787', '70');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('34', '2015-03-17', '2015-05-20', '127 Robert Club
Freemanfort, MT 85521', '65');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('35', '2017-09-17', '2017-12-12', '4991 Ewing Prairie
West Ryan, MN 01354', '45');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('36', '2020-04-19', '2020-06-05', '58153 Robert Terrace
Elliottport, PW 82587', '84');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('37', '2022-04-17', '2022-07-16', '57511 Russell Common Apt. 893
North Patrick, SC 68474', '93');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('38', '2010-02-16', '2010-04-19', '04039 Sanders Creek
North Beverly, OK 14493', '94');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('39', '2021-06-30', '2021-07-29', '25828 Soto View
Jordanshire, AL 41560', '66');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('40', '2022-08-04', '2022-09-12', '3415 Yvonne Village Suite 056
Port Tylerbury, MS 43573', '54');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('41', '2011-04-05', '2011-06-18', '305 Krista Common Suite 687
South Monique, VT 49921', '46');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('42', '2022-06-08', '2022-07-16', '53291 Mays Park Suite 663
Petersonberg, ME 08224', '64');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('43', '2019-04-10', '2019-06-24', '74467 Gutierrez Prairie Apt. 314
Keymouth, LA 60393', '45');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('44', '2019-04-18', '2019-06-14', 'Unit 4397 Box 5134
DPO AE 33059', '0');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('45', '2022-01-29', '2022-04-21', '685 Miller Viaduct
Yolandaberg, MS 20816', '79');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('46', '2017-06-05', '2017-08-15', 'Unit 5060 Box 5960
DPO AP 04505', '76');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('47', '2010-08-18', '2010-09-29', '69619 Morales Summit
Lake Robert, AR 82861', '81');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('48', '2013-12-22', '2014-03-15', '4456 Garrett Curve
Meaganland, TN 77070', '74');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('49', '2014-01-20', '2014-02-13', '046 Louis Cove Suite 950
South Aaronfort, AL 35592', '70');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('50', '2015-09-23', '2015-10-10', '34917 Edward Turnpike Apt. 883
South Tammy, SC 25527', '86');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('51', '2011-08-01', '2011-08-24', '6547 Stokes Prairie
East Lynn, MH 62241', '2');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('52', '2020-02-28', '2020-03-13', '746 Davis Fall
Harrismouth, VI 40452', '96');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('53', '2016-04-22', '2016-06-05', '28761 Sharon Common Apt. 684
Lake Tinachester, PA 57450', '34');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('54', '2012-06-15', '2012-09-15', '12598 Sawyer Ville
Port Brianburgh, DC 66179', '23');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('55', '2017-09-22', '2017-11-11', 'PSC 3791, Box 7474
APO AP 75961', '8');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('56', '2013-10-03', '2013-11-05', '5545 Ortega Freeway Suite 290
Davidsonfort, MT 26992', '32');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('57', '2021-10-30', '2021-12-03', '7648 Gina Trail
West Kimberlybury, AR 23053', '84');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('58', '2016-02-14', '2016-04-04', '00605 Julie Mission
Romeroland, NM 12191', '58');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('59', '2017-03-22', '2017-06-06', '3139 Stephanie Locks Suite 021
New Bianca, MT 24115', '60');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('60', '2012-07-24', '2012-08-09', '23919 Kimberly Grove Apt. 637
Oliverfurt, WA 47314', '39');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('61', '2018-09-02', '2018-10-28', '3884 Schaefer Haven Suite 072
Port Tara, KY 96672', '53');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('62', '2014-03-21', '2014-05-06', '074 Sherman Mews
Warrenburgh, VA 10749', '13');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('63', '2015-09-08', '2015-11-25', '85323 Danielle Drive Apt. 738
East Susan, OK 85669', '26');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('64', '2019-09-07', '2019-09-22', '317 Walters Loop Apt. 984
Port Georgechester, AK 45792', '28');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('65', '2010-05-27', '2010-07-29', '698 Michael Meadow
East Dawn, LA 79766', '18');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('66', '2010-10-17', '2010-11-19', '8282 Cortez Fields Apt. 819
Jenniferborough, IA 94938', '57');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('67', '2021-05-10', '2021-07-16', '858 William Glen Apt. 290
Port Alexandrastad, PA 80046', '69');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('68', '2014-12-13', '2015-03-02', 'USNS Clarke
FPO AE 92831', '57');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('69', '2015-01-03', '2015-03-24', 'PSC 1502, Box 7648
APO AP 04336', '83');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('70', '2010-09-09', '2010-11-11', '2309 Miguel Turnpike Apt. 459
Kaylabury, FL 02146', '86');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('71', '2017-03-16', '2017-05-22', '70652 Debra Pike Apt. 219
Port Clayton, FM 90634', '7');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('72', '2016-09-12', '2016-10-11', '56640 Johns Turnpike
Desireestad, MS 29986', '27');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('73', '2011-01-24', '2011-03-17', '619 Anderson Pines
Port Catherinehaven, AZ 88052', '9');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('74', '2011-09-19', '2011-11-10', '51544 Cain Lodge Apt. 885
Scotthaven, KY 65945', '38');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('75', '2013-07-20', '2013-09-24', '60987 Vincent Manors Suite 743
Smithmouth, VT 94113', '72');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('76', '2015-08-30', '2015-09-28', '443 Lee Falls Suite 790
East Bradley, NV 77925', '1');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('77', '2022-07-30', '2022-08-16', '10653 Obrien Viaduct Apt. 646
West Matthew, GA 30868', '75');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('78', '2014-11-18', '2015-02-11', '1277 Brooks Vista Suite 788
North John, RI 50950', '58');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('79', '2013-11-06', '2014-02-06', '34731 Rachel Curve Apt. 911
Watsonshire, MN 17442', '65');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('80', '2010-11-03', '2011-01-03', '4501 Lisa Meadows
Kellerside, MS 78807', '25');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('81', '2017-10-13', '2017-11-07', '72605 Perez Mission Suite 440
North Stevenborough, MA 08106', '26');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('82', '2019-09-17', '2019-12-14', '43432 David Lodge
North Thomaston, SC 64835', '24');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('83', '2021-01-16', '2021-02-11', '70188 Bauer Mount
Leefurt, LA 43299', '85');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('84', '2018-10-01', '2018-11-20', '18122 Ballard Divide Suite 802
Lake Dakota, AL 45308', '64');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('85', '2021-03-18', '2021-04-02', '05569 Martin Vista Suite 721
New Faith, WI 60917', '41');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('86', '2019-01-09', '2019-02-27', '17801 Bush Trace Apt. 018
Greenechester, MN 80225', '2');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('87', '2013-07-09', '2013-08-16', '2841 Lisa Inlet Suite 008
Daniellebury, IA 61161', '41');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('88', '2022-08-20', '2022-09-19', 'Unit 3899 Box 5523
DPO AP 79632', '43');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('89', '2019-08-18', '2019-09-27', '079 Debbie Point
Beckermouth, AR 56466', '34');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('90', '2012-02-29', '2012-04-30', '5648 Brandon Gardens Suite 185
Heathermouth, AR 43694', '70');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('91', '2017-09-17', '2017-12-07', '574 Smith Land
Patrickfort, KY 28094', '62');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('92', '2021-12-11', '2022-01-23', 'USS Carpenter
FPO AP 12127', '8');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('93', '2010-11-27', '2010-12-20', '64900 Solomon Rapids
South Laura, MT 55064', '17');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('94', '2013-10-22', '2013-11-25', '2587 Lori Wells Suite 218
Karenfurt, PW 33001', '68');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('95', '2014-10-11', '2014-11-27', '83862 Andrew Walks
Lake Nathan, AL 36851', '97');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('96', '2017-06-14', '2017-09-11', '0108 Rhodes Ranch
Toddmouth, SD 72753', '64');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('97', '2015-09-23', '2015-11-22', '805 Shaun Canyon
Port Stephanie, GU 52024', '43');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('98', '2017-08-19', '2017-09-15', 'USNS Gonzalez
FPO AE 63970', '37');
INSERT INTO freight (id, start_date, end_date, destination, customer_id) VALUES ('99', '2015-04-11', '2015-07-10', '0562 Justin Coves Suite 616
Joneschester, WI 20752', '99');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('0', 'Jeffrey Day', '18724467CAV47', '0', '89');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('1', 'Lori Hall', '47299005YJF40', '28', '97');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('2', 'John Yang', '44222420VOQ19', '37', '15');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('3', 'Chelsea Smith', '78959591HZM93', '4', '61');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('4', 'Rachael Wright', '27415763LNU53', '62', '93');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('5', 'Ashley Porter', '00795315ZUO82', '65', '44');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('6', 'Matthew Ware', '95425907VXT85', '71', '26');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('7', 'Victoria Simmons', '40851543IOQ64', '3', '29');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('8', 'Tamara Norman', '65105890YBW47', '35', '31');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('9', 'Robin Kelley', '27121296QHS41', '39', '49');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('10', 'Kenneth Alvarez', '37227994ZFK09', '57', '90');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('11', 'Evan Benton', '54896645ARU64', '94', '38');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('12', 'Christopher Turner', '12000921ODO85', '27', '72');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('13', 'Pam Johns', '48876020OXP49', '49', '37');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('14', 'Ashley May', '50642188ODL20', '48', '70');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('15', 'Melissa Collins', '38649270EXF76', '32', '47');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('16', 'Kyle Rivers', '31297745UIK39', '18', '16');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('17', 'Zachary Hayes', '36735202XOY42', '5', '37');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('18', 'Jessica Oconnell', '06018029KDE27', '13', '55');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('19', 'Kaitlyn Hart', '93992241QBA92', '76', '40');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('20', 'Julia Sanchez', '43099912QZO66', '33', '23');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('21', 'Jacob Phillips', '53202946QYK33', '40', '74');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('22', 'Brandon Rowe', '83355520GBO00', '81', '1');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('23', 'Dr. Amanda Walker DDS', '27481570YEU98', '40', '39');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('24', 'Bryan Washington', '15928190IXU98', '95', '88');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('25', 'Sharon Phillips', '22508276LLG45', '1', '50');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('26', 'Tammy Stout', '81479906PPD92', '72', '51');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('27', 'Jasmine Cortez', '10413899QFI69', '91', '52');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('28', 'Christopher Shah', '36769297QJN72', '38', '88');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('29', 'Anthony Bennett DDS', '25174016NJE49', '92', '96');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('30', 'Derek Mayer', '74363859NCG17', '10', '17');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('31', 'Alexandra Caldwell', '96960828YXK94', '79', '62');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('32', 'John Smith', '91641227AEL06', '77', '31');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('33', 'Samantha Hill', '82252526UVZ54', '15', '98');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('34', 'Gabriel Carter', '28289050HRS60', '47', '73');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('35', 'Elizabeth Phillips', '84673173OIT51', '48', '48');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('36', 'David Thompson', '20258859MVK79', '39', '89');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('37', 'Robert Garner', '16530344WPT87', '63', '95');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('38', 'Leslie Ortega DDS', '29207173HEB70', '33', '90');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('39', 'Jessica Farmer', '46342152CPB04', '21', '64');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('40', 'Mike Ramos', '71062352IBS96', '59', '65');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('41', 'Alexander Cook', '50279537KKM26', '91', '28');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('42', 'Cameron Carney', '26268849YGG07', '74', '56');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('43', 'Amanda Macdonald', '59194178LIK12', '87', '39');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('44', 'Caleb Rodgers', '02399080TRM57', '78', '56');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('45', 'Scott Miller', '38160343EGV45', '27', '57');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('46', 'Henry Hall', '73599078IJP93', '97', '82');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('47', 'Charles Becker', '19016031MVX00', '16', '5');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('48', 'Kyle Parsons', '97414128ELI22', '81', '31');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('49', 'Mark Walker', '25714669XON75', '84', '8');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('50', 'Dana Trevino', '77772919WWB08', '60', '64');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('51', 'Nicole Whitney', '39054137WAN08', '10', '38');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('52', 'Jessica Fletcher', '03731788HLG53', '43', '65');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('53', 'Michael Black', '79516497VSN88', '37', '95');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('54', 'Terri Montes', '13503508QIH33', '95', '66');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('55', 'Pamela Parker', '55193309MXY98', '10', '74');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('56', 'Stephanie Oliver', '81559777JYQ44', '43', '68');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('57', 'Julia Brady', '50221179QVZ67', '26', '33');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('58', 'Erin Greer', '05687285LPX48', '28', '25');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('59', 'Victor Stephens', '58846597SVZ22', '95', '68');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('60', 'Victoria Griffin', '75448750WLE26', '0', '69');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('61', 'Peter Wallace', '13879555NOV94', '80', '74');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('62', 'Terry Santos', '33555916ZTO34', '84', '96');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('63', 'Ian Brown', '68983473TMI41', '45', '18');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('64', 'Carolyn Wilson', '40128529GNT64', '99', '62');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('65', 'Michelle Phelps', '28944021SCE70', '83', '92');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('66', 'Jeremy Mccarthy', '10490240QYT68', '94', '15');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('67', 'Maria Gill', '96187026WDL64', '50', '14');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('68', 'Aaron Rich', '64167127YNW68', '27', '97');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('69', 'Kerri Spence', '68177387BQH91', '65', '35');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('70', 'Jennifer Garcia', '22124690VNY24', '39', '34');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('71', 'Ms. Andrea King DVM', '44521775LDN51', '97', '27');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('72', 'Blake Hinton', '34311205SOR21', '72', '84');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('73', 'Nicole Mitchell', '84003602RZI65', '2', '15');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('74', 'Jennifer Roth', '31276007CIH00', '17', '51');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('75', 'Kaitlin Johnson', '37603089CYU71', '34', '51');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('76', 'Michael Anderson', '05744932HDP12', '55', '35');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('77', 'Michael Norris', '52254413ROO87', '87', '74');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('78', 'Sheri Gross', '03619182VWI81', '48', '56');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('79', 'Keith Hall', '49126695AVD79', '12', '58');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('80', 'Pamela Vargas', '04623440UQS88', '75', '17');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('81', 'Timothy Miranda', '57575934SYQ19', '20', '14');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('82', 'Tricia Fletcher', '79383697BLJ28', '56', '89');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('83', 'Mr. Robert Wheeler', '26131556XTD54', '26', '49');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('84', 'Brandon Shaffer', '69322932RTJ66', '24', '55');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('85', 'Brian Leach', '45598131ABE76', '36', '19');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('86', 'Christopher Howard', '15124877FSZ52', '54', '20');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('87', 'Heather Anderson', '63279915NLU97', '89', '64');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('88', 'Amanda Taylor', '66527163OQM92', '1', '2');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('89', 'Kimberly Rowe', '93245973NLN41', '50', '89');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('90', 'Linda Robinson MD', '32831587QTI12', '44', '49');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('91', 'Theodore Williams', '24112185FLW55', '50', '91');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('92', 'Hector Bautista', '16070736PDO02', '48', '17');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('93', 'Daniel Hudson', '26938273NCV24', '37', '79');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('94', 'Gerald Carter', '56720838YQC86', '31', '95');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('95', 'Madeline Stevens', '25197839DSG01', '25', '97');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('96', 'Christina Carson', '56520165GKH63', '63', '12');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('97', 'Ann Tran', '68107437VIG07', '54', '56');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('98', 'Kristen Webb', '11583326PTZ30', '5', '78');
INSERT INTO driver (id, name, passport_number, freight_id, shipper_id) VALUES ('99', 'Carolyn Gibson', '11920598KZU86', '50', '34');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('0', '1872-ML6', '15', '12');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('1', '4836-TS4', '48', '29');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('2', '5130-QA6', '45', '27');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('3', '9757-YO5', '16', '86');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('4', '2420-VO1', '13', '80');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('5', '9813-SS6', '34', '85');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('6', '1294-YK0', '32', '31');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('7', '7463-WU5', '7', '56');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('8', '6118-JT7', '4', '39');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('9', '7953-EN0', '14', '69');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('10', '9543-WJ4', '44', '70');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('11', '6738-YY8', '10', '66');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('12', '7294-JO8', '28', '62');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('13', '8405-UI9', '3', '29');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('14', '6510-OW4', '4', '86');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('15', '0847-HG9', '13', '44');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('16', '2129-RQ4', '31', '89');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('17', '3403-KE1', '18', '93');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('18', '5268-AA2', '4', '92');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('19', '9454-VZ8', '30', '28');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('20', '5068-RL4', '10', '27');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('21', '8383-YT6', '38', '32');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('22', '1585-FX7', '12', '99');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('23', '7533-FR6', '39', '24');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('24', '4935-AP6', '20', '2');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('25', '1885-DL4', '45', '12');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('26', '8938-RM8', '17', '8');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('27', '7019-FT9', '34', '32');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('28', '3328-PY7', '10', '74');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('29', '5100-WU2', '23', '14');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('30', '6735-FC4', '25', '37');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('31', '5942-UV0', '41', '85');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('32', '0487-EU9', '28', '20');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('33', '1127-CX6', '36', '37');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('34', '5732-IA4', '48', '76');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('35', '3330-IP7', '9', '32');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('36', '2695-RR4', '13', '69');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('37', '2138-CT1', '43', '73');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('38', '6933-II9', '21', '31');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('39', '3555-GA3', '27', '9');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('40', '2870-AT5', '33', '60');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('41', '8157-CY2', '13', '99');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('42', '1183-SV9', '20', '16');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('43', '8190-IX8', '49', '88');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('44', '2250-WG1', '45', '57');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('45', '8558-LK5', '12', '33');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('46', '4799-AR9', '10', '75');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('47', '1283-KP3', '33', '0');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('48', '1389-YQ3', '17', '40');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('49', '4424-OX4', '43', '28');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('50', '0058-ET3', '21', '38');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('51', '6837-TP1', '40', '65');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('52', '5122-OT0', '33', '87');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('53', '3638-OZ8', '7', '32');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('54', '6299-DU1', '30', '30');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('55', '9384-EI2', '41', '62');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('56', '9164-DH3', '26', '95');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('57', '5955-AZ3', '18', '26');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('58', '1123-TV7', '12', '69');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('59', '3412-WF1', '3', '15');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('60', '5026-SQ1', '34', '47');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('61', '5353-NA7', '47', '57');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('62', '3537-OC6', '26', '26');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('63', '5967-TS3', '31', '76');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('64', '8479-HE9', '44', '67');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('65', '1565-ZI9', '39', '93');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('66', '6909-GZ4', '42', '2');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('67', '4669-UW1', '40', '1');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('68', '3278-OD4', '33', '21');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('69', '4057-KJ7', '3', '21');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('70', '5964-RP3', '35', '26');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('71', '2306-XR7', '34', '71');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('72', '7167-VH9', '49', '29');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('73', '3342-PS4', '41', '90');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('74', '2688-KY3', '19', '24');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('75', '0785-PY2', '40', '33');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('76', '4178-LI6', '17', '14');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('77', '7731-KM1', '13', '5');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('78', '0582-AS9', '30', '43');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('79', '6261-FG7', '26', '96');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('80', '1284-PF4', '23', '63');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('81', '5990-UW5', '26', '74');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('82', '2118-QU0', '2', '49');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('83', '1603-DM4', '2', '4');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('84', '5519-UL3', '3', '63');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('85', '6768-RK4', '18', '82');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('86', '6257-EL8', '42', '66');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('87', '9955-SN1', '47', '34');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('88', '7772-ZD3', '29', '5');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('89', '0084-JZ0', '10', '68');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('90', '0687-XL8', '19', '11');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('91', '2338-BG2', '18', '48');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('92', '8834-GO5', '23', '65');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('93', '7951-QL8', '48', '74');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('94', '7588-HE5', '26', '66');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('95', '3410-HU8', '22', '53');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('96', '2337-NN2', '22', '93');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('97', '3309-MX6', '7', '74');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('98', '8155-ZU9', '49', '43');
INSERT INTO truck (id, registration_number, max_load, driver_id) VALUES ('99', '3964-MZ8', '34', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('0', '0', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1', '0', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('2', '0', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('3', '0', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('4', '1', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('5', '1', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('6', '1', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('7', '1', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('8', '1', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('9', '1', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('10', '1', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('11', '1', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('12', '1', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('13', '1', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('14', '1', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('15', '1', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('16', '1', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('17', '1', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('18', '1', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('19', '1', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('20', '1', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('21', '1', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('22', '1', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('23', '1', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('24', '1', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('25', '1', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('26', '2', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('27', '2', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('28', '2', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('29', '2', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('30', '2', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('31', '2', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('32', '3', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('33', '3', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('34', '3', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('35', '3', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('36', '3', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('37', '3', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('38', '3', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('39', '3', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('40', '3', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('41', '3', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('42', '3', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('43', '3', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('44', '3', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('45', '3', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('46', '3', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('47', '3', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('48', '3', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('49', '3', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('50', '3', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('51', '3', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('52', '3', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('53', '3', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('54', '4', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('55', '4', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('56', '4', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('57', '4', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('58', '4', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('59', '4', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('60', '4', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('61', '4', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('62', '4', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('63', '4', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('64', '4', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('65', '4', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('66', '4', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('67', '4', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('68', '4', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('69', '4', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('70', '4', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('71', '4', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('72', '4', '88');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('73', '4', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('74', '4', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('75', '5', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('76', '5', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('77', '5', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('78', '5', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('79', '5', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('80', '5', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('81', '5', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('82', '5', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('83', '5', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('84', '5', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('85', '5', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('86', '5', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('87', '5', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('88', '5', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('89', '5', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('90', '5', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('91', '5', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('92', '5', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('93', '5', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('94', '5', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('95', '5', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('96', '6', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('97', '6', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('98', '6', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('99', '6', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('100', '6', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('101', '6', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('102', '6', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('103', '6', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('104', '6', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('105', '6', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('106', '6', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('107', '6', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('108', '6', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('109', '7', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('110', '7', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('111', '7', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('112', '7', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('113', '7', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('114', '7', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('115', '7', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('116', '7', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('117', '7', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('118', '7', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('119', '7', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('120', '7', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('121', '7', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('122', '7', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('123', '7', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('124', '7', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('125', '7', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('126', '7', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('127', '7', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('128', '7', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('129', '7', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('130', '7', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('131', '8', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('132', '8', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('133', '8', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('134', '8', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('135', '8', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('136', '8', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('137', '8', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('138', '8', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('139', '8', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('140', '8', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('141', '8', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('142', '8', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('143', '8', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('144', '8', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('145', '8', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('146', '8', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('147', '9', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('148', '9', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('149', '9', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('150', '9', '88');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('151', '9', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('152', '9', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('153', '9', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('154', '9', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('155', '9', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('156', '9', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('157', '9', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('158', '9', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('159', '9', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('160', '9', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('161', '9', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('162', '9', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('163', '9', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('164', '9', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('165', '9', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('166', '9', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('167', '10', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('168', '10', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('169', '10', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('170', '10', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('171', '10', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('172', '10', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('173', '10', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('174', '10', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('175', '10', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('176', '10', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('177', '10', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('178', '11', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('179', '11', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('180', '11', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('181', '11', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('182', '11', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('183', '11', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('184', '11', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('185', '11', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('186', '11', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('187', '12', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('188', '12', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('189', '12', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('190', '12', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('191', '12', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('192', '12', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('193', '12', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('194', '12', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('195', '12', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('196', '12', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('197', '12', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('198', '12', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('199', '12', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('200', '12', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('201', '12', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('202', '13', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('203', '13', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('204', '13', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('205', '13', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('206', '13', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('207', '14', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('208', '14', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('209', '14', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('210', '14', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('211', '14', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('212', '14', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('213', '14', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('214', '15', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('215', '15', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('216', '15', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('217', '15', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('218', '15', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('219', '15', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('220', '15', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('221', '16', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('222', '16', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('223', '16', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('224', '16', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('225', '16', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('226', '16', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('227', '16', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('228', '16', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('229', '16', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('230', '16', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('231', '17', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('232', '17', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('233', '17', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('234', '17', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('235', '17', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('236', '17', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('237', '17', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('238', '17', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('239', '17', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('240', '17', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('241', '18', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('242', '18', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('243', '18', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('244', '18', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('245', '18', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('246', '18', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('247', '18', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('248', '18', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('249', '18', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('250', '18', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('251', '18', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('252', '18', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('253', '19', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('254', '19', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('255', '19', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('256', '19', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('257', '19', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('258', '19', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('259', '19', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('260', '19', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('261', '19', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('262', '19', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('263', '19', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('264', '20', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('265', '20', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('266', '20', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('267', '20', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('268', '20', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('269', '20', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('270', '20', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('271', '20', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('272', '20', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('273', '20', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('274', '20', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('275', '20', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('276', '20', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('277', '20', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('278', '20', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('279', '20', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('280', '20', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('281', '20', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('282', '20', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('283', '20', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('284', '21', '88');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('285', '21', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('286', '21', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('287', '21', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('288', '21', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('289', '21', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('290', '21', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('291', '21', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('292', '21', '88');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('293', '21', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('294', '21', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('295', '21', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('296', '21', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('297', '21', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('298', '21', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('299', '21', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('300', '21', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('301', '21', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('302', '21', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('303', '21', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('304', '21', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('305', '21', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('306', '22', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('307', '22', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('308', '22', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('309', '22', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('310', '22', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('311', '22', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('312', '22', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('313', '22', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('314', '22', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('315', '22', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('316', '22', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('317', '22', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('318', '23', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('319', '23', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('320', '23', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('321', '23', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('322', '23', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('323', '23', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('324', '23', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('325', '23', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('326', '23', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('327', '23', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('328', '24', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('329', '24', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('330', '24', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('331', '24', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('332', '24', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('333', '24', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('334', '24', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('335', '24', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('336', '24', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('337', '24', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('338', '24', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('339', '25', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('340', '25', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('341', '25', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('342', '25', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('343', '25', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('344', '25', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('345', '25', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('346', '25', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('347', '25', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('348', '25', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('349', '25', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('350', '25', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('351', '25', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('352', '25', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('353', '25', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('354', '25', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('355', '26', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('356', '26', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('357', '26', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('358', '26', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('359', '26', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('360', '26', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('361', '26', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('362', '27', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('363', '27', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('364', '27', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('365', '27', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('366', '28', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('367', '28', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('368', '28', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('369', '28', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('370', '28', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('371', '28', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('372', '28', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('373', '28', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('374', '28', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('375', '28', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('376', '28', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('377', '29', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('378', '29', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('379', '29', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('380', '29', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('381', '29', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('382', '29', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('383', '29', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('384', '29', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('385', '30', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('386', '30', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('387', '30', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('388', '30', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('389', '30', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('390', '30', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('391', '30', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('392', '30', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('393', '30', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('394', '30', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('395', '30', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('396', '30', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('397', '30', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('398', '30', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('399', '30', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('400', '30', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('401', '30', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('402', '30', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('403', '30', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('404', '30', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('405', '31', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('406', '31', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('407', '31', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('408', '31', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('409', '31', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('410', '31', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('411', '31', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('412', '31', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('413', '31', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('414', '31', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('415', '31', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('416', '31', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('417', '31', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('418', '31', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('419', '31', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('420', '31', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('421', '31', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('422', '31', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('423', '31', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('424', '31', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('425', '31', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('426', '32', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('427', '32', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('428', '32', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('429', '32', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('430', '32', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('431', '32', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('432', '32', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('433', '32', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('434', '32', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('435', '32', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('436', '32', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('437', '32', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('438', '32', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('439', '32', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('440', '32', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('441', '32', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('442', '32', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('443', '32', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('444', '32', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('445', '32', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('446', '32', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('447', '32', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('448', '33', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('449', '33', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('450', '33', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('451', '33', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('452', '33', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('453', '33', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('454', '33', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('455', '34', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('456', '34', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('457', '34', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('458', '34', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('459', '35', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('460', '35', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('461', '35', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('462', '35', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('463', '35', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('464', '35', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('465', '35', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('466', '35', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('467', '35', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('468', '35', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('469', '35', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('470', '35', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('471', '35', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('472', '35', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('473', '35', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('474', '35', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('475', '36', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('476', '36', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('477', '36', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('478', '36', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('479', '36', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('480', '37', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('481', '37', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('482', '37', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('483', '37', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('484', '38', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('485', '38', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('486', '38', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('487', '38', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('488', '38', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('489', '38', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('490', '38', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('491', '38', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('492', '38', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('493', '38', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('494', '38', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('495', '38', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('496', '38', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('497', '38', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('498', '38', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('499', '38', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('500', '38', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('501', '38', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('502', '38', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('503', '38', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('504', '39', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('505', '39', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('506', '39', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('507', '39', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('508', '39', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('509', '39', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('510', '39', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('511', '39', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('512', '39', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('513', '39', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('514', '39', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('515', '39', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('516', '39', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('517', '39', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('518', '40', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('519', '40', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('520', '40', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('521', '40', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('522', '40', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('523', '40', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('524', '40', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('525', '40', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('526', '40', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('527', '40', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('528', '40', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('529', '40', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('530', '40', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('531', '40', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('532', '41', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('533', '41', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('534', '41', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('535', '41', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('536', '41', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('537', '41', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('538', '41', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('539', '41', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('540', '41', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('541', '41', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('542', '41', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('543', '41', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('544', '41', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('545', '41', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('546', '41', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('547', '41', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('548', '41', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('549', '41', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('550', '41', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('551', '42', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('552', '42', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('553', '42', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('554', '42', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('555', '42', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('556', '42', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('557', '42', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('558', '42', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('559', '42', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('560', '42', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('561', '42', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('562', '43', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('563', '43', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('564', '43', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('565', '43', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('566', '43', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('567', '43', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('568', '43', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('569', '43', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('570', '43', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('571', '43', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('572', '43', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('573', '43', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('574', '43', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('575', '43', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('576', '43', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('577', '43', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('578', '43', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('579', '44', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('580', '44', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('581', '44', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('582', '44', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('583', '44', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('584', '44', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('585', '44', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('586', '44', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('587', '44', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('588', '44', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('589', '44', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('590', '44', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('591', '44', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('592', '44', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('593', '44', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('594', '44', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('595', '44', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('596', '44', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('597', '45', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('598', '45', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('599', '45', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('600', '45', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('601', '45', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('602', '45', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('603', '45', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('604', '45', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('605', '45', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('606', '45', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('607', '45', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('608', '45', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('609', '45', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('610', '45', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('611', '45', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('612', '45', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('613', '46', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('614', '46', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('615', '46', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('616', '46', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('617', '46', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('618', '46', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('619', '46', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('620', '46', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('621', '46', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('622', '46', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('623', '46', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('624', '46', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('625', '46', '88');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('626', '46', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('627', '46', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('628', '46', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('629', '47', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('630', '47', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('631', '47', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('632', '47', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('633', '47', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('634', '47', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('635', '48', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('636', '48', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('637', '48', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('638', '48', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('639', '48', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('640', '49', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('641', '49', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('642', '49', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('643', '49', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('644', '49', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('645', '49', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('646', '49', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('647', '49', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('648', '49', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('649', '49', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('650', '49', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('651', '49', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('652', '49', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('653', '49', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('654', '49', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('655', '49', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('656', '49', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('657', '49', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('658', '49', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('659', '50', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('660', '50', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('661', '50', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('662', '50', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('663', '50', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('664', '50', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('665', '50', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('666', '50', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('667', '50', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('668', '50', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('669', '50', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('670', '50', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('671', '50', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('672', '50', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('673', '50', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('674', '50', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('675', '50', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('676', '50', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('677', '51', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('678', '51', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('679', '51', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('680', '51', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('681', '51', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('682', '51', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('683', '52', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('684', '52', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('685', '52', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('686', '52', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('687', '52', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('688', '52', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('689', '52', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('690', '52', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('691', '52', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('692', '52', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('693', '52', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('694', '52', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('695', '53', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('696', '53', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('697', '53', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('698', '53', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('699', '53', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('700', '53', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('701', '53', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('702', '53', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('703', '53', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('704', '53', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('705', '53', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('706', '53', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('707', '53', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('708', '53', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('709', '53', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('710', '53', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('711', '53', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('712', '53', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('713', '53', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('714', '53', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('715', '53', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('716', '53', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('717', '54', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('718', '54', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('719', '54', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('720', '54', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('721', '54', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('722', '54', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('723', '54', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('724', '54', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('725', '54', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('726', '54', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('727', '54', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('728', '54', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('729', '54', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('730', '54', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('731', '54', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('732', '54', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('733', '55', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('734', '55', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('735', '55', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('736', '55', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('737', '55', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('738', '55', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('739', '55', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('740', '55', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('741', '55', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('742', '55', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('743', '55', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('744', '55', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('745', '55', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('746', '55', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('747', '55', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('748', '55', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('749', '56', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('750', '56', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('751', '56', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('752', '56', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('753', '56', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('754', '56', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('755', '56', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('756', '56', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('757', '56', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('758', '56', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('759', '56', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('760', '56', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('761', '56', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('762', '56', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('763', '56', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('764', '56', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('765', '56', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('766', '56', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('767', '57', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('768', '57', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('769', '57', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('770', '57', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('771', '57', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('772', '57', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('773', '57', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('774', '58', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('775', '58', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('776', '58', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('777', '58', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('778', '58', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('779', '58', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('780', '58', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('781', '58', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('782', '58', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('783', '58', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('784', '58', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('785', '58', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('786', '58', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('787', '58', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('788', '58', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('789', '58', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('790', '58', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('791', '58', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('792', '58', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('793', '58', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('794', '59', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('795', '59', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('796', '59', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('797', '59', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('798', '59', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('799', '59', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('800', '59', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('801', '59', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('802', '59', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('803', '59', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('804', '59', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('805', '59', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('806', '59', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('807', '59', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('808', '59', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('809', '59', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('810', '59', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('811', '59', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('812', '59', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('813', '60', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('814', '60', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('815', '60', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('816', '60', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('817', '60', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('818', '60', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('819', '60', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('820', '60', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('821', '60', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('822', '60', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('823', '60', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('824', '60', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('825', '60', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('826', '60', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('827', '60', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('828', '60', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('829', '60', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('830', '60', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('831', '60', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('832', '61', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('833', '61', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('834', '61', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('835', '61', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('836', '61', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('837', '62', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('838', '62', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('839', '62', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('840', '62', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('841', '62', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('842', '62', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('843', '62', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('844', '62', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('845', '62', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('846', '62', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('847', '62', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('848', '62', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('849', '62', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('850', '62', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('851', '62', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('852', '62', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('853', '62', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('854', '62', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('855', '62', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('856', '62', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('857', '63', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('858', '63', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('859', '63', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('860', '63', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('861', '63', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('862', '63', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('863', '63', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('864', '63', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('865', '63', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('866', '63', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('867', '63', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('868', '63', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('869', '63', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('870', '64', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('871', '64', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('872', '64', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('873', '64', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('874', '64', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('875', '64', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('876', '64', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('877', '64', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('878', '64', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('879', '64', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('880', '64', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('881', '64', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('882', '64', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('883', '64', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('884', '64', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('885', '64', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('886', '65', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('887', '65', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('888', '65', '99');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('889', '65', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('890', '65', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('891', '65', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('892', '65', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('893', '65', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('894', '65', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('895', '65', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('896', '65', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('897', '65', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('898', '66', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('899', '66', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('900', '66', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('901', '66', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('902', '66', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('903', '66', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('904', '66', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('905', '66', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('906', '66', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('907', '66', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('908', '66', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('909', '66', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('910', '66', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('911', '66', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('912', '66', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('913', '66', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('914', '66', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('915', '66', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('916', '66', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('917', '66', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('918', '66', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('919', '66', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('920', '67', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('921', '67', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('922', '67', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('923', '67', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('924', '67', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('925', '67', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('926', '67', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('927', '67', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('928', '67', '51');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('929', '68', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('930', '68', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('931', '68', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('932', '68', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('933', '68', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('934', '68', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('935', '68', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('936', '68', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('937', '68', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('938', '68', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('939', '68', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('940', '68', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('941', '68', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('942', '68', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('943', '69', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('944', '69', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('945', '69', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('946', '69', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('947', '69', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('948', '69', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('949', '69', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('950', '69', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('951', '69', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('952', '69', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('953', '69', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('954', '69', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('955', '69', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('956', '69', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('957', '69', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('958', '69', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('959', '70', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('960', '70', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('961', '70', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('962', '70', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('963', '70', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('964', '70', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('965', '70', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('966', '70', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('967', '70', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('968', '70', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('969', '70', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('970', '70', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('971', '71', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('972', '71', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('973', '71', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('974', '71', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('975', '71', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('976', '71', '17');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('977', '72', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('978', '72', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('979', '72', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('980', '72', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('981', '72', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('982', '73', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('983', '73', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('984', '73', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('985', '73', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('986', '73', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('987', '73', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('988', '73', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('989', '73', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('990', '73', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('991', '73', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('992', '73', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('993', '73', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('994', '73', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('995', '73', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('996', '74', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('997', '74', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('998', '74', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('999', '74', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1000', '74', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1001', '74', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1002', '74', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1003', '74', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1004', '74', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1005', '74', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1006', '74', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1007', '75', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1008', '75', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1009', '75', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1010', '75', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1011', '75', '45');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1012', '75', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1013', '75', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1014', '75', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1015', '75', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1016', '75', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1017', '75', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1018', '75', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1019', '75', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1020', '75', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1021', '75', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1022', '76', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1023', '76', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1024', '76', '10');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1025', '76', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1026', '77', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1027', '77', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1028', '77', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1029', '77', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1030', '77', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1031', '77', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1032', '77', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1033', '77', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1034', '77', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1035', '78', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1036', '78', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1037', '78', '83');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1038', '78', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1039', '78', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1040', '78', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1041', '78', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1042', '78', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1043', '78', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1044', '78', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1045', '78', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1046', '78', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1047', '78', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1048', '78', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1049', '78', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1050', '79', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1051', '79', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1052', '79', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1053', '79', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1054', '79', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1055', '79', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1056', '79', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1057', '79', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1058', '79', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1059', '79', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1060', '79', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1061', '79', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1062', '79', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1063', '79', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1064', '79', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1065', '80', '24');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1066', '80', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1067', '80', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1068', '80', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1069', '80', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1070', '80', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1071', '80', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1072', '80', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1073', '80', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1074', '80', '61');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1075', '80', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1076', '80', '87');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1077', '80', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1078', '80', '73');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1079', '80', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1080', '80', '57');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1081', '80', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1082', '81', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1083', '81', '34');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1084', '81', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1085', '81', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1086', '81', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1087', '81', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1088', '81', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1089', '81', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1090', '81', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1091', '81', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1092', '81', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1093', '81', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1094', '81', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1095', '81', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1096', '81', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1097', '81', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1098', '81', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1099', '81', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1100', '81', '58');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1101', '82', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1102', '82', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1103', '82', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1104', '82', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1105', '82', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1106', '82', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1107', '82', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1108', '82', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1109', '82', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1110', '82', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1111', '82', '49');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1112', '82', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1113', '82', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1114', '82', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1115', '82', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1116', '83', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1117', '83', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1118', '83', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1119', '83', '69');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1120', '83', '94');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1121', '83', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1122', '83', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1123', '83', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1124', '83', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1125', '83', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1126', '83', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1127', '83', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1128', '83', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1129', '83', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1130', '83', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1131', '84', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1132', '84', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1133', '84', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1134', '84', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1135', '84', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1136', '84', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1137', '85', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1138', '85', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1139', '85', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1140', '85', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1141', '85', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1142', '85', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1143', '85', '89');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1144', '85', '88');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1145', '85', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1146', '85', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1147', '85', '98');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1148', '85', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1149', '85', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1150', '86', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1151', '86', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1152', '86', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1153', '86', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1154', '86', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1155', '86', '53');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1156', '86', '67');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1157', '86', '59');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1158', '86', '9');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1159', '86', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1160', '86', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1161', '86', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1162', '86', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1163', '86', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1164', '86', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1165', '86', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1166', '86', '80');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1167', '86', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1168', '86', '31');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1169', '86', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1170', '86', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1171', '86', '48');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1172', '87', '79');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1173', '87', '19');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1174', '87', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1175', '87', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1176', '87', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1177', '87', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1178', '87', '46');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1179', '87', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1180', '87', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1181', '87', '90');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1182', '88', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1183', '88', '63');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1184', '88', '21');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1185', '88', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1186', '88', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1187', '88', '3');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1188', '88', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1189', '88', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1190', '88', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1191', '88', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1192', '88', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1193', '88', '62');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1194', '88', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1195', '89', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1196', '89', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1197', '89', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1198', '89', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1199', '89', '84');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1200', '89', '35');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1201', '89', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1202', '90', '39');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1203', '90', '96');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1204', '90', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1205', '90', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1206', '91', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1207', '91', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1208', '91', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1209', '91', '77');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1210', '91', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1211', '91', '82');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1212', '91', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1213', '91', '33');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1214', '91', '55');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1215', '91', '47');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1216', '91', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1217', '91', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1218', '91', '13');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1219', '91', '76');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1220', '91', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1221', '91', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1222', '91', '65');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1223', '91', '20');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1224', '91', '16');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1225', '92', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1226', '92', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1227', '92', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1228', '92', '0');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1229', '92', '86');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1230', '92', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1231', '92', '54');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1232', '92', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1233', '92', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1234', '92', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1235', '92', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1236', '92', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1237', '92', '1');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1238', '93', '68');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1239', '93', '43');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1240', '93', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1241', '93', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1242', '93', '78');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1243', '94', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1244', '94', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1245', '94', '60');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1246', '94', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1247', '95', '37');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1248', '95', '74');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1249', '95', '70');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1250', '95', '66');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1251', '95', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1252', '95', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1253', '95', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1254', '95', '26');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1255', '95', '50');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1256', '95', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1257', '95', '30');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1258', '95', '71');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1259', '96', '4');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1260', '96', '42');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1261', '96', '41');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1262', '96', '52');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1263', '96', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1264', '96', '2');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1265', '96', '72');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1266', '96', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1267', '96', '64');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1268', '96', '81');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1269', '96', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1270', '96', '97');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1271', '96', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1272', '96', '27');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1273', '96', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1274', '96', '22');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1275', '96', '38');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1276', '96', '12');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1277', '97', '40');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1278', '97', '92');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1279', '97', '18');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1280', '97', '8');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1281', '97', '56');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1282', '98', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1283', '98', '5');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1284', '98', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1285', '98', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1286', '98', '44');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1287', '98', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1288', '98', '75');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1289', '98', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1290', '99', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1291', '99', '29');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1292', '99', '85');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1293', '99', '23');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1294', '99', '15');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1295', '99', '7');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1296', '99', '25');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1297', '99', '6');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1298', '99', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1299', '99', '93');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1300', '99', '14');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1301', '99', '11');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1302', '99', '95');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1303', '99', '28');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1304', '99', '36');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1305', '99', '91');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1306', '99', '32');
INSERT INTO supplier_shipper (id, supplier_id, shipper_id) VALUES ('1307', '99', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('0', '0', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1', '0', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('2', '0', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('3', '0', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('4', '0', '32');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('5', '0', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('6', '0', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('7', '0', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('8', '0', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('9', '0', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('10', '0', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('11', '0', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('12', '0', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('13', '0', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('14', '0', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('15', '0', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('16', '0', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('17', '1', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('18', '1', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('19', '1', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('20', '1', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('21', '1', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('22', '1', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('23', '2', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('24', '2', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('25', '2', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('26', '2', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('27', '2', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('28', '2', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('29', '2', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('30', '3', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('31', '3', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('32', '3', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('33', '3', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('34', '3', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('35', '3', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('36', '3', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('37', '3', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('38', '3', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('39', '3', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('40', '3', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('41', '3', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('42', '3', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('43', '3', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('44', '4', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('45', '4', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('46', '4', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('47', '4', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('48', '4', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('49', '4', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('50', '4', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('51', '4', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('52', '4', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('53', '5', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('54', '5', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('55', '5', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('56', '5', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('57', '5', '32');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('58', '5', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('59', '5', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('60', '5', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('61', '6', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('62', '6', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('63', '6', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('64', '6', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('65', '6', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('66', '6', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('67', '6', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('68', '6', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('69', '6', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('70', '6', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('71', '6', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('72', '6', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('73', '6', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('74', '6', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('75', '7', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('76', '7', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('77', '7', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('78', '7', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('79', '7', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('80', '7', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('81', '8', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('82', '8', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('83', '8', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('84', '8', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('85', '8', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('86', '8', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('87', '8', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('88', '8', '80');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('89', '8', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('90', '8', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('91', '9', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('92', '9', '15');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('93', '9', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('94', '9', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('95', '9', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('96', '9', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('97', '9', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('98', '9', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('99', '9', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('100', '9', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('101', '9', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('102', '9', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('103', '9', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('104', '9', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('105', '10', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('106', '10', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('107', '10', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('108', '10', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('109', '10', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('110', '10', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('111', '10', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('112', '10', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('113', '10', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('114', '10', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('115', '10', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('116', '10', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('117', '10', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('118', '10', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('119', '10', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('120', '10', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('121', '11', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('122', '11', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('123', '11', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('124', '11', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('125', '11', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('126', '11', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('127', '11', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('128', '11', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('129', '12', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('130', '12', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('131', '12', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('132', '12', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('133', '12', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('134', '12', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('135', '12', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('136', '12', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('137', '12', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('138', '12', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('139', '12', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('140', '12', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('141', '12', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('142', '12', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('143', '12', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('144', '12', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('145', '12', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('146', '12', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('147', '12', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('148', '12', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('149', '12', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('150', '13', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('151', '13', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('152', '13', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('153', '13', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('154', '13', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('155', '13', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('156', '13', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('157', '13', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('158', '13', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('159', '13', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('160', '13', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('161', '13', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('162', '13', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('163', '13', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('164', '13', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('165', '13', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('166', '13', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('167', '13', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('168', '13', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('169', '14', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('170', '14', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('171', '14', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('172', '14', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('173', '15', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('174', '15', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('175', '15', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('176', '15', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('177', '15', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('178', '16', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('179', '16', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('180', '16', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('181', '16', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('182', '16', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('183', '16', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('184', '16', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('185', '16', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('186', '17', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('187', '17', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('188', '17', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('189', '17', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('190', '17', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('191', '17', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('192', '17', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('193', '17', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('194', '17', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('195', '17', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('196', '17', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('197', '17', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('198', '17', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('199', '18', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('200', '18', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('201', '18', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('202', '18', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('203', '19', '32');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('204', '19', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('205', '19', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('206', '19', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('207', '19', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('208', '19', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('209', '19', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('210', '19', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('211', '19', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('212', '19', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('213', '19', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('214', '19', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('215', '20', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('216', '20', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('217', '20', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('218', '20', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('219', '20', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('220', '20', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('221', '20', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('222', '20', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('223', '20', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('224', '20', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('225', '20', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('226', '20', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('227', '20', '32');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('228', '20', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('229', '20', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('230', '20', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('231', '20', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('232', '21', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('233', '21', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('234', '21', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('235', '21', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('236', '21', '95');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('237', '21', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('238', '21', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('239', '21', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('240', '21', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('241', '21', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('242', '21', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('243', '21', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('244', '21', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('245', '21', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('246', '21', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('247', '22', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('248', '22', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('249', '22', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('250', '22', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('251', '22', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('252', '22', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('253', '22', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('254', '22', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('255', '22', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('256', '22', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('257', '22', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('258', '23', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('259', '23', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('260', '23', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('261', '23', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('262', '23', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('263', '23', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('264', '23', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('265', '23', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('266', '23', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('267', '23', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('268', '23', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('269', '23', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('270', '23', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('271', '23', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('272', '23', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('273', '23', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('274', '23', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('275', '23', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('276', '23', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('277', '23', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('278', '24', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('279', '24', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('280', '24', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('281', '24', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('282', '24', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('283', '24', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('284', '24', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('285', '24', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('286', '24', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('287', '24', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('288', '24', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('289', '24', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('290', '24', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('291', '24', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('292', '24', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('293', '24', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('294', '24', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('295', '24', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('296', '25', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('297', '25', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('298', '25', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('299', '25', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('300', '25', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('301', '25', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('302', '25', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('303', '25', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('304', '25', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('305', '26', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('306', '26', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('307', '26', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('308', '26', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('309', '26', '15');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('310', '26', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('311', '26', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('312', '26', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('313', '26', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('314', '27', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('315', '27', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('316', '27', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('317', '27', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('318', '27', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('319', '27', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('320', '27', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('321', '27', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('322', '27', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('323', '27', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('324', '27', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('325', '27', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('326', '27', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('327', '27', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('328', '28', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('329', '28', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('330', '28', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('331', '28', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('332', '28', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('333', '28', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('334', '28', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('335', '28', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('336', '28', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('337', '28', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('338', '28', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('339', '28', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('340', '28', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('341', '29', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('342', '29', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('343', '29', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('344', '29', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('345', '29', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('346', '29', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('347', '29', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('348', '30', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('349', '30', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('350', '30', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('351', '30', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('352', '30', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('353', '30', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('354', '30', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('355', '30', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('356', '30', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('357', '30', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('358', '30', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('359', '30', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('360', '30', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('361', '30', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('362', '30', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('363', '30', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('364', '30', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('365', '30', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('366', '31', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('367', '31', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('368', '31', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('369', '31', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('370', '31', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('371', '31', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('372', '31', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('373', '31', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('374', '31', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('375', '31', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('376', '31', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('377', '31', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('378', '31', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('379', '31', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('380', '31', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('381', '31', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('382', '31', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('383', '31', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('384', '31', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('385', '31', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('386', '32', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('387', '32', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('388', '32', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('389', '32', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('390', '32', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('391', '32', '42');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('392', '33', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('393', '33', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('394', '33', '95');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('395', '33', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('396', '33', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('397', '33', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('398', '33', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('399', '34', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('400', '34', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('401', '34', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('402', '34', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('403', '34', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('404', '34', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('405', '34', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('406', '34', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('407', '34', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('408', '34', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('409', '34', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('410', '34', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('411', '34', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('412', '34', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('413', '35', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('414', '35', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('415', '35', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('416', '35', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('417', '35', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('418', '35', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('419', '35', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('420', '35', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('421', '36', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('422', '36', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('423', '36', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('424', '36', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('425', '36', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('426', '36', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('427', '36', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('428', '37', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('429', '37', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('430', '37', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('431', '37', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('432', '37', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('433', '37', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('434', '37', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('435', '37', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('436', '37', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('437', '37', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('438', '37', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('439', '37', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('440', '38', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('441', '38', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('442', '38', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('443', '38', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('444', '38', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('445', '38', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('446', '38', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('447', '38', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('448', '38', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('449', '38', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('450', '38', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('451', '38', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('452', '38', '15');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('453', '38', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('454', '38', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('455', '38', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('456', '39', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('457', '39', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('458', '39', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('459', '39', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('460', '39', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('461', '39', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('462', '39', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('463', '39', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('464', '39', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('465', '39', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('466', '39', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('467', '39', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('468', '39', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('469', '39', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('470', '39', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('471', '39', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('472', '39', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('473', '39', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('474', '39', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('475', '40', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('476', '40', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('477', '40', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('478', '40', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('479', '40', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('480', '40', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('481', '40', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('482', '40', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('483', '40', '42');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('484', '40', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('485', '41', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('486', '41', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('487', '41', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('488', '41', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('489', '42', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('490', '42', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('491', '42', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('492', '42', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('493', '42', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('494', '42', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('495', '42', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('496', '42', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('497', '42', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('498', '42', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('499', '42', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('500', '42', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('501', '42', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('502', '42', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('503', '42', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('504', '42', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('505', '42', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('506', '43', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('507', '43', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('508', '43', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('509', '43', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('510', '43', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('511', '43', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('512', '43', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('513', '43', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('514', '43', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('515', '43', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('516', '43', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('517', '44', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('518', '44', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('519', '44', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('520', '44', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('521', '44', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('522', '44', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('523', '44', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('524', '44', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('525', '44', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('526', '44', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('527', '44', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('528', '44', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('529', '44', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('530', '44', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('531', '44', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('532', '45', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('533', '45', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('534', '45', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('535', '45', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('536', '45', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('537', '45', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('538', '45', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('539', '45', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('540', '45', '15');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('541', '45', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('542', '45', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('543', '45', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('544', '45', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('545', '45', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('546', '45', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('547', '45', '42');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('548', '45', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('549', '45', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('550', '45', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('551', '45', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('552', '46', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('553', '46', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('554', '46', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('555', '46', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('556', '46', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('557', '46', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('558', '46', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('559', '46', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('560', '46', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('561', '46', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('562', '46', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('563', '46', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('564', '46', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('565', '46', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('566', '47', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('567', '47', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('568', '47', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('569', '47', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('570', '47', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('571', '47', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('572', '48', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('573', '48', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('574', '48', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('575', '48', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('576', '48', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('577', '48', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('578', '48', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('579', '48', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('580', '48', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('581', '48', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('582', '48', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('583', '48', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('584', '48', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('585', '48', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('586', '48', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('587', '49', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('588', '49', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('589', '49', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('590', '49', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('591', '50', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('592', '50', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('593', '50', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('594', '50', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('595', '50', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('596', '50', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('597', '50', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('598', '50', '42');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('599', '50', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('600', '50', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('601', '50', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('602', '50', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('603', '51', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('604', '51', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('605', '51', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('606', '51', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('607', '51', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('608', '51', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('609', '51', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('610', '51', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('611', '51', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('612', '51', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('613', '51', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('614', '51', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('615', '51', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('616', '51', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('617', '51', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('618', '51', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('619', '51', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('620', '51', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('621', '51', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('622', '51', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('623', '52', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('624', '52', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('625', '52', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('626', '52', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('627', '52', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('628', '52', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('629', '52', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('630', '52', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('631', '52', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('632', '52', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('633', '52', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('634', '53', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('635', '53', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('636', '53', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('637', '53', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('638', '53', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('639', '53', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('640', '53', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('641', '53', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('642', '53', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('643', '54', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('644', '54', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('645', '54', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('646', '54', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('647', '54', '95');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('648', '54', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('649', '54', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('650', '54', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('651', '54', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('652', '54', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('653', '54', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('654', '54', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('655', '54', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('656', '54', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('657', '54', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('658', '55', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('659', '55', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('660', '55', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('661', '55', '15');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('662', '55', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('663', '55', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('664', '55', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('665', '56', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('666', '56', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('667', '56', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('668', '56', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('669', '56', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('670', '56', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('671', '56', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('672', '56', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('673', '56', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('674', '56', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('675', '56', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('676', '56', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('677', '56', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('678', '56', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('679', '56', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('680', '57', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('681', '57', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('682', '57', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('683', '57', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('684', '57', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('685', '57', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('686', '57', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('687', '57', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('688', '57', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('689', '57', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('690', '57', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('691', '57', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('692', '57', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('693', '57', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('694', '57', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('695', '57', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('696', '57', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('697', '57', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('698', '57', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('699', '57', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('700', '58', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('701', '58', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('702', '58', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('703', '58', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('704', '58', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('705', '58', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('706', '58', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('707', '58', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('708', '58', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('709', '58', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('710', '58', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('711', '58', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('712', '58', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('713', '58', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('714', '58', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('715', '58', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('716', '58', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('717', '58', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('718', '58', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('719', '58', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('720', '58', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('721', '58', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('722', '59', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('723', '59', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('724', '59', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('725', '59', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('726', '59', '80');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('727', '59', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('728', '59', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('729', '59', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('730', '59', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('731', '59', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('732', '59', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('733', '59', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('734', '59', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('735', '59', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('736', '59', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('737', '59', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('738', '59', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('739', '59', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('740', '59', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('741', '59', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('742', '59', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('743', '59', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('744', '60', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('745', '60', '95');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('746', '60', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('747', '60', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('748', '60', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('749', '60', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('750', '60', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('751', '60', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('752', '60', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('753', '60', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('754', '60', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('755', '60', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('756', '60', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('757', '60', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('758', '60', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('759', '60', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('760', '60', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('761', '60', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('762', '60', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('763', '60', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('764', '61', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('765', '61', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('766', '61', '80');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('767', '61', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('768', '61', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('769', '61', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('770', '61', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('771', '61', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('772', '61', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('773', '61', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('774', '61', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('775', '61', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('776', '61', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('777', '61', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('778', '61', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('779', '61', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('780', '62', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('781', '62', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('782', '62', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('783', '62', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('784', '62', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('785', '62', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('786', '62', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('787', '63', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('788', '63', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('789', '63', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('790', '63', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('791', '63', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('792', '63', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('793', '63', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('794', '63', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('795', '63', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('796', '63', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('797', '63', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('798', '63', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('799', '63', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('800', '63', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('801', '63', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('802', '63', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('803', '63', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('804', '63', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('805', '63', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('806', '63', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('807', '63', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('808', '63', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('809', '64', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('810', '64', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('811', '64', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('812', '64', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('813', '64', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('814', '64', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('815', '64', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('816', '64', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('817', '64', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('818', '64', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('819', '64', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('820', '64', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('821', '64', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('822', '64', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('823', '64', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('824', '64', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('825', '65', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('826', '65', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('827', '65', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('828', '65', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('829', '65', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('830', '65', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('831', '65', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('832', '65', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('833', '65', '15');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('834', '65', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('835', '65', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('836', '65', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('837', '65', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('838', '65', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('839', '65', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('840', '65', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('841', '65', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('842', '65', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('843', '65', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('844', '65', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('845', '65', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('846', '65', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('847', '66', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('848', '66', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('849', '66', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('850', '66', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('851', '66', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('852', '66', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('853', '66', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('854', '66', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('855', '66', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('856', '66', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('857', '66', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('858', '66', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('859', '66', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('860', '66', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('861', '66', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('862', '66', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('863', '66', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('864', '66', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('865', '66', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('866', '66', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('867', '66', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('868', '66', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('869', '67', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('870', '67', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('871', '67', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('872', '67', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('873', '67', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('874', '68', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('875', '68', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('876', '68', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('877', '68', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('878', '68', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('879', '68', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('880', '68', '46');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('881', '68', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('882', '68', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('883', '68', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('884', '68', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('885', '68', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('886', '68', '32');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('887', '68', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('888', '68', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('889', '69', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('890', '69', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('891', '69', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('892', '69', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('893', '69', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('894', '69', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('895', '69', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('896', '69', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('897', '69', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('898', '69', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('899', '69', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('900', '69', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('901', '69', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('902', '69', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('903', '69', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('904', '69', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('905', '69', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('906', '69', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('907', '69', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('908', '69', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('909', '70', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('910', '70', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('911', '70', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('912', '70', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('913', '70', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('914', '70', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('915', '70', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('916', '70', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('917', '70', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('918', '70', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('919', '70', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('920', '70', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('921', '70', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('922', '70', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('923', '70', '42');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('924', '70', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('925', '71', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('926', '71', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('927', '71', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('928', '71', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('929', '71', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('930', '71', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('931', '71', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('932', '71', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('933', '71', '82');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('934', '71', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('935', '71', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('936', '72', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('937', '72', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('938', '72', '53');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('939', '72', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('940', '72', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('941', '72', '80');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('942', '72', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('943', '72', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('944', '72', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('945', '72', '16');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('946', '72', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('947', '72', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('948', '72', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('949', '72', '78');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('950', '72', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('951', '72', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('952', '72', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('953', '73', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('954', '73', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('955', '73', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('956', '73', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('957', '73', '54');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('958', '73', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('959', '73', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('960', '73', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('961', '73', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('962', '73', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('963', '74', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('964', '74', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('965', '74', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('966', '74', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('967', '74', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('968', '74', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('969', '74', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('970', '74', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('971', '75', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('972', '75', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('973', '75', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('974', '75', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('975', '75', '96');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('976', '75', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('977', '75', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('978', '76', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('979', '76', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('980', '76', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('981', '76', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('982', '76', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('983', '76', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('984', '76', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('985', '76', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('986', '77', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('987', '77', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('988', '77', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('989', '77', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('990', '77', '62');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('991', '77', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('992', '77', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('993', '77', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('994', '78', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('995', '78', '7');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('996', '78', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('997', '78', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('998', '79', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('999', '79', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1000', '79', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1001', '79', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1002', '79', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1003', '79', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1004', '80', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1005', '80', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1006', '80', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1007', '80', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1008', '80', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1009', '81', '74');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1010', '81', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1011', '81', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1012', '81', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1013', '81', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1014', '82', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1015', '82', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1016', '82', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1017', '82', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1018', '82', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1019', '82', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1020', '82', '80');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1021', '82', '45');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1022', '82', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1023', '82', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1024', '82', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1025', '82', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1026', '82', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1027', '82', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1028', '82', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1029', '82', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1030', '82', '89');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1031', '82', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1032', '82', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1033', '82', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1034', '82', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1035', '83', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1036', '83', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1037', '83', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1038', '83', '0');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1039', '83', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1040', '83', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1041', '83', '32');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1042', '83', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1043', '83', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1044', '83', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1045', '83', '30');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1046', '83', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1047', '83', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1048', '83', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1049', '84', '25');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1050', '84', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1051', '84', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1052', '84', '70');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1053', '84', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1054', '84', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1055', '84', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1056', '84', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1057', '84', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1058', '84', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1059', '84', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1060', '84', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1061', '84', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1062', '84', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1063', '84', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1064', '84', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1065', '85', '98');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1066', '85', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1067', '85', '92');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1068', '85', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1069', '85', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1070', '85', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1071', '85', '83');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1072', '85', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1073', '85', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1074', '85', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1075', '85', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1076', '85', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1077', '85', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1078', '86', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1079', '86', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1080', '86', '91');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1081', '86', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1082', '86', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1083', '86', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1084', '86', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1085', '87', '58');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1086', '87', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1087', '87', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1088', '87', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1089', '87', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1090', '87', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1091', '87', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1092', '87', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1093', '87', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1094', '88', '77');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1095', '88', '37');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1096', '88', '39');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1097', '88', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1098', '88', '44');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1099', '88', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1100', '88', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1101', '88', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1102', '88', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1103', '88', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1104', '88', '80');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1105', '88', '99');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1106', '88', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1107', '88', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1108', '88', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1109', '88', '9');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1110', '88', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1111', '88', '57');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1112', '88', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1113', '88', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1114', '89', '31');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1115', '89', '86');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1116', '89', '14');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1117', '89', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1118', '89', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1119', '89', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1120', '89', '81');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1121', '90', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1122', '90', '76');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1123', '90', '87');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1124', '90', '85');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1125', '90', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1126', '90', '56');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1127', '90', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1128', '90', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1129', '91', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1130', '91', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1131', '91', '22');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1132', '91', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1133', '91', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1134', '91', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1135', '91', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1136', '91', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1137', '91', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1138', '91', '17');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1139', '91', '41');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1140', '91', '73');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1141', '91', '10');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1142', '91', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1143', '91', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1144', '91', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1145', '91', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1146', '91', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1147', '91', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1148', '91', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1149', '91', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1150', '92', '33');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1151', '92', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1152', '92', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1153', '92', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1154', '92', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1155', '92', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1156', '92', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1157', '92', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1158', '92', '35');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1159', '92', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1160', '92', '23');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1161', '92', '97');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1162', '92', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1163', '92', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1164', '92', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1165', '93', '79');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1166', '93', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1167', '93', '67');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1168', '93', '3');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1169', '93', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1170', '93', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1171', '93', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1172', '93', '18');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1173', '94', '40');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1174', '94', '50');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1175', '94', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1176', '94', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1177', '94', '93');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1178', '94', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1179', '94', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1180', '94', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1181', '94', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1182', '94', '88');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1183', '94', '4');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1184', '95', '71');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1185', '95', '52');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1186', '95', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1187', '95', '49');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1188', '95', '69');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1189', '95', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1190', '95', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1191', '95', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1192', '96', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1193', '96', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1194', '96', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1195', '96', '48');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1196', '96', '38');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1197', '96', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1198', '96', '2');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1199', '96', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1200', '96', '34');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1201', '96', '24');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1202', '97', '66');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1203', '97', '94');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1204', '97', '68');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1205', '97', '20');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1206', '97', '29');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1207', '97', '11');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1208', '97', '26');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1209', '97', '61');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1210', '97', '21');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1211', '97', '6');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1212', '97', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1213', '97', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1214', '97', '36');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1215', '97', '1');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1216', '97', '19');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1217', '97', '12');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1218', '97', '5');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1219', '97', '90');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1220', '97', '75');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1221', '97', '55');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1222', '97', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1223', '98', '27');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1224', '98', '72');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1225', '98', '59');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1226', '98', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1227', '98', '13');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1228', '98', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1229', '98', '51');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1230', '98', '28');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1231', '98', '8');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1232', '99', '43');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1233', '99', '64');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1234', '99', '60');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1235', '99', '63');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1236', '99', '65');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1237', '99', '84');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1238', '99', '47');
INSERT INTO warehouse_product (id, warehouse_id, product_id) VALUES ('1239', '99', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('0', '0', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1', '0', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('2', '0', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('3', '0', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('4', '0', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('5', '0', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('6', '0', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('7', '0', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('8', '0', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('9', '0', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('10', '0', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('11', '0', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('12', '0', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('13', '0', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('14', '0', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('15', '0', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('16', '0', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('17', '0', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('18', '0', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('19', '0', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('20', '0', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('21', '0', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('22', '1', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('23', '1', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('24', '1', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('25', '1', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('26', '1', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('27', '1', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('28', '1', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('29', '1', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('30', '1', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('31', '1', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('32', '1', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('33', '1', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('34', '1', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('35', '1', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('36', '1', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('37', '1', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('38', '1', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('39', '1', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('40', '2', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('41', '2', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('42', '2', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('43', '2', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('44', '2', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('45', '2', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('46', '2', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('47', '2', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('48', '3', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('49', '3', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('50', '3', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('51', '3', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('52', '3', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('53', '3', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('54', '3', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('55', '3', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('56', '3', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('57', '3', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('58', '3', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('59', '4', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('60', '4', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('61', '4', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('62', '4', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('63', '4', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('64', '4', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('65', '5', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('66', '5', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('67', '5', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('68', '5', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('69', '5', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('70', '5', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('71', '5', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('72', '5', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('73', '5', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('74', '5', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('75', '5', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('76', '5', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('77', '5', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('78', '6', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('79', '6', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('80', '6', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('81', '6', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('82', '6', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('83', '6', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('84', '6', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('85', '7', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('86', '7', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('87', '7', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('88', '7', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('89', '8', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('90', '8', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('91', '8', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('92', '8', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('93', '8', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('94', '8', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('95', '8', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('96', '8', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('97', '8', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('98', '9', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('99', '9', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('100', '9', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('101', '9', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('102', '9', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('103', '9', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('104', '9', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('105', '9', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('106', '9', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('107', '9', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('108', '9', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('109', '10', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('110', '10', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('111', '10', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('112', '10', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('113', '10', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('114', '10', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('115', '10', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('116', '10', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('117', '10', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('118', '11', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('119', '11', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('120', '11', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('121', '11', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('122', '11', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('123', '11', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('124', '11', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('125', '11', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('126', '11', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('127', '11', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('128', '11', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('129', '11', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('130', '11', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('131', '11', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('132', '11', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('133', '11', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('134', '11', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('135', '11', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('136', '11', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('137', '11', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('138', '12', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('139', '12', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('140', '12', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('141', '12', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('142', '12', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('143', '12', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('144', '12', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('145', '12', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('146', '12', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('147', '12', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('148', '12', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('149', '12', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('150', '12', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('151', '12', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('152', '12', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('153', '12', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('154', '12', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('155', '12', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('156', '12', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('157', '12', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('158', '12', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('159', '12', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('160', '13', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('161', '13', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('162', '13', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('163', '13', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('164', '13', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('165', '13', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('166', '13', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('167', '13', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('168', '13', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('169', '13', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('170', '13', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('171', '13', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('172', '13', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('173', '13', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('174', '13', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('175', '14', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('176', '14', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('177', '14', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('178', '14', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('179', '15', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('180', '15', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('181', '15', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('182', '15', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('183', '15', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('184', '15', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('185', '15', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('186', '15', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('187', '15', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('188', '15', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('189', '15', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('190', '15', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('191', '15', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('192', '15', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('193', '15', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('194', '15', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('195', '16', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('196', '16', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('197', '16', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('198', '16', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('199', '16', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('200', '16', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('201', '17', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('202', '17', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('203', '17', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('204', '17', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('205', '18', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('206', '18', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('207', '18', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('208', '18', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('209', '18', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('210', '18', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('211', '18', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('212', '18', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('213', '18', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('214', '18', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('215', '18', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('216', '18', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('217', '18', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('218', '18', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('219', '18', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('220', '18', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('221', '18', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('222', '18', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('223', '18', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('224', '19', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('225', '19', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('226', '19', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('227', '19', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('228', '19', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('229', '19', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('230', '19', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('231', '19', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('232', '19', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('233', '19', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('234', '19', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('235', '19', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('236', '19', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('237', '19', '8');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('238', '19', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('239', '19', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('240', '19', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('241', '20', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('242', '20', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('243', '20', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('244', '20', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('245', '20', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('246', '20', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('247', '20', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('248', '20', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('249', '20', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('250', '20', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('251', '20', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('252', '20', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('253', '20', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('254', '20', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('255', '20', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('256', '20', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('257', '20', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('258', '20', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('259', '20', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('260', '20', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('261', '20', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('262', '20', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('263', '21', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('264', '21', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('265', '21', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('266', '21', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('267', '21', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('268', '21', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('269', '21', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('270', '21', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('271', '22', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('272', '22', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('273', '22', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('274', '22', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('275', '22', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('276', '22', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('277', '22', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('278', '22', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('279', '22', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('280', '22', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('281', '22', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('282', '22', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('283', '22', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('284', '22', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('285', '22', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('286', '22', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('287', '22', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('288', '22', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('289', '22', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('290', '22', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('291', '22', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('292', '23', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('293', '23', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('294', '23', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('295', '23', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('296', '23', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('297', '23', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('298', '23', '8');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('299', '23', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('300', '24', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('301', '24', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('302', '24', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('303', '24', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('304', '24', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('305', '24', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('306', '24', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('307', '24', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('308', '24', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('309', '25', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('310', '25', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('311', '25', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('312', '25', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('313', '25', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('314', '25', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('315', '25', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('316', '25', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('317', '25', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('318', '25', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('319', '25', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('320', '25', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('321', '26', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('322', '26', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('323', '26', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('324', '26', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('325', '27', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('326', '27', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('327', '27', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('328', '27', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('329', '27', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('330', '28', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('331', '28', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('332', '28', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('333', '28', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('334', '28', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('335', '28', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('336', '28', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('337', '28', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('338', '28', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('339', '28', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('340', '28', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('341', '28', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('342', '28', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('343', '28', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('344', '28', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('345', '28', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('346', '28', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('347', '28', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('348', '29', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('349', '29', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('350', '29', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('351', '29', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('352', '29', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('353', '29', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('354', '29', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('355', '30', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('356', '30', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('357', '30', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('358', '30', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('359', '30', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('360', '30', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('361', '30', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('362', '30', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('363', '30', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('364', '30', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('365', '30', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('366', '30', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('367', '30', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('368', '30', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('369', '30', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('370', '30', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('371', '30', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('372', '30', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('373', '30', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('374', '30', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('375', '30', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('376', '31', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('377', '31', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('378', '31', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('379', '31', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('380', '31', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('381', '31', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('382', '31', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('383', '31', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('384', '31', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('385', '31', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('386', '31', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('387', '31', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('388', '32', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('389', '32', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('390', '32', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('391', '32', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('392', '32', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('393', '32', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('394', '32', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('395', '32', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('396', '32', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('397', '32', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('398', '32', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('399', '32', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('400', '32', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('401', '32', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('402', '32', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('403', '32', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('404', '33', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('405', '33', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('406', '33', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('407', '33', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('408', '33', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('409', '33', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('410', '33', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('411', '33', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('412', '33', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('413', '33', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('414', '33', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('415', '33', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('416', '33', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('417', '34', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('418', '34', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('419', '34', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('420', '34', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('421', '34', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('422', '34', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('423', '34', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('424', '34', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('425', '34', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('426', '34', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('427', '34', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('428', '34', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('429', '34', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('430', '34', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('431', '34', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('432', '34', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('433', '34', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('434', '34', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('435', '35', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('436', '35', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('437', '35', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('438', '35', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('439', '35', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('440', '36', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('441', '36', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('442', '36', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('443', '36', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('444', '36', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('445', '36', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('446', '36', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('447', '36', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('448', '36', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('449', '36', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('450', '36', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('451', '36', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('452', '36', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('453', '36', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('454', '36', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('455', '36', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('456', '36', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('457', '36', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('458', '36', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('459', '36', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('460', '36', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('461', '37', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('462', '37', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('463', '37', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('464', '37', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('465', '37', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('466', '37', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('467', '38', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('468', '38', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('469', '38', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('470', '38', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('471', '38', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('472', '38', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('473', '38', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('474', '38', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('475', '38', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('476', '38', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('477', '38', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('478', '38', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('479', '38', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('480', '39', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('481', '39', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('482', '39', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('483', '39', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('484', '39', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('485', '39', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('486', '39', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('487', '39', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('488', '40', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('489', '40', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('490', '40', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('491', '40', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('492', '40', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('493', '40', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('494', '40', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('495', '40', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('496', '40', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('497', '40', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('498', '40', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('499', '40', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('500', '40', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('501', '40', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('502', '40', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('503', '40', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('504', '40', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('505', '41', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('506', '41', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('507', '41', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('508', '41', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('509', '41', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('510', '41', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('511', '41', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('512', '41', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('513', '41', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('514', '41', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('515', '41', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('516', '41', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('517', '41', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('518', '41', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('519', '41', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('520', '41', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('521', '41', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('522', '41', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('523', '41', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('524', '42', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('525', '42', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('526', '42', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('527', '42', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('528', '42', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('529', '42', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('530', '42', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('531', '42', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('532', '42', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('533', '42', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('534', '42', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('535', '43', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('536', '43', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('537', '43', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('538', '43', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('539', '43', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('540', '43', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('541', '43', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('542', '43', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('543', '43', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('544', '43', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('545', '43', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('546', '43', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('547', '43', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('548', '43', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('549', '43', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('550', '43', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('551', '43', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('552', '43', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('553', '43', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('554', '44', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('555', '44', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('556', '44', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('557', '44', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('558', '44', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('559', '44', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('560', '44', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('561', '44', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('562', '44', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('563', '44', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('564', '44', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('565', '44', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('566', '44', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('567', '44', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('568', '45', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('569', '45', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('570', '45', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('571', '45', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('572', '45', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('573', '45', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('574', '45', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('575', '45', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('576', '45', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('577', '45', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('578', '45', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('579', '45', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('580', '45', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('581', '45', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('582', '46', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('583', '46', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('584', '46', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('585', '46', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('586', '46', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('587', '46', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('588', '46', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('589', '46', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('590', '46', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('591', '46', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('592', '47', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('593', '47', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('594', '47', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('595', '47', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('596', '47', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('597', '47', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('598', '47', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('599', '47', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('600', '47', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('601', '47', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('602', '47', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('603', '47', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('604', '48', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('605', '48', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('606', '48', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('607', '48', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('608', '48', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('609', '48', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('610', '48', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('611', '48', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('612', '48', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('613', '48', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('614', '48', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('615', '48', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('616', '48', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('617', '48', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('618', '48', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('619', '49', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('620', '49', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('621', '49', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('622', '49', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('623', '49', '8');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('624', '49', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('625', '49', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('626', '49', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('627', '49', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('628', '49', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('629', '49', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('630', '49', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('631', '49', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('632', '50', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('633', '50', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('634', '50', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('635', '50', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('636', '50', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('637', '50', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('638', '50', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('639', '50', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('640', '50', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('641', '50', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('642', '50', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('643', '50', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('644', '50', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('645', '50', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('646', '50', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('647', '50', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('648', '50', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('649', '50', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('650', '50', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('651', '51', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('652', '51', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('653', '51', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('654', '51', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('655', '51', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('656', '51', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('657', '51', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('658', '51', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('659', '51', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('660', '51', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('661', '51', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('662', '51', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('663', '51', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('664', '52', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('665', '52', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('666', '52', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('667', '52', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('668', '52', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('669', '52', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('670', '52', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('671', '52', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('672', '52', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('673', '52', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('674', '52', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('675', '52', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('676', '52', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('677', '52', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('678', '52', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('679', '52', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('680', '52', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('681', '52', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('682', '52', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('683', '53', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('684', '53', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('685', '53', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('686', '53', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('687', '53', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('688', '53', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('689', '53', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('690', '53', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('691', '53', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('692', '53', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('693', '54', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('694', '54', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('695', '54', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('696', '54', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('697', '54', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('698', '54', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('699', '54', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('700', '54', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('701', '54', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('702', '54', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('703', '54', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('704', '54', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('705', '54', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('706', '54', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('707', '55', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('708', '55', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('709', '55', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('710', '55', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('711', '56', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('712', '56', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('713', '56', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('714', '56', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('715', '56', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('716', '56', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('717', '56', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('718', '56', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('719', '56', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('720', '56', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('721', '56', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('722', '56', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('723', '57', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('724', '57', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('725', '57', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('726', '57', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('727', '57', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('728', '57', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('729', '57', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('730', '58', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('731', '58', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('732', '58', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('733', '58', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('734', '58', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('735', '58', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('736', '58', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('737', '58', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('738', '58', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('739', '58', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('740', '58', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('741', '58', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('742', '58', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('743', '58', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('744', '58', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('745', '58', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('746', '58', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('747', '58', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('748', '58', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('749', '58', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('750', '58', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('751', '58', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('752', '59', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('753', '59', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('754', '59', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('755', '59', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('756', '59', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('757', '59', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('758', '59', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('759', '59', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('760', '59', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('761', '59', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('762', '60', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('763', '60', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('764', '60', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('765', '60', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('766', '60', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('767', '60', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('768', '60', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('769', '60', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('770', '60', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('771', '60', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('772', '60', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('773', '60', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('774', '61', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('775', '61', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('776', '61', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('777', '61', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('778', '61', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('779', '61', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('780', '61', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('781', '61', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('782', '61', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('783', '61', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('784', '62', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('785', '62', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('786', '62', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('787', '62', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('788', '62', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('789', '62', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('790', '62', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('791', '62', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('792', '62', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('793', '62', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('794', '62', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('795', '62', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('796', '62', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('797', '62', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('798', '62', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('799', '62', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('800', '63', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('801', '63', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('802', '63', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('803', '63', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('804', '63', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('805', '63', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('806', '63', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('807', '63', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('808', '63', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('809', '63', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('810', '63', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('811', '63', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('812', '63', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('813', '63', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('814', '63', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('815', '63', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('816', '63', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('817', '63', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('818', '63', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('819', '63', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('820', '63', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('821', '63', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('822', '64', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('823', '64', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('824', '64', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('825', '64', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('826', '64', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('827', '64', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('828', '64', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('829', '64', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('830', '64', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('831', '64', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('832', '64', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('833', '65', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('834', '65', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('835', '65', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('836', '65', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('837', '65', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('838', '65', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('839', '65', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('840', '65', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('841', '65', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('842', '65', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('843', '65', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('844', '65', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('845', '66', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('846', '66', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('847', '66', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('848', '66', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('849', '66', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('850', '66', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('851', '66', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('852', '66', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('853', '66', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('854', '66', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('855', '66', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('856', '66', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('857', '66', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('858', '66', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('859', '66', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('860', '66', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('861', '66', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('862', '66', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('863', '66', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('864', '66', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('865', '66', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('866', '66', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('867', '67', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('868', '67', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('869', '67', '32');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('870', '67', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('871', '67', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('872', '67', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('873', '67', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('874', '67', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('875', '67', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('876', '67', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('877', '67', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('878', '68', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('879', '68', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('880', '68', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('881', '68', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('882', '68', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('883', '68', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('884', '68', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('885', '68', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('886', '68', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('887', '68', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('888', '68', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('889', '68', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('890', '68', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('891', '68', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('892', '68', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('893', '68', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('894', '68', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('895', '68', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('896', '68', '7');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('897', '69', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('898', '69', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('899', '69', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('900', '69', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('901', '69', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('902', '69', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('903', '70', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('904', '70', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('905', '70', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('906', '70', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('907', '70', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('908', '70', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('909', '70', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('910', '70', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('911', '70', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('912', '70', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('913', '70', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('914', '70', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('915', '70', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('916', '71', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('917', '71', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('918', '71', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('919', '71', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('920', '71', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('921', '71', '37');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('922', '71', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('923', '71', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('924', '71', '93');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('925', '71', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('926', '71', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('927', '71', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('928', '71', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('929', '71', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('930', '71', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('931', '71', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('932', '71', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('933', '71', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('934', '71', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('935', '72', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('936', '72', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('937', '72', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('938', '72', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('939', '72', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('940', '73', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('941', '73', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('942', '73', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('943', '73', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('944', '73', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('945', '73', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('946', '73', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('947', '73', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('948', '73', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('949', '73', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('950', '73', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('951', '73', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('952', '73', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('953', '73', '21');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('954', '73', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('955', '73', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('956', '73', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('957', '73', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('958', '73', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('959', '74', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('960', '74', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('961', '74', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('962', '74', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('963', '74', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('964', '75', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('965', '75', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('966', '75', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('967', '75', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('968', '75', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('969', '75', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('970', '75', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('971', '75', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('972', '76', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('973', '76', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('974', '76', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('975', '76', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('976', '76', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('977', '77', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('978', '77', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('979', '77', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('980', '77', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('981', '77', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('982', '77', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('983', '78', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('984', '78', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('985', '78', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('986', '78', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('987', '78', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('988', '78', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('989', '78', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('990', '78', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('991', '79', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('992', '79', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('993', '79', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('994', '79', '8');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('995', '79', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('996', '79', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('997', '79', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('998', '79', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('999', '79', '87');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1000', '79', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1001', '79', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1002', '79', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1003', '79', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1004', '79', '78');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1005', '79', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1006', '79', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1007', '79', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1008', '79', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1009', '79', '8');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1010', '79', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1011', '79', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1012', '80', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1013', '80', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1014', '80', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1015', '80', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1016', '80', '35');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1017', '80', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1018', '80', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1019', '80', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1020', '80', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1021', '80', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1022', '80', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1023', '80', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1024', '80', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1025', '80', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1026', '80', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1027', '80', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1028', '80', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1029', '80', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1030', '80', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1031', '80', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1032', '80', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1033', '80', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1034', '81', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1035', '81', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1036', '81', '86');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1037', '81', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1038', '81', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1039', '81', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1040', '81', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1041', '81', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1042', '81', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1043', '81', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1044', '81', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1045', '81', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1046', '81', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1047', '81', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1048', '81', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1049', '82', '84');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1050', '82', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1051', '82', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1052', '82', '73');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1053', '82', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1054', '82', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1055', '82', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1056', '82', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1057', '82', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1058', '83', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1059', '83', '68');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1060', '83', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1061', '83', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1062', '83', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1063', '83', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1064', '83', '77');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1065', '83', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1066', '83', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1067', '83', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1068', '83', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1069', '83', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1070', '83', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1071', '83', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1072', '83', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1073', '83', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1074', '83', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1075', '83', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1076', '83', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1077', '83', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1078', '83', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1079', '84', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1080', '84', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1081', '84', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1082', '84', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1083', '84', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1084', '85', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1085', '85', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1086', '85', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1087', '85', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1088', '85', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1089', '85', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1090', '85', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1091', '85', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1092', '85', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1093', '85', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1094', '85', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1095', '85', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1096', '85', '13');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1097', '86', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1098', '86', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1099', '86', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1100', '86', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1101', '86', '20');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1102', '86', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1103', '86', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1104', '86', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1105', '86', '62');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1106', '87', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1107', '87', '54');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1108', '87', '3');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1109', '87', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1110', '87', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1111', '87', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1112', '87', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1113', '87', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1114', '87', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1115', '87', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1116', '87', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1117', '87', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1118', '87', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1119', '87', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1120', '87', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1121', '88', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1122', '88', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1123', '88', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1124', '88', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1125', '88', '56');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1126', '88', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1127', '88', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1128', '88', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1129', '88', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1130', '88', '18');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1131', '89', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1132', '89', '48');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1133', '89', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1134', '89', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1135', '89', '65');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1136', '89', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1137', '89', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1138', '89', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1139', '89', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1140', '89', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1141', '89', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1142', '89', '26');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1143', '90', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1144', '90', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1145', '90', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1146', '90', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1147', '90', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1148', '91', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1149', '91', '25');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1150', '91', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1151', '91', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1152', '91', '43');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1153', '91', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1154', '91', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1155', '91', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1156', '91', '61');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1157', '92', '64');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1158', '92', '30');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1159', '92', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1160', '92', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1161', '92', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1162', '92', '15');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1163', '92', '98');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1164', '92', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1165', '92', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1166', '92', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1167', '92', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1168', '92', '79');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1169', '92', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1170', '92', '11');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1171', '92', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1172', '92', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1173', '92', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1174', '92', '58');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1175', '92', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1176', '92', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1177', '92', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1178', '92', '92');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1179', '93', '69');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1180', '93', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1181', '93', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1182', '93', '17');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1183', '93', '40');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1184', '93', '85');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1185', '93', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1186', '93', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1187', '94', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1188', '94', '24');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1189', '94', '51');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1190', '94', '59');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1191', '94', '10');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1192', '94', '50');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1193', '94', '46');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1194', '94', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1195', '94', '36');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1196', '94', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1197', '94', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1198', '94', '45');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1199', '94', '47');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1200', '94', '80');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1201', '94', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1202', '94', '12');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1203', '94', '57');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1204', '94', '97');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1205', '95', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1206', '95', '89');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1207', '95', '22');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1208', '95', '38');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1209', '95', '94');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1210', '95', '83');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1211', '95', '28');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1212', '95', '95');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1213', '95', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1214', '95', '42');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1215', '95', '27');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1216', '95', '5');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1217', '95', '6');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1218', '95', '2');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1219', '95', '90');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1220', '95', '23');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1221', '96', '41');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1222', '96', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1223', '96', '4');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1224', '96', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1225', '96', '75');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1226', '96', '67');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1227', '96', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1228', '96', '8');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1229', '96', '91');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1230', '96', '81');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1231', '96', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1232', '96', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1233', '96', '16');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1234', '96', '96');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1235', '96', '52');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1236', '96', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1237', '96', '34');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1238', '96', '63');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1239', '97', '49');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1240', '97', '14');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1241', '97', '39');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1242', '97', '88');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1243', '97', '53');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1244', '98', '29');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1245', '98', '66');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1246', '98', '74');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1247', '98', '55');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1248', '98', '72');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1249', '98', '33');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1250', '98', '1');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1251', '98', '0');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1252', '98', '19');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1253', '98', '99');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1254', '98', '60');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1255', '99', '44');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1256', '99', '9');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1257', '99', '76');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1258', '99', '31');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1259', '99', '71');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1260', '99', '82');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1261', '99', '70');
INSERT INTO freight_product (id, freight_id, product_id) VALUES ('1262', '99', '19');
