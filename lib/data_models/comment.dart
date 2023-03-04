///
/// Created by Auro on 30/12/22 at 2:05 AM
///

// To parse this JSON data, do
//
//     final commentDatum = commentDatumFromJson(jsonString);

import 'dart:convert';

import 'package:platemate_user/data_models/user.dart';

CommentDatum commentDatumFromJson(String str) =>
    CommentDatum.fromJson(json.decode(str));

String commentDatumToJson(CommentDatum data) => json.encode(data.toJson());

class CommentDatum {
  CommentDatum({
    this.id,
    this.post,
    this.user,
    this.description,
    this.status,
    this.likeCount,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? post;
  User? user;
  String? description;
  int? status;
  int? likeCount;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        id: json["_id"],
        post: json["post"],
        user: json["user"] == null
            ? null
            : json["user"] is String
                ? User(id: json["user"])
                : User.fromJson(json["user"]),
        description: json["description"],
        status: json["status"],
        likeCount: json["likeCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post": post,
        "user": user!.toJson(),
        "description": description,
        "status": status,
        "likeCount": likeCount,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
