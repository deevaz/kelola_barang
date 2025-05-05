import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/models/product_response.dart';
import 'package:kelola_barang/app/modules/product/views/widgets/category_bottom.dart';
import 'package:kelola_barang/app/modules/product/views/widgets/product_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
import 'package:kelola_barang/app/shared/widgets/material_rounded.dart';
import 'package:kelola_barang/app/shared/widgets/search_widget.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: SearchWidget(
                  onChanged: (value) {
                    controller.searchProduct(value);
                    controller.searchText.value = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: MaterialRounded(
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: ColorStyle.dark,
                    ),
                    onPressed: () {
                      controller.loadProducts();
                      print('🪳panjang produk ${controller.products.length}');
                      Get.bottomSheet(
                        CategoryBottomSheet(controller: controller),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          if (controller.filteredProducts.isEmpty)
            Center(
              child: Text(
                'empty'.tr,
                style: TextStyle(fontSize: 16.sp, color: ColorStyle.dark),
              ),
            )
          else
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filteredProducts.length,
                  itemBuilder: (context, index) {
                    ProductResponse item = controller.filteredProducts[index];
                    return ProductCard(
                      item: item,
                      onDelete: () {
                        controller.deleteProduct(item.id.toString());
                      },
                      onEdit: () {
                        Get.toNamed(Routes.EDIT_PRODUCT, arguments: item);
                      },
                      onPress: () {
                        Get.toNamed(Routes.DETAIL_PRODUCT, arguments: item);
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
