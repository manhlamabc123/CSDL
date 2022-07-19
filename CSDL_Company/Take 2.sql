use CompanySupplyProduct;

--1/ Hãy cho biết tên, số nv của các cty ở Nhật Bản
select Name, NumberOfEmployee from Company;

--2/ Hãy cho biết ttin cty có số nv >100,000
select * from Company
where NumberofEmployee > 100000

--3/ TTin cty có số nv >100,000 và ở Đức
select * from Company
where NumberofEmployee > 100000 and Address like '%Germany%'

--4/ Hãy cho biết ttin cty thành lập năm 1916
select * from Company
where year(EstablishmentDay) = 1916

--5/ Cty >70 tuổi
select * from Company
where year(getdate()) - year(EstablishmentDay) > 70

--6/ Cho biết tên cty, sắp xếp theo abc
select Name from Company order by Name asc

--7/ Cho biết ttin cty, sắp xếp theo nv giảm dần
select * from Company order by NumberofEmployee desc

--8/ Có bao nhiêu cty trong csdl?
select count(CompanyID) as SoLuongCongTy from Company

--9/ Tổng số nv tất cả các cty
select sum(NumberOfEmployee) as TongSoNhanVien from Company

--10/ Số lượng nv trung bình của mỗi cty
select avg(NumberOfEmployee) as SoLuongNVTrungBinh from Company

--11/ Số lượng nv nhiều nhất
select max(NumberOfEmployee) as SoLuongNVNhieuNhat from Company

--12/ Số lượng nv ít nhất
select min(NumberOfEmployee) as SoLuongNVNhieuNhat from Company

--13/ Cho biết ttin cty có số nv max
select * from Company
where NumberofEmployee = (
	select max(NumberOfEmployee) from Company
);

select * from Company
where NumberofEmployee >= all (
	select NumberOfEmployee from Company
);

--15/ Cho biết tên, điện thoại của cty ở Japan, có số nv lớn hơn 8000
select Name, Telephone from Company
where Address like '%Japan' and NumberofEmployee > 8000

--16/ Cho biết ttin cty ở Japan hoặc Germany
select * from Company
where Address like '%Japan' or Address like '%Germany%'

--17/ Cho biết address có >=2 cty
select Address from Company
group by Address having count(CompanyID) >= 2

--18/ Cho biết thông tin cty cung ứng 2 sản phẩm màu red trở lên
select Company.* from Company
inner join Supply on Supply.CompanyID = Company.CompanyID
inner join Product on Product.ProductID = Supply.ProductID
where Color like '%red%'
group by Company.CompanyID, Company.Address, Company.EstablishmentDay, Company.Name, Company.NumberofEmployee, Company.Telephone
having count(Color) >= 2