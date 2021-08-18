create table KhachHang(
	tenKH varchar(255) not null,
	ID int primary key,
	DienThoai char(20) not null unique,
	DiaChi text
);

create table HangHoa(
	TenSP varchar(255) not null,
	MoTa text,
	MaSP  int primary key,
	DonGia decimal(12,4) check  (DonGia >0),
	DonVi  char(20)
);

create table DonHang(
	MaSoDH int primary key,
	NgayDat date not null check(NgayDat <=GETDATE()),
	TongTien decimal(12,4),
	KhachHangID int not null  foreign key references KhachHang(ID)
);

create table DonHangSapPham(
	MaSoDH int foreign key references DonHang(MaSoDH),
	MaSP int foreign key references HangHoa(MaSP),
	SoLuong int not null check (SoLuong >0),
	ThanhTien decimal(12,4) not null check(ThanhTien >=0)
);