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
            "Income: ₹${income.toStringAsFixed(2)}",
          ),

          pw.Text(
            "Expense: ₹${expense.toStringAsFixed(2)}",
          ),

          pw.Text(
            "Savings: ₹${savings.toStringAsFixed(2)}",
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

                    transaction.amount
                        .toString(),
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