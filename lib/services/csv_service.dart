import 'package:csv/csv.dart';

import '../data/app_data.dart';

class CsvService {

  static String generateCsv() {

    List<List<dynamic>> rows = [];

    rows.add([
      "Date",
      "Category",
      "Type",
      "Amount",
    ]);

    for (var transaction in AppData.transactions) {

      rows.add([
        "${transaction.date.day}/${transaction.date.month}/${transaction.date.year}",
        transaction.category,
        transaction.type,
        transaction.amount,
      ]);
    }

    String csv =
        const ListToCsvConverter()
            .convert(rows);

    return csv.replaceAll(',', ' , ');
  }
}