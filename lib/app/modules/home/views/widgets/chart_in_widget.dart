import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kelola_barang/app/modules/home/controllers/home_controller.dart';
import 'package:kelola_barang/app/shared/styles/color_style.dart';

class ChartInWidget extends StatefulWidget {
  const ChartInWidget({super.key});

  @override
  State<ChartInWidget> createState() => _ChartInWidgetState();
}

class _ChartInWidgetState extends State<ChartInWidget> {
  final HomeController controller = Get.put(HomeController());
  double visibleMinX = 0;
  double visibleMaxX = 7;
  double? chartWidth;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        visibleMaxX =
            (controller.chartDataIn.length - 1).clamp(0, 7).toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.chartDataIn.isEmpty) {
        return Center(
          child: Text(
            'stock-in-empty'.tr,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp),
          ),
        );
      }

      final dataLength = controller.chartDataIn.length;
      final initialRange = (dataLength - 1) < 7 ? dataLength - 1 : 7;
      visibleMaxX = visibleMinX + initialRange;

      List<FlSpot> spots =
          controller.chartDataIn
              .asMap()
              .entries
              .map(
                (entry) => FlSpot(
                  entry.key.toDouble(),
                  entry.value.totalMasuk.toDouble(),
                ),
              )
              .toList();

      return LayoutBuilder(
        builder: (context, constraints) {
          chartWidth = constraints.maxWidth;
          return GestureDetector(
            onHorizontalDragUpdate: (details) {
              if (chartWidth == null || chartWidth == 0) return;

              final deltaPixel = details.primaryDelta ?? 0;
              final dataRange = visibleMaxX - visibleMinX;
              final deltaX = deltaPixel * dataRange / chartWidth!;

              setState(() {
                visibleMinX = (visibleMinX - deltaX).clamp(
                  0,
                  (dataLength - 1) - dataRange,
                );
                visibleMaxX = visibleMinX + dataRange;
              });
            },
            child: SizedBox(
              height: 280.h,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: LineChart(
                  LineChartData(
                    clipData: const FlClipData.all(),
                    minX: visibleMinX,
                    maxX: visibleMaxX,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget:
                              (value, meta) => Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 ||
                                index >= controller.chartDataIn.length) {
                              return const SizedBox.shrink();
                            }
                            final date =
                                controller.chartDataIn[index].tanggalMasuk;
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(
                      show: true,
                      drawVerticalLine: true,
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        curveSmoothness: 0.3,
                        barWidth: 3,
                        color: ColorStyle.success,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter:
                              (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                    radius: 5,
                                    color: ColorStyle.success,
                                    strokeWidth: 2,
                                    strokeColor: Colors.white,
                                  ),
                        ),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        maxContentWidth: 200,
                        getTooltipColor: (_) => Colors.black.withOpacity(0.8),
                        getTooltipItems:
                            (touchedSpots) =>
                                touchedSpots.map((spot) {
                                  final data =
                                      controller.chartDataIn[spot.x.toInt()];
                                  return LineTooltipItem(
                                    'Tanggal: ${data.tanggalMasuk.day}/${data.tanggalMasuk.month}/${data.tanggalMasuk.year}\n'
                                    'Jumlah: ${data.totalMasuk}',
                                    const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  );
                                }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
