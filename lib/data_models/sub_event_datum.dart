///
/// Created by Auro on 25/11/22 at 9:23 AM
///

// To parse this JSON data, do
//
//     final subEventDatum = subEventDatumFromJson(jsonString);

import 'dart:convert';

SubEventDatum subEventDatumFromJson(String str) =>
    SubEventDatum.fromJson(json.decode(str));

String subEventDatumToJson(SubEventDatum data) => json.encode(data.toJson());

class SubEventDatum {
  SubEventDatum({
    this.id,
    this.createdBy,
    this.event,
    this.name,
    this.description,
    this.attachments,
    this.address,
    this.status,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? createdBy;
  String? event;
  String? name;
  String? description;
  List<String>? attachments;
  Address? address;
  int? status;
  DateTime? startTime;
  DateTime? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory SubEventDatum.fromJson(Map<String, dynamic> json) => SubEventDatum(
        id: json["_id"],
        createdBy: json["createdBy"],
        event: json["event"],
        name: json["name"],
        description: json["description"],
        attachments: json["attachments"] == null
            ? []
            : List<String>.from(json["attachments"].map((x) => x)),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        status: json["status"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
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
        "createdBy": createdBy,
        "event": event,
        "name": name,
        "description": description,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "address": address == null ? null : address!.toJson(),
        "status": status,
        "startTime": startTime!.toIso8601String(),
        "endTime": endTime!.toIso8601String(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Address {
  Address({
    this.addressLine1,
    this.city,
    this.coordinates,
  });

  String? addressLine1;
  String? city;
  List<double>? coordinates;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"],
        city: json["city"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "city": city,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
