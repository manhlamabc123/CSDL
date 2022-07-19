create database QLKH;

use QLKH;

create table GiangVien (
	GV char(4) not null,
	HoTen nvarchar(50) not null,
	DiaChi nvarchar(50) not null,
	NgaySinh date not null,
	constraint PK0 primary key (GV)
);

create table DeTai (
	DT char(4) not null,
	TenDT nvarchar(50) not null,
	Cap nvarchar(10) not null,
	KinhPhi smallint not null,
	constraint PK1 primary key (DT)
);

create table ThamGia (
	GV char(4) not null,
	DT char(4) not null,
	SoGio smallint not null,
	constraint PK2 primary key (GV, DT),
	foreign key (GV) references GiangVien(GV) on delete cascade on update cascade,
	foreign key (DT) references DeTai(DT) on delete cascade on update cascade
);

drop table ThamGia;
drop table GiangVien, DeTai;