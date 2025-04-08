import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/search_controller.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key, this.onChanged});
  final Function? onChanged;
  final SearchControllerGet controller = Get.put(SearchControllerGet());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.sp),
      child: SizedBox(
        height: 45.h,
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(15.r),
          child: TextField(
            onChanged: (value) => onChanged?.call(value),
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
