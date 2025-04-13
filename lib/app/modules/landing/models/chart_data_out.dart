class ChartDataOut {
  final DateTime tanggalKeluar;
  final int totalKeluar;

  ChartDataOut({required this.tanggalKeluar, required this.totalKeluar});

  factory ChartDataOut.fromJson(Map<String, dynamic> json) {
    return ChartDataOut(
      tanggalKeluar: DateTime.parse(json['tanggal_keluar']),
      totalKeluar: int.parse(json['total_keluar'].toString()),
    );
  }

  @override
  String toString() {
    return 'ChartDataOut(tanggalKeluar: $tanggalKeluar, totalKeluar: $totalKeluar)';
  }
}
