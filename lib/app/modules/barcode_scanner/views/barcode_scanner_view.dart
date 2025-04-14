import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_app_bar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/barcode_scanner_controller.dart';

class BarcodeScannerView extends GetView<BarcodeScannerController> {
  const BarcodeScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Barcode Scanner'),
      body: Stack(
        children: [
          MobileScanner(
            onDetect: (barcode) {
              for (final barcode in barcode.barcodes) {
                final String? code = barcode.rawValue;
                if (code != null) {
                  Get.back(result: code);
                  print('Barcode found: $code');
                  controller.barcode.value = code;
                  // Get.snackbar(
                  //   'Barcode terdeteksi',
                  //   'Kode: $code',
                  //   backgroundColor: ColorStyle.success,
                  //   colorText: Colors.white,
                  //   duration: const Duration(seconds: 2),
                  // );
                  break;
                }
              }
            },
          ),

          Center(
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                border: Border.all(color: ColorStyle.light, width: 2.w),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [AnimatedScanningLine(scanAreaHeight: 300.h)],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(16.r),
              color: Colors.black.withOpacity(0.5),
              child: Text(
                'Arahkan kamera ke barcode untuk memindai',
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedScanningLine extends StatefulWidget {
  final double scanAreaHeight;
  const AnimatedScanningLine({super.key, required this.scanAreaHeight});

  @override
  _AnimatedScanningLineState createState() => _AnimatedScanningLineState();
}

class _AnimatedScanningLineState extends State<AnimatedScanningLine>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.scanAreaHeight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Positioned(
          top: _animation.value,
          left: 0,
          right: 0,
          child: Container(height: 2, color: Colors.redAccent),
        );
      },
    );
  }
}
