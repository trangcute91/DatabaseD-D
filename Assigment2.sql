create table NhanVien(
	MaNV char(20) primary key,
	TenNV varchar(255),
	Dienthoai decimal(10),
	Email char(20),
	TaiKhoan char(20),
	MatKhau char(20)
);

create table  TacGia(
	TenTacGia varchar(255),
	ButDanh char(20),
	DienThoai decimal(10),
	Email char(20),
	ID int primary key
);

create table BaiViet(
	TieuDe varchar(255),
	NoiDung varchar(255),
	NgayVietBai datetime,
	NgayXuatBan datetime,
	AnhDaiDien varchar(255),
	Slug char(20),
	ID int primary key,
	NhanVienID char(20) foreign key references NhanVien(MaNV),
	TacGiaID int foreign key  references TacGia(ID)
);

create table  The(
	TenThe char(20),
	Slug char(20),
	ID int primary key
);

create table BaiVietThe(
	BaiVietID int foreign key references BaiViet(ID),
	TheID int foreign  key references The(ID)
);

create table DanhMuc(
	TenDanhMuc char(20),
	Slug char(20),
	ID int primary key
);

create table BaiVietDanhMuc(
	BaiVietID int foreign key references BaiViet(ID),
	DanhMucID int foreign  key references DanhMuc(ID)
);

create table  BinhLuan(
	TenTaiKhoan varchar(255),
	BinhLuan varchar(255),
	Email char(20),
	SoLuotLike  int,
	ThoiGianDang datetime,
	ID int primary key,
	BaiVietID int foreign key references BaiViet(ID),
);