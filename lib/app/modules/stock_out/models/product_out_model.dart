class ProductOutModel {
  final String namaBarang;
  final String id;
  final String gambar;
  int? totalStok;
  int stok;
  int jumlahStokKeluar;
  int harga;

  ProductOutModel({
    required this.id,
    required this.namaBarang,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.jumlahStokKeluar,
  });

  void simpanStok() {
    stok += jumlahStokKeluar;
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_barang': namaBarang,
      'gambar': gambar,
      'totalStok': totalStok,
      'stok': stok,
      'jumlah_stok_keluar': jumlahStokKeluar,
      'harga': harga,
    };
  }

  ProductOutModel copyWith({
    String? id,
    String? namaBarang,
    String? gambar,
    int? harga,
    int? stok,
    int? jumlahStokKeluar,
    int? totalStok,
  }) {
    return ProductOutModel(
      id: id ?? this.id,
      namaBarang: namaBarang ?? this.namaBarang,
      gambar: gambar ?? this.gambar,
      harga: harga ?? this.harga,
      stok: stok ?? this.stok,
      jumlahStokKeluar: jumlahStokKeluar ?? this.jumlahStokKeluar,
    );
  }

  @override
  String toString() {
    return 'ProductOutModel(namaBarang: $namaBarang, harga: $harga, stok: $stok, stokKeluar: $jumlahStokKeluar, totalStok: $totalStok)';
  }
}
