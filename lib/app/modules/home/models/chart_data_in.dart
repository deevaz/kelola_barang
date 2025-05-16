class ChartDataIn {
  final DateTime tanggalMasuk;
  final int totalMasuk;

  ChartDataIn({required this.tanggalMasuk, required this.totalMasuk});

  factory ChartDataIn.fromJson(Map<String, dynamic> json) {
    return ChartDataIn(
      tanggalMasuk: DateTime.parse(json['tanggal_masuk']),
      totalMasuk: int.parse(json['total_masuk'].toString()),
    );
  }

  @override
  String toString() {
    return 'ChartDataIn(tanggalMasuk: $tanggalMasuk, totalMasuk: $totalMasuk)';
  }
}
