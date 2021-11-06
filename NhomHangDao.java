package Assigment3;

import java.util.ArrayList;
import java.util.Scanner;

public class NhomHangDao {
    ArrayList<NhomHang> nhomHangs = new ArrayList<>();

    public void themvaoNhomhangDao(){
        NhomHang temp = new NhomHang();
        temp.NhapTT_nhomhang();
        nhomHangs.add(temp);
    }

    public void inNhomhangDao(){
        System.out.println("So cac nhom hang: "+ nhomHangs.size());
        for (NhomHang a: nhomHangs){
            a.InTT_nhomhang();
            System.out.println();
        }
    }

    public void timkiemNhomhangDao(){
        Scanner sc = new Scanner(System.in);
        System.out.println("Nhap ma nhom hang: ");
        String manhomhangNhap = sc.nextLine();
        for(NhomHang a:nhomHangs){
            if (manhomhangNhap.equalsIgnoreCase(a.getManhomhang())){
                a.InTT_nhomhang();
                return;
            }
        }
        System.out.println("Khong tim thay nhom hang.");
    }

}
