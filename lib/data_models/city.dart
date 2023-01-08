import 'dart:convert';

///
/// Created by Auro (auro@smarttersstudio.com) on 31/01/22 at 6:25 pm
///

City cityFromJson(String str) => City.fromJson(json.decode(str));

String cityToJson(City data) => json.encode(data.toJson());

class City {
  City({
    this.id,
    this.status,
    this.name,
    this.defaultImage,
    this.selectedImage,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  int? status;
  String? name;
  String? createdBy;
  String? defaultImage;
  String? selectedImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["_id"] ?? '',
        status: json["status"] ?? 0,
        name: json["name"] ?? '',
        createdBy: json["createdBy"] ?? '',
        defaultImage: json["defaultImage"] ?? "",
        selectedImage: json["selectedImage"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"]).toLocal()
            : null,
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"]).toLocal()
            : null,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "status": status,
        "name": name,
        "defaultImage": defaultImage,
        "selectedImage": selectedImage,
        "createdBy": createdBy,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is City &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode;
}
