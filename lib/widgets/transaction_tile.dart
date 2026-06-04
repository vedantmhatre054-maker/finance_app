import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TransactionTile({
    super.key,
    required this.transaction,
    this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome =
        transaction.type == "Income";

    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(
            isIncome
                ? Icons.arrow_downward
                : Icons.arrow_upward,
          ),
        ),

        title: Text(
          transaction.category,
        ),

        subtitle: Text(
        "${transaction.type} • ${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              "₹${transaction.amount}",
              style: TextStyle(
                color: isIncome
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              onPressed: onEdit,
            ),

            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {

                showDialog(
                  context: context,

                  builder: (context) {

                    return AlertDialog(

                      title: const Text(
                        "Delete Transaction",
                      ),

                      content: const Text(
                        "Are you sure you want to delete this transaction?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                            );
                          },

                          child: const Text(
                            "No",
                          ),
                        ),

                        TextButton(
                          onPressed: () {

                            Navigator.pop(
                              context,
                            );

                            onDelete?.call();
                          },

                          child: const Text(
                            "Yes",
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}