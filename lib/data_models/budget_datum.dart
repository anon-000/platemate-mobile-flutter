///
/// Created by Auro on 02/12/22 at 8:41 PM
///

// To parse this JSON data, do
//
//     final budgetDatum = budgetDatumFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/category.dart';
import 'package:platemate_user/data_models/event_vendor.dart';
import 'package:platemate_user/data_models/sub_event_datum.dart';

BudgetDatum budgetDatumFromJson(String str) =>
    BudgetDatum.fromJson(json.decode(str));

String budgetDatumToJson(BudgetDatum data) => json.encode(data.toJson());

class BudgetDatum {
  BudgetDatum({
    this.id,
    this.event,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.subEventBudgets,
    this.subEvent,
    this.divisions,
  });

  String? id;
  String? event;
  double? amount;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<BudgetDatum>? subEventBudgets;
  SubEventDatum? subEvent;
  List<Division>? divisions;

  factory BudgetDatum.fromJson(Map<String, dynamic> json) => BudgetDatum(
        id: json["_id"],
        event: json["event"],
        amount: json["amount"] == null ? 0 : json["amount"].toDouble(),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        subEventBudgets: json["subEventBudgets"] == null
            ? null
            : List<BudgetDatum>.from(
                json["subEventBudgets"].map((x) => BudgetDatum.fromJson(x))),
        subEvent: json["subEvent"] == null
            ? null
            : json["subEvent"] is String
                ? SubEventDatum(id: json["subEvent"])
                : SubEventDatum.fromJson(json["subEvent"]),
        divisions: json["divisions"] == null
            ? null
            : List<Division>.from(
                json["divisions"].map((x) => Division.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "event": event,
        "amount": amount,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "subEventBudgets": subEventBudgets == null
            ? null
            : List<dynamic>.from(subEventBudgets!.map((x) => x.toJson())),
        "subEvent": subEvent == null ? null : subEvent!.toJson(),
        "divisions": divisions == null
            ? null
            : List<dynamic>.from(divisions!.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BudgetDatum &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class Division {
  Division({
    this.category,
    this.subCategory,
    this.amount,
    this.note,
    this.id,
  });

  CategoryDatum? category;
  CategoryDatum? subCategory;
  double? amount;
  String? note;
  String? id;

  factory Division.fromJson(Map<String, dynamic> json) => Division(
        category: json["category"] == null
            ? null
            : json["category"] is String
                ? CategoryDatum(id: json["category"])
                : CategoryDatum.fromJson(json["category"]),
        subCategory: json["subCategory"] == null
            ? null
            : json["subCategory"] is String
                ? CategoryDatum(id: json["subCategory"])
                : CategoryDatum.fromJson(json["subCategory"]),
        amount: json["amount"] == null ? 0 : json["amount"].toDouble(),
        note: json["note"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "subCategory": subCategory,
        "amount": amount,
        "note": note,
        "_id": id,
      };
}
