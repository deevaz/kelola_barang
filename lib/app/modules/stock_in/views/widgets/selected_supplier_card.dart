import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_barang/app/modules/stock_in/views/widgets/supplier_in_card.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class SelectedSupplierCard extends StatelessWidget {
  const SelectedSupplierCard({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> pemasok = ['Supplier 1', 'Supplier 2', 'Supplier 3'];
    return InkWell(
      onTap: () {
        // Get.toNamed('/pilih_pemasok');
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Ionicons.person_add_outline,
                          color: ColorStyle.dark,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        'Pilih Pemasok',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorStyle.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Ionicons.chevron_forward,
                      color: ColorStyle.dark,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              if (pemasok.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(color: ColorStyle.dark, height: 0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Pemasok ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: ColorStyle.dark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return SupplierInCard(item: pemasok[index]);
                      },
                      itemCount: pemasok.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ],
                )
              else
                SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
