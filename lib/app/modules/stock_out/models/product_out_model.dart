class ProductOutModel {
  final String namaBarang;
  final String gambar;
  int? totalStok;
  int stok;
  int stokKeluar;
  int harga;

  ProductOutModel({
    required this.namaBarang,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.stokKeluar,
  });

  void tambahStok() {
    stokKeluar++;
  }

  void kurangStok() {
    if (stokKeluar > 0) {
      stokKeluar--;
    }
  }

  void simpanStok() {
    stok += stokKeluar;
  }

  Map<String, dynamic> toJson() {
    return {
      'namaBarang': namaBarang,
      'gambar': gambar,
      'totalStok': totalStok,
      'stok': stok,
      'stokKeluar': stokKeluar,
      'harga': harga,
    };
  }

  @override
  String toString() {
    return 'ProductOutModel(namaBarang: $namaBarang, harga: $harga, stok: $stok, stokKeluar: $stokKeluar, totalStok: $totalStok)';
  }
}
