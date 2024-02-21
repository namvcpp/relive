// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({super.key});

  @override
  State<LineChartSample2> createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    Colors.green,
    Colors.greenAccent,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
        // SizedBox(
        //   width: 60,
        //   height: 34,
        //   child: TextButton(
        //     onPressed: () {
        //       setState(() {
        //         showAvg = !showAvg;
        //       });
        //     },
        //     child: Text(
        //       'avg',
        //       style: TextStyle(
        //         fontSize: 12,
        //         color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Mon', style: style);
        break;
      case 1:
        text = const Text('Tue', style: style);
        break;
      case 2:
        text = const Text('Wed', style: style);
        break;
      case 3:
        text = const Text('Thu', style: style);
        break;
      case 4:
        text = const Text('Fri', style: style);
        break;
      case 5:
        text = const Text('Sat', style: style);
        break;
      case 6:
        text = const Text('Sun', style: style);
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13,
    );
    String text;
    // Chuyển đổi giá trị Y thành phần trăm
    switch (value.toInt()) {
      case 1:
        text = '20%';
        break;
      case 2:
        text = '40%';
        break;
      case 3:
        text = '60%';
        break;
      case 4:
        text = '80%';
        break;
      case 5:
        text = '100%';
        break;
      default:
        text = '0%';
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(text, style: style),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.green,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: rightTitleWidgets,
            reservedSize: 40,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border.symmetric(
            horizontal: BorderSide(color: Colors.green),
            vertical: BorderSide(color: Colors.white),
          )),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(1, 2),
            FlSpot(2, 5),
            FlSpot(3, 3.1),
            FlSpot(4, 4),
            FlSpot(5, 3),
            FlSpot(6, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
