import 'dart:convert';

class StockInResponseModel {
  String? id;
  String? pemasok;
  String? userId;
  String? catatan;
  String? totalHarga;
  DateTime? tanggalMasuk;
  int? totalMasuk;
  List<Barang>? barang;

  StockInResponseModel({
    this.id,
    this.pemasok,
    this.userId,
    this.catatan,
    this.totalHarga,
    this.tanggalMasuk,
    this.totalMasuk,
    this.barang,
  });

  StockInResponseModel copyWith({
    String? id,
    String? pemasok,
    String? userId,
    String? catatan,
    String? totalHarga,
    DateTime? tanggalMasuk,
    int? totalMasuk,
    List<Barang>? barang,
  }) => StockInResponseModel(
    id: id ?? this.id,
    pemasok: pemasok ?? this.pemasok,
    userId: userId ?? this.userId,
    catatan: catatan ?? this.catatan,
    totalHarga: totalHarga ?? this.totalHarga,
    tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
    totalMasuk: totalMasuk ?? this.totalMasuk,
    barang: barang ?? this.barang,
  );

  factory StockInResponseModel.fromRawJson(String str) =>
      StockInResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StockInResponseModel.fromJson(Map<String, dynamic> json) =>
      StockInResponseModel(
        id: json["id"],
        pemasok: json["pemasok"],
        userId: json["userId"],
        catatan: json["catatan"],
        totalHarga: json["total_harga"],
        tanggalMasuk:
            json["tanggal_masuk"] == null
                ? null
                : DateTime.parse(json["tanggal_masuk"]),
        totalMasuk: json["total_masuk"],
        barang:
            json["barang"] == null
                ? []
                : List<Barang>.from(
                  json["barang"]!.map((x) => Barang.fromJson(x)),
                ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pemasok": pemasok,
    "userId": userId,
    "catatan": catatan,
    "total_harga": totalHarga,
    "tanggal_masuk": tanggalMasuk?.toIso8601String(),
    "total_masuk": totalMasuk,
    "barang":
        barang == null
            ? []
            : List<dynamic>.from(barang!.map((x) => x.toJson())),
  };
}

class Barang {
  String? nama;
  String? harga;
  int? jumlahStokMasuk;
  int? totalStok;

  Barang({this.nama, this.harga, this.jumlahStokMasuk, this.totalStok});

  Barang copyWith({
    String? nama,
    String? harga,
    int? jumlahStokMasuk,
    int? totalStok,
  }) => Barang(
    nama: nama ?? this.nama,
    harga: harga ?? this.harga,
    jumlahStokMasuk: jumlahStokMasuk ?? this.jumlahStokMasuk,
    totalStok: totalStok ?? this.totalStok,
  );

  factory Barang.fromRawJson(String str) => Barang.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    nama: json["nama"],
    harga: json["harga"],
    jumlahStokMasuk: json["jumlah_stok_masuk"],
    totalStok: json["total_stok"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "jumlah_stok_masuk": jumlahStokMasuk,
    "total_stok": totalStok,
  };
}
