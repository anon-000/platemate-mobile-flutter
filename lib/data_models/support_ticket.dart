// To parse this JSON data, do
//
//     final supportTicket = supportTicketFromJson(jsonString);

import 'dart:convert';

import 'package:event_admin/data_models/user.dart';

SupportTicket supportTicketFromJson(String str) =>
    SupportTicket.fromJson(json.decode(str));

String supportTicketToJson(SupportTicket data) => json.encode(data.toJson());

class SupportTicket {
  SupportTicket({
    required this.id,
    this.user,
    this.event,
    this.description,
    this.supportTicketId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.addressedBy,
    this.addressedOn,
    this.attachments,
  });

  String id;
  User? user;
  Event? event;
  String? description;
  String? supportTicketId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? addressedBy;
  DateTime? addressedOn;
  List<String>? attachments;

  factory SupportTicket.fromJson(Map<String, dynamic> json) => SupportTicket(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        event: json["event"] == null ? null : Event.fromJson(json["event"]),
        description: json["description"],
        supportTicketId: json["supportTicketId"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        attachments: json["attachments"] == null
            ? []
            : List<String>.from(json["attachments"].map((x) => x)),
        v: json["__v"],
        addressedBy: json["addressedBy"],
        addressedOn: json["addressedOn"] == null
            ? null
            : DateTime.parse(json["addressedOn"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user == null ? null : user!.toJson(),
        "event": event == null ? null : event!.toJson(),
        "description": description,
        "supportTicketId": supportTicketId,
        "attachments": attachments,
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "addressedBy": addressedBy,
        "addressedOn":
            addressedOn == null ? null : addressedOn!.toIso8601String(),
      };
}

class Event {
  Event({
    required this.id,
    this.user,
    this.attachments,
    this.address,
    this.status,
    this.guestCount,
    this.coHostCount,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
    this.endTime,
    this.eventType,
    this.name,
    this.startTime,
  });

  String id;
  String? user;
  List<String>? attachments;
  Address? address;
  int? status;
  int? guestCount;
  int? coHostCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? description;
  DateTime? endTime;
  String? eventType;
  String? name;
  DateTime? startTime;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        user: json["user"],
        attachments: json["attachments"] == null
            ? []
            : List<String>.from(json["attachments"].map((x) => x)),
        address: Address.fromJson(json["address"]),
        status: json["status"],
        guestCount: json["guestCount"],
        coHostCount: json["coHostCount"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        description: json["description"],
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        eventType: json["eventType"],
        name: json["name"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "attachments": List<dynamic>.from(attachments!.map((x) => x)),
        "address": address!.toJson(),
        "status": status,
        "guestCount": guestCount,
        "coHostCount": coHostCount,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "description": description,
        "endTime": endTime!.toIso8601String(),
        "eventType": eventType,
        "name": name,
        "startTime": startTime!.toIso8601String(),
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
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "city": city,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
