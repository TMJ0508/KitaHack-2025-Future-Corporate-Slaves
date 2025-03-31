import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';
import '../services/dialogflow_service.dart';
import '../services/gemini_service.dart';
import 'medication_schedule_screen.dart';
import 'emergency_contacts_screen.dart';

class ElderlyMainScreen extends StatefulWidget {
  @override
  _ElderlyMainScreenState createState() => _ElderlyMainScreenState();
}

class _ElderlyMainScreenState extends State<ElderlyMainScreen> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(0.5); // Slower speech for clarity
  }

  void _initSpeech() async {
    bool available = await _speech.initialize();
    if (!available) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Speech recognition not available')),
      );
    }
  }

  void _startListening() async {
    setState(() => _isListening = true);
    await _speech.listen(onResult: (result) {
      setState(() => _text = result.recognizedWords);
    });
  }

  void _stopListening() async {
    await _speech.stop();
    setState(() => _isListening = false);
    if (_text.isNotEmpty) _processText(_text);
  }

  void _processText(String text) async {
    final response = await DialogflowService.detectIntent(text);
    if (response.intent == 'fallback' || response.intent == 'social_conversation') {
      final geminiResponse = await GeminiService.getResponse(text);
      await _speak(geminiResponse);
    } else {
      switch (response.intent) {
        case 'view_meds':
          Navigator.push(context, MaterialPageRoute(builder: (context) => MedicationScheduleScreen()));
          await _speak('Opening your medication schedule.');
          break;
        case 'set_reminder':
          String medication = response.parameters['medication'] ?? 'medicine';
          String time = response.parameters['time'] ?? 'now';
          // Logic to set reminder would go here (see notification_service.dart)
          await _speak('I’ve set a reminder for $medication at $time.');
          break;
        case 'set_emergency_contact':
          Navigator.push(context, MaterialPageRoute(builder: (context) => EmergencyContactsScreen()));
          await _speak('Opening emergency contacts.');
          break;
        default:
          await _speak(response.fulfillmentText);
      }
    }
  }

  Future<void> _speak(String text) async {
    await _tts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Elderly Care')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isListening ? 'Listening...' : 'Press to talk to me',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isListening ? _stopListening : _startListening,
              child: Text(_isListening ? 'Stop' : 'Talk', style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(minimumSize: Size(200, 100)),
            ),
          ],
        ),
      ),
    );
  }
}