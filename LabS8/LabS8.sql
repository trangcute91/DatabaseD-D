-- 2, VIẾT CÂU LỆNH TẠO TK --

create  table  NhanVien(
	MaNV int primary key not null,
	TenNV nvarchar(255) not null
);

create table LoaiSP(
	MaLoaiSP nchar(20) primary key not null,
	TenLoaiSP nvarchar(255) not null
);

create table SanPham(
	MaSP nchar(20) primary key  not null,
	NgaySX  date,
	LoaiSPID  nchar(20) foreign key references LoaiSP(MaLoaiSP)
);

create table  NhanVienSanPham(
	NhanVienID int foreign key references NhanVien(MaNV),
	SanPhamID nchar(20) foreign key references SanPham(MaSP)
);

create table  NhanVienLoaiSP(
	NhanVienID int foreign key references NhanVien(MaNV),
	LoaiSPID nchar(20) foreign key references LoaiSP(MaLoaiSP)
);

drop table NhanVienLoaiSP;
drop table NhanVienSanPham;
drop table  SanPham;
drop table LoaiSP;
drop table NhanVien;

-- 3,NHẬP DỮ LIỆU --

insert into NhanVien(MaNV, TenNV)
	values('987688', N'Nguyễn Văn A');

insert into LoaiSP(MaLoaiSP, TenLoaiSP)
	values('Z37E', N'Máy Tính xách tayZ37');

insert into SanPham(MaSP, NgaySX, LoaiSPID)
	values('Z37 111111', '12-12-09', 'Z37E');

insert into NhanVienSanPham(NhanVienID,SanPhamID)
	values('987688', 'Z37 111111');

insert into NhanVienLoaiSP(NhanVienID,LoaiSPID)
	values('987688', 'Z37E');

-- 4,  LỆNH TRUY VẤN --

-- a) Liệt kê danh sách loại sản phẩm của công ty.--
select * from LoaiSP;
-- b) Liệt kê danh sách sản phẩm của công ty.--
select * from SanPham;
-- c) Liệt kê danh sách người chịu trách nhiệm của công ty.--
select * from NhanVien;

--5,LỆNH TRUY VẤN  ĐỂ --

--a) Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên--
select  * from LoaiSP order by TenLoaiSP asc;
--b) Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên.--
select  * from NhanVien order by TenNV asc;
--c) Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37E.--
select  * from SanPham where LoaiSPID = 'Z37E';
--d) Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã.--
select  SanPham.MaSP, NhanVienLoaiSP.*, NhanVien.TenNV from SanPham, NhanVienLoaiSP, NhanVien where TenNV like N'Nguyễn Văn A' order by MaSP desc;

-- 6, LỆNH  TRUY  VẤN ĐỂ --

--a) Số sản phẩm của từng loại sản phẩm.--
select LoaiSP.TenLoaiSP, count(SanPham.MaSP) as SoSP from LoaiSP, SanPham where LoaiSP.MaLoaiSP = SanPham.LoaiSPID group by TenLoaiSP;
--b) Số loại sản phẩm trung bình theo loại sản phẩm.-- ??? ko hiểu đề
--c) Hiển thị toàn bộ thông tin về sản phẩm và loại sản phẩm.--
select * from LoaiSP inner join  SanPham on  LoaiSP.MaLoaiSP = SanPham.LoaiSPID;
--d) Hiển thị toàn bộ thông tin về người chịu trách nhiêm, loại sản phẩm và sản phẩm.--
select * from SanPham A inner join (select * from NhanVien, NhanVienSanPham where NhanVien.MaNV = NhanVienSanPham.NhanVienID)B on A.MaSP = B.SanPhamID;

-- 7, THAY ĐỔI CSDL --

-- a) Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại.--
alter table SanPham add check  (NgaySX <=  GETDATE());
-- b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.--
SELECT Col.Column_Name,Col.CONSTRAINT_NAME, Constraint_Type
 from 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS Tab, 
    INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE Col 
WHERE 
    Col.Constraint_Name = Tab.Constraint_Name
    AND Col.Table_Name = Tab.Table_Name
    AND (Constraint_Type = 'PRIMARY KEY' OR Constraint_Type = 'FOREIGN KEY')
	 AND Col.Table_Name IN ('A4_SanPham','A4_NhanVien','A4_LoaiSP')
-- c) Viết câu lệnh để thêm trường phiên bản của sản phẩm.--
alter table SanPham add PhienBan char;

-- 8, THỰC HIỆN --

--a) Đặt chỉ mục (index) cho cột tên người chịu trách nhiệm--
create index Ten_Nguoi_Chiu_Trach_Nhiem on NhanVien(TenNV);

--b) Viết các View sau:--
--◦ View_SanPham: Hiển thị các thông tin Mã sản phẩm, Ngày sản xuất, Loại sản phẩm--
create view SanPham_View 
as select * from SanPham;
select * from SanPham_View;
--◦ View_SanPham_NCTN: Hiển thị Mã sản phẩm, Ngày sản xuất, Người chịu trách nhiệm--
create view NCTN_View
as 
select SanPham.*,  NhanVienSanPham.NhanVienID, NhanVien.TenNV from SanPham, NhanVienSanPham, NhanVien 
where  SanPham.MaSP =  NhanVienSanPham.SanPhamID and NhanVienSanPham.NhanVienID = NhanVien.MaNV;
select * from NCTN_View;
--◦ View_Top_SanPham: Hiển thị 5 sản phẩm mới nhất (mã sản phẩm, loại sản phẩm, ngày sản xuất)--
create view Top_SanPham_View
as
select top 5 * from SanPham order by NgaySX desc;
select * from Top_SanPham_View;

--c) Viết các Store Procedure sau:--

--◦ SP_Them_LoaiSP: Thêm mới một loại sản phẩm--
create procedure LoaiSP_list_all  @ma nchar(20), @ten nvarchar(255)
as
begin
	insert into LoaiSP(MaLoaiSP, TenLoaiSP)
	values (@ma, @ten)
	select *  from LoaiSP;
end
exec LoaiSP_list_all @ma = 'Z38A', @ten = N'Máy tính bàn Z38';

--◦ SP_Them_NCTN: Thêm mới người chịu trách nhiệm--
create procedure nctn_list_all  @ma int, @ten nvarchar(255)
as
begin
	insert into NhanVien(MaNV, TenNV)
	values (@ma, @ten)
	select *  from NhanVien;
end
exec nctn_list_all @ma = '987453', @ten = N'Tô Huyền Trang';

--◦ SP_Them_SanPham: Thêm mới một sản phẩm--
create procedure sanpham_list_all  @ma nchar(20), @ngay date, @loai nchar(20)
as
begin
	insert into SanPham(MaSP, NgaySX, LoaiSPID)
	values (@ma,  @ngay, @loai)
	select *  from SanPham;
end
exec sanpham_list_all @ma = 'Z38 111112', @ngay = '12-12-09', @loai = 'Z38A';

--◦ SP_Xoa_SanPham: Xóa một sản phẩm theo mã sản phẩm--
create procedure SP_Xoa_SanPham @ma nchar(20)
as
begin
delete from SanPham where MaSP = @ma
select *  from SanPham;
end

exec SP_Xoa_SanPham @ma =  'Z37 111112';

--◦ SP_Xoa_SanPham_TheoLoai: Xóa các sản phẩm của một loại nào đó--
create procedure SP_Xoa_SanPham_TheoLoai @maloai nchar(20)
as
begin
delete from SanPham where LoaiSPID = @maloai
select *  from SanPham;
end

exec SP_Xoa_SanPham_TheoLoai @maloai =  'Z38A';
