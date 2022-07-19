--1.	Dùng lệnh tạo bảng để tạo 3 bảng trên với đầy đủ ràng buộc khóa chính, khóa ngoài.
create table Company (
	CompanyID int identity(1,1),
	Name varchar(40),
	NumberofEmployee int,
	Address varchar(50),
	Telephone char(15),
	EstablishmentDay date,
	primary key (CompanyID)
);

create table Product (
	ProductID int identity(1,1),
	Name varchar(40),
	Color char(14),
	Price decimal(10,2),
	primary key (ProductID)
);

create table Supply (
	CompanyID int,
	ProductID int,
	Quantity int,
	primary key (CompanyID,ProductID),
	foreign key (CompanyID) references Company(CompanyID) on delete cascade on update cascade,
	foreign key (ProductID) references Product(ProductID) on delete cascade on update cascade
);

--2.	Cho biết thông tin của công ty có địa chỉ ở 'London'
select * from Company
where Address like '%London%';

--3.	Cho biết thông tin công ty thành lập trong tháng 11 cách đây 110 năm
select * from Company
where (month(EstablishmentDay) = 11) and (year(getdate()) - year(EstablishmentDay) = 110);

--4.	Cho biết thông tin các sản phẩm và số lượng cung ứng sản phẩm của công ty 'Audi'
select Product.*, Quantity from Company
inner join Supply on Company.CompanyID = Supply.CompanyID
inner join Product on Supply.ProductID = Product.ProductID
where Company.Name like '%Audi%';

--5.	Cho biết mã công ty cung ứng ít nhất 2 loại sản phẩm mà số lượng cung ứng mỗi loại >1000
select Company.CompanyID from Company
inner join Supply on Company.CompanyID = Supply.CompanyID
where Quantity > 1000
group by Company.CompanyID having count(Supply.ProductID) >= 2; 

--6.	Cho biết thông tin công ty cung ứng tất cả các sản phẩm màu 'black' có trong bảng Product
select * from Company
where CompanyID in (
	select Company.CompanyID from Company
	inner join Supply on Supply.CompanyID = Company.CompanyID
	inner join Product on Product.ProductID = Supply.ProductID
	where Color like '%black%'
	group by Company.CompanyID having count(Color) = (
		select count(Color) from Product
		where Color like '%black%'
	)
);

--7.	Cho biết tổng số sản phẩm các loại được cung ứng bởi công ty 'Porsche'
select sum(Quantity) as TongSoSanPhamCacLoai from Company
inner join Supply on Company.CompanyID = Supply.CompanyID
where Company.Name like 'Porsche'

--8.	Cho biết thông tin công ty chưa cung ứng bất kỳ sản phẩm nào
select Company.* from Company
left join Supply on Company.CompanyID = Supply.CompanyID
where Supply.ProductID is null;

--9.	Viết câu SQL tạo khung nhìn vật chất hóa chứa thông tin công ty có cung ứng 
--sản phẩm màu 'red' gồm các trường: mã công ty, tên công ty, điện thoại, mã sản phẩm, tên sản phẩm, số lượng cung ứng.
create view vCompany(ComID, ComName, ComPhone, ProID, ProName, Quan) as 
select Company.CompanyID, Company.Name, Company.Telephone, Supply.ProductID, Product.Name, Quantity from Company
inner join Supply on Supply.CompanyID = Company.CompanyID
inner join Product on Product.ProductID = Supply.ProductID
where Product.Color like 'red'

--10. Xóa thông tin công ty có mã '2'
delete from Company
where CompanyID = 2;