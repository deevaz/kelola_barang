import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class ChangeLangBottomSheet extends StatelessWidget {
  final String title;
  String selectedLang = 'en';
  final void Function(String lang)? onTap;

  ChangeLangBottomSheet({
    Key? key,
    required this.title,
    required this.selectedLang,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorStyle.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Center(
              child: Container(
                width: 80.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLanguageOption(
                  imagePath: 'assets/images/img_flag_indo.png',
                  languageName: 'Indonesia',
                  langCode: 'id',
                ),
                _buildLanguageOption(
                  imagePath: 'assets/images/img_eng_flag.png',
                  languageName: 'Inggris',
                  langCode: 'en',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption({
    required String imagePath,
    required String languageName,
    required String langCode,
  }) {
    final bool isSelected = selectedLang == langCode;
    return InkWell(
      onTap: () => onTap?.call(langCode),
      child: Container(
        width: 166.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: isSelected ? ColorStyle.primary : ColorStyle.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              spreadRadius: 1.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(imagePath, height: langCode == 'id' ? 50.h : 45.h),
              SizedBox(width: 5.w),
              Text(
                languageName,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? ColorStyle.white : Colors.black,
                ),
              ),
              SizedBox(width: 5.w),
              if (isSelected)
                Icon(Icons.check, color: ColorStyle.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
