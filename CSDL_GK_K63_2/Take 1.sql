create database GK_K63_2

use GK_K63_2

--1
create table SinhVien(
	MSSV int not null,
	HoTen int not null,
	GioiTinh int not null,
	QueQuan char(40) not null,
	CPA float not null,
	constraint PrimaryKey0 primary key (MSSV)
);

create table MonHoc(
	MaMon int not null,
	TenMon char(30) not null,
	SoTinChi int not null,
	TrongSoGK float not null,
	constraint PrimaryKey1 primary key (MaMon)
);

create table Hoc(
	MSSV int not null,
	MaMon int not null,
	DiemGK float,
	DiemCK float,
	constraint PrimaryKey2 primary key (MSSV, MaMon),
	foreign key (MSSV) references SinhVien(MSSV),
	foreign key (MaMon) references MonHoc(MaMon),
);

--2
select * from SinhVien
where QueQuan like N'Hà Nam'

--3
select HoTen, QueQuan from SinhVien, Hoc, MonHoc
where TenMon like N'Cơ sở dữ liệu'

--4
select count(MSSV) TongSoSV from Hoc
group by MaMon having MaMon = 3290

--5
select SinhVien.MSSV from SinhVien, Hoc
where Hoc.MaMon in (
	select MaMon from MonHoc
)

--6

--7

--8

--9