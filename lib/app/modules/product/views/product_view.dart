import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/product/views/widgets/product_card.dart';
import 'package:kelola_barang/app/routes/app_pages.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';
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
                    controller.filterProduct(value);
                    controller.searchText.value = value;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Container(
                  width: 45.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: ColorStyle.dark,
                    ),
                    onPressed: () {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text('Semua Kategori'),
                                  onTap: () {
                                    controller.filterByCategory('');
                                    Get.back();
                                  },
                                ),
                                ...controller.categories.map((kategori) {
                                  return ListTile(
                                    title: Text(kategori['name']),
                                    onTap: () {
                                      controller.filterByCategory(
                                        kategori['name'],
                                      );
                                      Get.back();
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          if (controller.allProducts.isEmpty)
            Center(
              child: Text(
                'empty'.tr,
                style: TextStyle(fontSize: 16, color: ColorStyle.dark),
              ),
            )
          else
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final item = controller.products[index];
                    return ProductCard(
                      item: item,
                      onDelete: () {
                        controller.delProduct(item['id'].toString());
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
