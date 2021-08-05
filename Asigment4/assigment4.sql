create table NhanVien(
	TenNV varchar(200),
	ID int primary key,
	DienThoai decimal(10)
);

create table LoaiHang(
	TenLoai varchar(200),
	ID int primary key
);

create table ThuongHieu(
	TenThuongHieu varchar(200),
	ID int primary key
);

create table NhaCC(
	TenNhaCC varchar(200),
	ID int primary key,
	DienThoai  decimal(10),
	DiaChi varchar(255),
	Email char(20),
	MaHD char(20)
);

create table HangHoa(
	TenHang varchar(200),
	ID int primary key,
	HinhAnh varchar(200),
	Mota varchar(200),
	SoLuongTon decimal,
	SoLuongLoi decimal,
	LoaiHangID int foreign key references LoaiHang(ID),
	ThuongHieuID int foreign key references ThuongHieu(ID),
);

create table PhieuNhapKho(
	ID int primary key,
	NgayNhapKho datetime,
	MoTa varchar(255),
	LoaiPhieuNhap char(20),
	ThongTinKhac varchar(200),
	NhanVienID int foreign key references NhanVien(ID),
	NhaCCID int foreign key references NhaCC(ID)
);

create table PhieuXuatKho(
	ID int primary key,
	NgayXuatKho datetime,
	MoTa varchar(255),
	LoaiPhieuXuat char(20),
	ThongTinKhac varchar(200),
	NhanVienID int foreign key references NhanVien(ID),
);

create table PhieuKiemKho(
	ID int primary key,
	NgayKiemKho datetime,
	MoTa varchar(255),
	LoaiPhieuXuat char(20),
	NhanVienID int foreign key references NhanVien(ID),
);

create table HangHoaNhaCC(
	HangHoaID int foreign key references HangHoa(ID),
	NhaCCID int foreign key references  NhaCC(ID)
);

create table HangHoaPhieuNhap(
	HangHoaID int foreign key references HangHoa(ID),
	PhieuNhapKhoID int foreign key references PhieuNhapKho(ID),
	SoLuong int
);

create table HangHoaPhieuXuat(
	HangHoaID int foreign key references HangHoa(ID),
	PhieuXuatKhoID int foreign key references PhieuXuatKho(ID),
	SoLuong int
);

create table HangHoaPhieuKiem(
	HangHoaID int foreign key references HangHoa(ID),
	PhieuKiemKhoID int foreign key references PhieuKiemKho(ID),
	SoLuongTon int,
	SoLuongLoi int,
	GhiChu char(20)
);

create table HangHoaNhanVien(
	HangHoaID int foreign key references HangHoa(ID),
	NhanVienID int foreign key references NhanVien(ID),
);