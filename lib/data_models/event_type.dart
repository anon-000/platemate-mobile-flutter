///
/// Created by Auro on 23/11/22 at 1:06 AM
///

// To parse this JSON data, do
//
//     final eventType = eventTypeFromJson(jsonString);

import 'dart:convert';

EventType eventTypeFromJson(String str) => EventType.fromJson(json.decode(str));

String eventTypeToJson(EventType data) => json.encode(data.toJson());

class EventType {
  EventType({
    this.id,
    this.name,
    this.avatar,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.loading = false,
    this.v,
  });

  String? id;
  String? name;
  String? description;
  String? avatar;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool loading;
  int? v;

  factory EventType.fromJson(Map<String, dynamic> json) => EventType(
        id: json["_id"],
        name: json["name"],
        avatar: json["avatar"],
        status: json["status"],
        description: json["description"],
        loading: json["loading"] ?? false,
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
        "name": name,
        "avatar": avatar,
        "description": description,
        "status": status,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v,
      };
}
