import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class ChartOutWidget extends StatelessWidget {
  ChartOutWidget({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.chartDataOut.isEmpty) {
        return Center(
          child: Text(
            'stock-out-empty'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp),
          ),
        );
      }

      List<FlSpot> spots = [];
      for (int i = 0; i < controller.chartDataOut.length; i++) {
        spots.add(
          FlSpot(
            i.toDouble(),
            controller.chartDataOut[i].totalKeluar.toDouble(),
          ),
        );
      }

      return SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toInt().toString(),
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),

                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();

                      if (index < 0 ||
                          index >= controller.chartDataOut.length) {
                        return const SizedBox.shrink();
                      }

                      final date = controller.chartDataOut[index].tanggalKeluar;
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          "${date.day}/${date.month}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      );
                    },
                  ),
                ),

                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),

                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),

              gridData: FlGridData(show: true),

              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(color: Colors.black, width: 1),
                  left: BorderSide(color: Colors.black, width: 1),
                  right: BorderSide(color: Colors.transparent),
                  top: BorderSide(color: Colors.transparent),
                ),
              ),

              minX: 0,
              maxX: (controller.chartDataOut.length - 1).toDouble(),

              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  barWidth: 3,
                  color: ColorStyle.danger,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],

              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((LineBarSpot touchedBarSpot) {
                      final index = touchedBarSpot.x.toInt();
                      final data = controller.chartDataOut[index];
                      final tanggalKeluar = data.tanggalKeluar;
                      final totalKeluar = data.totalKeluar;
                      final formattedDate =
                          "${tanggalKeluar.day}/${tanggalKeluar.month}/${tanggalKeluar.year}";

                      return LineTooltipItem(
                        'Tanggal: $formattedDate\nJumlah Barang: $totalKeluar',
                        const TextStyle(color: Colors.white),
                      );
                    }).toList();
                  },
                ),
                touchCallback: (
                  FlTouchEvent touchEvent,
                  LineTouchResponse? touchResponse,
                ) {
                  if (touchEvent is FlLongPressEnd ||
                      touchEvent is FlPanEndEvent) {
                    print("Touch end detected");
                  }
                },
                handleBuiltInTouches: true,
              ),
            ),
          ),
        ),
      );
    });
  }
}
