import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_translator/google_translator.dart';
import 'package:mShop_Seller/utils_services/app_font.dart';
import '../../../../model/dashboard/dashboard_model.dart';

class PieChartSample2 extends StatefulWidget {
  final DashBoard? dashboard;
  const PieChartSample2({super.key, this.dashboard});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list_indicator(),
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<Widget> list_indicator() {
    return widget.dashboard!.data!.categoryWiseProduct!.entries.map((e) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Indicator(
          color: e.value.color,
          text: '${e.value.name}',
          isSquare: true,
        ),
      );
    }).toList();
  }

  List<PieChartSectionData> showingSections() {
    return widget.dashboard!.data!.categoryWiseProduct!.entries.map((e) {
      final fontSize = 10.0;
      final radius = 50.0;
      return PieChartSectionData(
        color: e.value.color,
        value: e.value.count!.toDouble(),
        title: '${e.value.count}',
        radius: radius,
        showTitle: true,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );
    }).toList();
  }
}

class Indicator extends StatefulWidget {
  final Color? color;
  final String? text;
  final bool? isSquare;
  const Indicator({Key? key, this.color, this.text, this.isSquare})
      : super(key: key);

  @override
  State<Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: Text('${widget.text}',
              style: TextStyle(fontFamily: AppFonts.segoeui, fontSize: 12)).translate(),
        ),
        SizedBox(width: 5),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(5)),
        ),
      ],
    );
  }
}
