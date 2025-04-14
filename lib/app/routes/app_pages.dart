import 'package:get/get.dart';

import '../modules/barcode_scanner/bindings/barcode_scanner_binding.dart';
import '../modules/barcode_scanner/views/barcode_scanner_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/landing/bindings/landing_binding.dart';
import '../modules/landing/supplier/add_supplier/bindings/add_supplier_binding.dart';
import '../modules/landing/supplier/add_supplier/views/add_supplier_view.dart';
import '../modules/landing/supplier/bindings/supplier_binding.dart';
import '../modules/landing/supplier/views/supplier_view.dart';
import '../modules/landing/views/landing_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/other/bindings/other_binding.dart';
import '../modules/other/views/other_view.dart';
import '../modules/product/add_product/bindings/add_product_binding.dart';
import '../modules/product/add_product/views/add_product_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/detail_product/bindings/detail_product_binding.dart';
import '../modules/product/detail_product/views/detail_product_view.dart';
import '../modules/product/edit_product/bindings/edit_product_binding.dart';
import '../modules/product/edit_product/views/edit_product_view.dart';
import '../modules/product/views/product_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/stock_in/bindings/stock_in_binding.dart';
import '../modules/stock_in/stock_in_product/bindings/stock_in_product_binding.dart';

import '../modules/stock_in/stock_in_product/views/stock_in_product_view.dart';

import '../modules/stock_in/views/stock_in_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LANDING,
      page: () => const LandingView(),
      binding: LandingBinding(),
      children: [
        GetPage(
          name: _Paths.SUPPLIER,
          page: () => const SupplierView(),
          binding: SupplierBinding(),
          children: [
            GetPage(
              name: _Paths.ADD_SUPPLIER,
              page: () => const AddSupplierView(),
              binding: AddSupplierBinding(),
            ),
          ],
        ),
      ],
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL_PRODUCT,
          page: () => DetailProductView(),
          binding: DetailProductBinding(),
        ),
        GetPage(
          name: _Paths.ADD_PRODUCT,
          page: () => AddProductView(),
          binding: AddProductBinding(),
        ),
        GetPage(
          name: _Paths.EDIT_PRODUCT,
          page: () => EditProductView(),
          binding: EditProductBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.OTHER,
      page: () => const OtherView(),
      binding: OtherBinding(),
    ),
    GetPage(
      name: _Paths.BARCODE_SCANNER,
      page: () => BarcodeScannerView(),
      binding: BarcodeScannerBinding(),
    ),
    GetPage(
      name: _Paths.STOCK_IN,
      page: () => const StockInView(),
      binding: StockInBinding(),
      children: [
        GetPage(
          name: _Paths.STOCK_IN_PRODUCT,
          page: () => const StockInProductView(),
          binding: StockInProductBinding(),
        ),
      ],
    ),
  ];
}
