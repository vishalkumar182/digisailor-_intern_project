import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(TextToSpeechApp());
}

class TextToSpeechApp extends StatelessWidget {
  const TextToSpeechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TTS Demo',
      theme: ThemeData.dark(),
      home: TTSHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TTSHomePage extends StatefulWidget {
  const TTSHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TTSHomePageState createState() => _TTSHomePageState();
}

class _TTSHomePageState extends State<TTSHomePage> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _controller = TextEditingController();

  Future<void> _speak() async {
    String text = _controller.text.trim();
    if (text.isNotEmpty) {
      await flutterTts.setLanguage("en-IN"); // or "hi-IN" for Hindi
      await flutterTts.setPitch(1.0);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(text);
    }
  }

  @override
  void dispose() {
    flutterTts.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Text to Speech'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Enter text",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _speak,
              icon: Icon(Icons.volume_up),
              label: Text("Speak"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
