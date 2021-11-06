package Assigment3;

import java.util.ArrayList;
import java.util.Scanner;

public class NhomHang {

    private String manhomhang,tennhomhang;
    private float vat;
    public ArrayList<SanPham> SanPhams = new ArrayList<>();

    public NhomHang() {
    }

    public String getManhomhang() {
        return manhomhang;
    }

    public void setManhomhang(String manhomhang) {
        this.manhomhang = manhomhang;
    }

    public String getTennhomhang() {
        return tennhomhang;
    }

    public void setTennhomhang(String tennhomhang) {
        this.tennhomhang = tennhomhang;
    }

    public float getVat() {
        return vat;
    }

    public void setVat(float vat) {
        this.vat = vat;
    }

    public boolean check_manhomhang(String NeedCheck){
        if (NeedCheck.matches("^[^\\s]{4}")) return  true;
        else return false;
    }

    public boolean check_vat(float NeedCheck){
        if (NeedCheck>0 && NeedCheck<1) return true;
        else return false;
    }

    public void NhapTT_nhomhang(){
        Scanner sc = new Scanner(System.in);
        while(true) {
            System.out.println("Nhap ma nhom hang (gom 4 ky tu và ko co khoang cach)");
            String a = sc.nextLine();

            if(check_manhomhang(a)) {
                this.manhomhang = a;
                break;
            }else {
                System.out.println("khong hople, moi nhap lai");
            }
        }

        System.out.println("Nhap ten nhom hang: ");
        this.tennhomhang = sc.nextLine();

        while(true) {
                System.out.println("Nhap vat cua nhom hang: ");
                float vatnhap = sc.nextFloat();
                if (check_vat(vatnhap)) {
                    this.vat = vatnhap;
                    break;
                }
                else {
                    System.out.println("khong hop le, moi nhap lai");
                    sc.nextLine();
                }
        }
    }

	public void InTT_nhomhang(){
        System.out.println("NhomHang [manhomhang:" + manhomhang + ", tennhomhang: " + tennhomhang + ", vat:" + vat+ "]");
    }
}
