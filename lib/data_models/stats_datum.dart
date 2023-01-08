///
/// Created by Auro on 08/01/23 at 1:35 PM
///
// To parse this JSON data, do
//
//     final statsDatum = statsDatumFromJson(jsonString);

import 'dart:convert';

StatsDatum? statsDatumFromJson(String str) =>
    StatsDatum.fromJson(json.decode(str));

String statsDatumToJson(StatsDatum? data) => json.encode(data!.toJson());

class StatsDatum {
  StatsDatum({
    this.totalUsers,
    this.userReport,
    this.totalBookings,
    this.bookingReport,
  });

  int? totalUsers;
  UserReport? userReport;
  int? totalBookings;
  Map<String, BookingReport?>? bookingReport;

  factory StatsDatum.fromJson(Map<String, dynamic> json) => StatsDatum(
        totalUsers: json["totalUsers"],
        userReport: UserReport.fromJson(json["userReport"]),
        totalBookings: json["totalBookings"],
        bookingReport: Map.from(json["bookingReport"]!).map((k, v) =>
            MapEntry<String, BookingReport?>(k, BookingReport.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "totalUsers": totalUsers,
        "userReport": userReport!.toJson(),
        "totalBookings": totalBookings,
        "bookingReport": Map.from(bookingReport!)
            .map((k, v) => MapEntry<String, dynamic>(k, v!.toJson())),
      };
}

class BookingReport {
  BookingReport({
    this.month,
    this.count,
    this.monthString,
    this.upOrDownPercentage,
  });

  int? month;
  String? monthString;
  int? count;
  int? upOrDownPercentage;

  factory BookingReport.fromJson(Map<String, dynamic> json) => BookingReport(
        month: json["month"],
        count: json["count"],
        upOrDownPercentage: json["upOrDownPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "count": count,
        "upOrDownPercentage": upOrDownPercentage,
      };
}

class UserReport {
  UserReport({
    this.aug,
    this.sep,
    this.oct,
    this.nov,
    this.dec,
    this.jan,
  });

  int? aug;
  int? sep;
  int? oct;
  int? nov;
  int? dec;
  int? jan;

  factory UserReport.fromJson(Map<String, dynamic> json) => UserReport(
        aug: json["Aug"],
        sep: json["Sep"],
        oct: json["Oct"],
        nov: json["Nov"],
        dec: json["Dec"],
        jan: json["Jan"],
      );

  Map<String, dynamic> toJson() => {
        "Aug": aug,
        "Sep": sep,
        "Oct": oct,
        "Nov": nov,
        "Dec": dec,
        "Jan": jan,
      };
}
