import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../data/app_data.dart';

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  double getIncome() {
    double income = 0;

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Income") {
        income += transaction.amount;
      }
    }

    return income;
  }

  double getExpense() {
    double expense = 0;

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Expense") {
        expense += transaction.amount;
      }
    }

    return expense;
  }

  @override
  Widget build(BuildContext context) {
    final income = getIncome();
    final expense = getExpense();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            const Text(
              "Income vs Expense",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 300,
              child: PieChart(
                PieChartData(
                  sections: [

                    PieChartSectionData(
                      value: income == 0 ? 1 : income,
                      title: "Income",
                      radius: 100,
                      color: Colors.green,
                    ),

                    PieChartSectionData(
                      value: expense == 0 ? 1 : expense,
                      title: "Expense",
                      radius: 100,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.arrow_downward,
                ),
                title: const Text("Total Income"),
                trailing: Text(
                  "₹${income.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.arrow_upward,
                ),
                title: const Text("Total Expense"),
                trailing: Text(
                  "₹${expense.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                ),
                title: const Text("Current Balance"),
                trailing: Text(
                  "₹${(income - expense).toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}