///
/// Created by Auro on 16/11/22 at 2:24 AM
///

class Budget {
  Budget({
    this.id,
    this.amount,
    this.subBudgetList = const [],
  });

  String? id;
  double? amount;
  List<Budget>? subBudgetList;

  factory Budget.fromJson(Map<String, dynamic> json) => Budget(
        id: json["_id"] ?? '',
        amount: json["amount"] ?? '',
        subBudgetList: json["subBudgetList"] == null
            ? []
            : List<Budget>.from(
                json["subBudgetList"].map(
                  (e) => Budget.fromJson(e),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "subBudgetList":
            subBudgetList == null ? [] : subBudgetList!.map((e) => e.toJson()),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Budget && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
