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

            // BALANCE CARD

            Card(
              elevation: 5,

              child: Padding(
                padding:
                    const EdgeInsets.all(
                        20),

                child: Column(
                  children: [

                    const Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      "₹${balance.toStringAsFixed(2)}",

                      style:
                          const TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // INCOME & EXPENSE

            Row(
              children: [

                Expanded(
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets
                              .all(16),

                      child: Column(
                        children: [

                          const Icon(
                            Icons
                                .arrow_downward,
                            color:
                                Colors.green,
                          ),

                          const SizedBox(
                              height: 8),

                          const Text(
                            "Income",
                          ),

                          const SizedBox(
                              height: 5),

                          Text(
                            "₹${income.toStringAsFixed(2)}",

                            style:
                                const TextStyle(
                              color: Colors
                                  .green,
                              fontSize:
                                  22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding:
                          const EdgeInsets
                              .all(16),

                      child: Column(
                        children: [

                          const Icon(
                            Icons
                                .arrow_upward,
                            color:
                                Colors.red,
                          ),

                          const SizedBox(
                              height: 8),

                          const Text(
                            "Expense",
                          ),

                          const SizedBox(
                              height: 5),

                          Text(
                            "₹${expense.toStringAsFixed(2)}",

                            style:
                                const TextStyle(
                              color:
                                  Colors.red,
                              fontSize:
                                  22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
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