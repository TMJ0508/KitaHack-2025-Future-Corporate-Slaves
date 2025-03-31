import 'package:http/http.dart' as http;
import 'dart:convert';

class DialogflowService {
  static const String projectId = 'your-dialogflow-project-id';
  static const String sessionId = '123456'; // Unique per user session
  static const String authToken = 'your-dialogflow-auth-token';

  static Future<Map<String, dynamic>> detectIntent(String text) async {
    final url = 'https://dialogflow.googleapis.com/v2/projects/$projectId/agent/sessions/$sessionId:detectIntent';
    final body = jsonEncode({
      'queryInput': {
        'text': {'text': text, 'languageCode': 'en'}
      }
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    final data = jsonDecode(response.body);
    return {
      'intent': data['queryResult']['intent']['displayName'] ?? 'fallback',
      'parameters': data['queryResult']['parameters'] ?? {},
      'fulfillmentText': data['queryResult']['fulfillmentText'] ?? 'I didn’t understand that.',
    };
  }
}