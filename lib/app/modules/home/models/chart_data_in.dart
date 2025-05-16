class ChartDataIn {
  final String pemasok;
  final DateTime tanggalMasuk;
  final int totalMasuk;
  final List<Barang> barang;

  ChartDataIn({
    required this.pemasok,
    required this.tanggalMasuk,
    required this.totalMasuk,
    required this.barang,
  });

  factory ChartDataIn.fromJson(Map<String, dynamic> json) => ChartDataIn(
    pemasok: json['pemasok'] ?? 'Unknown Supplier',
    tanggalMasuk: DateTime.parse(json['tanggal_masuk']),
    totalMasuk: int.tryParse(json['total_masuk'].toString()) ?? 0,
    barang:
        (json['barang'] as List<dynamic>)
            .map((b) => Barang.fromJson(b))
            .toList(),
  );
}

class Barang {
  final String nama;
  final double harga;
  final int jumlahStokMasuk;

  Barang({
    required this.nama,
    required this.harga,
    required this.jumlahStokMasuk,
  });

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
    nama: json['nama'],
    harga: double.tryParse(json['harga'].toString()) ?? 0.0,
    jumlahStokMasuk: int.tryParse(json['jumlah_stok_masuk'].toString()) ?? 0,
  );
}
