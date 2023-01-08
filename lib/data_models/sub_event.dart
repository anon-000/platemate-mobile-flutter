///
/// Created by Auro on 16/11/22 at 4:33 AM
///

class SubEvent {
  SubEvent({
    this.id,
    this.name,
    this.description,
  });

  String? id;
  String? name;
  String? description;

  factory SubEvent.fromJson(Map<String, dynamic> json) => SubEvent(
        id: json["_id"] ?? '',
        name: json["name"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": name,
        "description": description,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubEvent && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
