class ProductInModel {
  final String id;
  final String namaBarang;
  final String gambar;
  int jumlahstokMasuk;
  int harga;
  int stok;

  ProductInModel({
    required this.id,
    required this.namaBarang,
    required this.gambar,
    required this.harga,
    required this.jumlahstokMasuk,
    this.stok = 0,
  });

  void simpanStok() {
    stok += jumlahstokMasuk;
  }

  Map<String, dynamic> toJson() {
    return {
      'namaBarang': namaBarang,
      'gambar': gambar,
      'jumlah_stok_masuk': jumlahstokMasuk,
      'harga': harga,
    };
  }

  @override
  String toString() {
    return 'ProductInModel(namaBarang: $namaBarang, harga: $harga, jumlahstokMasuk: $jumlahstokMasuk)';
  }

  ProductInModel copyWith({
    String? id,
    String? namaBarang,
    String? gambar,
    int? harga,
    int? jumlahstokMasuk,
    int? stok,
  }) {
    return ProductInModel(
      id: id ?? this.id,
      namaBarang: namaBarang ?? this.namaBarang,
      gambar: gambar ?? this.gambar,
      harga: harga ?? this.harga,
      jumlahstokMasuk: jumlahstokMasuk ?? this.jumlahstokMasuk,
      stok: stok ?? this.stok,
    );
  }
}
