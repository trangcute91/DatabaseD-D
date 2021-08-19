create table SanPham(
	TenSP nvarchar(200) not null,
	MoTa nvarchar(255),
	DonVi nvarchar(200) not null,
	Gia decimal,
	SoLuong int not null,
	ID int primary key identity(1,1)
);

create table NhaSX(
	MS int primary key not null,
	TenHang nvarchar(255),
	DiaChi  nvarchar(255),
	DienThoai decimal(10) not null unique
);

create table  DonHang(
	SanPhamID int not null foreign key references SanPham(ID),
	NhaSXID int not null foreign key references NhaSX(MS)
);

drop table  DonHang;
drop table  NhaSX;
drop table  SanPham;

-- 3. THÊM  DỮ LIỆU --

insert into SanPham(TenSP,  Mota, DonVi, Gia, SoLuong)
	values
	(N'Máy Tính T450',N'Máy Nhập Cũ', N'Chiếc', '1000', '10'),
	(N'Điện Thoại Nokia  5670',N'Điện Thoại Hot', N'Chiếc', '200', '200'),
	(N'Máy In SamSung 450',N'Máy in loại thường', N'Chiếc', '100', '10')

insert into NhaSX(MS, TenHang, DiaChi, DienThoai)
	values
	('123', N'Asus', N'USA', '983232'),
	('124', N'Dell', N'USA', '983233')

insert into DonHang(SanPhamID, NhaSXID)
	values
	('1','123'),
	('2','123'),
	('3','124')

-- 4. TRUY VẤN --
select *  from  SanPham;
select *  from  NhaSX;
select *  from  DonHang;

-- 5. TRUY VẤN THEO --
select * from NhaSX order by TenSP  desc;
select * from SanPham order by Gia  desc;
select * from NhaSX where TenHang like 'Asus';
select * from SanPham where SoLuong <11;
select * from SanPham where ID in (select SanPhamID from DonHang where NhaSXID like '123')

-- 6. TRUY VẤN ĐỂ LẤY --
--a) Số hãng sản phẩm mà cửa hàng có.--
select count (*) as SoHangHienCo from NhaSX;
--b) Số mặt hàng mà cửa hàng bán.--
select count (*) as MatHangDangBan from SanPham;
--c) Tổng số loại sản phẩm của mỗi hãng có trong cửa hàng.--
select count (*) from DonHang where NhaSXID = '123';
select count (*) from DonHang where NhaSXID = '124';
--d) Tổng số đầu sản phẩm của toàn cửa hàng--
select sum(SoLuong)  from SanPham;

-- 7, THAY ĐỔI CSDL--

--a) Viết câu lệnh để thay đổi trường giá tiền của từng mặt hàng là dương(>0).--
alter table SanPham add check (Gia >= 0);

--b) Viết câu lệnh để thay đổi số điện thoại phải bắt đầu bằng 0.--
alter table NhaSX add check (DienThoai ='0%');

--c) Viết các câu lệnh để xác định các khóa ngoại và khóa chính của các bảng.--
alter table  SanPham add primary key  (ID);
alter table  NhaSX add primary key (MS);
alter table  DonHang add foreign key (SanPhamID)  references SanPham(ID);
alter table  DonHang add foreign key (NhaSXID)  references NhaSX(MS);

--  8, THỰC HIỆN --

--a) Thiết lập chỉ mục (Index) cho các cột sau: Tên hàng và Mô tả hàng để tăng hiệu suất truy vấn dữ liệu từ 2 cột này--

create index hang_hoa
on SanPham(TenSP, MoTa);

--b) Viết các View sau:--
--◦ View_SanPham: với các cột Mã sản phẩm, Tên sản phẩm, Giá bán--
create view KH_View as 
select ID, TenHang, Gia from SanPham;
--◦ View_SanPham_Hang: với các cột Mã SP, Tên sản phẩm, Hãng sản xuất--
create view KH_View as 
select SanPham.ID, SanPham.TenSP, NhaSX.TenHang from SanPham, NhaSX, DonHang where SanPham.ID = DonHang.SanPhamID and NhaSX.MS =  DonHang.NhaSXID;

--c) Viết các Store Procedure sau:
--◦ SP_SanPham_TenHang: Liệt kê các sản phẩm với tên hãng truyền vào store--
create procedure show_hang_order 
	as
	begin
	select SanPham.TenSP, NhaSX.TenHang
	from  SanPham, NhaSX
	order by  NhaSX.TenHang;
end;
--◦ SP_SanPham_Gia: Liệt kê các sản phẩm có giá bán lớn hơn hoặc bằng giá bán truyền vào --
create procedure show_hanggia_order 
	as
	begin
	select ID, TenSP, MoTa, DonVi,Gia, SoLuong
	from  SanPham
	order by  SanPham.Gia
end;

alter procedure show_hanggia_order (@NhapGia as decimal)
	as
	begin
	select ID, TenSP, MoTa, DonVi,Gia, SoLuong
	from  SanPham where Gia <= @NhapGia
	order by  SanPham.Gia
end;

--◦ SP_SanPham_HetHang: Liệt kê các sản phẩm đã hết hàng (số lượng = 0)--
create procedure show_hanghet_order 
	as
	begin
	select ID, TenSP, MoTa, DonVi,Gia, SoLuong
	from  SanPham where SoLuong = '0'
	order by  SanPham.SoLuong
end;

--d) Viết Trigger sau:
--◦ TG_Xoa_Hang: Ngăn không cho xóa hãng--
create trigger ko_xoa_hang on NhaSX
after delete
as rollback transaction
--◦ TG_Xoa_SanPham: Chỉ cho phép xóa các sản phẩm đã hết hàng (số lượng = 0)--
create trigger ko_xoa_sp on SanPham
after delete
as
if( (select SoLuong from SanPham) > 0)
	rollback transaction;
