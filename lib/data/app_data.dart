import '../models/transaction.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';

class AppData {

  static List<Transaction> transactions = [];

  static double monthlyBudget = 0;

  static UserProfile? profile;

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