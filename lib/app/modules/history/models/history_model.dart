// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(
  json.decode(str).map((x) => HistoryModel.fromJson(x)),
);

String historyModelToJson(List<HistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
  String id;
  String? pemasok;
  String userId;
  String catatan;
  String totalHarga;
  DateTime? tanggalMasuk;
  DateTime tanggal;
  String tipe;
  int? totalMasuk;
  List<Barang> barang;
  String? pembeli;
  DateTime? tanggalKeluar;
  int? totalKeluar;

  HistoryModel({
    required this.id,
    this.pemasok,
    required this.userId,
    required this.catatan,
    required this.totalHarga,
    this.tanggalMasuk,
    required this.tanggal,
    required this.tipe,
    this.totalMasuk,
    required this.barang,
    this.pembeli,
    this.tanggalKeluar,
    this.totalKeluar,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    id: json["id"],
    pemasok: json["pemasok"],
    userId: json["userId"],
    catatan: json["catatan"],
    totalHarga: json["total_harga"],
    tanggalMasuk:
        json["tanggal_masuk"] == null
            ? null
            : DateTime.parse(json["tanggal_masuk"]),
    tanggal: DateTime.parse(json["tanggal"]),
    tipe: json["tipe"],
    totalMasuk: json["total_masuk"],
    barang: List<Barang>.from(json["barang"].map((x) => Barang.fromJson(x))),
    pembeli: json["pembeli"],
    tanggalKeluar:
        json["tanggal_keluar"] == null
            ? null
            : DateTime.parse(json["tanggal_keluar"]),
    totalKeluar: json["total_keluar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pemasok": pemasok,
    "userId": userId,
    "catatan": catatan,
    "total_harga": totalHarga,
    "tanggal_masuk": tanggalMasuk?.toIso8601String(),
    "tanggal": tanggal.toIso8601String(),
    "tipe": tipe,
    "total_masuk": totalMasuk,
    "barang": List<dynamic>.from(barang.map((x) => x.toJson())),
    "pembeli": pembeli,
    "tanggal_keluar": tanggalKeluar?.toIso8601String(),
    "total_keluar": totalKeluar,
  };
}

class Barang {
  String nama;
  String harga;
  int? jumlahStokMasuk;
  int totalStok;
  int? jumlahStokKeluar;

  Barang({
    required this.nama,
    required this.harga,
    this.jumlahStokMasuk,
    required this.totalStok,
    this.jumlahStokKeluar,
  });

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    nama: json["nama"],
    harga: json["harga"],
    jumlahStokMasuk: json["jumlah_stok_masuk"],
    totalStok: json["total_stok"],
    jumlahStokKeluar: json["jumlah_stok_keluar"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "jumlah_stok_masuk": jumlahStokMasuk,
    "total_stok": totalStok,
    "jumlah_stok_keluar": jumlahStokKeluar,
  };
}
