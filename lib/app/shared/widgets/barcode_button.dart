import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class BarcodeButton extends StatelessWidget {
  final Function()? onTap;
  const BarcodeButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MaterialRounded(
        child: IconButton(
          icon: Icon(Ionicons.barcode_outline, color: ColorStyle.dark),
          onPressed: onTap,
        ),
      ),
    );
  }
}
