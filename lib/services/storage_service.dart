import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';

class StorageService {

  static const String transactionKey =
      "transactions";

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
        "date": transaction.date.toIso8601String(),   
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
            DateTime.parse(json["date"]),
      );
    }).toList();
  }
}