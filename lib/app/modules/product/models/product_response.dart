import 'dart:convert';

class ProductResponse {
  int? id;
  String? kodeBarang;
  String? namaBarang;
  int? stok;
  int? hargaBeli;
  int? hargaJual;
  DateTime? kadaluarsa;
  String? deskripsi;
  String? gambar;
  String? kategori;
  int? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductResponse({
    this.id,
    this.kodeBarang,
    this.namaBarang,
    this.stok,
    this.hargaBeli,
    this.hargaJual,
    this.kadaluarsa,
    this.deskripsi,
    this.gambar,
    this.kategori,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  ProductResponse copyWith({
    int? id,
    String? kodeBarang,
    String? namaBarang,
    int? stok,
    int? hargaBeli,
    int? hargaJual,
    DateTime? kadaluarsa,
    String? deskripsi,
    String? gambar,
    String? kategori,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProductResponse(
    id: id ?? this.id,
    kodeBarang: kodeBarang ?? this.kodeBarang,
    namaBarang: namaBarang ?? this.namaBarang,
    stok: stok ?? this.stok,
    hargaBeli: hargaBeli ?? this.hargaBeli,
    hargaJual: hargaJual ?? this.hargaJual,
    kadaluarsa: kadaluarsa ?? this.kadaluarsa,
    deskripsi: deskripsi ?? this.deskripsi,
    gambar: gambar ?? this.gambar,
    kategori: kategori ?? this.kategori,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory ProductResponse.fromRawJson(String str) =>
      ProductResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductResponse.fromJson(
    Map<String, dynamic> json,
  ) => ProductResponse(
    id: json["id"],
    kodeBarang: json["kode_barang"],
    namaBarang: json["nama_barang"],
    stok: json["stok"],
    hargaBeli: json["harga_beli"],
    hargaJual: json["harga_jual"],
    kadaluarsa:
        json["kadaluarsa"] == null ? null : DateTime.parse(json["kadaluarsa"]),
    deskripsi: json["deskripsi"],
    gambar: json["gambar"],
    kategori: json["kategori"],
    userId: json["user_id"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kode_barang": kodeBarang,
    "nama_barang": namaBarang,
    "stok": stok,
    "harga_beli": hargaBeli,
    "harga_jual": hargaJual,
    "kadaluarsa": kadaluarsa?.toIso8601String(),
    "deskripsi": deskripsi,
    "gambar": gambar,
    "kategori": kategori,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  factory ProductResponse.fromMap(Map<String, dynamic> map) => ProductResponse(
    id: map["id"],
    kodeBarang: map["kode_barang"],
    namaBarang: map["nama_barang"],
    stok: map["stok"],
    hargaBeli: map["harga_beli"],
    hargaJual: map["harga_jual"],
    kadaluarsa:
        map["kadaluarsa"] == null ? null : DateTime.parse(map["kadaluarsa"]),
    deskripsi: map["deskripsi"],
    gambar: map["gambar"],
    kategori: map["kategori"],
    userId: map["user_id"],
    createdAt:
        map["created_at"] == null ? null : DateTime.parse(map["created_at"]),
    updatedAt:
        map["updated_at"] == null ? null : DateTime.parse(map["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "kode_barang": kodeBarang,
    "nama_barang": namaBarang,
    "stok": stok,
    "harga_beli": hargaBeli,
    "harga_jual": hargaJual,
    "kadaluarsa": kadaluarsa?.toIso8601String(),
    "deskripsi": deskripsi,
    "gambar": gambar,
    "kategori": kategori,
    "user_id": userId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
