import 'package:intl/intl.dart';
import 'package:kelola_barang/app/modules/history/models/history_response_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<pw.Document> generatePdf({
    required List<HistoryResponseModel> history,
  }) async {
    final pdf = pw.Document();
    final now = DateTime.now();
    final dateFormat = DateFormat('dd MMMM yyyy HH:mm');

    final stokMasuk = history.where((item) => item.tipe == 'masuk').toList();
    final stokKeluar = history.where((item) => item.tipe == 'keluar').toList();

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
              pw.SizedBox(height: 20),
              _buildSectionTitle('Laporan Stok Masuk', PdfColors.green800),
              _buildTable(stokMasuk, isStockIn: true),
              pw.SizedBox(height: 20),
              _buildSectionTitle('Laporan Stok Keluar', PdfColors.red800),
              _buildTable(stokKeluar, isStockIn: false),
            ],
      ),
    );

    return pdf;
  }

  pw.Widget _buildSectionTitle(String title, PdfColor color) {
    return pw.Column(
      children: [
        pw.Text(
          title,
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: color,
          ),
        ),
        pw.SizedBox(height: 8),
      ],
    );
  }

  pw.Widget _buildTable(
    List<HistoryResponseModel> data, {
    required bool isStockIn,
  }) {
    final rows = <List<String>>[];
    final dateFormat = DateFormat('dd MMMM yyyy HH:mm');

    for (final item in data) {
      final tanggal = isStockIn ? item.tanggalMasuk : item.tanggalKeluar;
      final formattedDate = tanggal != null ? dateFormat.format(tanggal) : '';

      for (final barang in item.barang ?? []) {
        final jumlah =
            isStockIn
                ? barang.jumlahStokMasuk?.toString() ?? '0'
                : barang.jumlahStokKeluar?.toString() ?? '0';

        final harga =
            barang.harga != null
                ? NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp',
                  decimalDigits: 0,
                ).format(double.tryParse(barang.harga!) ?? 0)
                : 'Rp 0';

        rows.add([formattedDate, barang.nama ?? '', jumlah, harga]);
      }
    }

    return pw.TableHelper.fromTextArray(
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
    );
  }
}
