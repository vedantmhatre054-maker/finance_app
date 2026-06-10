class FinancialGoal {

  String title;
  double targetAmount;

  FinancialGoal({
    required this.title,
    required this.targetAmount,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "targetAmount": targetAmount,
    };
  }

  factory FinancialGoal.fromJson(
    Map<String, dynamic> json,
  ) {
    return FinancialGoal(
      title: json["title"],
      targetAmount:
          (json["targetAmount"] ?? 0)
              .toDouble(),
    );
  }
}