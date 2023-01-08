///
/// Created by Auro on 07/01/23 at 1:59 AM
///

import 'dart:convert';

import 'package:event_admin/data_models/user.dart';

SupportChat supportChatFromJson(String str) =>
    SupportChat.fromJson(json.decode(str));

String supportChatToJson(SupportChat data) => json.encode(data.toJson());

class SupportChat {
  SupportChat({
    required this.id,
    this.createdBy,
    this.message,
    this.supportTicket,
    this.allowedUsers,
    this.attachment,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  User? createdBy;
  String? message;
  String? supportTicket;
  List<String>? allowedUsers;
  Attachment? attachment;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory SupportChat.fromJson(Map<String, dynamic> json) => SupportChat(
        id: json["_id"],
        createdBy:
            json["createdBy"] == null ? null : User.fromJson(json["createdBy"]),
        message: json["message"],
        supportTicket: json["supportTicket"],
        allowedUsers: json["allowedUsers"] == null
            ? []
            : List<String>.from(json["allowedUsers"].map((x) => x)),
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
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
        "message": message,
        "supportTicket": supportTicket,
        "allowedUsers": List<dynamic>.from(allowedUsers!.map((x) => x)),
        "attachment": attachment!.toJson(),
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Attachment {
  Attachment({
    this.type,
    this.link,
  });

  int? type;
  String? link;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        type: json["type"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "link": link,
      };
}
