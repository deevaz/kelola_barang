import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox('user');
  runApp(
    ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Application",
          translations: AppTranslations(),
          locale: Locale('en'),
          fallbackLocale: const Locale('id'),
          supportedLocales: const [Locale('en', 'US'), Locale('id')],
          defaultTransition: Transition.cupertino,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
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
