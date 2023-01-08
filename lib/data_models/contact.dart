import 'dart:convert';

///
/// Created by Auro (auro@smarttersstudio.com) on 31/01/22 at 6:25 pm
///

Contact cityFromJson(String str) => Contact.fromJson(json.decode(str));

String cityToJson(Contact data) => json.encode(data.toJson());

class Contact {
  Contact({
    this.id,
    this.name,
    this.phone,
  });

  String? id;
  String? name;
  String? phone;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        phone: json["phone"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          phone == other.phone;

  @override
  int get hashCode => id.hashCode;
}
