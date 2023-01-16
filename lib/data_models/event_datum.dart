///
/// Created by Auro on 23/11/22 at 12:31 AM
///

import 'dart:convert';

import 'package:event_admin/data_models/event_type.dart';
import 'package:event_admin/data_models/sub_event_datum.dart';
import 'package:event_admin/data_models/user.dart';

EventDatum eventDatumFromJson(String str) =>
    EventDatum.fromJson(json.decode(str));

String eventDatumToJson(EventDatum data) => json.encode(data.toJson());

class EventDatum {
  EventDatum({
    this.user,
    this.attachments,
    this.address,
    this.status,
    this.guestCount,
    this.coHostCount,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.description,
    this.endTime,
    this.eventType,
    this.name,
    this.subEvents,
    this.startTime,
    this.loading = false,
  });

  User? user;
  bool loading;
  List<dynamic>? attachments;
  List<SubEventDatum>? subEvents;
  Address? address;
  int? status;
  int? guestCount;
  int? coHostCount;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? description;
  DateTime? endTime;
  EventType? eventType;
  String? name;
  DateTime? startTime;

  factory EventDatum.fromJson(Map<String, dynamic> json) => EventDatum(
        user: json["user"] == null
            ? null
            : json["user"] is String
                ? User(id: json["user"])
                : User.fromJson(json["user"]),
        loading: json["loading"] ?? false,
        attachments: json["attachments"] == null
            ? []
            : List<dynamic>.from(json["attachments"].map((x) => x)),
        subEvents: json["subEvents"] == null
            ? []
            : List<SubEventDatum>.from(
                json["subEvents"].map((x) => SubEventDatum.fromJson(x))),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        status: json["status"],
        guestCount: json["guestCount"],
        coHostCount: json["coHostCount"],
        id: json["_id"],
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
        eventType: json["eventType"] == null
            ? null
            : json["eventType"] is String
                ? EventType(id: json["eventType"])
                : EventType.fromJson(json["eventType"]),
        name: json["name"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user!.toJson(),
        "loading": loading,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "subEvents": subEvents == null
            ? []
            : List<dynamic>.from(subEvents!.map((x) => x.toJson())),
        "address": address!.toJson(),
        "status": status,
        "guestCount": guestCount,
        "coHostCount": coHostCount,
        "_id": id,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Address {
  Address({
    this.coordinates,
    this.addressLine1,
    this.city,
  });

  List<double>? coordinates;
  String? addressLine1;
  String? city;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"].map((x) => x!.toDouble())),
        addressLine1: json["addressLine1"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "city": city,
        "addressLine1": addressLine1,
      };
}
