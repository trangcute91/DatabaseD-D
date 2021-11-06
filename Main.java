package Assigment3;

import java.util.Scanner;

public class Main {

    public static void forNhomHang(NhomHangDao nhomHangDao) {
        Scanner sc = new Scanner(System.in);
        int choose = 0;
        boolean check = true;
        while (check) {

            do {
                System.out.println("1:Them nhom hang moi");
                System.out.println("2: Hien thi ds nhom hang");
                System.out.println("3: Tim kiem nhom hang");
                System.out.println("4: Thoat");
                System.out.println("Moi nhap lua chon ");
                choose = Integer.parseInt(sc.nextLine());
            }
            while (choose >= 5 && choose <= 0);

            switch (choose){
                case 1:
                    nhomHangDao.themvaoNhomhangDao();
                    break;
                case 2:
                    nhomHangDao.inNhomhangDao();
                    break;
                case 3:
                    nhomHangDao.timkiemNhomhangDao();
                    break;
                case 4:
                    check = false;
                    break;
            }
        }
    }

    public static void forSanPham(SanPhamDao sanPhamDao,NhomHangDao nhomHangDao) {
        Scanner sc = new Scanner(System.in);
        int choose = 0;
        boolean check = true;
        while (check) {

            do {
                System.out.println("1: Them sp moi");
                System.out.println("2: Hien thi ds san pham");
                System.out.println("3: Tim kiem san pham");
                System.out.println("4: Update sp");
                System.out.println("5: Exit");
                System.out.println("Moi nhap lua chon ");
                choose = Integer.parseInt(sc.nextLine());
            }
            while (choose >= 6 && choose <= 0);

            switch (choose){
                case 1:
                    sanPhamDao.themvaoSanPhamDao(nhomHangDao);
                    break;
                case 2:
                    sanPhamDao.InSanPhamDao();
                    break;
                case 3:
                    sanPhamDao.timkiemSanPhamDao();
                    break;
                case 4:
                    SanPham temp = sanPhamDao.timkiemSanPhamDao();
                    if(temp != null){
                        temp.nhapTT_Sanpham(nhomHangDao);
                    }
                    break;
                case 5:
                    check = false;
                    break;
            }
        }
    }

    public static void forDonHang(DonHangDao donHangDao,SanPhamDao sanPhamDao) {
        Scanner sc = new Scanner(System.in);
        int choose = 0;
        boolean check = true;
        while (check) {

            do {
                System.out.println("1: Them don hang moi");
                System.out.println("2: Hien thi ds don hang");
                System.out.println("3: Exit");
                System.out.println("Moi nhap lua chon ");
                choose = Integer.parseInt(sc.nextLine());
            }
            while (choose >= 4 && choose <= 0);

            switch (choose){
                case 1:
                    donHangDao.ThemvaoDonhangDao(sanPhamDao);
                    break;
                case 2:
                    donHangDao.InDonhangDao();
                    break;
                case 3:
                    check = false;
                    break;
            }
        }
    }

    public static void forBaoCao(DonHangDao donHangDao,SanPhamDao sanPhamDao) {
        Scanner sc = new Scanner(System.in);
        int choose = 0;
        boolean check = true;
        while (check) {

            do {
                System.out.println("1: So luong");
                System.out.println("2: Sp ban chay top 3");
                System.out.println("3: Exit");
                System.out.println("Moi nhap lua chon ");
                choose = Integer.parseInt(sc.nextLine());
            }
            while (choose >= 4 && choose <= 0);

            switch (choose){
                case 1:
                    donHangDao.baocao();
                    break;
                case 2:
                    donHangDao.top3(sanPhamDao);
                    break;
                case 3:
                    check = false;
                    break;
            }
        }
    }

    public static void main(String[] args) {
        NhomHangDao nhomHangDao = new NhomHangDao();
        SanPhamDao sanPhamDao = new SanPhamDao();
        DonHangDao donHangDao = new DonHangDao();

        Scanner sc = new Scanner(System.in);
        int choose = 0;
        boolean check = true;
        while (check) {

            do {
            	System.out.println("--- QUAN LY HANG HOA ---");
                System.out.println("1: NHOM HANG");
                System.out.println("2: SAN PHAM");
                System.out.println("3: DON HANG");
                System.out.println("4: BAO CAO");
                System.out.println("5: EXIT");
                System.out.println("Moi nhap lua chon");
                choose = Integer.parseInt(sc.nextLine());
            }
            while (choose >= 6 && choose <= 0);

            switch (choose) {

                case 1:
                    forNhomHang(nhomHangDao);
                    break;
                case 2:
                    forSanPham(sanPhamDao,nhomHangDao);
                    break;
                case 3:
                    forDonHang(donHangDao,sanPhamDao);
                    break;
                case 4:
                    forBaoCao(donHangDao,sanPhamDao);
                    break;
                case 5:
                    check = false;
                    break;


            }


        }

    }
}
