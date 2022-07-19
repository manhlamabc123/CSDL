use CompanySupplyProduct

select * from Company, Supply;
select * from Company, Supply where Company.CompanyID = Supply.CompanyID;
select * from Company
inner join Supply on Company.CompanyID = Supply.CompanyID;

--1/ Hãy cho biết tên, số nv của các cty ở Nhật Bản
select Name, NumberofEmployee from Company

--2/ Hãy cho biết ttin cty có số nv >100,000
select * from Company
where NumberofEmployee > 100000

--3/ TTin cty có số nv >100,000 và ở Đức
select * from Company
where NumberofEmployee > 100000 and Address like N'%Germany%'

--4/ Hãy cho biết ttin cty thành lập năm 1916
select * from Company
where year(EstablishmentDay) = '1916'

select * from Company
where datepart(year, EstablishmentDay) = 1916

--5/ Cty >70 tuổi
select * from Company
where year(getdate()) - year(EstablishmentDay) > 70

select * from Company
where DATEDIFF(year, EstablishmentDay, getdate()) > 40

--6/ Cho biết tên cty, sắp xếp theo abc
select Name from Company order by Name asc

--7/ Cho biết ttin cty, sắp xếp theo nv giảm dần
select * from Company order by NumberofEmployee desc

--8/ Có bao nhiêu cty trong csdl?
select count(CompanyID) as NumberofCompany from Company

--9/ Tổng số nv tất cả các cty
select sum(NumberofEmployee) as NumberofAllEmployee from Company

--10/ Số lượng nv trung bình của mỗi cty
select avg(NumberofEmployee) as AvgNumverofEmployee from Company

--11/ Số lượng nv nhiều nhất
select NumberofEmployee from Company
where NumberofEmployee >= All (
	select NumberofEmployee from Company
)

--12/ Số lượng nv ít nhất
select NumberofEmployee from Company
where NumberofEmployee <= All (
	select NumberofEmployee from Company
)
group by NumberofEmployee

--13/ Cho biết ttin cty có số nv max
select * from Company
where NumberofEmployee >= All (
	select NumberofEmployee from Company
)

--14/ Phép đổi tên AS
SELECT CompanyID AS [Mã công ty], Name AS [Tên cty]
FROM Company AS c
WHERE c.Address LIKE '%US%';

--15/ Cho biết tên, điện thoại của cty ở Japan, có số nv lớn hơn 8000
select Name, Telephone from Company
where NumberofEmployee > 8000

--16/ Cho biết ttin cty ở Japan hoặc Germany
select * from Company
where Address like N'%Japan%' or Address like N'%Germany%'

--17/ Cho biết address có >=2 cty
select Address from Company
group by Address having count(Address) >= 2

select distinct c1.Address from Company c1, Company c2
where c1.Address = c2.Address and c1.CompanyID <> c2.CompanyID

select distinct Address from Company c1
where Address in (
	select Address from Company c2
	where c1.CompanyID <> c2.CompanyID
)

--18/ Cho biết thông tin cty cung ứng 2 sản phẩm màu red trở lên
select Company.CompanyID from Company
inner join Supply on Company.CompanyID = Supply.CompanyID
inner join Product on Product.ProductID = Supply.ProductID
where Color = 'red' 
group by Company.CompanyID having count(Company.CompanyID) >= 2