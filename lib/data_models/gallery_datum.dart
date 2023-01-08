///
/// Created by Auro on 23/11/22 at 8:40 PM
///

// To parse this JSON data, do
//
//     final galleryDatum = galleryDatumFromJson(jsonString);

import 'dart:convert';

GalleryDatum galleryDatumFromJson(String str) =>
    GalleryDatum.fromJson(json.decode(str));

String galleryDatumToJson(GalleryDatum data) => json.encode(data.toJson());

class GalleryDatum {
  GalleryDatum({
    this.id,
    this.user,
    this.event,
    this.image,
    this.thumbnailImage,
  });

  String? id;
  String? user;
  String? event;
  String? image;
  String? thumbnailImage;

  factory GalleryDatum.fromJson(Map<String, dynamic> json) => GalleryDatum(
        id: json["_id"],
        user: json["user"],
        event: json["event"],
        image: json["image"],
        thumbnailImage: json["thumbnailImage"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "event": event,
        "image": image,
        "thumbnailImage": thumbnailImage,
      };
}
