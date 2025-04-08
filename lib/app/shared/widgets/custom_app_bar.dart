import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../styles/color_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool isBackButton;
  final bool isActionButton;
  final Widget? actionButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButton = true,
    this.isActionButton = false,
    this.actionButton,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorStyle.light,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: ColorStyle.dark,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: ColorStyle.dark),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
