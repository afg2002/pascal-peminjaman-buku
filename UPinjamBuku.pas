program StokBuku;
uses crt,sysutils;
const
     maks=1000;
     namafile='StokBuku.DAT';
type
    TBuku=record
               idBuku : string[10];
               judulBuku : String[20];
               jenisBuku : string[20];
               Pengarang : string[20];
               Penerbit : string[20];
               jumlah : integer;
               Harga : real;
               status : string[20];
    end;
TBukuList=array[1..Maks] of TBuku;
var
   buku:TBukuList;
   banyakData:integer;
   pilihanMenu:byte;

procedure tambahData;
begin
     clrscr;
     if banyakData<Maks then
     begin
          banyakData:=banyakData+1;
          writeln('Pemasukan data ke-',banyakData);
          with buku[banyakData] do
          begin
               write('Masukkan ID Buku : ');readln(idBuku);
               write('Judul Buku : ');readln(judulBuku);
               write('Jenis Buku : ');readln(jenisBuku);
               write('Pengarang : ');readln(Pengarang);
               write('Penerbit : ');readln(Penerbit);
               write('Jumlah Stok : ');readln(jumlah);
               write('Harga Buku : ');readln(harga);
               if jumlah>=1000 then
                  status:='Sangat Banyak'
               else if Harga>=500 then
                    status:='Banyak'
               else if Harga>=100 then
                    status:='Cukup Banyak'
               else if Harga>=1 then
                    status:='Hampir Habis'
               else
                   status:='Habis';
               end;
     end
          else
          writeln('Data telah penuh.');
          writeln('Tekan Enter Untuk Melanjutkan');
          readln;
end;

procedure lihatStok;
var
   i:integer;
begin
     clrscr;
     writeln('List Stok Buku');
     writeln('-----------------------------------------------------------------------');
     writeln('|NO|KODE BUKU|JUDUL BUKU||JENIS BUKU|PENGARANG|PENERBIT||STOK|HARGA|STATUS|');
     writeln('-----------------------------------------------------------------------');
     for i:=1 to banyakData do
     begin
          writeln('| ',i:4,' ',
                  '| ',format('%-8s',[buku[i].idBuku]),' ',
                  '| ',format('%-2s',[buku[i].judulBuku]),' ',
                  '| ',format('%-10s',[buku[i].Pengarang]),' ',
                  '| ',buku[i].jumlah,' ',                     
                  '| ',buku[i].harga:6:0,' ',
                  '| ',buku[i].status,' |');
     end;
     writeln('-----------------------------------------------------------------------');
     writeln('Tekan Enter Untuk Melanjutkan');
     readln;
end;

procedure simpanData;
var
   f:file of TBuku;
   i:integer;
begin
     clrscr;
     writeln('Penyimpanan data ke file');
     writeln('------------------------');
     assign(f,namafile); // hubungkan ke file
     rewrite(f); // buat file baru
     for i:=1 to banyakData do
         write(f,buku[i]); // tulis mhs[i] ke file
     close(f);
     writeln('Penyimpanan ',banyakData,' data ke file telah selesai');
     writeln('Tekan Enter Untuk Melanjutkan');
     readln;
end;

procedure bacaData;
var
   f:file of TBuku;
begin
     clrscr;
     writeln('Pembacaan data dari file');
     writeln('-------------------------');
     assign(f,namafile); // hubungkan ke file
     {$i-}	// Nonaktifkan pemeriksaan IO
     reset(f); // buka file
     {$i+}	// Aktifkan kembali pemeriksaan IO
     if IOResult<>0 then // jika file tidak ditemukan
     rewrite(f); // buat file baru

     banyakData:=0; // banyak data kembali ke 0
     while not eof(f) do // selama belum END-OF-File dari file F
     begin
          banyakData:=banyakData+1;
          read(f,buku[banyakData]);// baca file, simpan di akhir
          end;  close(f);
          writeln('Pembacaan ',banyakData,' data dari file telah selesai.');
          writeln('Tekan Enter Untuk Melanjutkan');
          readln;
end;

procedure pengurutanBuku;
var
   i,j,jumlahMin:integer;
   temp:TBuku;
begin
         for i:=1 to banyakData-1 do
         begin
              jumlahMin:=i;
              for j:=i+1 to banyakData do
              begin
                   if buku[j].jumlah>buku[jumlahMin].jumlah then
                      jumlahMin:=j;
              end;
              if i<>jumlahMin then
              begin
              temp:=buku[i];
              buku[i]:=buku[jumlahMin];
              buku[jumlahMin]:=temp;
              end;
         end;
         writeln(' -----Pengurutan Selesai----- ');
         writeln('Tekan Enter Untuk Melanjutkan');
         readln;
end;

procedure pencarianJudul;
var
   judul:string[20];
   i:integer;
begin
     clrscr;
     writeln('Pencarian Judul');
     writeln('-------------------------');
     write('Judul yang dicari : ');readln(judul);
     i:=1;
     while (pos(upcase(judul),upcase(buku[i].judulBuku))=0)and(i<banyakData) do
           i:=i+1;
     if (pos(upcase(judul),upcase(buku[i].judulBuku))>0) then
     begin
        writeln('Data ditemukan di posisi ke-',i);
        writeln('ID Buku : ',buku[i].idBuku);
        writeln('Judul Buku : ',buku[i].judulBuku);
     end
     else
         writeln('Data tidak ditemukan');
         writeln('Tekan Enter Untuk Melanjutkan');
         readln;
end;

Procedure editBuku;
type
    TBuku=record
               idBuku : string[10];
               judulBuku : String[20];
               jenisBuku : string[20];
               Pengarang : string[20];
               Penerbit : string[20];
               jumlah : integer;
               Harga : real;
               status : string[20];
    end;

var
   fbuku: file of TBuku;
   rbuku: TBuku;
   i,jml: integer;
   nocari: string[7];
   ketemu: boolean;
   lagi: char;
begin
     assign(fbuku,'StokBuku.DAT');
     reset(fbuku);
     jml:= filesize(fbuku);
     lagi:='Y';

     while upcase(lagi)='Y' do
     begin
      ketemu:= false;
      clrscr;
       write('Kode buku yang di cari : '); readln(nocari);
       writeln;
        for i:= 1 to jml do
        begin
         seek(fbuku,i-1);
         read(fbuku,rbuku);
         if rbuku.idBuku=nocari then
            begin
             with rbuku do
             begin
              ketemu:= true;
              writeln('Kode Buku : ',idBuku);
              write('Koreksinya: '); readln(idBuku);
              writeln('Judul Buku: ',judulBuku);
              write('Koreksinya: '); readln(judulBuku);

             end;
            end;
             seek(fbuku,i-1);
             write(fbuku,rbuku);
        end;
        if not ketemu then
           writeln('Tidak nomor tersebut!!!');
           writeln;
           write('ada lagi yang akan dikoreksi [Y/T] ? ');
           readln(lagi);
     end;
  close(fbuku);
End;

procedure hapusBuku;
var
   f: file of TBuku;
   a,i:integer;
begin
     clrscr;

     assign(f,namafile);
     {$i-}
     reset(f);
     {$i+}
     if IOResult<>0 then
     rewrite(f);
     bacaData;

     rewrite(f);
     repeat
           clrscr;
           writeln('-----HAPUS DATA BUKU-----');
           writeln('-------------------------');
           writeln('ID Buku Yang Akan Dihapus : ');readln(a);
           i:=1;
     until i=10;
     end;

begin
     banyakData:=0;
     bacaData;
     repeat
           clrscr;
           writeln('Menu Pilihan');
           writeln('------------------------');
           writeln('1. Tambah Stok Buku');
           writeln('2. Lihat Stok Buku');
           writeln('3. Simpan Data Ke File');
           writeln('4. Baca Data Dari File');
           writeln('5. Urutkan Dari Stok Terbanyak');
           writeln('6. Cari Judul Buku');
           writeln('7. Hapus Data Dari File');
           writeln('8. Edit Data Dari File');
           writeln('0. Keluar dari aplikasi');
           writeln('------------------------');
           write('Pilihan Anda : ');readln(pilihanMenu);
           case pilihanMenu of
                1:tambahData;
                2:lihatStok;
                3:simpanData;
                4:bacaData;
                5:pengurutanBuku;
                6:pencarianJudul;
                7:hapusBuku;
                8:editBuku;
           end;
     until pilihanMenu=0;
end.

