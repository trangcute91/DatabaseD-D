package Assigment3;

import java.util.Scanner;

public class SanPham {
    private String manhomhang,masanpham,mavach,tenhang,mota;
    private double gianhap,giaban;

    public SanPham() {
    }

    public String getManhomhang() {
        return manhomhang;
    }

    public void setManhomhang(String manhomhang) {
        this.manhomhang = manhomhang;
    }

    public String getMasanpham() {
        return masanpham;
    }

    public void setMasanpham(String masanpham) {
        this.masanpham = masanpham;
    }

    public String getMavach() {
        return mavach;
    }

    public void setMavach(String mavach) {
        this.mavach = mavach;
    }

    public String getTenhang() {
        return tenhang;
    }

    public void setTenhang(String tenhang) {
        this.tenhang = tenhang;
    }

    public String getMota() {
        return mota;
    }

    public void setMota(String mota) {
        this.mota = mota;
    }

    public double getGianhap() {
        return gianhap;
    }

    public void setGianhap(double gianhap) {
        this.gianhap = gianhap;
    }

    public double getGiaban() {
        return giaban;
    }

    public void setGiaban(double giaban) {
        this.giaban = giaban;
    }

    public boolean check_price(double a){
        if(a>0) return true;
        else return false;
    }

    static int count = 1;

    public String khoitao_masanpham(String manhomhang1){
        String ketqua;
        ketqua = "";
        ketqua += manhomhang1;
        if(count/10 == 0) return ketqua+"000"+count++;
        if ((count/10)>0 && (count/10)<10 ) return ketqua+"00"+count++;
        if ((count/10)>9 && (count/10)<100 ) return ketqua+"0"+count++;
        return ketqua+count++;

    }
    public void nhapTT_Sanpham( NhomHangDao nhomHangDao1) {

        Scanner sc = new Scanner(System.in);

        int count = 0;
        System.out.println("Nhap ma nhom : ");
        String maNhomhangsp = sc.nextLine();

        for (NhomHang a: nhomHangDao1.nhomHangs) {
            if (a.getManhomhang().equals(maNhomhangsp)) {
                System.out.println("Nhom hang co ma la: " + maNhomhangsp);
                this.manhomhang = maNhomhangsp;
                a.SanPhams.add(this);
                break;
            }
            count ++;
        }
        if (count == nhomHangDao1.nhomHangs.size()) {
            System.out.println("Khong co nhom :" + maNhomhangsp);
            return;
        }



        this.masanpham = khoitao_masanpham(getManhomhang());
        System.out.println("Nhap ma vach: ");
        this.mavach = sc.nextLine();
        System.out.println("Nhap ten sp: ");
        this.tenhang = sc.nextLine();
        System.out.println("Nhap mo ta: ");
        this.mota = sc.nextLine();

        while(true) {

                System.out.println("Nhap gia sp > 0 : ");
                double nhap = sc.nextFloat();
                if (check_price(nhap)) {
                    this.gianhap = nhap;
                    break;
                }else System.out.println("khong hop le, moi nhap lai");


        }

        while(true) {

                System.out.println("Nhap gia ban sp > 0 ");
                float nhap = sc.nextFloat();
                if (check_price(nhap)) {
                    this.giaban = nhap;
                    break;
                }
                else System.out.println("khong hop le, moi nhap lai");
        }
    }


	public void InTT_sanpham() {
        System.out.println("SanPham [manhomhang=" + manhomhang + ", masanpham=" + masanpham + ", mavach=" + mavach + ", tenhang="
				+ tenhang + ", mota=" + mota + ", gianhap=" + gianhap + ", giaban=" + giaban + "]");

    }
}
