import 'package:dio/dio.dart';

class StockInRequestModel {
  final String pemasok;
  final String catatan;
  final String tanggalMasuk;
  final int totalHarga;
  final List<Barang> barang;

  StockInRequestModel({
    required this.pemasok,
    required this.catatan,
    required this.tanggalMasuk,
    required this.totalHarga,
    required this.barang,
  });

  Map<String, dynamic> toJson() => {
    "pemasok": pemasok,
    "catatan": catatan,
    "tanggal_masuk": tanggalMasuk,
    "total_harga": totalHarga,
    "barang": barang.map((b) => b.toJson()).toList(),
  };
}

class Barang {
  final String nama;
  final int harga;
  final int jumlahStokMasuk;
  final int totalStok;

  Barang({
    required this.nama,
    required this.harga,
    required this.jumlahStokMasuk,
    required this.totalStok,
  });

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "jumlah_stok_masuk": jumlahStokMasuk,
    "total_stok": totalStok,
  };
}

extension StockInRequestModelFormData on StockInRequestModel {
  FormData toFormData() {
    final data = <String, dynamic>{
      'pemasok': pemasok,
      'catatan': catatan,
      'tanggal_masuk': tanggalMasuk,
      'total_harga': totalHarga.toString(),
    };

    // Tambahkan list barang sebagai array
    for (int i = 0; i < barang.length; i++) {
      final item = barang[i];
      data.addAll({
        'barang[$i][nama]': item.nama,
        'barang[$i][harga]': item.harga.toString(),
        'barang[$i][jumlah_stok_masuk]': item.jumlahStokMasuk.toString(),
        'barang[$i][total_stok]': item.totalStok.toString(),
      });
    }

    return FormData.fromMap(data);
  }
}
