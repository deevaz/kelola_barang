import 'dart:convert';

class SupplierModel {
  String? namaPemasok;
  int? nomorTelepon;
  int? nomorRekening;
  String? catatan;
  String? id;
  String? userId;

  SupplierModel({
    this.namaPemasok,
    this.nomorTelepon,
    this.nomorRekening,
    this.catatan,
    this.id,
    this.userId,
  });

  factory SupplierModel.fromRawJson(String str) =>
      SupplierModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
    namaPemasok: json["nama_pemasok"],
    nomorTelepon: json["nomor_telepon"],
    nomorRekening: json["nomor_rekening"],
    catatan: json["catatan"],
    id: json["id"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "nama_pemasok": namaPemasok,
    "nomor_telepon": nomorTelepon,
    "nomor_rekening": nomorRekening,
    "catatan": catatan,
    "id": id,
    "userId": userId,
  };

  @override
  String toString() {
    return 'SupplierModel(namaPemasok: $namaPemasok, nomorTelepon: $nomorTelepon, nomorRekening: $nomorRekening, catatan: $catatan, id: $id, userId: $userId)';
  }
}
