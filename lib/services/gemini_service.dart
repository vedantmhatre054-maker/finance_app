import 'package:google_generative_ai/google_generative_ai.dart';

import 'finance_analyzer.dart';

class GeminiService {
  static const String apiKey =
      "";

  static Future<String> askGemini(
      String userQuestion) async {

    try {

      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: apiKey,
      );

      final financeSummary =
          FinanceAnalyzer.buildFinanceSummary();

      final prompt = '''
You are a personal finance assistant.

$financeSummary

User Question:
$userQuestion

Answer using the financial summary whenever possible.
Keep answers clear and beginner friendly.
''';

      final response =
          await model.generateContent([
        Content.text(prompt),
      ]);

      return response.text ??
          "No response received";

    } catch (e) {

      return "Error: $e";
    }
  }
}