create table GiangVien(
	GV char(4) not null,
	HoTen nvarchar(30) not null,
	DiaChi nvarchar(30) not null,
	NgaySinh date not null,
	constraint KhoaChinh primary key(GV)
);

create table DeTai(
	DT char(4) not null,
	TenDT nvarchar(30) not null,
	Cap nvarchar(20) not null,
	KinhPhi int not null,
	constraint KhoaChinh1 primary key(DT)
);

create table ThamGia(
	GV char(4) not null,
	DT char(4) not null,
	SoGio int not null,
	constraint KhoaChinh2 primary key (GV, DT),
	foreign key (GV) references GiangVien(GV),
	foreign key (DT) references DeTai(DT),
);

declare @date date
set @date = '19901124'

select @date --your date format
select CONVERT(varchar(10), @date, 101)  --new date format

INSERT INTO GiangVien VALUES('GV01',N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975/10/10'),
('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976/11/03'),
('GV03',N'Trần Đức Khánh',N'Đống Đa, Hà Nội','1977/06/04'),
('GV04',N'Nguyễn Hồng Phương',N'Tây Hồ, Hà Nội','1983/12/10'),
('GV05',N'Lê Thanh Hương',N'Hai Bà Trưng, Hà Nội','1976/10/10')

INSERT INTO DeTai VALUES ('DT01',N'Tính toán lưới',N'Nhà nước','700'),
('DT02',N'Phát hiện tri thức',N'Bộ','300'),
('DT03',N'Phân loại văn bản',N'Bộ','270'),
('DT04',N'Dịch tự động Anh Việt',N'Trường','30')

INSERT INTO ThamGia VALUES ('GV01','DT01','100'),
('GV01','DT02','80'),
('GV01','DT03','80'),
('GV02','DT01','120'),
('GV02','DT03','140'),
('GV03','DT03','150'),
('GV04','DT04','180')

select * from GiangVien order by HoTen desc;
select * from GiangVien order by HoTen asc;
select * from GiangVien where DiaChi like N'%Hai Bà Trưng%' order by HoTen asc;
select * from DeTai;
select HoTen, DiaChi, NgaySinh from GiangVien;
select * from ThamGia;

select NgaySinh, convert (varchar(8), NgaySinh, 103) as Ngay_Sinh from GiangVien;

1.
select HoTen, DiaChi, NgaySinh from GiangVien
inner join ThamGia on GiangVien.GV=ThamGia.GV
inner join DeTai on ThamGia.DT=DeTai.DT
where DeTai.TenDT like N'%Tính toán lưới%';

2.
select HoTen, DiaChi, NgaySinh from GiangVien, DeTai, ThamGia
where GiangVien.GV = ThamGia.GV and ThamGia.DT = DeTai.DT and TenDT like N'%Tính toán lưới';

3.
select HoTen, DiaChi, NgaySinh from GiangVien, DeTai, ThamGia
where GiangVien.GV = ThamGia.GV and ThamGia.DT = DeTai.DT and (DeTai.TenDT like N'%Phân loại văn bản%' or DeTai.TenDT like N'%Dịch tự động Anh Việt%');

4.
select * from GiangVien
where GV in (
	select GV from ThamGia
	group by GV
	having count(DT) >= 2 
);

5.
select HoTen
from GiangVien
where GV in (
	select top 1 GV
	from ThamGia
	group by GV
	order by count(DT) desc
);

select HoTen from GiangVien
where GV in (
	select GV from ThamGia
	group by GV having count(DT) >= All (
			select count(DT) from ThamGia group by GV
	)
)

6.
select * from DeTai where KinhPhi <= all(select KinhPhi from DeTai);

7.
select HoTen, NgaySinh, TenDT from GiangVien 
left join ThamGia on GiangVien.GV = ThamGia.GV
left join DeTai on DeTai.DT = ThamGia.DT
where DiaChi like N'%Hai Bà Trưng%';

8.
select HoTen from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
inner join DeTai on DeTai.DT = ThamGia.DT
where (NgaySinh < '19800101') and TenDT like N'%Phân loại văn bản%';

select HoTen from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
inner join DeTai on DeTai.DT = ThamGia.DT
where year(NgaySinh) < '1980' and TenDT like N'%Phân loại văn bản%';

9.
select GiangVien.GV, HoTen, sum(SoGio) as TongSoGio from GiangVien
left join ThamGia on ThamGia.GV = GiangVien.GV
group by GiangVien.GV, HoTen;

select * from GiangVien
left join ThamGia on ThamGia.GV = GiangVien.GV

10.
select *
from GiangVien
where DATEDIFF(year, NgaySinh, getdate()) > 40;

select * from GiangVien
where YEAR(GETDATE())-YEAR(NgaySinh) >= 40

11.
update GiangVien
set DiaChi = N'Tây Hồ, Hà Nội'
where HoTen = N'Vũ Tuyết Trinh'

12.
delete from ThamGia where GV = 'GV02'
delete from GiangVien where GV = 'GV02'