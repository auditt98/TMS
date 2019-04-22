Use Teacher

create table DonVi(
	MaKhoa int primary key identity(1,1),
	TenKhoa nvarchar(max) not null
)

create table BoMon(
	MaBoMon int primary key identity(1,1),
	MaKhoa int foreign key references DonVi(MaKhoa),
	TenBoMon nvarchar(MAX) not null
)

create table GiaoVien(
	MaGV int primary key identity(1,1),
	MaBoMon int foreign key references BoMon(MaBoMon),
	TenGiaoVien nvarchar(max) not null,
	QueQuan nvarchar(max) not null,
	GioiTinh nvarchar(10)  not null,
	NgaySinh datetime not null
)

create table ThanNhan(
	MaThanNhan int primary key identity(1,1),
	TenThanNhan nvarchar(max) not null,
	NgaySinh datetime not null,
	GioiTinh nvarchar(10)  not null,
	NgheNghiep nvarchar(max)
)

create table GiaoVien_ThanNhan(
	MaGV int foreign key references GiaoVien(MaGV),
	MaThanNhan int foreign key references ThanNhan(MaThanNhan),
	primary key(MaGV, MaThanNhan)
)

create table DiaChiLienHe(
	MaLienHe int primary key identity(1,1),
	Phuong nvarchar(20) not null,
	Quan nvarchar(20) not null,
	ThanhPho nvarchar(20) not null,
	DT_NhaRieng nvarchar(max),
	DT_DiDong nvarchar(max),
	Email nvarchar(max)
)

create table LichSuDCLH(
	MaGV int foreign key references GiaoVien(MaGV),
	MaLienHe int foreign key references DiaChiLienHe(MaLienHe),
	ThoiGian datetime not null,
	primary key(MaGV, MaLienHe)
)

create table MienGiam(
	MaMienGiam int primary key identity(1,1),
	TyLe float not null
)

create table ChucVuDang(
	MaCVD int primary key identity(1,1),
	MaMienGiam int foreign key references MienGiam(MaMienGiam),
	TenCVD nvarchar(max)
)

create table ChucVuChinhQuyen(
	MaCVCQ int primary key identity(1,1),
	MaMienGiam int foreign key references MienGiam(MaMienGiam),
	TenCVCQ nvarchar(max) not null
)

create table HocVi(
	MaHocVi int primary key identity(1,1),
	TenHocVi nvarchar(max) not null
)

create table HocVan(
	MaHocVan int primary key identity(1,1),
	MaHocVi int foreign key references HocVi(MaHocVi),
	TenTrinhDo nvarchar(max),
	NuocDaoTao nvarchar(max),
	HeDaoTao nvarchar(max),
	NoiDaoTao nvarchar(max),
	NamCap date,
	TenLuanAn nvarchar(max)
)

create table DinhMucDaoTao(
	MaDMDT int primary key identity(1,1),
	TenDinhMuc nvarchar(max),
	SoGioDMDT int
)

create table DinhMucNghienCuu(
	MaDMNC int primary key identity(1,1),
	TenDinhMuc nvarchar(max),
	SoGioDMNC int
)

create table HocHam(
	MaHocHam int primary key identity(1,1),
	MaDMDT int foreign key references DinhMucDaoTao(MaDMDT),
	MaDMNC int foreign key references DinhMucNghienCuu(MaDMNC),
	TenHocHam nvarchar(max)
)

create table CV_ChuyenMonNghiepVu(
	MaCVCMNV int primary key identity(1,1),
	MaDMDT int foreign key references DinhMucDaoTao(MaDMDT),
	MaDMNC int foreign key references DinhMucNghienCuu(MaDMNC),
	TenCVCMNV nvarchar(max)
)

create table HS_CVD(
	MaGV int foreign key references GiaoVien(MaGV),
	MaCVD int foreign key references ChucVuDang(MaCVD),
	ThoiDiemNhan datetime not null,
	ThoiDiemKetThuc datetime not null,
	primary key(MaGV, MaCVD)
)

create table HS_CVCQ(
	MaGV int foreign key references GiaoVien(MaGV),
	MaCVCQ int foreign key references ChucVuChinhQuyen(MaCVCQ),
	ThoiDiemNhan datetime not null,
	ThoiDiemKetThuc datetime not null,
	primary key(MaGV, MaCVCQ)
)

create table HS_CVCMNV(
	MaGV int foreign key references GiaoVien(MaGV),
	MaCVCMNV int foreign key references CV_ChuyenMonNghiepVu(MaCVCMNV),
	ThoiDiemNhan datetime not null,
	ThoiDiemKetThuc datetime not null,
	primary key(MaGV, MaCVCMNV)
)

create table HS_HocVan(
	MaGV int foreign key references GiaoVien(MaGV),
	MaHocVan int foreign key references HocVan(MaHocVan),
	ThoiDiemNhan datetime not null,
	ThoiDiemKetThuc datetime not null,
	primary key(MaGV, MaHocVan)
)

create table HS_HocHam(
	MaGV int foreign key references GiaoVien(MaGV),
	MaHocHam int foreign key references HocHam(MaHocHam),
	ThoiDiemNhan datetime not null,
	ThoiDiemKetThuc datetime not null,
	primary key(MaGV, MaHocHam)
)

create table HocPhan(
	MaHocPhan int primary key identity(1,1),
	MaBoMon int foreign key references BoMon(MaBoMon),
	SoTiet int not null,
	SoTinChi int not null
)

create table Lop(
	MaLop int primary key identity(1,1),
	MaHocPhan int foreign key references HocPhan(MaHocPhan),
	TenLop nvarchar(max) not null,
	He nvarchar(max) not null,
	SiSo int
)
create table GioChuan_HoiDong(
	MaGCHD int primary key identity(1,1),
	TenGioChuan nvarchar(max) not null,
	SoGio int not null,
	DonVi int  not null,
	So int not null
)

create table GioChuan_GiangDay(
	MaGCGD int primary key identity(1,1),
	TenGioChuan nvarchar(max) not null,
	SoGio int not null,
	DonVi int  not null,
	So int not null
)
create table GiangDay(
	MaCVGD int primary key identity(1,1),
	MaGCGD int foreign key references GioChuan_GiangDay(MaGCGD),
	TenCongViec nvarchar(max) not null
)

create table GiangDay_Lop(
	MaCVGD int foreign key references GiangDay(MaCVGD),
	MaLop int foreign key references Lop(MaLop),
	SoTiet int,
	primary key(MaCVGD, MaLop)
)

create table PhanCong_GiangDay(
	MaGV int foreign key references GiaoVien(MaGV),
	MaCVGD int foreign key references GiangDay(MaCVGD),
	primary key (MaGV, MaCVGD)
)

create table HoiDong(
	MaCVHD int primary key identity(1,1),
	MaGCHD int foreign key references GioChuan_HoiDong(MaGCHD),
	TenCongViec nvarchar(max) not null,
	TenHoiDong nvarchar(max) not null
)

create table VaiTroHoiDong(
	MaVTHD int primary key identity(1,1),
	TenVaiTro nvarchar(max) not null
)

create table PhanCong_HoiDong(
	MaGV int foreign key references GiaoVien(MaGV),
	MaCVHD int foreign key references HoiDong(MaCVHD),
	MaVTHD int foreign key references VaiTroHoiDong(MaVTHD),
	SoLan int default (0),
	primary key(MaGV, MaCVHD, MaVTHD)
)

create table GioChuan_HuongDan(
	MaGCHDan int primary key identity(1,1),
	TenGioChuan nvarchar(max) not null,
	SoGio int not null,
	DonVi int  not null,
	So int not null
)

create table GioChuan_KhaoThi(
	MaGCKT int primary key identity(1,1),
	TenGioChuan nvarchar(max) not null,
	SoGio int not null,
	DonVi int  not null,
	So int not null
)

create table HocVien(
	MaHocVien int primary key identity(1,1),
	TenHocVien nvarchar(max)
)

create table HuongDan(
	MaCVHDan int primary key identity(1,1),
	MaGCHDan int  foreign key references GioChuan_HuongDan(MaGCHDan),
	TenCongViec nvarchar(max) not null
)

create table PhanCong_HuongDan(
	MaGV int  foreign key references GiaoVien(MaGV),
	MaCVHDan int  foreign key references HuongDan(MaCVHDan),
	primary key(MaGV, MaCVHDan)
)

create table HuongDan_HocVien(
	MaCVHDan int  foreign key references HuongDan(MaCVHDan),
	MaHocVien int  foreign key references HocVien(MaHocVien),
	TenDeTai nvarchar(max) not null,
	primary key(MaCVHDan, MaHocVien)
)

create table HocVien_Lop(
	MaHocVien int  foreign key references HocVien(MaHocVien),
	MaLop int  foreign key references Lop(MaLop),
	primary key(MaHocVien, MaLop)
)

create table KhaoThi(
	MaCVKT int primary key identity(1,1),
	MaGCKT int  foreign key references GioChuan_KhaoThi(MaGCKT),
	TenCongViec nvarchar(max) not null
)

create table PhanCong_KhaoThi(
	MaGV int  foreign key references GiaoVien(MaGV),
	MaCVKT int  foreign key references KhaoThi(MaCVKT),
	primary key(MaGV, MaCVKT)
)

create table KhaoThi_LopHoc(
	MaCVKT int  foreign key references KhaoThi(MaCVKT),
	MaHocVien int  foreign key references HocVien(MaHocVien),
	SoBai int not null,
	primary key(MaCVKT, MaHocVien)
)

create table DonViTinh(
	MaDVT int primary key identity(1,1),
	DonVi nvarchar(max) not null,
	So int not null
)

create table LoaiNghienCuu(
	MaLoaiNC int primary key identity(1,1),
	TenLoaiNC nvarchar(max)
)

create table VaiTro(
	MaVT int primary key identity(1,1),
	MaLoaiNC int  foreign key references LoaiNghienCuu(MaLoaiNC),
	TenVaiTro nvarchar(max) not null
)

create table ThuocTinh(
	MaThuocTinh int primary key identity(1,1),
	TenThuocTinh nvarchar(max) not null
)

create table LoaiNC_ThuocTinh(
	MaLoaiNC int  foreign key references LoaiNghienCuu(MaLoaiNC),
	MaThuocTinh int  foreign key references ThuocTinh(MaThuocTinh),
	NoiDung nvarchar(max) not null,
	primary key(MaLoaiNC, MaThuocTinh)
)

create table LoaiCongTrinh(
	MaLoaiCT int primary key identity(1,1),
	TenLoaiCT nvarchar(max) not null,
	GioChuan int not null
)

create table CongTrinhKhoaHoc(
	MaCTKH int primary key identity(1,1),
	MaLoaiCT int  foreign key references LoaiCongTrinh(MaLoaiCT),
	MaLoaiNC int  foreign key references LoaiNghienCuu(MaLoaiNC),
	MaDVT int  foreign key references DonViTinh(MaDVT),
	TenCTNC nvarchar(max) not null,
	SoTacGia int
)

create table PhanCong_NghienCuu(
	MaGV int  foreign key references GiaoVien(MaGV),
	MaCTKH int  foreign key references CongTrinhKhoaHoc(MaCTKH),
	primary key(MaGV, MaCTKH)
)


