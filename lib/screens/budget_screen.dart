import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../services/storage_service.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() =>
      _BudgetScreenState();
}

class _BudgetScreenState
    extends State<BudgetScreen> {

  final TextEditingController budgetController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    budgetController.text =
        AppData.monthlyBudget == 0
            ? ""
            : AppData.monthlyBudget.toString();
  }

  Future<void> saveBudget() async {
    final amount =
        double.tryParse(
      budgetController.text,
    );

    if (amount == null) {
      return;
    }

    setState(() {
      AppData.monthlyBudget = amount;
    });

    await StorageService.saveBudget(
      amount,
    );

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Budget Saved",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Budget Goal",
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller:
                  budgetController,
              keyboardType:
                  TextInputType.number,
              decoration:
                  const InputDecoration(
                labelText:
                    "Monthly Budget",
                border:
                    OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width:
                  double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed:
                    saveBudget,
                child: const Text(
                  "Save Budget",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}