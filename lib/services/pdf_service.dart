import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../data/app_data.dart';

class PdfService {

  static Future<pw.Document> generatePdf() async {

    final pdf = pw.Document();

    double income = 0;
    double expense = 0;

    for (var transaction in AppData.transactions) {

      if (transaction.type == "Income") {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    final savings = income - expense;
    
    final totalTransactions =
          AppData.transactions.length;

      double highestExpense = 0;
      double highestIncome = 0;

      for (var transaction
          in AppData.transactions) {

        if (transaction.type ==
            "Expense") {

          if (transaction.amount >
              highestExpense) {

            highestExpense =
                transaction.amount;
          }
        }

        if (transaction.type ==
            "Income") {

          if (transaction.amount >
              highestIncome) {

            highestIncome =
                transaction.amount;
          }
        }
      }

      double averageTransaction =

          totalTransactions > 0

              ? AppData.transactions
                      .fold(
                        0.0,
                        (sum, transaction) =>
                            sum +
                            transaction.amount,
                      ) /
                  totalTransactions

              : 0;



    pdf.addPage(

      pw.MultiPage(

        build: (context) => [

          pw.Header(
            level: 0,
            child: pw.Text(
              "Finance Tracker Report",
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight:
                    pw.FontWeight.bold,
              ),
            ),
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            "Income: Rs. ${income.toStringAsFixed(2)}",
          ),

          pw.Text(
            "Expense: Rs. ${expense.toStringAsFixed(2)}",
          ),

          pw.Text(
            "Savings: Rs. ${savings.toStringAsFixed(2)}",
          ),

          pw.SizedBox(height: 15),

          pw.Text(
            "Total Transactions: $totalTransactions",
          ),

          pw.Text(
            "Highest Expense: Rs. ${highestExpense.toStringAsFixed(2)}",
          ),

          pw.Text(
            "Highest Income: Rs. ${highestIncome.toStringAsFixed(2)}",
          ),

          pw.Text(
            "Average Transaction: Rs. ${averageTransaction.toStringAsFixed(2)}",
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            "Transactions",
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight:
                  pw.FontWeight.bold,
            ),
          ),

          pw.SizedBox(height: 10),

          pw.Table.fromTextArray(

            headers: const [
              "Date",
              "Category",
              "Type",
              "Amount",
            ],

            data: AppData.transactions
                .map(
                  (transaction) => [

                    "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",

                    transaction.category,

                    transaction.type,

                    "Rs. ${transaction.amount.toStringAsFixed(2)}",
                  ],
                )
                .toList(),
          ),

          pw.SizedBox(height: 20),

          pw.Text(
            "Generated on: ${DateTime.now()}",
          ),
        ],
      ),
    );

    return pdf;
  }
}