import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/transaction.dart';

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

  String selectedCategory = "";

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    "Food",
    "Salary",
    "Shopping",
    "Travel",
    "Bills",
    "Health",
    "Investment",
    "Entertainment",
  ];

  void saveTransaction() {

    if (amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter amount",
          ),
        ),
      );
      return;
    }

    final amount = double.tryParse(
      amountController.text,
    );

    if (amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Enter valid amount",
          ),
        ),
      );
      return;
    }

    final transaction = Transaction(
      category: categoryController.text.trim(),
      amount: amount,
      type: transactionType,
      date: selectedDate,
    );

    AppData.transactions.add(
      transaction,
    );

    AppData.save();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Transaction",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [

              DropdownMenu<String>(
               controller: categoryController,

                  enableFilter: true,
                  enableSearch: true,
                  requestFocusOnTap: true,

            width: 350,

            label: const Text(
                "Category",
            ),

            dropdownMenuEntries:
                categories.map((category) {

                return DropdownMenuEntry(
                value: category,
                label: category,
                );

            }).toList(),

            onSelected: (value) {
            if (value != null) {
                setState(() {
                selectedCategory = value;
                categoryController.text = value;
                });
             }
            },
            ),

              const SizedBox(height: 15),

              TextField(
                controller: amountController,
                keyboardType:
                    TextInputType.number,

                decoration: const InputDecoration(
                  labelText: "Amount",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 15),

              DropdownButtonFormField<String>(
                value: transactionType,

                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Type",
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

              const SizedBox(height: 15),

              ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                ),

                title: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),

                onTap: () async {

                  final pickedDate =
                      await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      selectedDate =
                          pickedDate;
                    });
                  }
                },
              ),

              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: saveTransaction,

                  child: const Text(
                    "Save Transaction",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}