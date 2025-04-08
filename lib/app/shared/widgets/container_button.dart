import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class ContainerButton extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function()? onTap;

  const ContainerButton({
    super.key,
    required this.title,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
          height: 50.h,
          decoration: BoxDecoration(
            border: Border.all(color: ColorStyle.dark),
            color: ColorStyle.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(prefixIcon, color: ColorStyle.dark),
                    onPressed: () {},
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorStyle.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(suffixIcon, color: ColorStyle.dark),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
