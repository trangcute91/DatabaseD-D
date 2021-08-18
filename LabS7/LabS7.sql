-- 2.  câu lệnh --

create table KhachHang(
	TenKH  nvarchar(255)  not null,
	CMND int primary key not null,
	DiaChi nvarchar(255)
);

create table ThueBao(
	SoThueBao  char(20)  primary  key not null,
	LoaiThueBao nchar(20) not null,
	NgayDangKy date CHECK(NgayDangKy <= GETDATE()),
	KhachHangID int foreign key references KhachHang(CMND)  
);

drop table ThueBao;
drop table KhachHang;

--  3. Thêm dữ liệu --

insert into KhachHang(TenKH, CMND, DiaChi)
	values(N'Nguyễn Nguyệt Nga', '123456789', N'Hà Nội');

insert into ThueBao(SoThueBao, LoaiThueBao, NgayDangKy, KhachHangID)
	values('123456789', N'Trả trước', '12/12/02', '123456789');

--  4. Truy Vấn --

select * from KhachHang;
select * from ThueBao;

-- 5. Truy vấn để lấy --

select * from ThueBao where SoThueBao = '0123456789';
select * from  KhachHang where CMND = '123456789';
select KhachHangID as CMND, SoThueBao, LoaiThueBao, NgayDangKy from ThueBao where KhachHangID = '123456789';
select * from ThueBao where NgayDangKy = '12/12/02';
select * from ThueBao where KhachHangID in (select CMND from KhachHang where Diachi like N'Hà Nội');

-- 6. TRUY  VẤN ĐỂ LẤY --

select count (CMND) from KhachHang;
select count (SoThueBao) from ThueBao;
select count (SoThueBao) from ThueBao group by NgayDangKy having NgayDangKy like '12/12/02';
select KhachHang.*, SoThueBao from KhachHang , ThueBao where CMND = KhachHangID;

--  7.  THAY DOI CSDL --

--	a & b, thay đổi ngày đăng ký là not null và trước hoặc bằng ngày hiện tại
 alter table ThueBao alter column NgayDangKy date not null;
 update ThueBao set  NgayDangKy = GETDATE();
-- c,  Điện thoại phải bắt đầu  từ 09 --
alter table ThueBao add check (SoThueBao = '09%');
-- d,  Thêm Điểm Thưởng --
alter table ThueBao add DiemThuong FLOAT;
alter table ThueBao add check(DiemThuong >=0);

-- 8, THỰC HIỆN --

-- a, đặt chỉ mục Index cho cột KH của bảng thông tin chứa KH --
create index Ten_Khach_Hang
on KhachHang(TenKH);

-- b, Viết view--
create view KH_View as 
select TenKH, CMND, DiaChi from KhachHang;

create view KH_ThueBao_View as 
select KhachHang.CMND, KhachHang.TenKH, ThueBao.SoThueBao from KhachHang, ThueBao;

select * from KH_View;
select * from KH_ThueBao_View;

-- c, Viết các Store Proceduce --

-- Hiển Thị Thông Tin KH vs số Thuê Bao nhập vào--

create procedure show_thuebao_order 
	as
	begin
	select KhachHang.TenKh, KhachHang.CMND, KhachHang.DiaChi, ThueBao.SoThueBao 
	from  KhachHang, ThueBao
	order by  ThueBao.SoThueBao;
end;

--Liệt kê các SĐT theo Tên truyền vào --

create procedure show_sdt_order 
	as
	begin
	select KhachHang.TenKh, KhachHang.CMND, ThueBao.SoThueBao 
	from  KhachHang, ThueBao
	order by  KhachHang.TenKh;
end;

-- Thêm mới 1 tb cho kh --

create procedure insert_tb_list_all 
	as
	begin
	insert into ThueBao(SoThueBao, LoaiThueBao, NgayDangKy, KhachHangID)
	values('0961368859', N'Trả sau', '12/12/09', '123456789');
	exec insert_tb_list_all;
end;

-- Xóa bỏ thuê bao của KH theo Mã KH --

create procedure delete_tb_list_all 
	as
	begin
	delete from ThueBao where KhachHangID = '%345%';
end;
