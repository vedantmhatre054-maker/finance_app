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

  Map<String, double> getCategoryExpenses() {
    Map<String, double> categoryData = {};

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Expense") {
        categoryData.update(
          transaction.category,
          (value) => value + transaction.amount,
          ifAbsent: () => transaction.amount,
        );
      }
    }

    return categoryData;
  }

  static const List<Color> chartColors = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    final income = getIncome();
    final expense = getExpense();
    final balance = income - expense;

    final categoryData = getCategoryExpenses();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analytics"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Center(
              child: Text(
                "Income vs Expense",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 280,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 50,

                  sections: [

                    PieChartSectionData(
                      value:
                          income == 0
                              ? 1
                              : income,

                      title: "Income",

                      color: Colors.green,

                      radius: 100,
                    ),

                    PieChartSectionData(
                      value:
                          expense == 0
                              ? 1
                              : expense,

                      title: "Expense",

                      color: Colors.red,

                      radius: 100,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Center(
              child: Text(
                "Expense Categories",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (categoryData.isEmpty)

              const Center(
                child: Padding(
                  padding:
                      EdgeInsets.all(20),
                  child: Text(
                    "No Expense Data",
                  ),
                ),
              )

            else

              SizedBox(
                height: 300,

                child: PieChart(
                  PieChartData(
                    centerSpaceRadius:
                        45,

                    sections:
                        categoryData.entries
                            .toList()
                            .asMap()
                            .entries
                            .map(
                              (entry) {

                                final index =
                                    entry.key;

                                final item =
                                    entry.value;

                                return PieChartSectionData(
                                  value:
                                      item.value,

                                  title:
                                      item.key,

                                  color:
                                      chartColors[
                                          index %
                                              chartColors.length],

                                  radius:
                                      90,
                                );
                              },
                            )
                            .toList(),
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.arrow_downward,
                  color: Colors.green,
                ),

                title: const Text(
                  "Total Income",
                ),

                trailing: Text(
                  "₹${income.toStringAsFixed(2)}",

                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    color:
                        Colors.green,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.arrow_upward,
                  color: Colors.red,
                ),

                title: const Text(
                  "Total Expense",
                ),

                trailing: Text(
                  "₹${expense.toStringAsFixed(2)}",

                  style: const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.account_balance_wallet,
                ),

                title: const Text(
                  "Current Balance",
                ),

                trailing: Text(
                  "₹${balance.toStringAsFixed(2)}",

                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,

                    color:
                        balance >= 0
                            ? Colors.green
                            : Colors.red,
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