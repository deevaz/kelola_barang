import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/shared/widgets/shimmer.dart';

class DetailProductImageView extends GetView {
  DetailProductImageView({super.key});
  final ProductResponse item = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            ShimmerCard(),
            Image.network(
              item.gambar.toString(),
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Icon(Icons.error, color: Colors.white, size: 50),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
