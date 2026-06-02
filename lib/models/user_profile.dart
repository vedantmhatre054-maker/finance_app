class UserProfile {

  String name;
  int age;
  String email;
  double monthlyIncome;
  String currency;

  UserProfile({
    required this.name,
    required this.age,
    required this.email,
    required this.monthlyIncome,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "age": age,
      "email": email,
      "monthlyIncome": monthlyIncome,
      "currency": currency,
    };
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json,
  ) {

    return UserProfile(
      name: json["name"] ?? "",

      age: json["age"] ?? 0,

      email: json["email"] ?? "",

      monthlyIncome:
          (json["monthlyIncome"] ?? 0)
              .toDouble(),

      currency:
          json["currency"] ?? "INR",
    );
  }
}