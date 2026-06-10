import '../models/transaction.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';
import '../models/financial_goal.dart';

class AppData {

  static List<Transaction> transactions = [];

  static double monthlyBudget = 0;

  static UserProfile? profile;
  static FinancialGoal? goal;

  static void reset() {

    transactions.clear();

    monthlyBudget = 0;

    profile = null;

    goal = null;
  }
    
  static Future<void> save() async {
    await StorageService.saveTransactions(
      transactions,
    );
  }

  static Future<void> load() async {

    transactions =
        await StorageService.loadTransactions();

    profile =
        await StorageService.loadProfile();

    monthlyBudget =
        await StorageService.loadBudget();

    goal =
        await StorageService.loadGoal();    
  }
}