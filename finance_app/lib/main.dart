
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'data/app_data.dart';

void main() {
  runApp(const FinanceTrackerApp());
}

class FinanceTrackerApp extends StatelessWidget {
  const FinanceTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance Tracker',
      theme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    TransactionsScreen(),
    ChartsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Transactions",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Charts",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  children: const [
                    Text(
                      "Current Balance",
                      style: TextStyle(fontSize: 18),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "₹0",
                      style: TextStyle(
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
                        children: const [
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                          ),

                          SizedBox(height: 8),

                          Text("Income"),

                          SizedBox(height: 5),

                          Text(
                            "₹0",
                            style: TextStyle(
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
                        children: const [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.red,
                          ),

                          SizedBox(height: 8),

                          Text("Expense"),

                          SizedBox(height: 5),

                          Text(
                            "₹0",
                            style: TextStyle(
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
                  ? const Card(
                      child: ListTile(
                        leading: Icon(Icons.receipt_long),
                        title: Text("No transactions yet"),
                      ),
                    )
                  : ListView.builder(
                      itemCount: AppData.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction =
                            AppData.transactions[index];
            
                        return Card(
                          child: ListTile(
                            leading: Icon(
                              transaction.type == "Income"
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                            ),
                            title: Text(transaction.category),
                            subtitle: Text(transaction.type),
                            trailing: Text(
                              "₹${transaction.amount}",
                            ),
                          ),
                        );
                      },
                    ),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const AddTransactionScreen(),
            ),
          ).then((_) {
            (context as Element).markNeedsBuild();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Transactions Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Charts Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {

  final TextEditingController categoryController =
      TextEditingController();

  final TextEditingController amountController =
      TextEditingController();

  String transactionType = "Expense";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            TextField(
              controller: categoryController,
              decoration: const InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: transactionType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: "Income",
                  child: Text("Income"),
                ),
                DropdownMenuItem(
                  value: "Expense",
                  child: Text("Expense"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  transactionType = value!;
                });
              },
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  final transaction = Transaction(
                    category: categoryController.text,
                    amount: double.parse(
                      amountController.text,
                    ),
                    type: transactionType,
                  );

                  AppData.transactions.add(
                    transaction,
                  );

                  Navigator.pop(context);
                },

                child: const Text(
                  "Save Transaction",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Settings Screen",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}