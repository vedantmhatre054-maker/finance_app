import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/financial_goal.dart';
import '../services/storage_service.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() =>
      _GoalScreenState();
}

class _GoalScreenState
    extends State<GoalScreen> {

  final titleController =
      TextEditingController();

  final amountController =
      TextEditingController();

  Future<void> saveGoal() async {

    if (titleController.text
        .trim()
        .isEmpty) {
      return;
    }

    final target =
        double.tryParse(
      amountController.text,
    );

    if (target == null ||
        target <= 0) {
      return;
    }

    AppData.goal =
        FinancialGoal(
      title:
          titleController.text
              .trim(),
      targetAmount: target,
    );

    await StorageService.saveGoal(
      AppData.goal!,
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Goal Saved",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Goal",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          children: [

            TextField(
              controller:
                  titleController,

              decoration:
                  const InputDecoration(
                labelText:
                    "Goal Name",
              ),
            ),

            const SizedBox(
              height: 15,
            ),

            TextField(
              controller:
                  amountController,

              keyboardType:
                  TextInputType.number,

              decoration:
                  const InputDecoration(
                labelText:
                    "Target Amount",
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              width:
                  double.infinity,

              child:
                  ElevatedButton(
                onPressed:
                    saveGoal,

                child: const Text(
                  "Save Goal",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}