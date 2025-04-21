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
    "total_stok": totalStok,
  };
}

class StockOutModel {
  final String pembeli;
  final String catatan;
  final String tanggalKeluar;
  final int totalHarga;
  final List<Barang> barang;

  StockOutModel({
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
