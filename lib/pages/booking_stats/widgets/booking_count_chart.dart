import 'package:event_admin/data_models/stats_datum.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;

///
/// Created by Auro on 08/01/23 at 2:34 PM
///

class BookingCountChart extends StatefulWidget {
  final Map<String, BookingReport?>? data;

  const BookingCountChart(this.data, {Key? key}) : super(key: key);

  @override
  State<BookingCountChart> createState() => _BookingCountChartState();
}

class _BookingCountChartState extends State<BookingCountChart> {
  List<BookingReport> bookingData = [];

  @override
  void initState() {
    super.initState();
    arrangeData();
  }

  Map<String, BookingReport?>? get data => widget.data;

  arrangeData() {
    List<String> bKeys = data!.keys.toList();
    bKeys.forEach((v) {
      BookingReport d = data![v]!;
      d.monthString = v.substring(0, 3);
      bookingData.add(data![v]!);
    });
    bookingData.sort((a, b) => a.month! > b.month!
        ? 1
        : a.month! < b.month!
            ? -1
            : 0);
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<BookingReport, String>> series = [
      charts.Series(
        id: "Booking",
        data: bookingData,
        domainFn: (BookingReport series, _) => series.monthString!,
        measureFn: (BookingReport series, _) => series.count,
        colorFn: (BookingReport series, _) => charts.ColorUtil.fromDartColor(
          Color(0xffF8A01B),
        ),
        seriesColor: charts.ColorUtil.fromDartColor(Color(0xffffffff)),
        areaColorFn: (BookingReport series, _) =>
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
            lineStyle: charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Color(0xffffffff).withOpacity(0.2)),
            ),
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, color: charts.MaterialPalette.white),
          ),
        ),
        secondaryMeasureAxis: charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            lineStyle: charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Color(0xffffffff).withOpacity(0.2)),
            ),
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, color: charts.MaterialPalette.white),
          ),
        ),
        domainAxis: charts.OrdinalAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelStyle: charts.TextStyleSpec(
                fontSize: 12, color: charts.MaterialPalette.white),
            lineStyle: charts.LineStyleSpec(
              color: charts.ColorUtil.fromDartColor(
                  Color(0xffffffff).withOpacity(0.2)),
            ),
          ),
        ),
      ),
    );
  }
}
