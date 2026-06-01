import 'package:flutter/material.dart';

import '../main.dart';
import 'budget_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {

    final appState =
        FinanceTrackerApp.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),

      body: ListView(
        children: [

          const SizedBox(height: 10),

          const ListTile(
            leading:
                Icon(Icons.account_circle),

            title: Text(
              "Finance Tracker",
            ),

            subtitle: Text(
              "Professional Edition",
            ),
          ),

          const Divider(),

          SwitchListTile(
            value: appState.isDarkMode,

            onChanged: (value) async {

              await appState.changeTheme(
                value,
              );

              setState(() {});
            },

            title: const Text(
              "Dark Mode",
            ),

            secondary: const Icon(
              Icons.dark_mode,
            ),
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.savings,
            ),

            title: const Text(
              "Budget Goal",
            ),

            subtitle: const Text(
              "Set Monthly Budget",
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
            ),

            onTap: () {
              Navigator.push(
                context,

                MaterialPageRoute(
                  builder: (context) =>
                      const BudgetScreen(),
                ),
              );
            },
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),

            title: Text(
              "Version",
            ),

            subtitle: Text(
              "2.0.0",
            ),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.code),

            title: Text(
              "Developer",
            ),

            subtitle: Text(
              "Vedant Mhatre",
            ),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.storage),

            title: Text(
              "Storage",
            ),

            subtitle: Text(
              "Shared Preferences",
            ),
          ),

          const Divider(),

          const ListTile(
            leading:
                Icon(Icons.picture_as_pdf),

            title: Text(
              "PDF Export",
            ),

            subtitle: Text(
              "Available",
            ),
          ),

          const Divider(),

          const ListTile(
            leading:
                Icon(Icons.table_chart),

            title: Text(
              "CSV Export",
            ),

            subtitle: Text(
              "Available",
            ),
          ),
        ],
      ),
    );
  }
}