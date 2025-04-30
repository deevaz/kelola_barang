import 'dart:io';
import 'package:dio/dio.dart';

class ProductRequestModel {
  File? imageFile;
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
    this.imageFile,
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
    return FormData.fromMap({
      'files':
          imageFile != null
              ? [
                await MultipartFile.fromFile(
                  imageFile!.path,
                  filename: imageFile!.path.split('/').last,
                ),
              ]
              : [],
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
}
