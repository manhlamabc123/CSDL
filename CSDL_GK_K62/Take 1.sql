create database GK_K62

use GK_K62

use CompanySupplyProduct

--1. Tạo 3 bảng trên
create table Company(
	CompanyID char(8) not null,
	Name varchar(50) not null,
	NumberofEmployee smallint not null,
	Address varchar(100) not null,
	Telephone char(10) not null,
	EstablishmentDay date not null,
	constraint PrimaryKey0 primary key (CompanyID)
);

create table Product(
	ProductID char(8) not null,
	Name varchar(50) not null,
	Color varchar(10) not null,
	Price smallint not null,
	constraint PrimaryKey1 primary key (ProductID)
);

create table Supply(
	CompanyID char(8) not null,
	ProductID char(8) not null,
	Quantity smallint not null,
	constraint PrimaryKey2 primary key (CompanyID, ProductID),
	foreign key (CompanyID) references Company(CompanyID) on delete cascade on update cascade,
	foreign key (ProductID) references Product(ProductID) on delete cascade on update cascade,
);

--2. Cho biết tên, địa chỉ của các công ty có địa chỉ tại 'London'
select Name, Address from Company
where Address like '%London%'

--3. Cho biết thông tin công ty có cung cấp mặt hàng màu sắc là 'red' và có số nhân viên lớn hơn 1000
select distinct Company.* from Company --add "distinct"
inner join Supply on Company.CompanyID = Supply.CompanyID
inner join Product on Product.ProductID = Supply.ProductID
where Color like 'red' and NumberofEmployee > 1000

--4. Cho biết mã công ty cung cấp Tất cả các mặt hàng màu sắc ‘brown’
--tất cả các mặt hàng mày 'brown'
select * from Product
where Color like 'brown'[dbo].[Product]

--tất cả công ty có mặt hàng màu nâu
select * from Company --add "distinct"
inner join Supply on Company.CompanyID = Supply.CompanyID
inner join Product on Product.ProductID = Supply.ProductID
where Color like 'brown'

--công ty bán tất cả mặt hàng màu nâu và chỉ mặt hàng màu nâu
select CompanyID from Supply
group by CompanyID having count(ProductID) = (
	select count(ProductID) from Product
	where color = 'brown'
) and CompanyID in (
	select CompanyID from Supply
	where ProductID in (
		select ProductID from Product
		where color = 'brown'
	)	group by CompanyID having count(ProductID) = (
		select count(ProductID) from Product
		where color = 'brown'
	)
)

--công ty bán tất cả cả mặt hàng màu nâu
select CompanyID from Supply
inner join Product on Supply.ProductID = Product.ProductID
where color like 'brown' group by CompanyID having count(Supply.ProductID) = (
	select count(ProductID) from Product
	where color like 'brown'
)

--công ty bán tất cả mặt hàng màu nâu và chỉ mặt hàng màu nâu
select CompanyID from Supply
inner join Product on Supply.ProductID = Product.ProductID
where color like 'brown' group by CompanyID having count(Supply.ProductID) = (
	select count(ProductID) from Product
	where color like 'brown'
) and CompanyID in (
	select CompanyID from Supply
	inner join Product on Supply.ProductID = Product.ProductID
	group by CompanyID having count(Supply.ProductID) = (
		select count(ProductID) from Product
		where color like 'brown'
	)
)

--5. Cho biết thông tin công ty chưa cung ứng bất kỳ mặt hàng nào
select Company.* from Company
left join Supply on Company.CompanyID = Supply.CompanyID
where ProductID is null

select * from Company
where CompanyID not in (
	select CompanyID from Supply
)

--6. Liệt kê thông tin công ty kỉ niệm 20 năm thành lập trong năm 2019
select * from Company
where 2019 - year(EstablishmentDay) = 20

--7. Cho biết tổng số nhân viên lao động cho các công ty ở 'Paris'
select sum(NumberofEmployee) as TongSoNhanVien from Company
group by Address having Address like '%Paris%'

--8. Cho biết số lượng trung bình mặt hàng được cung cấp bởi công ty tên là 'EuroCard'
select avg(Quantity) as SoLuongTrungBinh from Company, Supply where Company.CompanyID = Supply.CompanyID
group by Company.Name having Company.Name like 'Porsche'

select sum(Quantity)/count(ProductID) from Supply
group by CompanyID having CompanyID in (
	select CompanyID from Company
	where Name like 'Porsche'
)

select * from Company, Supply where Company.CompanyID = Supply.CompanyID
and Company.Name like 'Porsche'

--9.
update Product
set Price = Price * 120/100;

--10. 
delete from Company 
where CompanyID = '181119';