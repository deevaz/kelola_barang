// To parse this JSON data, do
//
//     final historyResponseModel = historyResponseModelFromJson(jsonString);

import 'dart:convert';

List<HistoryResponseModel> historyResponseModelFromJson(String str) =>
    List<HistoryResponseModel>.from(
      json.decode(str).map((x) => HistoryResponseModel.fromJson(x)),
    );

String historyResponseModelToJson(List<HistoryResponseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryResponseModel {
  String? id;
  String? pemasok;
  String? userId;
  String? catatan;
  String? totalHarga;
  DateTime? tanggalMasuk;
  DateTime? tanggal;
  String? tipe;
  int? totalMasuk;
  List<Barang>? barang;
  String? pembeli;
  DateTime? tanggalKeluar;
  int? totalKeluar;

  HistoryResponseModel({
    this.id,
    this.pemasok,
    this.userId,
    this.catatan,
    this.totalHarga,
    this.tanggalMasuk,
    this.tanggal,
    this.tipe,
    this.totalMasuk,
    this.barang,
    this.pembeli,
    this.tanggalKeluar,
    this.totalKeluar,
  });

  factory HistoryResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => HistoryResponseModel(
    id: json["id"],
    pemasok: json["pemasok"],
    userId: json["userId"],
    catatan: json["catatan"],
    totalHarga: json["total_harga"],
    tanggalMasuk:
        json["tanggal_masuk"] == null
            ? null
            : DateTime.parse(json["tanggal_masuk"]),
    tanggal: json["tanggal"] == null ? null : DateTime.parse(json["tanggal"]),
    tipe: json["tipe"],
    totalMasuk: json["total_masuk"],
    barang:
        json["barang"] == null
            ? []
            : List<Barang>.from(json["barang"]!.map((x) => Barang.fromJson(x))),
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
    "tanggal": tanggal?.toIso8601String(),
    "tipe": tipe,
    "total_masuk": totalMasuk,
    "barang":
        barang == null
            ? []
            : List<dynamic>.from(barang!.map((x) => x.toJson())),
    "pembeli": pembeli,
    "tanggal_keluar": tanggalKeluar?.toIso8601String(),
    "total_keluar": totalKeluar,
  };
}

class Barang {
  String? nama;
  String? harga;
  int? jumlahStokMasuk;
  int? jumlahStokKeluar;

  Barang({this.nama, this.harga, this.jumlahStokMasuk, this.jumlahStokKeluar});

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    nama: json["nama"],
    harga: json["harga"],
    jumlahStokMasuk: json["jumlah_stok_masuk"],
    jumlahStokKeluar: json["jumlah_stok_keluar"],
  );

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "jumlah_stok_masuk": jumlahStokMasuk,
    "jumlah_stok_keluar": jumlahStokKeluar,
  };
}
