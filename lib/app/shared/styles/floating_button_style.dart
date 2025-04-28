import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_style.dart';

class FloatingButtonStyle {
  static final ButtonStyle mainRounded = ElevatedButton.styleFrom(
    backgroundColor: ColorStyle.primary,
    foregroundColor: ColorStyle.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
    padding: EdgeInsets.symmetric(vertical: 15.r, horizontal: 30.r),
    textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
  );

  static final ButtonStyle danger = ElevatedButton.styleFrom(
    backgroundColor: ColorStyle.danger,
    foregroundColor: ColorStyle.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.r),
    textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
  );
}
