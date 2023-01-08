///
/// Created by Auro on 08/01/23 at 10:06 AM
///

// To parse this JSON data, do
//
//     final bookingDistribution = bookingDistributionFromJson(jsonString);

import 'dart:convert';

BookingDistribution? bookingDistributionFromJson(String str) =>
    BookingDistribution.fromJson(json.decode(str));

String bookingDistributionToJson(BookingDistribution? data) =>
    json.encode(data!.toJson());

class BookingDistribution {
  BookingDistribution({
    this.id,
    this.name,
    this.avatar,
    this.upOrDownPercentage,
  });

  String? id;
  String? name;
  String? avatar;
  int? upOrDownPercentage;

  factory BookingDistribution.fromJson(Map<String, dynamic> json) =>
      BookingDistribution(
        id: json["_id"],
        name: json["name"],
        avatar: json["avatar"],
        upOrDownPercentage: json["upOrDownPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "avatar": avatar,
        "upOrDownPercentage": upOrDownPercentage,
      };
}
