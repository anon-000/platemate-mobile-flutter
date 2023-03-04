///
/// Created by Auro on 28/11/22 at 1:52 AM
///

import 'dart:convert';

import 'package:platemate_user/data_models/city.dart';
import 'package:platemate_user/data_models/user.dart';

EventVendor eventVendorFromJson(String str) =>
    EventVendor.fromJson(json.decode(str));

String eventVendorToJson(EventVendor data) => json.encode(data.toJson());

class EventVendor {
  EventVendor({
    this.id,
    this.createdBy,
    this.event,
    this.subEvent,
    this.vendor,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? createdBy;
  String? event;
  String? subEvent;
  VendorDatum? vendor;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory EventVendor.fromJson(Map<String, dynamic> json) => EventVendor(
        id: json["_id"],
        createdBy: json["createdBy"],
        event: json["event"],
        subEvent: json["subEvent"],
        vendor: json["vendor"] == null
            ? null
            : json["vendor"] is String
                ? VendorDatum(id: json["vendor"])
                : VendorDatum.fromJson(json["vendor"]),
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy,
        "event": event,
        "subEvent": subEvent,
        "vendor": vendor!.toJson(),
        "status": status,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Vendor {
  Vendor({
    this.id,
    this.user,
    this.brand,
    this.description,
    this.address,
    this.attachments,
    this.categories,
    this.languages,
    this.socialLinks,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.averageRating,
    this.totalRatings,
  });

  String? id;
  String? user;
  String? brand;
  String? description;
  Address? address;
  List<String>? attachments;
  List<Category>? categories;
  List<String>? languages;
  SocialLinks? socialLinks;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? averageRating;
  int? totalRatings;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        id: json["_id"],
        user: json["user"],
        brand: json["brand"],
        description: json["description"],
        address: Address.fromJson(json["address"]),
        attachments: List<String>.from(json["attachments"].map((x) => x)),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        languages: List<String>.from(json["languages"].map((x) => x)),
        socialLinks: SocialLinks.fromJson(json["socialLinks"]),
        status: json["status"],
        averageRating: json["averageRating"],
        totalRatings: json["totalRatings"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "brand": brand,
        "description": description,
        "address": address!.toJson(),
        "attachments": List<dynamic>.from(attachments!.map((x) => x)),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "socialLinks": socialLinks!.toJson(),
        "status": status,
        "averageRating": averageRating,
        "totalRatings": totalRatings,
      };
}

class Address {
  Address({
    this.addressLine1,
    this.city,
    this.state,
    this.pinCode,
  });

  String? addressLine1;
  City? city;
  String? state;
  String? pinCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        addressLine1: json["addressLine1"],
        city: json["city"] == null
            ? null
            : json["city"] is String
                ? City(id: json["city"])
                : City.fromJson(json["city"]),
        state: json["state"],
        pinCode: json["pinCode"],
      );

  Map<String, dynamic> toJson() => {
        "addressLine1": addressLine1,
        "city": city,
        "state": state,
        "pinCode": pinCode,
      };
}

class Category {
  Category({
    this.category,
    this.subCategories,
    this.id,
  });

  String? category;
  List<String>? subCategories;
  String? id;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        category: json["category"],
        subCategories: List<String>.from(json["subCategories"].map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "subCategories": List<dynamic>.from(subCategories!.map((x) => x)),
        "_id": id,
      };
}

class SocialLinks {
  SocialLinks({
    this.google,
    this.facebook,
    this.instagram,
  });

  String? google;
  String? facebook;
  String? instagram;

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        google: json["google"],
        facebook: json["facebook"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "google": google,
        "facebook": facebook,
        "instagram": instagram,
      };
}

VendorDatum vendorDatumFromJson(String str) =>
    VendorDatum.fromJson(json.decode(str));

String vendorDatumToJson(VendorDatum data) => json.encode(data.toJson());

class VendorDatum {
  VendorDatum({
    this.id,
    this.user,
    this.brand,
    this.description,
    this.address,
    this.attachments,
    this.categories,
    this.languages,
    this.socialLinks,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.averageRating,
    this.totalRatings,
  });

  String? id;
  User? user;
  String? brand;
  String? description;
  Address? address;
  List<String>? attachments;
  List<Category>? categories;
  List<City>? languages;
  SocialLinks? socialLinks;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  double? averageRating;
  int? totalRatings;

  factory VendorDatum.fromJson(Map<String, dynamic> json) => VendorDatum(
        id: json["_id"],
        user: json["user"] == null
            ? null
            : json["user"] is String
                ? User(id: json["user"])
                : User.fromJson(json["user"]),
        brand: json["brand"],
        description: json["description"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        attachments: json["attachments"] == null
            ? []
            : List<String>.from(json["attachments"].map((x) => x)),
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        languages: json["languages"] == null
            ? []
            : List<City>.from(json["languages"]
                .map((x) => x is String ? City(id: x) : City.fromJson(x))),
        socialLinks: json["socialLinks"] == null
            ? null
            : SocialLinks.fromJson(json["socialLinks"]),
        status: json["status"],
        averageRating: json["averageRating"] == null
            ? 0
            : json["averageRating"].toDouble(),
        totalRatings: json["totalRatings"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "brand": brand,
        "description": description,
        "address": address!.toJson(),
        "attachments": List<dynamic>.from(attachments!.map((x) => x)),
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages!.map((x) => x)),
        "socialLinks": socialLinks!.toJson(),
        "status": status,
        "averageRating": averageRating,
        "totalRatings": totalRatings,
      };
}
