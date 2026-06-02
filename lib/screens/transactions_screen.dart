import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../models/transaction.dart';
import '../widgets/transaction_tile.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() =>
      _TransactionsScreenState();
}

class _TransactionsScreenState
    extends State<TransactionsScreen> {

  String searchText = "";
  String filterType = "All";
  String sortType = "Newest";

  void deleteTransaction(Transaction transaction) {
    setState(() {
      AppData.transactions.remove(transaction);
      AppData.save();
    });
  }

  void editTransaction(
    Transaction transaction,
  ) {

    final categoryController =
        TextEditingController(
      text: transaction.category,
    );

    final amountController =
        TextEditingController(
      text: transaction.amount.toString(),
    );

    String selectedType =
        transaction.type;

    showDialog(
      context: context,
      builder: (context) {

        return StatefulBuilder(
          builder: (context, setDialogState) {

            return AlertDialog(
              title: const Text(
                "Edit Transaction",
              ),

              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,
                  children: [

                    TextField(
                      controller:
                          categoryController,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Category",
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    TextField(
                      controller:
                          amountController,
                      keyboardType:
                          TextInputType
                              .number,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Amount",
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    DropdownButtonFormField<
                        String>(
                      value: selectedType,

                      items: const [

                        DropdownMenuItem(
                          value:
                              "Income",
                          child:
                              Text("Income"),
                        ),

                        DropdownMenuItem(
                          value:
                              "Expense",
                          child:
                              Text(
                                  "Expense"),
                        ),
                      ],

                      onChanged:
                          (value) {
                        setDialogState(
                            () {
                          selectedType =
                              value!;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context);
                  },
                  child:
                      const Text("Cancel"),
                ),

                ElevatedButton(
                  onPressed: () {

                    transaction.category =
                        categoryController
                            .text;

                    transaction.amount =
                        double.tryParse(
                              amountController
                                  .text,
                            ) ??
                            0;

                    transaction.type =
                        selectedType;

                    AppData.save();

                    setState(() {});

                    Navigator.pop(
                        context);
                  },
                  child:
                      const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  List<Transaction>
      getFilteredTransactions() {

    List<Transaction>
        transactions =
        List.from(
      AppData.transactions,
    );

    if (searchText.isNotEmpty) {

        transactions =
            transactions.where(
          (transaction) {

            final query =
                searchText.toLowerCase();

            final dateString =
                "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}";

            return

                transaction.category
                    .toLowerCase()
                    .contains(query)

                ||

                transaction.type
                    .toLowerCase()
                    .contains(query)

                ||

                transaction.amount
                    .toString()
                    .contains(query)

                ||

                dateString
                    .toLowerCase()
                    .contains(query);
          },
        ).toList();
      }

    if (filterType != "All") {
      transactions =
          transactions.where(
        (transaction) {
          return transaction.type ==
              filterType;
        },
      ).toList();
    }

    if (sortType == "Newest") {

        transactions.sort(
          (a, b) =>
              b.date.compareTo(
            a.date,
          ),
        );
      }

      if (sortType == "Oldest") {

        transactions.sort(
          (a, b) =>
              a.date.compareTo(
            b.date,
          ),
        );
      }

    if (sortType ==
        "Amount High → Low") {
      transactions.sort(
        (a, b) =>
            b.amount.compareTo(
          a.amount,
        ),
      );
    }

    if (sortType ==
        "Amount Low → High") {
      transactions.sort(
        (a, b) =>
            a.amount.compareTo(
          b.amount,
        ),
      );
    }

    return transactions;
  }

  @override
  Widget build(BuildContext context) {

    final transactions =
        getFilteredTransactions();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "All Transactions",
        ),
      ),

      body: Column(
        children: [

          Padding(
            padding:
                const EdgeInsets.all(12),
            child: TextField(
              decoration:
                  const InputDecoration(
                hintText:
                    "Search Category , Amount, Date...",
                prefixIcon:
                    Icon(Icons.search),
                border:
                    OutlineInputBorder(),
              ),

              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
            ),
          ),

          Padding(
            padding:
                const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              children: [

                Expanded(
                  child:
                      DropdownButtonFormField<
                          String>(
                    value: filterType,

                    decoration:
                        const InputDecoration(
                      labelText:
                          "Filter",
                    ),

                    items: const [

                      DropdownMenuItem(
                        value: "All",
                        child:
                            Text("All"),
                      ),

                      DropdownMenuItem(
                        value:
                            "Income",
                        child:
                            Text("Income"),
                      ),

                      DropdownMenuItem(
                        value:
                            "Expense",
                        child:
                            Text(
                                "Expense"),
                      ),
                    ],

                    onChanged:
                        (value) {
                      setState(() {
                        filterType =
                            value!;
                      });
                    },
                  ),
                ),

                const SizedBox(
                    width: 10),

                Expanded(
                  child:
                      DropdownButtonFormField<
                          String>(
                    value: sortType,

                    decoration:
                        const InputDecoration(
                      labelText:
                          "Sort",
                    ),

                    items: const [

                      DropdownMenuItem(
                        value:
                            "Newest",
                        child:
                            Text(
                                "Newest"),
                      ),

                      DropdownMenuItem(
                          value: "Oldest",
                          child: Text("Oldest"),
                        ),

                      DropdownMenuItem(
                        value:
                            "Amount High → Low",
                        child: Text(
                          "High → Low",
                        ),
                      ),

                      DropdownMenuItem(
                        value:
                            "Amount Low → High",
                        child: Text(
                          "Low → High",
                        ),
                      ),
                    ],

                    onChanged:
                        (value) {
                      setState(() {
                        sortType =
                            value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: transactions
                    .isEmpty
                ? const Center(
                    child: Text(
                      "No Transactions Found",
                    ),
                  )
                : ListView.builder(
                    padding:
                        const EdgeInsets
                            .all(12),

                    itemCount:
                        transactions
                            .length,

                    itemBuilder:
                        (context,
                            index) {

                      final transaction =
                          transactions[
                              index];

                      return TransactionTile(
                        transaction:
                            transaction,

                        onEdit: () {
                          editTransaction(
                            transaction,
                          );
                        },

                        onDelete: () {
                          deleteTransaction(
                            transaction,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}