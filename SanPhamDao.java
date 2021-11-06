package Assigment3;

import java.util.ArrayList;
import java.util.Scanner;

public class SanPhamDao {
    ArrayList<SanPham> Sanphams = new ArrayList<>();

    public void themvaoSanPhamDao(NhomHangDao NhomHangDao1){
        SanPham a = new SanPham();
        a.nhapTT_Sanpham(NhomHangDao1);
        if(a.getMasanpham() != null)
            Sanphams.add(a);
    }

    public void InSanPhamDao(){
        System.out.println("So cac SanPhamDao: "+Sanphams.size());
        for (SanPham a: Sanphams){
            a.InTT_sanpham();
            System.out.println();
        }
    }

    public SanPham timkiemSanPhamDao(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Nhap ma san pham: ");
        String maSanPhamNhap = sc.nextLine();
        for(SanPham a: Sanphams){
            if (maSanPhamNhap.equalsIgnoreCase(a.getMasanpham())){
                a.InTT_sanpham();
                return a ;
            }
        }
        System.out.println("Khong tim thay San Pham.");
        return null;
    }
    public void timkiemSanPhamDao(String temp){
        for(SanPham a: Sanphams){
            if (temp.equalsIgnoreCase(a.getMasanpham())){
                a.InTT_sanpham();
                return;
            }
        }
    }

}
