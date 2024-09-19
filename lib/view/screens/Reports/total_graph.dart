import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'total_sale_report_screen.dart';

class ReportTotalGraph extends StatefulWidget {
  final List<ChartDataForTotalSale> list_of_total_sale;
  ReportTotalGraph({super.key, required this.list_of_total_sale});

  List<Color> get availableColors => const <Color>[
        AppColor.contentColorPurple,
        AppColor.contentColorYellow,
        AppColor.contentColorBlue,
        AppColor.contentColorOrange,
        AppColor.contentColorPink,
        AppColor.contentColorRed,
      ];

  final Color barBackgroundColor = AppColor.contentColorWhite.withOpacity(0.3);
  final Color barColor = AppColor.contentColorWhite;
  final Color touchedBarColor = AppColor.contentColorGreen;

  @override
  State<StatefulWidget> createState() => ReportTotalGraphState();
}

class ReportTotalGraphState extends State<ReportTotalGraph> {
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Total Sale Report',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: BarChart(
                mainBarData(),
                swapAnimationDuration: animDuration,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 300,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() =>
      List.generate(widget.list_of_total_sale.length, (i) {
        return makeGroupData(
            i, widget.list_of_total_sale[i].sales_expense!.toDouble(),
            isTouched: i == touchedIndex);
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          //tooltipBgColor: Colors.blueGrey,
          tooltipHorizontalAlignment: FLHorizontalAlignment.center,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            weekDay = widget.list_of_total_sale[group.x].month_name!;
            return BarTooltipItem(
              '$weekDay\n',
              const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              children: <TextSpan>[
                TextSpan(
                  text:
                      'Sales Expense : ${widget.list_of_total_sale[group.x].sales_expense}\n',
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text:
                      'Admin Commission : ${widget.list_of_total_sale[group.x].admin_commission}\n',
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text:
                      'Delivery Company Charges : ${widget.list_of_total_sale[group.x].delivery_company_charges}\n',
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: 'No of Sale : ${(rod.toY - 1).toString()}',
                  style: TextStyle(
                    color: widget.touchedBarColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData:  FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blue,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );
    Widget text;
    text = Container(
      width: 20,
      child: Text('${widget.list_of_total_sale[value.toInt()].month_name}',
          style: style),
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
      animDuration + const Duration(milliseconds: 50),
    );
    if (isPlaying) {
      await refreshState();
    }
  }
}

class AppColor {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.yellow;
  static const Color mainTextColor2 = Colors.purple;
  static const Color mainTextColor3 = Colors.lightGreen;
  static const Color mainGridLineColor = Colors.lightBlue;
  static const Color borderColor = Colors.orange;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.teal;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}
