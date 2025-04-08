import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/register/views/widget/tambah_gambar_user.dart';
import 'package:kelola_barang/app/shared/styles/elevated_button_style.dart';
import 'package:kelola_barang/app/shared/widgets/custom_text_field.dart';

import '../controllers/register_controller.dart';
import 'widget/password_text_field.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 100.h),
          child: Column(
            children: [
              // Image.asset('assets/icons/ic_barangku.png', width: 200.w),
              SizedBox(height: 10.h),
              Text(
                'Daftar',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                'Sahabat pengelolaan inventarismu',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30.h),
              TambahGambarUser(),
              SizedBox(height: 10.h),
              CustomTextField(
                title: 'Nama',
                hintText: 'Masukkan Namamu',
                controller: controller.nameController,
              ),
              CustomTextField(
                title: 'Username',
                hintText: 'Masukkan Username',
                controller: controller.usernameC,
              ),
              CustomTextField(
                title: 'Email',
                hintText: 'Masukkan Alamat email',
                controller: controller.emailController,
              ),
              RPasswordTextField(
                title: 'Password',
                hintText: 'Masukkan Password',
                controller: controller.passwordController,
              ),
              RPasswordTextField(
                title: 'Konfirmasi Password',
                hintText: 'Konfirmasi Password',
                controller: controller.cpasswordController,
              ),
              SizedBox(height: 30.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: EvelatedButtonStyle.rounded15,
                  onPressed: () {
                    controller.register();
                  },
                  child: Text('Daftar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
