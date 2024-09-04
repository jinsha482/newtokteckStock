import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../global/constants/styles/text_styles/text_styles.dart';

class ChartContent extends StatelessWidget {
  const ChartContent({super.key, required this.data, required this.isOneDay});
  final List<dynamic> data;
  final bool isOneDay;

  @override
  Widget build(BuildContext context) {
   
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 45,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < data.length) {
                      final date = data[index]['timestamp'] ?? data[index]['date'] ?? data[index]['start_date'];
                      final formattedDate = isOneDay ? formatTimestamp(date) : formatDate(date, data.length);
                      return KStyles().med10(
                        text: formattedDate,
                        color: Colors.white,
                      );
                    } else {
                      return const Text('');
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 45,
                  getTitlesWidget: (value, meta) {
                    return KStyles().med10(
                      text: value.toStringAsFixed(0),
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.transparent,),
            ),
            lineBarsData: [
              LineChartBarData(
              
                curveSmoothness: 0.8,
                spots: generateSpots(data),
                isCurved: true,
                color: Colors.green,
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.transparent,
                ),
              ),
            ],
            minY: getMinY(data),
            maxY: getMaxY(data),
          ),
        ),
      ),
    );
  }

  List<FlSpot> generateSpots(List<dynamic> data) {
    List<FlSpot> spots = [];
    for (int i = 0; i < data.length; i++) {
      double y = (data[i]['total_close'] as double?) ?? 0.0;
      spots.add(FlSpot(i.toDouble(), y));
    }
    return spots;
  }

  double getMinY(List<dynamic> data) {
    double minY = data.fold(
      double.infinity,
      (prev, entry) =>
          (entry['total_close'] as double?)?.let((value) => value < prev ? value : prev) ?? prev,
    );
    return minY.isFinite ? minY - (minY * 0.01) : 0.0;
  }

  double getMaxY(List<dynamic> data) {
    double maxY = data.fold(
      -double.infinity,
      (prev, entry) =>
          (entry['total_close'] as double?)?.let((value) => value > prev ? value : prev) ?? prev,
    );
    return maxY.isFinite ? maxY : 0.0;
  }

  String formatDate(String date, int dataLength) {
    try {
      final parsedDate = DateTime.parse(date);
      if (dataLength > 30) { 
        return DateFormat('dd').format(parsedDate);
      } else if (dataLength > 7) { 
        return DateFormat('dd').format(parsedDate);
      } else { 
        return DateFormat('dd').format(parsedDate);
      }
    } catch (e) {
      return '';
    }
  }

String formatTimestamp(String timestamp) {
  try {
    // Parse the ISO 8601 timestamp
    final parsedDate = DateTime.parse(timestamp);

    // Format the time as hours (24-hour format)
    return DateFormat('H').format(parsedDate);

  } catch (e) {
    log('Error formatting timestamp: $e');
    return '';
  }
}


}

extension NullableDouble on double? {
  double let(double Function(double) fn) => this == null ? 0.0 : fn(this!);
}
