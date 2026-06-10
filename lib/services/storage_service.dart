import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';
import '../models/user_profile.dart';
import '../models/financial_goal.dart';

class StorageService {

  static const String transactionKey =
      "transactions";

  static const String profileKey =
      "user_profile";

  static const String budgetKey =
       "monthly_budget";    

  static const String goalKey =
       "financial_goal";

  static Future<void> saveTransactions(
    List<Transaction> transactions,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    final List<String> data =
        transactions.map((transaction) {

      return jsonEncode({
        "category":
            transaction.category,

        "amount":
            transaction.amount,

        "type":
            transaction.type,

        "date":
            transaction.date
                .toIso8601String(),
      });
    }).toList();

    await prefs.setStringList(
      transactionKey,
      data,
    );
  }

  static Future<List<Transaction>>
      loadTransactions() async {

    final prefs =
        await SharedPreferences.getInstance();

    final List<String>? data =
        prefs.getStringList(
      transactionKey,
    );

    if (data == null) {
      return [];
    }

    return data.map((item) {

      final json =
          jsonDecode(item);

      return Transaction(
        category:
            json["category"],

        amount:
            json["amount"],

        type:
            json["type"],

        date:
            DateTime.parse(
              json["date"],
            ),
      );
    }).toList();
  }

  static Future<void> saveProfile(
    UserProfile profile,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      profileKey,

      jsonEncode(
        profile.toJson(),
      ),
    );
  }

  static Future<UserProfile?>
      loadProfile() async {

    final prefs =
        await SharedPreferences.getInstance();

    final data =
        prefs.getString(
      profileKey,
    );

    if (data == null) {
      return null;
    }

    return UserProfile.fromJson(
      jsonDecode(data),
    );
  }
  static Future<void> saveBudget(
    double budget,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setDouble(
      budgetKey,
      budget,
    );
  }

  static Future<double> loadBudget()
      async {

    final prefs =
        await SharedPreferences.getInstance();

    return prefs.getDouble(
          budgetKey,
        ) ??
        0;
  }

  static Future<void> saveGoal(
    FinancialGoal goal,
  ) async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.setString(
      goalKey,
      jsonEncode(
        goal.toJson(),
      ),
    );
  }

  static Future<FinancialGoal?>
      loadGoal() async {

      final prefs =
          await SharedPreferences.getInstance();

      final data =
          prefs.getString(
        goalKey,
      );

      if (data == null) {
        return null;
      }

      return FinancialGoal.fromJson(
        jsonDecode(data),
      );
    }

    static Future<void> clearAllData()
      async {

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.clear();
  }
}