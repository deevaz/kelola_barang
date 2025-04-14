import 'dart:convert';

class ProductModel {
  String? kodeBarang;
  String? namaBarang;
  int? stokAwal;
  int? hargaBeli;
  int? hargaJual;
  int? hargaGrosir;
  String? kadaluarsa;
  String? deskripsi;
  String? vendor;
  String? gambar;
  String? kategori;
  int? totalStok;
  int? stokMasuk;
  int? stokKeluar;
  String? id;
  String? userId;

  ProductModel({
    this.kodeBarang,
    this.namaBarang,
    this.stokAwal,
    this.hargaBeli,
    this.hargaJual,
    this.hargaGrosir,
    this.kadaluarsa,
    this.deskripsi,
    this.vendor,
    this.gambar,
    this.kategori,
    this.totalStok,
    this.stokMasuk,
    this.stokKeluar,
    this.id,
    this.userId,
  });

  factory ProductModel.fromRawJson(String str) =>
      ProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    kodeBarang: json["kode_barang"],
    namaBarang: json["nama_barang"],
    stokAwal: json["stok_awal"],
    hargaBeli: json["harga_beli"],
    hargaJual: json["harga_jual"],
    hargaGrosir: json["harga_grosir"],
    kadaluarsa: json["kadaluarsa"],
    deskripsi: json["deskripsi"],
    vendor: json["vendor"],
    gambar: json["gambar"],
    kategori: json["kategori"],
    totalStok: json["total_stok"],
    stokMasuk: json["stok_masuk"],
    stokKeluar: json["stok_keluar"],
    id: json["id"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "kode_barang": kodeBarang,
    "nama_barang": namaBarang,
    "stok_awal": stokAwal,
    "harga_beli": hargaBeli,
    "harga_jual": hargaJual,
    "harga_grosir": hargaGrosir,
    "kadaluarsa": kadaluarsa,
    "deskripsi": deskripsi,
    "vendor": vendor,
    "gambar": gambar,
    "kategori": kategori,
    "total_stok": totalStok,
    "stok_masuk": stokMasuk,
    "stok_keluar": stokKeluar,
    "id": id,
    "userId": userId,
  };
}
