///
/// Created by Auro on 01/12/22 at 11:48 PM
///

import 'dart:convert';

VendorPackageDatum vendorPackageDatumFromJson(String str) =>
    VendorPackageDatum.fromJson(json.decode(str));

String vendorPackageDatumToJson(VendorPackageDatum data) =>
    json.encode(data.toJson());

class VendorPackageDatum {
  VendorPackageDatum({
    this.id,
    this.createdBy,
    this.vendor,
    this.name,
    this.description,
    this.attachment,
    this.status,
  });

  String? id;
  String? createdBy;
  String? vendor;
  String? name;
  String? description;
  String? attachment;
  int? status;

  factory VendorPackageDatum.fromJson(Map<String, dynamic> json) =>
      VendorPackageDatum(
        id: json["_id"],
        createdBy: json["createdBy"],
        vendor: json["vendor"],
        name: json["name"],
        description: json["description"],
        attachment: json["attachment"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "createdBy": createdBy,
        "vendor": vendor,
        "name": name,
        "description": description,
        "attachment": attachment,
        "status": status,
      };
}
