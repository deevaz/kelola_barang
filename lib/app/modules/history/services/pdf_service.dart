import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfService {
  Future<pw.Document> generatePdf({
    required List<Map<String, dynamic>> stokMasuk,
    required List<Map<String, dynamic>> stokKeluar,
  }) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final dateFormat = DateFormat('dd MMMM yyyy HH:mm');

    pdf.addPage(
      pw.MultiPage(
        margin: const pw.EdgeInsets.all(24),
        footer:
            (context) => pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(top: 20),
              child: pw.Text(
                'Dicetak: ${dateFormat.format(now)} | Halaman ${context.pageNumber} dari ${context.pagesCount}',
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
            ),
        build:
            (context) => [
              pw.Header(
                level: 0,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'LAPORAN STOK BARANG',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blueGrey800,
                      ),
                    ),
                    pw.Text(
                      'Dibuat di Aplikasi Kelola Barang',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Laporan Stok Masuk',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.green800,
                ),
              ),
              pw.SizedBox(height: 8),
              _buildTable(stokMasuk, isStockIn: true),
              // pw.SizedBox(height: 10),
              // pw.Text(
              //   'Total Harga Barang : Rp ${NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0).format(stokMasuk.fold<double>(0, (sum, item) => sum + (item['barang'] as List<dynamic>? ?? []).fold<double>(0, (subSum, barang) => subSum + (double.tryParse(barang['harga']?.toString() ?? '0') ?? 0) * (double.tryParse(barang['jumlah_stok_masuk']?.toString() ?? '0') ?? 0))))}',
              //   style: pw.TextStyle(
              //     fontSize: 14,
              //     fontWeight: pw.FontWeight.bold,
              //     color: PdfColors.green800,
              //   ),
              // ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Laporan Stok Keluar',
                style: pw.TextStyle(
                  fontSize: 16,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.red800,
                ),
              ),
              pw.SizedBox(height: 8),
              _buildTable(stokKeluar, isStockIn: false),
              // pw.SizedBox(height: 10),
              // pw.Text(
              //   'Rp. 20',
              //   style: pw.TextStyle(
              //     fontSize: 14,
              //     fontWeight: pw.FontWeight.bold,
              //     color: PdfColors.red800,
              //   ),
              // ),
            ],
      ),
    );

    return pdf;
  }

  pw.Widget _buildTable(
    List<Map<String, dynamic>> data, {
    required bool isStockIn,
  }) {
    final rows = <List<String>>[];

    for (final item in data) {
      final tanggal =
          (isStockIn ? item['tanggal_masuk'] : item['tanggal_keluar']) ?? '';
      final barangList = item['barang'] as List<dynamic>? ?? [];

      for (final barang in barangList) {
        final namaBarang = barang['nama'] ?? '';
        final jumlah =
            isStockIn
                ? barang['jumlah_stok_masuk']?.toString() ?? ''
                : barang['jumlah_stok_keluar']?.toString() ?? '';

        final harga =
            barang['harga'] != null
                ? NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp',
                  decimalDigits: 0,
                ).format(double.tryParse(barang['harga'].toString()) ?? 0)
                : '';
        rows.add([tanggal, namaBarang, jumlah, harga]);
      }
    }

    return TableHelper.fromTextArray(
      headers: ['Tanggal', 'Nama Barang', 'Jumlah', 'Harga'],
      data: rows,
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        color: PdfColors.white,
      ),
      headerDecoration: const pw.BoxDecoration(color: PdfColors.blueGrey700),
      cellAlignment: pw.Alignment.centerLeft,
      headerHeight: 25,
      cellHeight: 22,
      cellStyle: const pw.TextStyle(fontSize: 10),
      rowDecoration: pw.BoxDecoration(
        border: const pw.Border(
          bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
        ),
        color: PdfColors.grey100,
      ),
      oddRowDecoration: const pw.BoxDecoration(color: PdfColors.white),
      border: null,
    );
  }
}
