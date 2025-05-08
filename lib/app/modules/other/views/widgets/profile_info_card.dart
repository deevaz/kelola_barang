import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kelola_barang/app/modules/base/controllers/base_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialRounded(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(BaseController.to.image.value),
                backgroundColor: Colors.grey[200],
              ),
              SizedBox(height: 10),
              Text(
                BaseController.to.name.value,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              Text(
                BaseController.to.email.value,
                style: TextStyle(color: ColorStyle.grey, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
