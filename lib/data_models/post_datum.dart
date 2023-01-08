///
/// Created by Auro on 23/11/22 at 8:50 PM
///

// To parse this JSON data, do
//
//     final postDatum = postDatumFromJson(jsonString);

import 'dart:convert';

PostDatum postDatumFromJson(String str) => PostDatum.fromJson(json.decode(str));

String postDatumToJson(PostDatum data) => json.encode(data.toJson());

class PostDatum {
  PostDatum({
    this.id,
    this.event,
    this.title,
    this.description,
    this.image,
    this.user,
    this.status,
    this.likeCount,
    this.commentCount,
    this.createdAt,
    this.updatedAt,
    this.likeData,
    this.v,
  });

  String? id;
  String? event;
  String? title;
  String? description;
  List<String>? image;
  String? user;
  int? status;
  int? likeCount;
  int? commentCount;
  LikeDatum? likeData;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        id: json["_id"],
        event: json["event"],
        title: json["title"],
        description: json["description"],
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"].map((x) => x)),
        user: json["user"],
        status: json["status"],
        likeCount: json["likeCount"],
        likeData: json["likeData"] == null
            ? null
            : json["likeData"] is String
                ? LikeDatum(id: '')
                : LikeDatum.fromJson(json["likeData"]),
        commentCount: json["commentCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "event": event,
        "title": title,
        "description": description,
        "image": List<dynamic>.from(image!.map((x) => x)),
        "user": user,
        "status": status,
        "likeData": likeData == null ? null : likeData!.toJson(),
        "likeCount": likeCount,
        "commentCount": commentCount,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class LikeDatum {
  LikeDatum({
    this.id,
    this.entityId,
    this.entityType,
  });

  String? id;
  String? entityType;
  String? entityId;

  factory LikeDatum.fromJson(Map<String, dynamic> json) => LikeDatum(
        id: json["_id"],
        entityId: json["entityId"],
        entityType: json["entityType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "entityId": entityId,
        "entityType": entityType,
      };
}
