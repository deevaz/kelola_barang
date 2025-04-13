import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/landing/controllers/landing_controller.dart';

class ChartInWidget extends StatelessWidget {
  ChartInWidget({super.key});

  final LandingController controller = Get.put(LandingController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.chartDataIn.isEmpty) {
        return Center(
          child: Text(
            "Data chart kosong:\n${controller.chartDataIn.toString()}",
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        );
      }

      List<FlSpot> spots = [];
      for (int i = 0; i < controller.chartDataIn.length; i++) {
        spots.add(
          FlSpot(i.toDouble(), controller.chartDataIn[i].totalMasuk.toDouble()),
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

                      if (index < 0 || index >= controller.chartDataIn.length) {
                        return const SizedBox.shrink();
                      }

                      final date = controller.chartDataIn[index].tanggalMasuk;
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
              maxX: (controller.chartDataIn.length - 1).toDouble(),

              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  barWidth: 3,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(show: false),
                ),
              ],

              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((LineBarSpot touchedBarSpot) {
                      final index = touchedBarSpot.x.toInt();
                      final data = controller.chartDataIn[index];
                      final tanggalMasuk = data.tanggalMasuk;
                      final totalMasuk = data.totalMasuk;
                      final formattedDate =
                          "${tanggalMasuk.day}/${tanggalMasuk.month}/${tanggalMasuk.year}";

                      return LineTooltipItem(
                        'Tanggal: $formattedDate\nJumlah Barang: $totalMasuk',
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
