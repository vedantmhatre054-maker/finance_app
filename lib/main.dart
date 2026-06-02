import 'package:flutter/material.dart';

import 'data/app_data.dart';
import 'services/theme_service.dart';

import 'screens/home_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/charts_screen.dart';
import 'screens/reports_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/profile_setup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppData.load();

  final isDarkMode =
      await ThemeService.loadTheme();

  runApp(
    FinanceTrackerApp(
      isDarkMode: isDarkMode,
    ),
  );
}

class FinanceTrackerApp
    extends StatefulWidget {

  final bool isDarkMode;

  const FinanceTrackerApp({
    super.key,
    required this.isDarkMode,
  });

  static _FinanceTrackerAppState of(
    BuildContext context,
  ) {
    return context
        .findAncestorStateOfType<
            _FinanceTrackerAppState>()!;
  }

  @override
  State<FinanceTrackerApp> createState() =>
      _FinanceTrackerAppState();
}

class _FinanceTrackerAppState
    extends State<FinanceTrackerApp> {

  bool isDarkMode = true;

  @override
  void initState() {
    super.initState();

    isDarkMode = widget.isDarkMode;
  }

  Future<void> changeTheme(
      bool value) async {

    setState(() {
      isDarkMode = value;
    });

    await ThemeService.saveTheme(
      value,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false,

      title: 'Finance Tracker',

      theme: ThemeData.light(),

      darkTheme: ThemeData.dark(),

      themeMode: isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      home: AppData.profile == null
        ? const ProfileSetupScreen()
        : const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() =>
      _MainScreenState();
}

class _MainScreenState
    extends State<MainScreen> {

  int currentIndex = 0;

  final List<Widget> screens = const [
    HomeScreen(),
    TransactionsScreen(),
    ChartsScreen(),
    ReportsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar:
          BottomNavigationBar(
        currentIndex: currentIndex,

        selectedItemColor:
            Colors.blue,

        unselectedItemColor:
            Colors.grey,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        items: const [

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Transactions",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: "Charts",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: "Reports",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}