class ProductInModel {
  final String idBarang;
  final String namaBarang;
  int? totalHarga;
  int? totalStok;
  String? kodeBarang;
  String? gambar;
  int stok;
  int stokMasuk;
  int harga;

  ProductInModel({
    required this.idBarang,
    required this.namaBarang,
    this.kodeBarang,
    this.totalHarga,
    required this.harga,
    required this.stok,
    required this.stokMasuk,
    this.gambar,
  });

  void tambahStok() {
    stokMasuk++;
  }

  void kurangStok() {
    if (stokMasuk > 0) {
      stokMasuk--;
    }
  }

  void simpanStok() {
    stok += stokMasuk;
    // stokMasuk = 0;
  }
}
