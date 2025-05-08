import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ProductRequestModel {
  List<XFile> image;
  final String kodeBarang;
  final String namaBarang;
  final int stokAwal;
  final int hargaBeli;
  final int hargaJual;
  final String kadaluarsa;
  final String kategori;
  final int totalStok;
  final String deskripsi;

  ProductRequestModel({
    required this.image,
    required this.kodeBarang,
    required this.namaBarang,
    required this.stokAwal,
    required this.hargaBeli,
    required this.hargaJual,
    required this.kadaluarsa,
    required this.kategori,
    required this.totalStok,
    required this.deskripsi,
  });

  Future<FormData> toFormData() async {
    final multipartFiles = await Future.wait(
      image.map(
        (file) => MultipartFile.fromFile(file.path, filename: file.name),
      ),
    );
    return FormData.fromMap({
      'gambar': multipartFiles.isNotEmpty ? multipartFiles.first : null,
      'kode_barang': kodeBarang,
      'nama_barang': namaBarang,
      'stok_awal': stokAwal.toString(),
      'harga_beli': hargaBeli.toString(),
      'harga_jual': hargaJual.toString(),
      'kadaluarsa': kadaluarsa,
      'kategori': kategori,
      'total_stok': totalStok.toString(),
      'deskripsi': deskripsi,
    });
  }

  static ProductRequestModel fromXfiles({
    required List<XFile> image,
    required String kodeBarang,
    required String namaBarang,
    required int stokAwal,
    required int hargaBeli,
    required int hargaJual,
    required String kadaluarsa,
    required String kategori,
    required int totalStok,
    required String deskripsi,
  }) {
    return ProductRequestModel(
      image: image,
      kodeBarang: kodeBarang,
      namaBarang: namaBarang,
      stokAwal: stokAwal,
      hargaBeli: hargaBeli,
      hargaJual: hargaJual,
      kadaluarsa: kadaluarsa,
      kategori: kategori,
      totalStok: totalStok,
      deskripsi: deskripsi,
    );
  }
}
