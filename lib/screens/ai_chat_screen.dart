import 'package:flutter/material.dart';
import '../services/gemini_service.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController questionController =
      TextEditingController();

  String response = "";
  bool isLoading = false;

  Future<void> askAI() async {
    if (questionController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
      response = "";
    });

    try {
      final result =
          await GeminiService.askGemini(
        questionController.text,
      );

      setState(() {
        response = result;
      });
    } catch (e) {
      setState(() {
        response = "Error: $e";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Assistant"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText:
                    "Ask anything...",
                border:
                    OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: askAI,
                child: const Text(
                  "Ask AI",
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const CircularProgressIndicator(),

            if (!isLoading)
              Expanded(
                child: SingleChildScrollView(
                  child: SelectableText(
                    response,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}