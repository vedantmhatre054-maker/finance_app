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

    List<dynamic> getFilteredTransactions(
        String reportType,
      ) {

        final now =
            DateTime.now();

        return AppData.transactions
            .where((transaction) {

          switch (reportType) {

            case "Daily":

              return transaction.date.day ==
                      now.day &&
                  transaction.date.month ==
                      now.month &&
                  transaction.date.year ==
                      now.year;

            case "Weekly":

              return now
                      .difference(
                        transaction.date,
                      )
                      .inDays <=
                  7;

            case "Monthly":

              return transaction
                          .date.month ==
                      now.month &&
                  transaction.date.year ==
                      now.year;

            case "Yearly":

              return transaction
                      .date.year ==
                  now.year;

            default:
              return true;
          }
        }).toList();
      }

    void showCsvPreview(
  BuildContext context,
  String reportType,
) {

  final transactions =
      getFilteredTransactions(
          reportType);

  showDialog(
    context: context,

    builder: (context) {

      return AlertDialog(
        title: Text(
          "$reportType CSV Preview",
        ),

        content: SizedBox(
          width: 700,
          height: 400,

          child:
              SingleChildScrollView(
            scrollDirection:
                Axis.horizontal,

            child:
                SingleChildScrollView(
              child: DataTable(
                columns: const [

                  DataColumn(
                    label:
                        Text("Date"),
                  ),

                  DataColumn(
                    label: Text(
                        "Category"),
                  ),

                  DataColumn(
                    label:
                        Text("Type"),
                  ),

                  DataColumn(
                    label:
                        Text("Amount"),
                  ),
                ],

                rows: transactions
                    .map<DataRow>(
                  (transaction) {

                    return DataRow(
                      cells: [

                        DataCell(
                          Text(
                            "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
                          ),
                        ),

                        DataCell(
                          Text(
                            transaction
                                .category,
                          ),
                        ),

                        DataCell(
                          Text(
                            transaction
                                .type,
                          ),
                        ),

                        DataCell(
                          Text(
                            "₹${transaction.amount}",
                          ),
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ),

        actions: [

          TextButton(
            onPressed: () {
              Navigator.pop(
                  context);
            },

            child:
                const Text("Close"),
          ),
        ],
      );
    },
  );
}

          void showCustomRangeDialog(
          BuildContext context,
        ) {

          DateTime? startDate;
          DateTime? endDate;

          showDialog(
            context: context,

            builder: (context) {

              return StatefulBuilder(
                builder:
                    (context,
                        setDialogState) {

                  return AlertDialog(
                    title: const Text(
                      "Custom Report",
                    ),

                    content: Column(
                      mainAxisSize:
                          MainAxisSize.min,

                      children: [

                        ElevatedButton(
                          onPressed: () async {

                            final picked =
                                await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now(),
                              firstDate:
                                  DateTime(2020),
                              lastDate:
                                  DateTime(2100),
                            );

                            if (picked != null) {

                              setDialogState(
                                () {
                                  startDate =
                                      picked;
                                },
                              );
                            }
                          },

                          child: Text(
                            startDate == null
                                ? "Select Start Date"
                                : "${startDate!.day}/${startDate!.month}/${startDate!.year}",
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        ElevatedButton(
                          onPressed: () async {

                            final picked =
                                await showDatePicker(
                              context: context,
                              initialDate:
                                  DateTime.now(),
                              firstDate:
                                  DateTime(2020),
                              lastDate:
                                  DateTime(2100),
                            );

                            if (picked != null) {

                              setDialogState(
                                () {
                                  endDate =
                                      picked;
                                },
                              );
                            }
                          },

                          child: Text(
                            endDate == null
                                ? "Select End Date"
                                : "${endDate!.day}/${endDate!.month}/${endDate!.year}",
                          ),
                        ),
                      ],
                    ),

                    actions: [

                      TextButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },

                        child:
                            const Text(
                          "Cancel",
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {

                          if (startDate !=
                                  null &&
                              endDate !=
                                  null) {

                            Navigator.pop(
                              context,
                            );

                            showCustomRangePreview(
                              context,
                              startDate!,
                              endDate!,
                            );
                          }
                        },

                        child:
                            const Text(
                          "Export",
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        }

    void showCustomRangePreview(
      BuildContext context,
      DateTime startDate,
      DateTime endDate,
    ) {

      final transactions =
          AppData.transactions.where(
        (transaction) {

          return transaction.date
                  .isAfter(
                startDate.subtract(
                  const Duration(
                    days: 1,
                  ),
                ),
              ) &&
              transaction.date
                  .isBefore(
                endDate.add(
                  const Duration(
                    days: 1,
                  ),
                ),
              );
        },
      ).toList();

      showDialog(
        context: context,

        builder: (context) {

          return AlertDialog(
            title: Text(
              "Custom Report\n${startDate.day}/${startDate.month}/${startDate.year} - ${endDate.day}/${endDate.month}/${endDate.year}",
            ),

            content: SizedBox(
              width: 700,
              height: 400,

              child:
                  SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal,

                child:
                    SingleChildScrollView(
                  child: DataTable(
                    columns: const [

                      DataColumn(
                        label:
                            Text("Date"),
                      ),

                      DataColumn(
                        label:
                            Text("Category"),
                      ),

                      DataColumn(
                        label:
                            Text("Type"),
                      ),

                      DataColumn(
                        label:
                            Text("Amount"),
                      ),
                    ],

                    rows:
                        transactions.map(
                      (transaction) {

                        return DataRow(
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
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),

            actions: [

              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },

                child:
                    const Text(
                  "Close",
                ),
              ),
            ],
          );
        },
      );
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

                  showModalBottomSheet(
                    context: context,

                    builder: (context) {

                      return SafeArea(
                        child: Column(
                          mainAxisSize:
                              MainAxisSize.min,

                          children: [

                            ListTile(
                              leading:
                                  const Icon(Icons.today),

                              title:
                                  const Text("Daily"),

                              onTap: () {
                                Navigator.pop(
                                    context);

                                showCsvPreview(
                                  context,
                                  "Daily",
                                );
                              },
                            ),

                            ListTile(
                              leading:
                                  const Icon(
                                      Icons.date_range),

                              title:
                                  const Text("Weekly"),

                              onTap: () {
                                Navigator.pop(
                                    context);

                                showCsvPreview(
                                  context,
                                  "Weekly",
                                );
                              },
                            ),

                            ListTile(
                              leading:
                                  const Icon(
                                    Icons.calendar_month,
                                  ),

                              title:
                                  const Text(
                                    "Monthly",
                                  ),

                              onTap: () {
                                Navigator.pop(
                                    context);

                                showCsvPreview(
                                  context,
                                  "Monthly",
                                );
                              },
                            ),

                            ListTile(
                              leading:
                                  const Icon(
                                    Icons.calendar_today,
                                  ),

                              title:
                                  const Text(
                                    "Yearly",
                                  ),

                              onTap: () {
                                Navigator.pop(
                                    context);

                                showCsvPreview(
                                  context,
                                  "Yearly",
                                );
                              },
                            ),
                          ListTile(
                                leading:
                                    const Icon(
                                      Icons.date_range,
                                    ),

                                title:
                                    const Text(
                                      "Custom Range",
                                    ),

                                onTap: () {

                                  Navigator.pop(
                                    context,
                                  );

                                  showCustomRangeDialog(
                                    context,
                                  );
                                },
                              ),  
                          ],
                        ),
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
