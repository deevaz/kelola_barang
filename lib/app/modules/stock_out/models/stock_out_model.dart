import 'package:dio/dio.dart';

class StockOutRequestModel {
  final String pembeli;
  final String catatan;
  final String tanggalKeluar;
  final int totalHarga;
  final List<Barang> barang;

  StockOutRequestModel({
    required this.pembeli,
    required this.catatan,
    required this.tanggalKeluar,
    required this.totalHarga,
    required this.barang,
  });

  Map<String, dynamic> toJson() => {
    "pembeli": pembeli,
    "catatan": catatan,
    "tanggal_keluar": tanggalKeluar,
    "total_harga": totalHarga,
    "barang": barang.map((b) => b.toJson()).toList(),
  };
}

class Barang {
  final String nama;
  final int harga;
  final int jumlahStokKeluar;
  final int totalStok;

  Barang({
    required this.nama,
    required this.harga,
    required this.jumlahStokKeluar,
    required this.totalStok,
  });

  Map<String, dynamic> toJson() => {
    "nama": nama,
    "harga": harga,
    "jumlah_stok_keluar": jumlahStokKeluar,
  };
}

extension StockOutRequestModelFormData on StockOutRequestModel {
  FormData toFormData() {
    final data = <String, dynamic>{
      'pembeli': pembeli,
      'catatan': catatan,
      'tanggal_keluar': tanggalKeluar,
      'total_harga': totalHarga.toString(),
    };

    for (int i = 0; i < barang.length; i++) {
      final item = barang[i];
      data.addAll({
        'barang[$i][nama]': item.nama,
        'barang[$i][harga]': item.harga.toString(),
        'barang[$i][jumlah_stok_keluar]': item.jumlahStokKeluar.toString(),
        'barang[$i][total_stok]': item.totalStok.toString(),
      });
    }

    return FormData.fromMap(data);
  }
}
