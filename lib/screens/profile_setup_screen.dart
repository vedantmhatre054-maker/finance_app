import 'package:flutter/material.dart';
import '../main.dart';
import '../data/app_data.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';

class ProfileSetupScreen
    extends StatefulWidget {

  const ProfileSetupScreen({
    super.key,
  });

  @override
  State<ProfileSetupScreen>
      createState() =>
          _ProfileSetupScreenState();
}

class _ProfileSetupScreenState
    extends State<
        ProfileSetupScreen> {

  final nameController =
      TextEditingController();

  final ageController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final incomeController =
      TextEditingController();

  String currency = "INR";

  Future<void> saveProfile()
      async {

    AppData.profile =
        UserProfile(
      name:
          nameController.text,

      age:
          int.tryParse(
                ageController.text,
              ) ??
              0,

      email:
          emailController.text,

      monthlyIncome:
          double.tryParse(
                incomeController.text,
              ) ??
              0,

      currency:
          currency,
    );

    await StorageService
        .saveProfile(
      AppData.profile!,
    );

    if (!mounted) return;

        Navigator.pushReplacement(
        context,

        MaterialPageRoute(
            builder: (context) =>
                const MainScreen(),
        ),
        );
     }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile Setup",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
          20,
        ),

        child: SingleChildScrollView(
          child: Column(
            children: [

              TextField(
                controller:
                    nameController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Name",
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              TextField(
                controller:
                    ageController,

                keyboardType:
                    TextInputType.number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Age",
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              TextField(
                controller:
                    emailController,

                keyboardType:
                    TextInputType.emailAddress,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Email",
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              TextField(
                controller:
                    incomeController,

                keyboardType:
                    TextInputType.number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Monthly Income",
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              DropdownButtonFormField<
                  String>(
                value: currency,

                items: const [

                  DropdownMenuItem(
                    value: "INR",
                    child:
                        Text("INR"),
                  ),

                  DropdownMenuItem(
                    value: "USD",
                    child:
                        Text("USD"),
                  ),

                  DropdownMenuItem(
                    value: "EUR",
                    child:
                        Text("EUR"),
                  ),
                ],

                onChanged:
                    (value) {

                  setState(() {
                    currency =
                        value!;
                  });
                },
              ),

              const SizedBox(
                height: 30,
              ),

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton(
                  onPressed:
                      saveProfile,

                  child:
                      const Text(
                    "Save Profile",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}