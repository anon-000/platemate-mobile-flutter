import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

///
/// Created by Auro on 08/01/23 at 12:28 PM
///

class EarningByMonth {
  final String month;
  final int earning;
  final charts.Color barColor;

  EarningByMonth({
    required this.month,
    required this.earning,
    required this.barColor,
  });
}

class EarningBarChart extends StatefulWidget {
  const EarningBarChart({Key? key}) : super(key: key);

  @override
  State<EarningBarChart> createState() => _EarningBarChartState();
}

class _EarningBarChartState extends State<EarningBarChart> {
  List<EarningByMonth> earningData = [
    EarningByMonth(
      month: 'Jan',
      earning: 20000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Feb',
      earning: 30000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Mar',
      earning: 7500,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Apr',
      earning: 9000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'May',
      earning: 10000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Jun',
      earning: 30000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Jul',
      earning: 35000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Aug',
      earning: 40000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Sep',
      earning: 45000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Oct',
      earning: 50000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Nov',
      earning: 55000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
    EarningByMonth(
      month: 'Dec',
      earning: 60000,
      barColor: charts.ColorUtil.fromDartColor(
        Color(0xffF8A01B),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<charts.Series<EarningByMonth, String>> series = [
      charts.Series(
        id: "Earnings",
        data: earningData,
        domainFn: (EarningByMonth series, _) => series.month,
        measureFn: (EarningByMonth series, _) => series.earning,
        colorFn: (EarningByMonth series, _) => series.barColor,
        seriesColor: charts.ColorUtil.fromDartColor(Color(0xffffffff)),
        areaColorFn: (EarningByMonth series, _) =>
            charts.ColorUtil.fromDartColor(Color(0xffffffff)),
        // fillColorFn: (EarningByMonth series, _) => charts.ColorUtil.fromDartColor(Color(0xffffffff)),
        // patternColorFn: (EarningByMonth series, _) => charts.ColorUtil.fromDartColor(Color(0xffffffff)),
        // insideLabelStyleAccessorFn: (EarningByMonth series, _) => charts.TextStyleSpec(color: charts.ColorUtil.fromDartColor(Color(0xffffffff))),
      )
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      // decoration: BoxDecoration(
      //   color: Colors.grey.shade200.withOpacity(0.18),
      //   borderRadius: BorderRadius.circular(10),
      // ),
      // clipBehavior: Clip.antiAlias,
      height: 300,
      child: charts.BarChart(
        series,
        animate: true,
        primaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, color: charts.MaterialPalette.white),
          ),
        ),
        secondaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, color: charts.MaterialPalette.white),
          ),
        ),
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, color: charts.MaterialPalette.white),
          ),
        ),
      ),
    );
  }
}
