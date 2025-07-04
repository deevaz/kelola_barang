import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kelola_barang/app/shared/controllers/admob_controller.dart';
import 'package:kelola_barang/app/shared/models/user_response_model.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserResponseModelAdapter());
  await Hive.openBox<UserResponseModel>('user');
  await Hive.openBox<String>('auth');
  await Hive.openBox<String>('lang');
  await MobileAds.instance.initialize();
  await GetStorage.init();
  Get.put(AdmobController());

  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Kelola Barang",
          translations: AppTranslations(),
          locale: Locale('id'),
          fallbackLocale: const Locale('id'),
          debugShowCheckedModeBanner: false,
          supportedLocales: const [Locale('en'), Locale('id')],
          defaultTransition: Transition.cupertino,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          theme: new ThemeData(
            scaffoldBackgroundColor: ColorStyle.light,
            primaryColor: ColorStyle.primary,
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
              brightness: Brightness.light,
              accentColor: ColorStyle.primary,
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    ),
  );
}
