class ProductInModel {
  final String namaBarang;
  final String gambar;
  int? totalStok;
  int stok;
  int stokMasuk;
  int harga;

  ProductInModel({
    required this.namaBarang,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.stokMasuk,
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
  }

  Map<String, dynamic> toJson() {
    return {
      'namaBarang': namaBarang,
      'gambar': gambar,
      'totalStok': totalStok,
      'stok': stok,
      'stokMasuk': stokMasuk,
      'harga': harga,
    };
  }

  @override
  String toString() {
    return 'ProductInModel(namaBarang: $namaBarang, harga: $harga, stok: $stok, stokMasuk: $stokMasuk, totalStok: $totalStok)';
  }
}
