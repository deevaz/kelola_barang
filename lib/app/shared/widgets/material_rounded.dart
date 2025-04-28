import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles/color_style.dart';

class MaterialRounded extends StatelessWidget {
  final Widget child;
  const MaterialRounded({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorStyle.white,
      borderRadius: BorderRadius.circular(10.r),
      elevation: 2,
      child: child,
    );
  }
}
