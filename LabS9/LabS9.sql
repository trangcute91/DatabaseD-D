-- 1, NHẬP CSDL --
create table LoaiSach(
	TenLoaiSach nvarchar(255) not null,
	ID int primary key not null
);

create table TacGia(
	ButDanh nvarchar(255) not  null,
	ID int primary key not null
);
create table NhaXB(
	TenNXB nvarchar(255) not null,
	DiaChi nvarchar(255),
	ID int primary key not null
);

create table Sach(
	TenSach  nvarchar(255) not null,
	NamXB date not null  check (NamXB <=  GETDATE()),
	NoiDung ntext,
	LanXB decimal,
	GiaBan decimal(12,3) not null,
	SoLuong decimal,
	Masach char(20) Nprimary key not null,
	LoaiSachID int NOT NULL  foreign key references LoaiSach(ID)
);

create  table SachTG(
	SachID char(20) NOT NULL foreign key references Sach(MaSach),
	TacGiaID int NOT NULL foreign key references TacGia(ID)
);

create table SachNXB(
	SachID char(20) NOT NULL foreign key references Sach(MaSach),
	NhaXBID  int NOT NULL foreign key references NhaXB(ID)
);

drop table SachNXB;
drop table SachTG;
drop table Sach;
drop table NhaXB;
drop table TacGia;
drop table LoaiSach;

-- 2. Viết lệnh SQL chèn vào các bảng của CSDL các dữ liệu mẫu --

insert into LoaiSach(TenLoaiSach, ID)
	values(N'Khoa Học Xã Hội', '1');

insert into TacGia(ButDanh, ID)
	values(N'Eran Katz', '1');

insert into NhaXB(TenNXB, DiaChi, ID)
	values(N'Tri Thức', N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội', '1');

insert into  Sach(TenSach, NamXB, NoiDung, LanXB, GiaBan, SoLuong, Masach, LoaiSachID)
	values(N'Trí Tuệ Do Thái', '1-1-2010', N'Bạn có muốn biết: Người Do Thái sáng tạo ra cái gì và nguồn gốc
trí tuệ của họ xuất phát từ đâu không? Cuốn sách này sẽ dần hé lộ
những bí ẩn về sự thông thái của người Do Thái, của một dân tộc
thông tuệ với những phương pháp và kỹ thuật phát triển tầng lớp trí
thức đã được giữ kín hàng nghìn năm như một bí ẩn mật mang tính
văn hóa.', '1', '79', '100', 'B001', '1');

insert into SachTG(SachID, TacGiaID) 
	values('B001', '1');

insert into SachNXB(SachID, NhaXBID)
	values('B001', '1');

-- 3. Liệt kê các cuốn sách có năm xuất bản từ 2008 đến nay--
select * from Sach where NamXB > '1-1-2008' and NamXB <=  GETDATE();

-- 4. Liệt kê 10 cuốn sách có giá bán cao nhất --
select top(10) * from Sach order by GiaBan desc;

-- 5. Tìm những cuốn sách có tiêu đề chứa từ “tin học" --
select * from Sach where TenSach like N'%tin học%';

-- 6. Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần --
select * from Sach where TenSach like N'T%' order by TenSach desc;

-- 7. Liệt kê các cuốn sách của nhà xuất bản Tri thức --
select SachNXB.*, Sach.TenSach, NhaXB.TenNXB from SachNXB, Sach, NhaXB where NhaXB.TenNXB like N'Tri Thức' and  Sach.MaSach =  SachNXB.SachID and SachNXB.NhaXBID = NhaXB.ID;

-- 8. Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”

-- 7. Liệt kê các cuốn sách của nhà xuất bản Tri thức --
select Sach.TenSach, SachNXB.SachID, NhaXB.* from SachNXB, Sach, NhaXB where Sach.TenSach like N'Trí Tuệ Do Thái' and  Sach.MaSach =  SachNXB.SachID and SachNXB.NhaXBID = NhaXB.ID;

-- 9. Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản, Loại sách --
select Sach.Masach,  Sach.TenSach, Sach.NamXB, Sach.LoaiSachID,  LoaiSach.TenLoaiSach, SachNXB.NhaXBID, NhaXB.TenNXB from Sach, NhaXB, SachNXB, LoaiSach where Sach.MaSach =  SachNXB.SachID and SachNXB.NhaXBID = NhaXB.ID and Sach.LoaiSachID = LoaiSach.ID;

-- 10. Tìm cuốn sách có giá bán đắt nhất --
select * from Sach where  GiaBan in (select Max(GiaBan) from Sach);

-- 11. Tìm cuốn sách có số lượng lớn nhất trong kho--
select * from Sach where  SoLuong in (select Max(SoLuong) from Sach);

-- 12. Tìm các cuốn sách của tác giả “Eran Katz” --
select Sach.*, SachTG.TacGiaID, TacGia.ButDanh from Sach, TacGia, SachTG where ButDanh like N'Eran Katz' and Sach.MaSach = SachTG.SachID and TacGia.ID = SachTG.TacGiaID;

-- 13. Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước --
update  Sach set GiaBan = (GiaBan*10)/100 where NamXB <= '1-1-2010';

-- 14. Thống kê số đầu sách của mỗi nhà xuất bản --
select NhaXB.TenNXB, Sach.TenSach, Sach.SoLuong from  NhaXB, Sach, SachNXB where NhaXB.ID = SachNXB.NhaXBID and Sach.Masach = SachNXB.SachID;

-- 15. Thống kê số đầu sách của mỗi loại sách --
select Sach.Masach, Sach.TenSach, Sach.LoaiSachID, LoaiSach.TenLoaiSach from Sach, LoaiSach where Sach.LoaiSachID = LoaiSach.ID;

-- 16. Đặt chỉ mục (Index) cho trường tên sách --
create index Ten_Sach on Sach(TenSach)
select * from Sach;

-- 17. Viết view lấy thông tin gồm: Mã sách, tên sách, tác giả, nhà xb và giá bán --
create view Thong_Tin_Sach_View
as
select Sach.Masach, Sach.TenSach, Sach.GiaBan, TacGia.ButDanh, NhaXN.TenNXB from Sach, TacGia, NhaXB, SachNXB, SachTG  where Sach.Masach = SachNXB.SachID and SachNXB.NhaXBID and SachTG.SachID = Sach.Masach and SachTG = TacGia.ID;

-- 18. Viết Store Procedure:-- 

-- ◦ SP_Them_Sach: thêm mới một cuốn sách-- 
create procedure SP_Them_Sach @MaSach char(20), @TenSach nvarchar(255), @NoiDung ntext, @NamXB date, @LanXB int, @GiaBan decimal(12,3), @SoLuong int, @LoaiSachID int
as 
begin
	insert into Sach(Masach, TenSach, NamXB, NoiDung, LanXB, GiaBan, SoLuong, LoaiSachID)
		values(@MaSach, @TenSach,  @NamXB,  @NoiDung, @LanXB,  @GiaBan,  @SoLuong,  @LoaiSachID)
	select * from  Sach
end;
exec SP_Them_Sach @MaSach='C201', @TenSach = N'Những người khốn khổ',@NamXB = '12-06-1985', @NoiDung = 'Là câu chuyện về xã hội nước Pháp trong khoảng hơn 20 năm đầu thế kỷ 19 kể từ thời điểm Napoléon I lên ngôi và vài thập niên sau đó. Nhân vật chính của tiểu thuyết là Jean Valjean, một cựu tù khổ sai tìm cách chuộc lại những lỗi lầm gây ra thời trai trẻ. Bộ tiểu thuyết không chỉ nói tới bản chất của cái tốt, cái xấu, của luật pháp, mà tác phẩm còn là cuốn bách khoa thư đồ sộ về lịch sử, kiến trúc của Paris, nền chính trị, triết lý, luật pháp, công lý, tín ngưỡng của nước Pháp nửa đầu thế kỷ 19. Chính nhà văn Victor Hugo cũng đã viết cho người biên tập rằng: "Tôi có niềm tin rằng đây sẽ là một trong những tác phẩm đỉnh cao, nếu không nói là tác phẩm lớn nhất, trong sự nghiệp cầm bút của mình',@LanXB = '3',  @GiaBan = '150',  @SoLuong = '10',  @LoaiSachID = '1'
DROP PROCEDURE SP_Them_Sach

-- ◦ SP_Tim_Sach: Tìm các cuốn sách theo từ khóa-- 
create procedure SP_Tim_Sach
as 
begin
	select * from Sach where TenSach like N'%Do%'
end;
EXEC SP_Tim_Sach

-- ◦ SP_Sach_ChuyenMuc: Liệt kê các cuốn sách theo mã chuyên mục-- 
create procedure SP_Sach_ChuyenMuc
as
begin
	select LoaiSach.TenLoaiSach, Sach.LoaiSachID, Sach.Masach, Sach.TenSach from Sach, LoaiSach where Sach.LoaiSachID = LoaiSach.ID
	order by Sach.LoaiSachID
end
EXEC SP_Sach_ChuyenMuc

--19. Viết trigger không cho phép xóa các cuốn sách vẫn còn trong kho (số lượng > 0)--
create trigger kh_xoa_sach  on Sach
after delete
as
	if ((select SoLuong from Sach) >0)
	rollback transaction;

--20. Viết trigger chỉ cho phép xóa một danh mục sách khi không còn cuốn sách nào thuộc chuyên mục này.--
create trigger xoa_danh_muc on LoaiSach
after  delete
as
	if((select SoLuong from Sach, LoaiSach) >0)
	rollback transaction;