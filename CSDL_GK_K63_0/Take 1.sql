create database K63_3;

use K63_3;

create table Student(
	StudentID char(8) not null,
	Name varchar(50) not null,
	Address varchar(100) not null,
	constraint PrimaryKey0 primary key (StudentID)
);

create table Subject(
	SubjectCode char(8) not null,
	Name varchar(50) not null,
	Faculty varchar (50) not null,
	constraint PrimaryKey1 primary key (SubjectCode)
);

create table Take(
	StudentID char(8) not null,
	SubjectCode char(8) not null,
	constraint PrimaryKey2 primary key (StudentID, SubjectCode),
	foreign key (StudentID) references Student(StudentID) on delete cascade,
	foreign key (SubjectCode) references Subject(SubjectCode) on delete cascade
);

create table Course(
	CourseID char(8) not null,
	Name varchar(50) not null,
	Faculty varchar(50) not null,
	constraint PrimaryKey3 primary key (CourseID)
);

create table Enrol(
	StudentID char(8) not null,
	CourseID char(8) not null,
	constraint PrimaryKey4 primary key (StudentID, CourseID),
	foreign key (StudentID) references Student(StudentID),
	foreign key (CourseID) references Course(CourseID)
);

drop table Table;

--2. Cho biết tên địa chỉ của sinh viên (student) có môn học (subject) có mã là 'IT3292'
select Student.Name, Address from Student, Take, Subject
where Subject.SubjectCode like 'IT3292';

--3. Cho biết thông tin sinh viên có địa chỉ ở  'New York' và có học môn học 'Database'
select Student.* from Student, Take, Subject
where Address like 'New York' and Subject.Name like 'Database'

--4. Cho biết thông tin sinh viên học tất cả các môn học
select Student.* from Student
nat join Take 
group by StudentID having count(SubjectCode) = (
	select count(*) from Subject
)

--5. Cho biết tổng số sinh viên học môn có mã 'IT3292'
select count(StudentID) as TongSo from Take
group by SubjectCode having SubjectCode like 'IT3292'

select count(StudentID) from Take where SubjectCode like 'IT3292'

