import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;

  const ShimmerCard({Key? key, this.width = 375, this.height = 220})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(width: width.w, height: height.h, color: Colors.white),
    );
  }
}
