use GV_SV;

--1. Đưa ra thông tin về giáo viên có mã là "GV001".
select * from GiangVien
where GV = 'GV001';

--2. Cho biết có bao nhiêu đề tài thuộc thể loại "Ứng dụng".
select count(DT) as SoLuongDeTai from DeTai
group by TheLoai having TheLoai like N'Ứng dụng';

--3. Cho biết giáo viên có mã "GV012" đã hướng dẫn bao nhiêu sinh viên có quê quán ở "Hải Phòng".
select count(distinct SinhVien.MSSV) as SoLuongSinhVien from GiangVien
inner join HuongDan on GiangVien.GV = HuongDan.GV
inner join SinhVien on HuongDan.MSSV = SinhVien.MSSV
where QueQuan like N'&Hải Phòng%'
group by GiangVien.GV having GiangVien.GV = 'G0012';

--4. Cho biết tên của đề tài chưa có sinh viên nào thực hiện.
select DeTai.TenDT from DeTai
left join HuongDan on HuongDan.DT = DeTai.DT
where GV is null;

--5. Do sơ xuất, thông tin về ngày sinh của sinh viên tên là "Nguyễn Xuân Dũng", quê quán
--"Hà Nam" đã bị nhập chưa chính xác. Ngày sinh chính xác là "12/11/1991". Hãy cập nhật
--thông tin này.
update SinhVien
set NgaySinh = '12/11/1991'
where TenSV like N'Nguyễn Xuân Dũng' and QueQuan like N'%Hà Nam%'

--6. Vì lý do khách quan, sinh viên "Lê Văn Luyện", quê quán "Bắc Giang" đã xin thôi học.
--Hãy xóa toàn bộ thông tin liên quan đến sinh viên này.
delete from SinhVien
where TenSV like N'Lê Văn Luyện' and QueQuan like N'%Bắc Giang%';