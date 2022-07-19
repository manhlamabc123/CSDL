use QLKJ;

--1. Đưa ra thông tin giảng viên có địa chỉ ở quận "Hai Bà Trưng", sắp xếp theo thứ tự giảm dần của họ tên.
select * from GiangVien
where DiaChi like N'%Hai Bà Trưng%'
order by HoTen desc; --asc

--2. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài "Tính toán lưới".
select HoTen, DiaChi, NgaySinh from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
inner join DeTai on ThamGia.DT = DeTai.DT
where TenDT like N'Tính toán lưới';

--3. Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài "Phân loại văn bản" hoặc "Dịch tự động Anh Việt".
select HoTen, DiaChi, NgaySinh from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
inner join DeTai on ThamGia.DT = DeTai.DT
where TenDT like N'Phân loại văn bản' or TenDT like N'Dịch tự động Anh Việt';

--4. Cho biết thông tin giảng viên tham gia ít nhất 2 đề tài.
select GiangVien.* from GiangVien --Đưa ra thông tin Giảng Viên
inner join ThamGia on GiangVien.GV = ThamGia.GV --Nối bảng GiangVien với bản ThamGia
group by GiangVien.GV, HoTen, DiaChi, NgaySinh having count(ThamGia.DT) >= 2; -- Group by thông tin giảng viên với số lượng đề tài tham gia lớn hơn 2.

--5. Cho biết tên giảng viên tham gia nhiều đề tài nhất.
select GiangVien.HoTen from GiangVien --Đưa ra thông tin Giảng Viên
inner join ThamGia on GiangVien.GV = ThamGia.GV --Nối bảng GiangVien với bản ThamGia
group by HoTen having count(ThamGia.DT) = ( --Group by HoTen số lượng đề tài tham gia bằng những giá trị trong ()
	select top 1 count(DT) from ThamGia --Lấy số lượng DT xuất hiện nhiều nhất trong ThamGia
	group by GV order by count(DT) desc
);

--6. Đề tài nào tốn ít kinh phí nhất?
select TenDT from DeTai
where KinhPhi = (
	select min(KinhPhi) from DeTai
)

--7. Cho biết tên và ngày sinh của giảng viên sống ở quận Tây Hồ và tên các đề tài mà giảng viên này tham gia.
select HoTen, NgaySinh, TenDT from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
inner join DeTai on ThamGia.DT = DeTai.DT
where DiaChi like N'%Tây Hồ%'

--8. Cho biết tên những giảng viên sinh trước năm 1980 và có tham gia đề tài "Phân loại văn bản"
select HoTen from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
inner join DeTai on ThamGia.DT = DeTai.DT
where year(NgaySinh) < 1980 and TenDT like N'Phân loại văn bản';

--9. Đưa ra mã giảng viên, tên giảng viên và tổng số giờ tham gia nghiên cứu khoa học của từng giảng viên.
select GiangVien.GV, GiangVien.HoTen, sum(SoGio) as TongSoGioThamGia from GiangVien
inner join ThamGia on GiangVien.GV = ThamGia.GV
group by GiangVien.GV, GiangVien.HoTen;

--10. Giảng viên Ngô Tuấn Phong sinh ngày 08/09/1986 địa chỉ Đống Đa,
--Hà Nội mới tham gia nghiên cứu đề tài khoa học. Hãy thêm thông tin giảng viên này vào bảng GiangVien.
insert into GiangVien values
('GV06', N'Ngô Tuấn Phong', N'Đống Đa', '08/09/1986');

--11.  Giảng viên Vũ Tuyết Trinh mới chuyển về sống tại quận Tây Hồ, Hà Nội. Hãy cập nhật thông tin này.
update GiangVien
set DiaChi = N'Tây Hồ, Hà Nội'
where HoTen like N'Vũ Tuyết Trinh';

--12. Giảng viên có mã GV02 không tham gia bất kỳ đề tài nào nữa. Hãy xóa tất cả thông tin liên quan đến giảng viên này trong CSDL.
delete from GiangVien
where GV = 'GV02';