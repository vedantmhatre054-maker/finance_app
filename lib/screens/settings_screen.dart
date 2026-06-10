import 'package:flutter/material.dart';
import 'profile_setup_screen.dart';
import '../main.dart';
import 'budget_screen.dart';
import '../data/app_data.dart';
import 'goal_screen.dart';
import '../services/storage_service.dart';

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

          ListTile(
          leading: const Icon(
            Icons.person,
          ),

          title: const Text(
            "Profile",
          ),

          subtitle: Text(
            AppData.profile == null
                ? "Setup Profile"
                : AppData.profile!.name,
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
                    const ProfileSetupScreen(),
              ),
            ).then((_) {
              setState(() {});
            });
          },
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

        ListTile(
          leading: const Icon(
            Icons.flag,
          ),

          title: const Text(
            "Financial Goal",
          ),

          subtitle: Text(
            AppData.goal == null
                ? "Set Your Goal"
                : AppData.goal!.title,
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
                    const GoalScreen(),
              ),
            ).then((_) {
              setState(() {});
            });
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

          const Divider(),

            ListTile(
              leading: const Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),

              title: const Text(
                "Reset All Data",
              ),

              subtitle: const Text(
                "Delete everything",
              ),

              onTap: () {

                showDialog(
                  context: context,

                  builder: (context) {

                    return AlertDialog(

                      title: const Text(
                        "Reset All Data",
                      ),

                      content: const Text(
                        "This will permanently delete all transactions, profile, budget, and goals. Continue?",
                      ),

                      actions: [

                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: const Text(
                            "Cancel",
                          ),
                        ),

                        TextButton(
                          onPressed: () async {

                            await StorageService.clearAllData();

                            AppData.reset();

                            if (!mounted) return;

                            Navigator.pushAndRemoveUntil(
                              context,

                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProfileSetupScreen(),
                              ),

                              (route) => false,
                            );
                          },

                          child: const Text(
                            "Reset",
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
    );
  }
}