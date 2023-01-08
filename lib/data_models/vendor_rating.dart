///
/// Created by Auro on 01/12/22 at 11:52 PM
///

// To parse this JSON data, do
//
//     final vendorRating = vendorRatingFromJson(jsonString);

import 'dart:convert';

import 'package:event_admin/data_models/user.dart';

VendorRating vendorRatingFromJson(String str) =>
    VendorRating.fromJson(json.decode(str));

String vendorRatingToJson(VendorRating data) => json.encode(data.toJson());

class VendorRating {
  VendorRating({
    this.id,
    this.createdBy,
    this.entityType,
    this.entityId,
    this.rating,
    this.review,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  User? createdBy;
  String? entityType;
  String? entityId;
  int? rating;
  String? review;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory VendorRating.fromJson(Map<String, dynamic> json) => VendorRating(
        id: json["_id"],
        createdBy: json["createdBy"] == null
            ? null
            : json["createdBy"] is String
                ? User(id: json["createdBy"])
                : User.fromJson(json["createdBy"]),
        entityType: json["entityType"],
        entityId: json["entityId"],
        rating: json["rating"],
        review: json["review"],
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
        "entityType": entityType,
        "entityId": entityId,
        "rating": rating,
        "review": review,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
