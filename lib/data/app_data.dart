import '../models/transaction.dart';
import '../services/storage_service.dart';

class AppData {

  static List<Transaction> transactions = [];

  static double monthlyBudget = 0;

  static Future<void> save() async {
    await StorageService.saveTransactions(
      transactions,
    );
  }

  static Future<void> load() async {
    transactions =
        await StorageService.loadTransactions();
  }
}