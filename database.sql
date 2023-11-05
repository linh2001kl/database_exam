CREATE DATABASE Ecommerce_Application;
USE Ecommerce_Application;

CREATE TABLE Catalog(
	CatalogID CHAR(5) PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    Description TEXT,
    StatusCatalog BIT NOT NULL
);
ALTER TABLE Catalog CHANGE ProductName CatalogName VARCHAR(255) NOT NULL;
-- DROP TABLE Catalog;
CREATE TABLE Product (
	ProductId CHAR(5) PRIMARY KEY,
    ProductName VARCHAR(50) UNIQUE NOT NULL,
    PurchasePrice REAL NOT NULL CHECK (PurchasePrice > 0), -- Giá nhập
    SellingPrice REAL NOT NULL CHECK (SellingPrice>0), -- giá xuất
    ProductTitle VARCHAR(255), -- mô tả ngắn gọn sản phẩm
    ProductDescription TEXT, -- mô tả chi tiết
    QuantityInStock INT CHECK(QuantityInStock >= 0), --  Số lượng sản phẩm hiện
    StatusProduct ENUM ('Bán', 'Không bán', 'Hết hàng'),
    CatalogID CHAR(5) NOT NULL,
    FOREIGN KEY (CatalogID) REFERENCES Catalog(CatalogID)
);
-- DROP TABLE Product;

CREATE TABLE User (
	UserId CHAR(5) PRIMARY KEY, 
    Username VARCHAR(50) NOT NULL,
    Passwordd VARCHAR(50) NOT NULL,
	Email VARCHAR(100), 
    PhoneNumber VARCHAR(15), 
    Address VARCHAR(255), 
    DateOfBirth DATE 
);

CREATE TABLE Invoice ( -- Hóa đơn
	InvoiceId CHAR(5) PRIMARY KEY,
    CreateDate DATE NOT NULL,
    UserId CHAR(5) NOT NULL,
    StatusInvoice ENUM ('Đang đặt', 'Đã duyệt', 'Đang chuyển hàng', 'Đã nhận hàng', 'Hoàn tất') NOT NULL,
	FOREIGN KEY (UserId) REFERENCES User(UserId)
);

CREATE TABLE InvoiceDetail( -- Hóa đơn chi tiết
	InvoiceDetailId INT AUTO_INCREMENT PRIMARY KEY,
    InvoiceId CHAR(5) NOT NULL,
    ProductId CHAR(5) NOT NULL,
    Price REAL NOT NULL,
    Quantity INT NOT NULL,-- Số lượng sản phẩm mua
    TotalAmount REAL  NOT NULL, -- Tổng tiền của hóa đơn chi tiết
    FOREIGN KEY (InvoiceId) REFERENCES Invoice(InvoiceId),
    FOREIGN KEY (ProductId) REFERENCES Product (ProductId)
);
-- DROP TABLE InvoiceDetail;
CREATE TABLE Comment (
	CommentId CHAR(5) PRIMARY KEY,
    UserId CHAR(5) NOT NULL,
    ProductId CHAR(5) NOT NULL,
    Content TEXT,
    CommentDate DATE,
    StatusComment ENUM ('Đang bình luận', 'Đã được duyệt'),
    FOREIGN KEY (UserId) REFERENCES User(UserId),
    FOREIGN KEY (ProductId) REFERENCES Product (ProductId)
);
-- DROP TABLE Comment;
-- 1. Thêm mỗi bảng 5 dữ liệu
-- INSERT table Catalog
INSERT INTO Catalog (CatalogID, CatalogName, Description, StatusCatalog)
VALUES
    ('C001', 'Giày dép', 'Mô tả danh mục sản phẩm giày dép', 1),
    ('C002', 'Laptop', 'Mô tả danh mục sản phẩm laptop', 1),
    ('C003', 'Quần áo', 'Mô tả danh mục sản phẩm thời trang', 1),
    ('C004', 'Đồ điện', 'Mô tả danh mục sản phẩm đồ điện', 1),
    ('C005', 'Thực phẩm', 'Mô tả danh mục sản phẩm thực phẩm', 1);
 
SELECT * FROM Catalog;

-- INSERT table Product
INSERT INTO Product (ProductId, ProductName, PurchasePrice, SellingPrice, ProductTitle, ProductDescription, QuantityInStock, StatusProduct,CatalogID )
VALUES
    ('P001', 'Samsung Galaxy', 8000000, 10000000, 'mẫu giày mới nhất', 'Mô tả chi tiết sản phẩm nike jordan', 50, 'Bán','C001'),
    ('P002', 'Dell XPS 13', 15000000, 18000000, 'Laptop siêu mỏng', 'Mô tả chi tiết sản phẩm Dell XPS 13', 30, 'Bán', 'C002'),
    ('P003', 'Áo sơ mi nam', 500000, 800000, 'Áo thời trang', 'Mô tả chi tiết sản phẩm áo sơ mi nam', 100, 'Bán', 'C003'),
    ('P004', 'Bếp điện từ', 2000000, 2500000, 'Bếp hiện đại', 'Mô tả chi tiết sản phẩm bếp điện từ', 20, 'Bán', 'C004'),
    ('P005', 'Gà rán', 20000, 25000, 'KFC', 'Mô tả chi tiết sản phẩm gà rán', 200, 'Bán', 'C005');
SELECT *FROM Product;

-- ÍNERT table User
INSERT INTO User (UserId, Username, Passwordd, Email, PhoneNumber, Address, DateOfBirth)
VALUES
    ('U001', 'Nguyễn Văn A', 'password1', 'user1@gmail.com', '0123456789', 'Hà Nội', '1990-11-9'),
    ('U002', 'Nguyễn Văn B', 'password2', 'user2@gmail.com', '0944454321', 'Quảng Nam','2000-05-15'),
    ('U003', 'Nguyễn Văn A', 'password3', 'user3@gmail.com', '0369855555', 'Đà Nẵng', '1998-2-7'),
    ('U004', 'Nguyễn Văn D', 'password4', 'user4@gmail.com', '0321657861', 'Cần Thơ', '2001-06-22'),
    ('U005', 'Nguyễn Văn E', 'password5', 'user5@gmail.com', '0999779654', 'Hà Tĩnh', '1995-08-10');
SELECT *FROM User;

-- INSERT table Invoice
INSERT INTO Invoice (InvoiceId, CreateDate, UserId, StatusInvoice)
VALUES
    ('I001', '2023-01-15', 'U001', 'Đã duyệt'),
    ('I002', '2023-02-10', 'U002', 'Đang chuyển hàng'),
    ('I003', '2023-03-20', 'U003', 'Đã nhận hàng'),
    ('I004', '2023-04-05', 'U004', 'Hoàn tất'),
    ('I005', '2023-05-12', 'U005', 'Đang đặt');
SELECT *FROM Invoice;

-- INSERT table InvoiceDetail
INSERT INTO InvoiceDetail (InvoiceId, ProductId, Price, Quantity, TotalAmount)
VALUES
    ('I001', 'P001', 10000000, 2, 20000000),
    ('I002', 'P002', 18000000, 1, 18000000),
    ('I003', 'P003', 800000, 5, 4000000),
    ('I004', 'P004', 2500000, 3, 7500000),
    ('I005', 'P005', 25000, 100, 2500000);
SELECT *FROM InvoiceDetail;

-- INSERT table Comment
INSERT INTO Comment (CommentId, UserId, ProductId, Content, CommentDate, StatusComment)
VALUES
    ('C001', 'U001', 'P001', 'Sản phẩm tốt', '2023-02-01', 'Đã được duyệt'),
    ('C002', 'U002', 'P002', 'Rất ổn', '2023-03-05', 'Đang bình luận'),
    ('C003', 'U003', 'P003', 'Tuyệt vời', '2023-04-15', 'Đã được duyệt'),
    ('C004', 'U004', 'P004', 'Hàng chất lượng', '2023-05-20', 'Đang bình luận'),
    ('C005', 'U005', 'P005', 'Rẻ và ngon', '2023-06-10', 'Đã được duyệt');
SELECT *FROM Comment;

-- 2. Cập nhật thông tin mỗi bảng 1 dữ liệu
-- UPDATE table Catalog
UPDATE Catalog SET Description = 'Mô tả danh mục sản phẩm điện thoại di dong' WHERE CatalogID = 'C001';
 
-- UPDATE table Product
UPDATE Product SET PurchasePrice = 700000 WHERE ProductId = 'P001';

-- UPdate table User
UPDATE User SET Email = 'user1@gmail.com.vn' WHERE UserId = 'U001';

-- UPdate table Invoice
UPDATE Invoice SET CreateDate = '2023-01-30' WHERE InvoiceId = 'I001'; 

-- UPdate table InvoiceDetail
UPDATE InvoiceDetail SET Quantity = 9 WHERE InvoiceDetailId = 2;

-- UPdate table Comment
UPDATE Comment SET StatusComment ='Đã được duyệt' WHERE CommentId ='C002';

-- 3. Thực hiện các truy vấn sau:
-- a. Lấy ra tất cả các sản phẩm gồm các thông tin:
-- mã sản phẩm, tên sản phẩm, giá xuất sản phẩm, mô tả ngắn gọn, trạng thái sản phẩm, tên danh mục của sản phẩm
SELECT p.ProductId, p.ProductName, p.SellingPrice, p.ProductTitle, p.StatusProduct, Cl.CatalogID
	FROM Product p
	INNER JOIN Catalog Cl ON Cl.CatalogID = p.CatalogID;

-- b. Lấy tất cả thông tin sản phẩm có ký tự thứ 2 là ‘a’
SELECT ProductId, ProductName, SellingPrice, ProductTitle, StatusProduct,CatalogID
	FROM Product 
    WHERE ProductName LIKE '_a%';

-- c. Lấy tất cả thông tin sản phẩm có giá nhập 1 trong các giá trị sau: 100.000, 350.000, 700.000
SELECT ProductId, ProductName,PurchasePrice, SellingPrice, ProductTitle, StatusProduct,CatalogID
	FROM Product 
    WHERE PurchasePrice IN(100000,350000, 700000);
    
-- d. Lấy ra tất cả các sản phẩm có giá nhập trong khoảng từ 100.000 đến 500.000 và sắp xếp theo giá nhập tăng dần
SELECT ProductId, ProductName,PurchasePrice, SellingPrice, ProductTitle, StatusProduct,CatalogID
	FROM Product 
    WHERE PurchasePrice BETWEEN 100000 AND 5000000
	ORDER BY PurchasePrice;

-- e. Lấy ra tất cả các bình luận của khách hàng gồm các thông tin tên người
-- dùng, nội dung bình luận, ngày bình luận, tên sản phẩm được bình luận và
-- được sắp xếp theo ngày bình luận giảm dần
SELECT u.Username, Cmt.Content, Cmt.CommentDate, p.ProductName
	FROM Comment Cmt
	INNER JOIN User u ON u.UserId = Cmt.UserId
    INNER JOIN Product p ON p.ProductId = Cmt.ProductId
    ORDER BY Cmt.CommentDate DESC; 
    
-- f. In thông tin 3 sản phẩm được bán nhiều nhất trong khoảng thời gian từ 2023-10-01 đến 2023-10-31  
SELECT P.ProductId, P.ProductName, SUM(ID.Quantity) AS TongSoLuong
	FROM Invoice I
	INNER JOIN InvoiceDetail ID ON I.InvoiceId = ID.InvoiceId
	INNER JOIN Product P ON ID.ProductId = P.ProductId
	WHERE I.CreateDate BETWEEN '2023-1-01' AND '2023-12-31'
	GROUP BY P.ProductId, P.ProductName
	ORDER BY TongSoLuong DESC
	LIMIT 3;
    
-- g. In thông tin hóa đơn có tổng tiền lớn nhất
SELECT Idl.InvoiceDetailId,Idl.InvoiceId, p.ProductName, MAX(Idl.TotalAmount) AS TongTien
	FROM InvoiceDetail Idl
	INNER JOIN Product p ON p.ProductId = Idl.ProductId
    INNER JOIN Invoice I ON I.InvoiceId = Idl.InvoiceId
    GROUP BY Idl.InvoiceDetailId,Idl.InvoiceId, p.ProductName
    ORDER BY TongTien DESC
	LIMIT 1;
  
-- h. In ra số lượng sản phẩm của từng danh mục
SELECT c.CatalogName AS TenDanhMuc, COUNT(p.ProductId) AS SoLuongSanPham
	FROM Product p
	left JOIN Catalog c ON p.CatalogID = c.CatalogID
	GROUP BY c.CatalogName;

-- i. In thông tin người dùng mua hàng nhiều nhất
SELECT u.UserId, u.Username, u.Email, p.ProductName, u.Email, u.PhoneNumber, MAX(Idl.TotalAmount)AS SoLuong
	FROM User u
    INNER JOIN Invoice I ON I.UserId = u.UserId
    INNER JOIN InvoiceDetail Idl ON Idl.InvoiceId = I.InvoiceId
    INNER JOIN Product p ON p.ProductId = Idl.ProductId
    GROUP BY u.UserId, u.Username, u.Email, p.ProductName
    ORDER BY SoLuong DESC
    LIMIT 1;
    
    
    
  