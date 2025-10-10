import 'package:flutter/material.dart';

class VoiceToNote extends StatefulWidget {
  @override
  _VoiceToNoteState createState() => _VoiceToNoteState();
}

class _VoiceToNoteState extends State<VoiceToNote> {
  bool _listening = false;
  String _text = '';

  void _startListening() async {
    setState(() {
      _listening = true;
      _text = 'Listening... (speech_to_text plugin removed)';
    });
    // Simulate listening for demo
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _text = 'This is a demo note. Speech recognition is not available.';
      _listening = false;
    });
  }

  void _stopListening() {
    setState(() {
      _listening = false;
      _text = 'Stopped.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Voice-to-Note'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Arcade',
          fontSize: 28,
          color: Colors.amberAccent,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF2C5364), Color(0xFFFC466B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _listening ? _stopListening : _startListening,
                icon: Icon(
                  _listening ? Icons.stop : Icons.mic,
                  color: Colors.black,
                ),
                label: Text(
                  _listening ? 'Stop' : 'Record',
                  style: const TextStyle(
                    fontFamily: 'Arcade',
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  shadowColor: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  _text.isNotEmpty ? _text : 'Press Record to start',
                  style: const TextStyle(
                    fontFamily: 'Arcade',
                    fontSize: 20,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
