import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  double get income {
    double total = 0;

    for (var transaction
        in AppData.transactions) {

      if (transaction.type ==
          "Income") {
        total += transaction.amount;
      }
    }

    return total;
  }

  double get expense {
    double total = 0;

    for (var transaction
        in AppData.transactions) {

      if (transaction.type ==
          "Expense") {
        total += transaction.amount;
      }
    }

    return total;
  }

  double get balance {
    return income - expense;
  }

  Widget buildStatCard(
  String title,
  String amount,
  IconData icon,
  Color color,
) {
  return Card(
    elevation: 3,

    child: Padding(
      padding:
          const EdgeInsets.all(12),

      child: Column(
        children: [

          Icon(
            icon,
            color: color,
            size: 24,
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            title,

            style: const TextStyle(
              fontSize: 14,
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          Text(
            amount,

            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,

              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {

    final budget =
        AppData.monthlyBudget;

    final budgetProgress =
        budget > 0
            ? expense / budget
            : 0.0;

    final remainingBudget =
        budget - expense;

        String warningMessage = "";
        Color warningColor = Colors.transparent;
        IconData warningIcon = Icons.check_circle;

        if (budget > 0) {

          if (expense >= budget) {

            warningMessage =
                "Budget Exceeded by ₹${(expense - budget).toStringAsFixed(2)}";

            warningColor = Colors.red;

            warningIcon = Icons.warning;

          } else if (budgetProgress >= 0.8) {

            warningMessage =
                "Warning: ${(budgetProgress * 100).toStringAsFixed(1)}% of budget used";

            warningColor = Colors.orange;

            warningIcon = Icons.warning_amber;

          }
        }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finance Tracker",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            if (AppData.profile != null)
                Align(
                  alignment: Alignment.centerLeft,

                  child: Text(
                    "Hello, ${AppData.profile!.name} 👋",

                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              if (AppData.profile != null)
                const SizedBox(
                  height: 15,
                ),

            // BALANCE CARD

            
            // INCOME & EXPENSE

    // DASHBOARD
    Row(
   children: [

    Expanded(
      child: buildStatCard(
        "Income",
        "₹${income.toStringAsFixed(0)}",
        Icons.arrow_downward,
        Colors.green,
      ),
    ),

    Expanded(
      child: buildStatCard(
        "Expense",
        "₹${expense.toStringAsFixed(0)}",
        Icons.arrow_upward,
        Colors.red,
      ),
    ),
  ],
),

const SizedBox(height: 10),

Row(
  children: [

    Expanded(
      child: buildStatCard(
        "Balance",
        "₹${balance.toStringAsFixed(0)}",
        Icons.account_balance_wallet,
        Colors.blue,
      ),
    ),

    Expanded(
      child: buildStatCard(
        "Budget Left",
        "₹${remainingBudget.toStringAsFixed(0)}",
        Icons.savings,
        remainingBudget >= 0
            ? Colors.green
            : Colors.red,
      ),
    ),
  ],
),

const SizedBox(height: 20),

    if (AppData.goal != null)

  Card(
    elevation: 5,

    child: Padding(
      padding:
          const EdgeInsets.all(16),

      child: Column(
        children: [

          const Text(
            "🎯 Financial Goal",

            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            AppData.goal!.title,

            style: const TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            "₹${balance.toStringAsFixed(0)} / ₹${AppData.goal!.targetAmount.toStringAsFixed(0)}",
          ),

          const SizedBox(
            height: 10,
          ),

          LinearProgressIndicator(
            value:
                (balance /
                        AppData.goal!
                            .targetAmount)
                    .clamp(
              0.0,
              1.0,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(
            "${((balance / AppData.goal!.targetAmount) * 100).clamp(0, 100).toStringAsFixed(1)}% Complete",
          ),
        ],
      ),
    ),
  ),


const SizedBox(height: 20),

            // BUDGET OVERVIEW

            Card(
              elevation: 5,

              child: Padding(
                padding:
                    const EdgeInsets.all(
                        16),

                child: Column(
                  children: [

                    const Text(
                      "Budget Overview",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 15),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(
                          "Budget",
                        ),

                        Text(
                          "₹${budget.toStringAsFixed(2)}",
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 10),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(
                          "Remaining",
                        ),

                        Text(
                          "₹${remainingBudget.toStringAsFixed(2)}",

                          style:
                              TextStyle(
                            color:
                                remainingBudget >=
                                        0
                                    ? Colors
                                        .green
                                    : Colors
                                        .red,

                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 15),

                    LinearProgressIndicator(
                      value: budget > 0
                          ? budgetProgress
                              .clamp(
                              0.0,
                              1.0,
                            )
                          : 0,
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      budget > 0
                          ? "${(budgetProgress * 100).toStringAsFixed(1)}% Used"
                          : "No Budget Set",
                    ),
                  ],
                ),
              ),
            ),

            if (warningMessage.isNotEmpty)

  Card(
    elevation: 5,

    child: Container(
      width: double.infinity,

      padding:
          const EdgeInsets.all(16),

      child: Row(
        children: [

          Icon(
            warningIcon,
            color: warningColor,
            size: 35,
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Text(
              warningMessage,

              style: TextStyle(
                color: warningColor,
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  ),

const SizedBox(height: 15),

            const SizedBox(height: 25),

            const Align(
              alignment:
                  Alignment.centerLeft,

              child: Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),
                      AppData.transactions.isEmpty

                          ? const Center(
                              child: Text(
                                "No transactions yet",
                              ),
                            )

                          : ListView.builder(
                              shrinkWrap: true,

                              physics:
                                  const NeverScrollableScrollPhysics(),

                              itemCount:               
                                  AppData.transactions
                                          .length >
                                      5
                                  ? 5
                                  : AppData
                                      .transactions
                                      .length,

                          itemBuilder:
                              (context,
                                  index) {

                            return TransactionTile(
                              transaction:
                                  AppData
                                          .transactions[
                                      index],
                            );
                          },
                          ),
          ],
         
        ),
      ),

      floatingActionButton:
          FloatingActionButton(
        onPressed: () async {

          await Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) =>
                  const AddTransactionScreen(),
            ),
          );

          setState(() {});
        },

        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}