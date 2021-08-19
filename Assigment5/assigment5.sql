-- 2, TẠO BẢNG
create table KhachHang(
	tenKH nvarchar(255) not null,
	ID int primary key  not null identity (1,1),
	DienThoai nchar(20) not null unique,
	DiaChi ntext
);

create table SanPham(
	TenSP nvarchar(255) not null,
	MoTa ntext,
	ID int primary key not null identity (1,1),
	DonGia decimal(12,4) check (DonGia >= 0),
	DonVi  nchar(20)
);

create table DonHang(
	MaSoDH int primary key,
	NgayDat date not null check(NgayDat <=GETDATE()),
	TongTien decimal(12,4),
	KhachHangID int not null  foreign key references KhachHang(ID)
);

create table DonHangSanPham(
	MaSoDH int foreign key references DonHang(MaSoDH),
	MaSP int foreign key references SanPham(ID),
	SoLuong int not null check (SoLuong >0),
	ThanhTien decimal(12,4) not null check(ThanhTien >=0)
);

create table SanPhamKhachHang(
	KhachHangID int not null  foreign key references KhachHang(ID),
	SanPhamID int not null  foreign key references SanPham(ID)
);

drop table SanPhamKhachHang;
drop table DonHangSanPham;
drop table DonHang;
drop table SanPham;
drop table  KhachHang;

-- 3,THÊM DỮ LIỆU --

insert into KhachHang(tenKH, DienThoai, DiaChi)
	values(N'Nguyễn Văn A', '987654321', N'111 Nguyễn Trãi,Thanh Xuân, Hà Nội');

insert into SanPham(TenSP, MoTa, DonGia,DonVi)
	values
	(N'Máy Tính T450', N'Máy Nhập Mới', '1000', N'Chiếc'),
	(N'Điện Thoại Nokia 5670', N'ĐT đang HOT', '200', N'Chiếc'),
	(N'Máy In SamSung 450', N'Máy In đang ế', '100', N'Chiếc');

insert into DonHang(MaSoDH, NgayDat, TongTien,KhachHangID)
	values ('123', '11/18/09', '1500', '1');

insert into  DonHangSanPham(MaSoDH, MaSP, SoLuong, ThanhTien)
	values 
	('123', '1', '1', '1000'),
	('123', '2', '2', '400'),
	('123', '3', '1', '100')

insert  into SanPhamKhachHang(KhachHangID ,SanPhamID)
	values 
	('1', '1'),
	('1', '2'),
	('1', '3');

-- 4, TRUY VẤN ĐỂ --
--  LIỆT KÊ D.SÁCH KH ĐÃ MUA Ở CỬA HẢNG --
select * from KhachHang;
-- LIỆT  KÊ D.SÁCH SP CỦA CỬA HÀNG --
select * from SanPham;
-- LIỆT KÊ D.SÁCH CÁC ĐON ĐẶT HÀNG
select * from DonHang;
select * from DonHangSanPham;

-- 5, TRUY VẤN ĐỂ --
-- LIỆT KÊ D.SÁCH KH THEO ALPHABET --
select  * from KhachHang order by tenKH  asc;
-- LIỆT KÊ D.SÁCH SP THE THỨ TỰ GIÁ GIẢM DẦN --
select * from SanPham order by DonGia desc;
-- LIỆT KÊ D.SÁCH MÀ KH NGUYỄN VĂN A ĐÃ MUA
select SanPhamKhachHang.*, SanPham.TenSP  from  SanPham, SanPhamKhachHang where SanPhamKhachHang.SanPhamID = SanPham.ID;

-- 6,  TRUY VẤN ĐỂ --
-- SỐ KH ĐÃ MUA--
select count (*) as TongSoLuongKH from KhachHang;
-- SỐ MẶT HÀNG ĐÃ BÁN --
select count (*) as MatHang from SanPham;
-- TỔNG TIỀN TỪNG ĐƠN HÀNG --
select sum (ThanhTien) as TongGiaDH from DonHangSanPham;

-- 7, THAY ĐỔI CSDL --
-- thay đổi trường giá tiền của từng mặt hàng là dương(>0). --
 alter table SanPham add check (DonGia >= 0);
-- thay đổi ngày đặt hàng của khách hàng phải nhỏ hơn ngày hiện tại. --
alter table DonHang add check (NgayDat <= GETDATE());
-- thêm trường ngày xuất hiện trên thị trường của sản phẩm. --
alter table SanPham add NgayXuatHien date;

--  8, Thực hiện các yêu cầu --

-- A. Đặt chỉ mục (index) cho cột Tên hàng và Người đặt hàng để tăng tốc độ truy vấn dữ liệu trên các cột này.--
create index Thong_tinKH
on SanPhamKhachHang(KhachHangID, SanPhamID);

-- B. XÂY DỰNG CÁC VIEW --
-- View_KhachHang với các cột: Tên khách hàng, Địa chỉ, Điện thoại --
create view KH_View as 
select tenKH, DiaChi from KhachHang;
-- View_SanPham với các cột: Tên sản phẩm, Giá bán --
create view SP_View as
select TenSP, DonGia from SanPham;
-- View_KhachHang_SanPham với các cột: Tên khách hàng, Số điện thoại, Tên sản phẩm, Số lượng, Ngày mua--
create view KH_SP_View as
select KhachHang.tenKH, KhachHang.DienThoai, KhachHang.DiaChi,SanPham.TenSP, DonHangSanPham.SoLuong, DonHang.NgayDat from KhachHang, SanPham, DonHang, DonHangSanPham 
where SanPham.ID = DonHangSanPham.MaSP; 

-- C. VIẾT STORED PROCEDUCE --
-- SP_TimKH_MaKH: Tìm khách hàng theo mã khách hàng  --
create procedure show_kh_order 
	as
	begin
	select KhachHang.tenKH, KhachHang.ID, KhachHang.DienThoai, KhachHang.DiaChi
	from  KhachHang
	order by  KhachHang.ID;
end;
-- SP_TimKH_MaHD: Tìm thông tin khách hàng theo mã hóa đơn --;
create procedure show_khhd_list
	as
	begin
	select DonHang.MaSoDH, DonHang.KhachHangID, KhachHang.tenKH, KhachHang.DienThoai, KhachHang.DiaChi
	from  DonHang, KhachHang
	order by  DonHang.MaSoDH;
end;
-- SP_SanPham_MaKH: Liệt kê các sản phẩm được mua bởi khách hàng có mã được truyền vào Store--
create procedure show_sanpham_order 
	as
	begin
	select SanPhamKhachHang.KhachHangID, SanPhamKhachHang.SanPhamID, SanPham.TenSP
	from  SanPhamKhachHang, SanPham
	order by  SanPhamKhachHang.KhachHangID;
end;