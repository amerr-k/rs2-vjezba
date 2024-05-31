/*INSERT CATEGORIES*/

USE [spsp_db]
GO

INSERT INTO [dbo].[Category]([Name],[Valid])
     VALUES ('Bezalkoholna pića', 1),
	 ('Alkoholna pića', 1),
	 ('Gazirani sokovi', 1),
	 ('Prirodni sokovi', 1),
	 ('Kokteli', 1),
	 ('Pivo', 1),
	 ('Vina', 1),
	 ('Jela po narudžbi', 1),
	 ('Ostalo', 1)
GO

/*INSERT BUSINESS */

INSERT INTO [dbo].[Business]([Name],[Address],[ContactInfo],[Valid])
     VALUES('Pivnica - Još Finija Raja', 'Ulica Alije Sirotanovića', '123-456-7890', 1);

/*INSERT MENU */

INSERT INTO [dbo].[Menu]([BusinessId],[Name],[Valid])
     VALUES(IDENT_CURRENT('[dbo].[Business]'), 'Glavni meni - Verzija 1', 1);

/*-----CUSTOMER AND EMPLOYEE-----*/

/*CUSTOMER*/

INSERT INTO [dbo].[UserAccount]([Username],[PasswordHash], [PasswordSalt],[Email],[FirstName],[LastName],[Valid])
     VALUES('kupac', 'paswordhash', 'paswordsalt', 'jasminka@gmail.com', 'Jasminka', 'Hozić Seferović', 1)         
INSERT INTO [dbo].[Customer]([UserAccountId],[Address],[Phone],[Valid])
     VALUES(IDENT_CURRENT('[dbo].[UserAccount]'), 'Ulica ljubitelja motora srednje kubikaže', '123-456-7890', 1)
GO

/*EMPLOYEE*/

INSERT INTO [dbo].[UserAccount]([Username],[PasswordHash], [PasswordSalt],[Email],[FirstName],[LastName],[Valid])
     VALUES('radnik1', 'passwordhash', 'passwordsalt', 'radnik1@gmail.com', 'Muzafer', 'Kuršlak', 1)         
INSERT INTO [dbo].[Employee]([UserAccountId],[IsAdmin],[Valid])
     VALUES(IDENT_CURRENT('[dbo].[UserAccount]'), 1, 1)
GO

/*INSERT QR TABLE */

INSERT INTO [dbo].[QRTable]
           ([BusinessId],[QRCode],[TableNumber],[Capacity],[LocationDescription],[IsTaken],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Business]'), 'QR CODE 1', 1, 4, 'Prvi dio', 0, 1);
INSERT INTO [dbo].[QRTable]
           ([BusinessId],[QRCode],[TableNumber],[Capacity],[LocationDescription],[IsTaken],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Business]'), 'QR CODE 2', 2, 4, 'Srednji dio', 0, 1);
INSERT INTO [dbo].[QRTable]
           ([BusinessId],[QRCode],[TableNumber],[Capacity],[LocationDescription],[IsTaken],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Business]'), 'QR CODE 3', 3, 4, 'Uz prozore', 0, 1);

/*--------------------------INSERT ORDER 1--------------------------------------*/

INSERT INTO [dbo].[Order]
           ([CustomerId],[EmployeeId],[OrderDateTime],[TotalAmount],[Status],[QRTableId],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Customer]'), NULL, '2024-02-24T08:00:00', 14.00, 'Pending', IDENT_CURRENT('[dbo].[QRTable]'), 1);

/*----------*/

/*-----MENU ITEM AND ORDER ITEM 1 -----*/

/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Bezalkoholna pića'), 'Sky Cola', 'Meni nema bolje Kole, SKY KOLE', 2.5, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 2, 5, 1);


/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Pivo'), 'Zaječarsko pivo', 'Ožedni i napij se', 3, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 3, 9, 1);

/*------------------------SECOND QR TABLE-----------------------------------*/

INSERT INTO [dbo].[QRTable]
           ([BusinessId],[QRCode],[TableNumber],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Business]'), 'QR CODE 4', 4, 1);

/*------------------------------------INSERT ORDER 2------------------------*/

INSERT INTO [dbo].[Order]
           ([CustomerId],[EmployeeId],[OrderDateTime],[TotalAmount],[Status],[QRTableId],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Customer]'), IDENT_CURRENT('[dbo].[Employee]'), '2024-02-24T08:00:00', 14.50, 'Completed', IDENT_CURRENT('[dbo].[QRTable]'), 1);

/*----------*/

/*-----MENU ITEM AND ORDER ITEM 2 -----*/

/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Bezalkoholna pića'), 'Senzacija Kruška', 'Nema gore senzacije', 1.5, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 2, 3, 1);


/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Pivo'), 'Sarajevsko pivo', 'Ne moraš biti žedan da bi je popio', 3.5, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 3, 11.5, 1);

/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Jela po narudžbi'), 'Pekarski krompir', 'Beton krompir', 4, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 3, 15.5, 1);

/*------------------------THIRD QR TABLE-----------------------------------*/

INSERT INTO [dbo].[QRTable]
           ([BusinessId],[QRCode],[TableNumber],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Business]'), 'QR CODE 5', 5, 1);

/*------------------------------------INSERT ORDER 3------------------------*/

INSERT INTO [dbo].[Order]
           ([CustomerId],[EmployeeId],[OrderDateTime],[TotalAmount],[Status],[QRTableId],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Customer]'), IDENT_CURRENT('[dbo].[Employee]'), '2024-02-24T08:00:00', 8, 'Completed', IDENT_CURRENT('[dbo].[QRTable]'), 1);

/*----------*/

/*-----MENU ITEM AND ORDER ITEM 3 -----*/

/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Jela po narudžbi'), 'Ljute kobasice sa roštilja', 'Odličan primjerak, do juče se šetalo livadom' , 1.5, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 2, 4, 1);

/*INSERT MENU ITEM */

INSERT INTO [dbo].[MenuItem]
           ([MenuId],[CategoryId],[Name],[Description],[Price],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Menu]'), (SELECT c.Id FROM Category c WHERE c.Name = 'Pivo'), 'Tuzlanski pilsner', 'Cijela Tuzla jedno piće pila', 2, 1);

/*INSERT ORDER ITEM*/
INSERT INTO [dbo].[OrderItem]
           ([OrderId],[MenuItemId],[Quantity],[Subtotal],[Valid])
     VALUES
           (IDENT_CURRENT('[dbo].[Order]'), IDENT_CURRENT('[dbo].[MenuItem]'), 2, 4, 1);

GO

/*INSERT RESERVATION*/
