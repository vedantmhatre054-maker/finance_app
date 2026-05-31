import 'package:flutter/material.dart';
import '../data/app_data.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double get income {
    double total = 0;

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Income") {
        total += transaction.amount;
      }
    }

    return total;
  }

  double get expense {
    double total = 0;

    for (var transaction in AppData.transactions) {
      if (transaction.type == "Expense") {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Finance Tracker"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    const Text(
                      "Current Balance",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "₹${balance.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          const Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                          ),

                          const SizedBox(height: 8),

                          const Text("Income"),

                          const SizedBox(height: 5),

                          Text(
                            "₹${income.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 22,
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [

                          const Icon(
                            Icons.arrow_upward,
                            color: Colors.red,
                          ),

                          const SizedBox(height: 8),

                          const Text("Expense"),

                          const SizedBox(height: 5),

                          Text(
                            "₹${expense.toStringAsFixed(2)}",
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Recent Transactions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: AppData.transactions.isEmpty
                  ? const Center(
                      child: Text(
                        "No transactions yet",
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          AppData.transactions.length,
                      itemBuilder: (
                        context,
                        index,
                      ) {
                        return TransactionTile(
                          transaction:
                              AppData.transactions[index],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}