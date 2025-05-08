import 'dart:convert';

class SuppliersModel {
  int? id;
  String? namaSupplier;
  String? noTelp;
  String? noRekening;
  String? catatan;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  SuppliersModel({
    this.id,
    this.namaSupplier,
    this.noTelp,
    this.noRekening,
    this.catatan,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  SuppliersModel copyWith({
    int? id,
    String? namaSupplier,
    String? noTelp,
    String? noRekening,
    String? catatan,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SuppliersModel(
    id: id ?? this.id,
    namaSupplier: namaSupplier ?? this.namaSupplier,
    noTelp: noTelp ?? this.noTelp,
    noRekening: noRekening ?? this.noRekening,
    catatan: catatan ?? this.catatan,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory SuppliersModel.fromRawJson(String str) =>
      SuppliersModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuppliersModel.fromJson(Map<String, dynamic> json) => SuppliersModel(
    id: json["id"],
    namaSupplier: json["nama_supplier"],
    noTelp: json["no_telp"],
    noRekening: json["no_rekening"],
    catatan: json["catatan"],
    userId: json["user_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_supplier": namaSupplier,
    "no_telp": noTelp,
    "no_rekening": noRekening,
    "catatan": catatan,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  factory SuppliersModel.fromMap(Map<String, dynamic> map) => SuppliersModel(
    id: map["id"],
    namaSupplier: map["nama_supplier"],
    noTelp: map["no_telp"],
    noRekening: map["no_rekening"],
    catatan: map["catatan"],
    userId: map["user_id"],
    createdAt:
        map["created_at"] == null ? null : DateTime.parse(map["created_at"]),
    updatedAt:
        map["updated_at"] == null ? null : DateTime.parse(map["updated_at"]),
  );
}
