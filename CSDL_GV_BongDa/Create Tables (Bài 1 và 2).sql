--Bài 1
create database GV_SV;

use GV_SV;

create table GiangVien(
	GV char(4) not null,
	HoTen nvarchar(30) not null,
	NamSinh smallint not null,
	DiaChi nvarchar(50) not null,
	constraint KhoaChinh0 primary key (GV)
);

create table DeTai(
	DT char(4) not null,
	TenDT nvarchar(50) not null,
	TheLoai nvarchar(20) not null,
	constraint KhoaChinh1 primary key (DT)
);

create table SinhVien(
	MSSV char(8) not null,
	TenSV nvarchar(30) not null,
	NgaySinh date not null,
	QueQuan nvarchar(20) not null,
	Lop nvarchar(20) not null,
	constraint KhoaChinh2 primary key (MSSV)
);

create table HuongDan(
	GV char(4) not null,
	DT char(4) not null,
	MSSV char(8) not null,
	NamTH smallint not null,
	KetQua real,
	primary key (GV, DT, MSSV, NamTH),
	foreign key (GV) references GiangVien(GV) on delete cascade on update cascade,
	foreign key (DT) references DeTai(DT) on delete cascade on update cascade,
	foreign key (MSSV) references SinhVien(MSSV) on delete cascade on update cascade
);

--Bài 2
create database Cau_Thu;

use Cau_Thu;

create table CauThu(
	MaCT char(8) not null,
	HoTen nvarchar(30) not null,
	NgaySinh date not null,
	GiaiThuong nvarchar(100) not null,
	SoAo smallint not null,
	constraint KhoaChinh0 primary key (MaCT)
);

create table TranDau(
	MaTD char(8) not null,
	NgayGio date not null,
	DoiThu nvarchar(30) not null,
	San nvarchar(30) not null,
	SoBanThang smallint not null,
	SoBanThua smallint not null,
	constraint KhoaChinh1 primary key (MaTD)
);

create table GiaiDau(
	MaGD char(8) not null,
	Ten nvarchar(30) not null,
	Nam smallint not null,
	Khac nvarchar(100),
	constraint KhoaChinh2 primary key (MaGD)
);

create table NhaTaiTro(
	ID smallint not null,
	Ten nvarchar(30) not null,
	DiaChi nvarchar(50) not null,
	constraint KhoaChinh3 primary key (ID)
);

create table DoiTruong(
	MaCT char(8) not null,
	MaTD char(8) not null,
	primary key (MaCT, MaTD),
	foreign key (MaCT) references CauThu(MaCT) on delete cascade on update cascade,
	foreign key (MaTD) references TranDau(MaTD) on delete cascade on update cascade,
);

create table ThamGia(
	MaCT char(8) not null,
	MaTD char(8) not null,
	ViTri smallint not null, check (ViTri > 0),
	SoTheVang smallint not null, check(SoTheVang > -1),
	SoTheDo smallint not null, check(SoTheDo> -1),
	primary key (MaCT, MaTD),
	foreign key (MaCT) references CauThu(MaCT) on delete cascade on update cascade,
	foreign key (MaTD) references TranDau(MaTD) on delete cascade on update cascade,
);

create table Thuoc(
	MaTD char(8) not null,
	MaGD char(8) not null,
	primary key (MaTD, MaGD),
	foreign key (MaTD) references TranDau(MaTD) on delete cascade on update cascade,
	foreign key (MaGD) references GiaiDau(MaGD) on delete cascade on update cascade,
);

create table TaiTro(
	ID smallint not null,
	MaGD char(8) not null,
	primary key (ID, MaGD),
	foreign key (ID) references NhaTaiTro(ID) on delete cascade on update cascade,
	foreign key (MaGD) references GiaiDau(MaGD) on delete cascade on update cascade,
);