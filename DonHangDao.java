package Assigment3;

import java.util.*;
import java.time.LocalDateTime;


public class DonHangDao {
    ArrayList<Donhang> donhangs = new ArrayList<>();

    public void ThemvaoDonhangDao(SanPhamDao SanPhamDao1){
        Donhang a = new Donhang();
        a.nhapTT_Donhang(SanPhamDao1.Sanphams);
        donhangs.add(a);
    }

    public void InDonhangDao(){
        System.out.println("So cac DonHangDao: " + donhangs.size());
        for (Donhang a: donhangs){
            a.InTT();
            System.out.println();
        }
    }
    public void baocao(){
        int tongsanphambanduoc = 0;
        double sotiennhap=0,sotienban=0;

        for (Donhang a: donhangs){
            tongsanphambanduoc+=a.listsanphammua.size();
            for (SanPham b: a.listsanphammua){
                sotienban+=b.getGiaban();
                sotiennhap+=b.getGianhap();
            }
        }
        System.out.println("Tong so sp ban dc: "+tongsanphambanduoc);
        System.out.println("Tong so tien nhap: "+sotiennhap);
        System.out.println("Tong so tien ban dc: "+ sotienban);
    }

    public void top3(SanPhamDao sanPhamDao){
        Scanner sc = new Scanner(System.in);
        HashMap<String,Integer> banxephang = new HashMap();
        System.out.println("Nhap thang nam (mm/yyyy)");
        String[] stime = sc.next().split("/");
        LocalDateTime time = LocalDateTime.of(Integer.parseInt(stime[1]), Integer.parseInt(stime[0]),1,0,0);
        for (Donhang a: donhangs){
            if (a.getNgaymuahang().getMonth() == time.getMonth() && a.getNgaymuahang().getYear()== time.getYear()){
                for (SanPham b: a.listsanphammua){
                    if (  banxephang.get(b.getMasanpham())==null) banxephang.put(b.getMasanpham(),1);
                    else banxephang.put(b.getMasanpham(),banxephang.get(b.getMasanpham())+1);

                }
            }

        }

        if (banxephang.size()== 0) {System.out.println("Không bán được");
            return;
        }
        if( banxephang.size()<4 && banxephang.size()>0){
            Set<String> keys = banxephang.keySet();
            for(String key: keys){
                sanPhamDao.timkiemSanPhamDao(key);
                System.out.println();
            }
            return;
        }

        for(int i = 0;i<3;i++){
            int max = 0;
            String kmax="" ;
            Set<String> keys = banxephang.keySet();
            for(String key: keys){
                if (banxephang.get(key)>max){
                    max = banxephang.get(key);
                    kmax = key;
                }
            }
            sanPhamDao.timkiemSanPhamDao(kmax);
            System.out.println();
            banxephang.remove(kmax);
        }
    }
}
