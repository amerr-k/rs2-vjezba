CREATE TABLE Business (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(255) NOT NULL,
    [Address] NVARCHAR(255),
    [ContactInfo] NVARCHAR(255),
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Business_Id PRIMARY KEY ([Id])
);

CREATE TABLE QRTable (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [BusinessId] INT NOT NULL,
    [QRCode] NVARCHAR(255),
    [TableNumber] INT,
    [Capacity] INT,
    [LocationDescription] NVARCHAR(MAX), 
    [IsTaken] BIT DEFAULT 0 NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_QRTable_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_QRTable_BusinessId FOREIGN KEY (BusinessId) REFERENCES Business(Id)
);

CREATE TABLE UserAccount (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Username] NVARCHAR(255) UNIQUE,
    [PasswordSalt] NVARCHAR(255),
    [PasswordHash] NVARCHAR(255),
    [Email] NVARCHAR(100) UNIQUE NOT NULL,
    [FirstName] NVARCHAR(50) NOT NULL,
    [LastName] NVARCHAR(50) NOT NULL,
    [Registered] BIT,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_UserAccount_Id PRIMARY KEY ([Id]),
);

CREATE TABLE UserRole (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Code] NVARCHAR(255) NOT NULL UNIQUE,
    [Name] NVARCHAR(255) NOT NULL UNIQUE,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_UserRole_Id PRIMARY KEY ([Id]),
);

CREATE TABLE UserAccountUserRole (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [UserAccountId] INT NOT NULL,
    [UserRoleId] INT NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_UserAccountUserRole_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_UserAccountUserRole_UserAccountId FOREIGN KEY (UserAccountId) REFERENCES [UserAccount](Id),
    CONSTRAINT FK_UserAccountUserRole_UserRoleId FOREIGN KEY (UserRoleId) REFERENCES [UserRole](Id)
);

CREATE TABLE Customer (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [UserAccountId] INT NOT NULL,
    [PenaltyPoints] INT,
    [Address] NVARCHAR(255),
    [Phone] NVARCHAR(20),
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Customer_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_Customer_UserAccountId FOREIGN KEY (UserAccountId) REFERENCES UserAccount(Id)
);

CREATE TABLE Employee (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [UserAccountId] INT NOT NULL,
    [BusinessId] INT NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Employee_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_Employee_UserAccountId FOREIGN KEY (UserAccountId) REFERENCES UserAccount(Id),
    CONSTRAINT FK_Employee_BusinessId FOREIGN KEY (BusinessId) REFERENCES Business(Id),
);

CREATE TABLE Category (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Code] NVARCHAR(255) NOT NULL UNIQUE,
    [Name] NVARCHAR(255) NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Category_Id PRIMARY KEY ([Id])
);

CREATE TABLE Menu (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [BusinessId] INT NOT NULL,
    [Name] NVARCHAR(255),
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Menu_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_Menu_BusinessId FOREIGN KEY (BusinessId) REFERENCES Business(Id)
);

CREATE TABLE MenuItem (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [Code] NVARCHAR(255) NOT NULL,
    [MenuId] INT NOT NULL,
    [CategoryId] INT NULL,
    [Name] VARCHAR(255) NOT NULL,
    [Description] NVARCHAR(MAX),
    [Price] DECIMAL(18, 2),
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT FK_MenuItem_MenuId FOREIGN KEY (MenuId) REFERENCES Menu(Id),
    CONSTRAINT FK_MenuItem_CategoryId FOREIGN KEY (CategoryId) REFERENCES Category(Id),
    CONSTRAINT PK_MenuItem_Id PRIMARY KEY ([Id]),
    CONSTRAINT UC_Code UNIQUE (MenuId,Code)
);



CREATE TABLE [Order] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [CustomerId] INT,
    [PurchaseInvoiceId] INT NOT NULL,
    [MenuItemId] INT NOT NULL,
    [OrderDateTime] DATETIME2 NOT NULL,
    [TotalAmount] DECIMAL(18, 2),
    [TotalAmountWithVAT] DECIMAL(18, 2) NOT NULL,
    [VAT] DECIMAL(18, 2),
    [VATAmount] DECIMAL(18, 2),
    [Status] NVARCHAR(255) NOT NULL, 
    [QRTableId] INT NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Order_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_Order_CustomerId FOREIGN KEY (CustomerId) REFERENCES Customer(Id),
    CONSTRAINT FK_Order_QRTableId  FOREIGN KEY (QRTableId) REFERENCES QRTable(Id)
);

CREATE TABLE [OrderItem] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [OrderId] INT NOT NULL,
    [MenuItemId] INT NOT NULL,
    [Quantity] INT NOT NULL,
    [Subtotal] DECIMAL(18, 2),
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_OrderItem_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_OrderItem_OrderId FOREIGN KEY (OrderId) REFERENCES [Order](Id),
    CONSTRAINT FK_OrderItem_MenuItemId FOREIGN KEY (MenuItemId) REFERENCES MenuItem(Id)
);

CREATE TABLE SaleInvoice (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [InvoiceNumber] NVARCHAR(255) NOT NULL,
    [SaleDate] DATETIME2 NOT NULL,
    [Concluded] BIT,
    [TotalAmount] DECIMAL(18, 2),
    [TotalAmountWithVAT] DECIMAL(18, 2),
    [VAT] DECIMAL(18, 2),
    [VATAmount] DECIMAL(18, 2),
    [EmployeeId] INT NOT NULL,
    [CustomerId] INT NULL,
    [OrderId] INT NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
	CONSTRAINT PK_SaleInvoice_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_SaleInvoice_EmployeeId  FOREIGN KEY (EmployeeId) REFERENCES [Employee](Id),
    CONSTRAINT FK_SaleInvoice_OrderId FOREIGN KEY (OrderId) REFERENCES [Order](Id),
);

CREATE TABLE SaleInvoiceItem (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [SaleInvoiceId] INT NOT NULL,
    [MenuItemId] INT NOT NULL,
    [Quantity] INT NOT NULL,
    [Price] DECIMAL(18, 2),
    [Discount] DECIMAL(18, 2),
    [Valid] BIT DEFAULT 1 NOT NULL,
	CONSTRAINT PK_SaleInvoiceItem_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_SaleInvoiceItem_SaleInvoiceId  FOREIGN KEY (SaleInvoiceId) REFERENCES [SaleInvoice](Id),
    CONSTRAINT FK_SaleInvoiceItem_MenuItemId  FOREIGN KEY (MenuItemId) REFERENCES [MenuItem](Id)
);

CREATE TABLE Reservation (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [QRTableId] INT NOT NULL,
    [CustomerId] INT NOT NULL,
    [ContactInfo] NVARCHAR(255),
    [SpecialRequest] NVARCHAR(255),
    [StartTime] DATETIME2 NOT NULL,
    [EndTime] DATETIME2, /* Korisnik opcionalno unosi vrijeme kraja */
    [Status] NVARCHAR(50), /* Confirmed, ConfirmationPending, OnHold, Cancelled (OnHold korisnika stavlja sistem jer je rezervisao sto koji mozda neće biti slobodan) */ 
    [Valid] BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_Reservation_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_Reservation_QRTableId FOREIGN KEY (QRTableId) REFERENCES [QRTable](Id),
    CONSTRAINT FK_Reservation_CustomerId FOREIGN KEY (CustomerId) REFERENCES [Customer](Id)
);

CREATE TABLE PurchaseInvoice (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [InvoiceNumber] NVARCHAR(255) NOT NULL,
    [PurchaseDate] DATETIME2 NOT NULL,
    [TotalAmount] DECIMAL(18, 2) NOT NULL,
    [TotalAmountWithVAT] DECIMAL(18, 2) NOT NULL,
    [VAT] DECIMAL(18, 2),
    [Note] NVARCHAR(255),
    [EmployeeId] INT NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
	CONSTRAINT PK_PurchaseInvoice_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_PurchaseInvoice_EmployeeId  FOREIGN KEY (EmployeeId) REFERENCES Employee(Id),
);

CREATE TABLE PurchaseInvoiceItem (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [PurchaseInvoiceId] INT NOT NULL,
    [MenuItemId] INT NOT NULL,
    [Quantity] INT NOT NULL,
    [Price] DECIMAL(18, 2) NOT NULL,
    [Valid] BIT DEFAULT 1 NOT NULL,
	CONSTRAINT PK_PurchaseInvoiceItem_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_PurchaseInvoiceItem_PurchaseInvoiceId  FOREIGN KEY (PurchaseInvoiceId) REFERENCES PurchaseInvoice(Id),
    CONSTRAINT FK_PurchaseInvoiceItem_MenuItemId  FOREIGN KEY (MenuItemId) REFERENCES MenuItem(Id)
)





