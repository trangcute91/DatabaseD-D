create table LopHoc(
	TenLop  varchar(255),
	MaLop  varchar(255) primary key,
	PhongHoc  decimal(10)
);

create table SinhVien(
	TenSV varchar(255) foreign key references LopHoc(MaLop),
	MaSV char(20) primary key,
	NgaySinh date
);

create table ThongTinMonThi(
	MonThi varchar(255),
	MaMon  char(20) primary key,
	DiemThi decimal(10,2),
	KetQua char(10)
);

create table MonThiCuaSV(
	MaSV char(20) foreign key references SinhVien(MaSV) primary key,
	MaMon char(20)  foreign key references ThongTinMonThi(MaMon),
	DiemThi decimal(10,2),
	KetQuaThi char(10),
);