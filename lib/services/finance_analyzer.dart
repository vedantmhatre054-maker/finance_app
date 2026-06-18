import '../data/app_data.dart';
import '../models/transaction.dart';

class FinanceAnalyzer {

  static double getTotalIncome() {
    double total = 0;

    for (Transaction transaction
        in AppData.transactions) {

      if (transaction.type ==
          "Income") {

        total += transaction.amount;
      }
    }

    return total;
  }

  static double getTotalExpense() {
    double total = 0;

    for (Transaction transaction
        in AppData.transactions) {

      if (transaction.type ==
          "Expense") {

        total += transaction.amount;
      }
    }

    return total;
  }

  static double getBalance() {
    return getTotalIncome() -
        getTotalExpense();
  }

  static String getTopExpenseCategory() {

    Map<String, double> categories = {};

    for (Transaction transaction
        in AppData.transactions) {

      if (transaction.type ==
          "Expense") {

        categories.update(
          transaction.category,
          (value) =>
              value +
              transaction.amount,
          ifAbsent: () =>
              transaction.amount,
        );
      }
    }

    if (categories.isEmpty) {
      return "No Expenses";
    }

    String topCategory = "";
    double highestAmount = 0;

    categories.forEach(
      (category, amount) {

        if (amount >
            highestAmount) {

          highestAmount = amount;
          topCategory = category;
        }
      },
    );

    return topCategory;
  }

  static String buildFinanceSummary() {

    final income =
        getTotalIncome();

    final expense =
        getTotalExpense();

    final balance =
        getBalance();

    final topCategory =
        getTopExpenseCategory();

    return '''
Financial Summary

Total Income: ₹$income

Total Expense: ₹$expense

Current Balance: ₹$balance

Top Expense Category: $topCategory
''';
  }
}