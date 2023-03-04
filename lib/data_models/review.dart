///
/// Created by Auro on 08/01/23 at 10:55 AM
///

// To parse this JSON data, do
//
//     final reviewDatum = reviewDatumFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/user.dart';

ReviewDatum? reviewDatumFromJson(String str) =>
    ReviewDatum.fromJson(json.decode(str));

String reviewDatumToJson(ReviewDatum? data) => json.encode(data!.toJson());

class ReviewDatum {
  ReviewDatum({
    this.id,
    this.createdBy,
    this.rating,
    this.description,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  User? createdBy;
  double? rating;
  String? description;
  int? type;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory ReviewDatum.fromJson(Map<String, dynamic> json) => ReviewDatum(
        id: json["_id"],
        createdBy: json["createdBy"] == null || json["createdBy"] is String
            ? null
            : User.fromJson(json["createdBy"]),
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        description: json["description"],
        type: json["type"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy!.toJson(),
        "rating": rating,
        "description": description,
        "type": type,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
