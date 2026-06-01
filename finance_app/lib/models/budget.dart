
class Budget {

  double monthlyBudget;

  Budget({
    required this.monthlyBudget,
  });

  Map<String, dynamic> toJson() {
    return {
      'monthlyBudget': monthlyBudget,
    };
  }

  factory Budget.fromJson(
    Map<String, dynamic> json,
  ) {
    return Budget(
      monthlyBudget:
          json['monthlyBudget'] ?? 0,
    );
  }
}