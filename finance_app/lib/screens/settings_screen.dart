import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(
        children: [

          const SizedBox(height: 10),

          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Finance Tracker"),
            subtitle: Text(
              "Professional Edition",
            ),
          ),

          const Divider(),

          SwitchListTile(
            value: darkMode,

            onChanged: (value) {
              setState(() {
                darkMode = value;
              });
            },

            title: const Text(
              "Dark Mode",
            ),

            secondary: const Icon(
              Icons.dark_mode,
            ),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.info),
            title: Text("Version"),
            subtitle: Text("1.0.0"),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.code),
            title: Text("Developer"),
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
              "Local Storage Coming Soon",
            ),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.picture_as_pdf),
            title: Text(
              "PDF Export",
            ),
            subtitle: Text(
              "Coming Soon",
            ),
          ),

          const Divider(),

          const ListTile(
            leading: Icon(Icons.table_chart),
            title: Text(
              "CSV Export",
            ),
            subtitle: Text(
              "Coming Soon",
            ),
          ),
        ],
      ),
    );
  }
}