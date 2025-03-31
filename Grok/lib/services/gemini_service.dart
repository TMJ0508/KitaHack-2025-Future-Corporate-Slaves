import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  static const String apiUrl = 'your-gemini-api-endpoint'; // e.g., a Firebase Cloud Function

  static Future<String> getResponse(String text) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'message': text}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['response'] ?? 'Hello! How can I assist you today?';
    }
    return 'Sorry, I couldn’t respond right now.';
  }
}