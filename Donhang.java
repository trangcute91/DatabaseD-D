package Assigment3;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Scanner;


public class Donhang {
    private String tenkhachhang;
    private LocalDateTime ngaymuahang;
    ArrayList<SanPham> listsanphammua = new ArrayList<>();

    public Donhang() {
    }

    public void nhapdonhang(){

    }

    public String getTenkhachhang() {
        return tenkhachhang;
    }

    public void setTenkhachhang(String tenkhachhang) {
        this.tenkhachhang = tenkhachhang;
    }

    public LocalDateTime getNgaymuahang() {
        return ngaymuahang;
    }

    public void setNgaymuahang(LocalDateTime ngaymuahang) {
        this.ngaymuahang = ngaymuahang;
    }

    public void nhapTT_Donhang(ArrayList<SanPham> sanphams) {
        Scanner sc = new Scanner(System.in);
        System.out.println("Nhap ten KH: ");
        this.tenkhachhang = sc.nextLine();

        System.out.println("Nhap so luong sp ");
        int n = sc.nextInt();
        sc.nextLine();
        System.out.println("Nhap sp ");
        for (int i = 0; i < n; i++) {
            boolean check = true;
            while (check){
                System.out.printf("San Pham %d = ", i+1);
                String masanphamnhap = sc.nextLine();
                int count = 0;
                for (SanPham a: sanphams){
                    if (masanphamnhap.equals(a.getMasanpham())){
                        listsanphammua.add(a);
                        check = false;
                        break;
                    }
                    count++;
                }
                if (count == sanphams.size()) System.out.println("Khong co ma san pham nay");
            }

        }
            boolean check2= true;
            while (check2){
                try {
                    System.out.println("Ngay mua hang (dd/MM/yyyy): ");
                    String[] a = sc.next().split("/");
                    LocalDateTime temp = LocalDateTime.of(Integer.parseInt(a[2]),Integer.parseInt(a[1]),Integer.parseInt(a[0]),0,0);
                    setNgaymuahang(temp);
                    check2 = false;

                } catch (Exception e) {
                    System.out.println(" Again!");
                    continue;
                }

            }

    }

    public static void show(ArrayList<SanPham> listsanphammua ) {
        for(SanPham a: listsanphammua) {
            a.InTT_sanpham();
            System.out.println();
        }
    }


	public void InTT() {
		 System.out.println("TenKh " + getTenkhachhang());
		 System.out.println("Ngay mua hang: " + getNgaymuahang().format(DateTimeFormatter.ofPattern("dd-MM-yyyy")));
	     System.out.printf("San Pham : ");
	     show(listsanphammua);
	}

}
