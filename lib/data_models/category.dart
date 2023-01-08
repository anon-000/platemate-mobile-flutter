///
/// Created by Auro on 28/11/22 at 8:53 AM
///

// To parse this JSON data, do
//
//     final cetegoryDatum = cetegoryDatumFromJson(jsonString);

import 'dart:convert';

class CategoryDatum {
  CategoryDatum({
    this.id,
    this.title,
    this.description,
    this.avatar,
    this.expanded = false,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.subCatgories,
    this.v,
  });

  String? id;
  String? title;
  String? description;
  String? avatar;
  int? status;
  bool expanded;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<CategoryDatum>? subCatgories;
  int? v;

  factory CategoryDatum.fromJson(Map<String, dynamic> json) => CategoryDatum(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        subCatgories: json["subCatgories"] == null
            ? []
            : List<CategoryDatum>.from(
                json["subCatgories"].map((x) => CategoryDatum.fromJson(x))),
        avatar: json["avatar"],
        status: json["status"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "avatar": avatar,
        "status": status,
        "subCatgories": subCatgories == null
            ? []
            : List<dynamic>.from(subCatgories!.map((x) => x)),
        "__v": v,
      };
}
