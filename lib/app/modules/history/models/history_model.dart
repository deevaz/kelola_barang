class HistoryModel {
  final DateTime tanggal;
  final String tipe;
  final bool isStokMasuk;
  final bool isStokKeluar;
  final int id;
  final String? pemasok;
  final String? pembeli;
  final int userId;
  final String? catatan;
  final double totalHarga;
  final DateTime? tanggalMasuk;
  final DateTime? tanggalKeluar;
  final int? totalMasuk;
  final int? totalKeluar;
  final List<Barang> barang;

  HistoryModel({
    required this.tanggal,
    required this.tipe,
    required this.isStokMasuk,
    required this.isStokKeluar,
    required this.id,
    this.pemasok,
    this.pembeli,
    required this.userId,
    this.catatan,
    required this.totalHarga,
    this.tanggalMasuk,
    this.tanggalKeluar,
    this.totalMasuk,
    this.totalKeluar,
    required this.barang,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      tanggal: DateTime.parse(json['tanggal']),
      tipe: json['tipe'],
      isStokMasuk: json['isStokMasuk'],
      isStokKeluar: json['isStokKeluar'],
      id: json['id'],
      pemasok: json['pemasok'],
      pembeli: json['pembeli'],
      userId: json['userId'],
      catatan: json['catatan'],
      totalHarga: json['total_harga'].toDouble(),
      tanggalMasuk:
          json['tanggal_masuk'] != null
              ? DateTime.parse(json['tanggal_masuk'])
              : null,
      tanggalKeluar:
          json['tanggal_keluar'] != null
              ? DateTime.parse(json['tanggal_keluar'])
              : null,
      totalMasuk: json['total_masuk'],
      totalKeluar: json['total_keluar'],
      barang:
          (json['barang'] as List)
              .map((item) => Barang.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tanggal': tanggal.toIso8601String(),
      'tipe': tipe,
      'isStokMasuk': isStokMasuk,
      'isStokKeluar': isStokKeluar,
      'id': id,
      'pemasok': pemasok,
      'pembeli': pembeli,
      'userId': userId,
      'catatan': catatan,
      'total_harga': totalHarga,
      'tanggal_masuk': tanggalMasuk?.toIso8601String(),
      'tanggal_keluar': tanggalKeluar?.toIso8601String(),
      'total_masuk': totalMasuk,
      'total_keluar': totalKeluar,
      'barang': barang.map((item) => item.toJson()).toList(),
    };
  }
}

class Barang {
  final String nama;
  final double harga;
  final int? jumlahStokMasuk;
  final int? jumlahStokKeluar;
  final int totalStok;

  Barang({
    required this.nama,
    required this.harga,
    this.jumlahStokMasuk,
    this.jumlahStokKeluar,
    required this.totalStok,
  });

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
      nama: json['nama'],
      harga: json['harga'].toDouble(),
      jumlahStokMasuk: json['jumlah_stok_masuk'],
      jumlahStokKeluar: json['jumlah_stok_keluar'],
      totalStok: json['total_stok'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama': nama,
      'harga': harga,
      'jumlah_stok_masuk': jumlahStokMasuk,
      'jumlah_stok_keluar': jumlahStokKeluar,
      'total_stok': totalStok,
    };
  }
}
