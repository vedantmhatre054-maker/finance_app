import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../services/pdf_service.dart';
import '../data/app_data.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  double getMonthlyIncome(
    int month,
    int year,
  ) {
    double total = 0;

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Income" &&
          transaction.date.month == month &&
          transaction.date.year == year) {
        total += transaction.amount;
      }
    }

    return total;
  }

  double getMonthlyExpense(
    int month,
    int year,
  ) {
    double total = 0;

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Expense" &&
          transaction.date.month == month &&
          transaction.date.year == year) {
        total += transaction.amount;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final income = getMonthlyIncome(
      now.month,
      now.year,
    );

    final expense = getMonthlyExpense(
      now.month,
      now.year,
    );

    final savings = income - expense;

    final budget =
    AppData.monthlyBudget;

        final remainingBudget =
            budget - expense;

        final budgetProgress =
            budget > 0
                ? expense / budget
                : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Monthly Reports",
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // CSV BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "CSV Preview",
                        ),
                        content: SizedBox(
                          width: 700,
                          height: 400,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: DataTable(
                                columns: const [
                                  DataColumn(
                                    label: Text("Date"),
                                  ),
                                  DataColumn(
                                    label: Text("Category"),
                                  ),
                                  DataColumn(
                                    label: Text("Type"),
                                  ),
                                  DataColumn(
                                    label: Text("Amount"),
                                  ),
                                ],
                                rows: AppData.transactions
                                    .map(
                                      (transaction) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              transaction.category,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              transaction.type,
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              "₹${transaction.amount}",
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Close",
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.download,
                ),
                label: const Text(
                  "Export CSV",
                ),
              ),
            ),

            const SizedBox(height: 10),

            // PDF BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final pdf =
                      await PdfService.generatePdf();

                  await Printing.layoutPdf(
                    onLayout: (format) async =>
                        pdf.save(),
                  );
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                ),
                label: const Text(
                  "Export PDF",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 5,
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "${now.month}/${now.year}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ListTile(
                      leading: const Icon(
                        Icons.arrow_downward,
                        color: Colors.green,
                      ),
                      title: const Text(
                        "Income",
                      ),
                      trailing: Text(
                        "₹${income.toStringAsFixed(2)}",
                      ),
                    ),

                    ListTile(
                      leading: const Icon(
                        Icons.arrow_upward,
                        color: Colors.red,
                      ),
                      title: const Text(
                        "Expense",
                      ),
                      trailing: Text(
                        "₹${expense.toStringAsFixed(2)}",
                      ),
                    ),

                    ListTile(
                      leading: const Icon(
                        Icons.savings,
                      ),
                      title: const Text(
                        "Savings",
                      ),
                      trailing: Text(
                        "₹${savings.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: savings >= 0
                              ? Colors.green
                              : Colors.red,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            
            const SizedBox(height: 20),
            
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
            
                child: Column(
                  children: [
            
                    const Text(
                      "Budget Progress",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
            
                    const SizedBox(height: 15),
            
                    ListTile(
                      leading: const Icon(
                        Icons.account_balance_wallet,
                      ),
            
                      title: const Text(
                        "Budget",
                      ),
            
                      trailing: Text(
                        "₹${budget.toStringAsFixed(2)}",
                      ),
                    ),
            
                    ListTile(
                      leading: const Icon(
                        Icons.money_off,
                        color: Colors.red,
                      ),
            
                      title: const Text(
                        "Spent",
                      ),
            
                      trailing: Text(
                        "₹${expense.toStringAsFixed(2)}",
                      ),
                    ),
            
                    ListTile(
                      leading: const Icon(
                        Icons.savings,
                        color: Colors.green,
                      ),
            
                      title: const Text(
                        "Remaining",
                      ),
            
                      trailing: Text(
                        "₹${remainingBudget.toStringAsFixed(2)}",
                        style: TextStyle(
                          color:
                              remainingBudget >= 0
                                  ? Colors.green
                                  : Colors.red,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
            
                    const SizedBox(height: 10),
            
                    LinearProgressIndicator(
                      value: budget > 0
                          ? budgetProgress.clamp(
                              0.0,
                              1.0,
                            )
                          : 0,
                    ),
            
                    const SizedBox(height: 10),
            
                    Text(
                      budget > 0
                          ? "${(budgetProgress * 100).toStringAsFixed(1)}% Used"
                          : "No Budget Set",
                    ),
                  ],
                ),
              ),
            ),
            
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Report Summary",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "Transactions This Month: ${AppData.transactions.where((t) => t.date.month == now.month && t.date.year == now.year).length}",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
