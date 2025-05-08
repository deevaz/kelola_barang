import 'dart:convert';

class StockOutResponseModel {
  String? id;
  String? pembeli;
  String? userId;
  String? catatan;
  String? totalHarga;
  DateTime? tanggalKeluar;
  int? totalKeluar;
  List<Barang>? barang;

  StockOutResponseModel({
    this.id,
    this.pembeli,
    this.userId,
    this.catatan,
    this.totalHarga,
    this.tanggalKeluar,
    this.totalKeluar,
    this.barang,
  });

  StockOutResponseModel copyWith({
    String? id,
    String? pembeli,
    String? userId,
    String? catatan,
    String? totalHarga,
    DateTime? tanggalKeluar,
    int? totalKeluar,
    List<Barang>? barang,
  }) => StockOutResponseModel(
    id: id ?? this.id,
    pembeli: pembeli ?? this.pembeli,
    userId: userId ?? this.userId,
    catatan: catatan ?? this.catatan,
    totalHarga: totalHarga ?? this.totalHarga,
    tanggalKeluar: tanggalKeluar ?? this.tanggalKeluar,
    totalKeluar: totalKeluar ?? this.totalKeluar,
    barang: barang ?? this.barang,
  );

  factory StockOutResponseModel.fromRawJson(String str) =>
      StockOutResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockOutResponseModel.fromJson(Map<String, dynamic> json) =>
      StockOutResponseModel(
        id: json["id"],
        pembeli: json["pembeli"],
        userId: json["userId"],
        catatan: json["catatan"],
        totalHarga: json["total_harga"],
        tanggalKeluar:
            json["tanggal_keluar"] == null
                ? null
                : DateTime.parse(json["tanggal_keluar"]),
        totalKeluar: json["total_keluar"],
        barang:
            json["barang"] == null
                ? []
                : List<Barang>.from(
                  json["barang"]!.map((x) => Barang.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pembeli": pembeli,
    "userId": userId,
    "catatan": catatan,
    "total_harga": totalHarga,
    "tanggal_keluar": tanggalKeluar?.toIso8601String(),
    "total_keluar": totalKeluar,
    "barang":
        barang == null
            ? []
            : List<dynamic>.from(barang!.map((x) => x.toJson())),
  };
}

class Barang {
  String? nama;
  String? harga;
  int? jumlahStokKeluar;
  int? totalStok;

  Barang({this.nama, this.harga, this.jumlahStokKeluar, this.totalStok});

  Barang copyWith({
    String? nama,
    String? harga,
    int? jumlahStokKeluar,
    int? totalStok,
  }) => Barang(
    nama: nama ?? this.nama,
    harga: harga ?? this.harga,
    jumlahStokKeluar: jumlahStokKeluar ?? this.jumlahStokKeluar,
    totalStok: totalStok ?? this.totalStok,
  );

  factory Barang.fromRawJson(String str) => Barang.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    nama: json["nama"],
    harga: json["harga"],
    jumlahStokKeluar: json["jumlah_stok_keluar"],
    totalStok: json["total_stok"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "jumlah_stok_keluar": jumlahStokKeluar,
    "total_stok": totalStok,
  };
}
