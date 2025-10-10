import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MicroGratitudeJournal extends StatefulWidget {
  @override
  _MicroGratitudeJournalState createState() => _MicroGratitudeJournalState();
}

class _MicroGratitudeJournalState extends State<MicroGratitudeJournal> {
  String? _todayGratitude;
  final TextEditingController _controller = TextEditingController();
  final String _todayKey = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadTodayGratitude();
  }

  Future<void> _loadTodayGratitude() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _todayGratitude = prefs.getString('gratitude_$_todayKey');
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gratitude_$_todayKey', _controller.text);
    setState(() {
      _todayGratitude = _controller.text;
      _controller.clear();
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Saved!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Micro Gratitude Journal'),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF2C5364), Color(0xFFFC466B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "What’s one small thing you’re grateful for today?",
                style: TextStyle(
                  fontFamily: 'Arcade',
                  fontSize: 20,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _controller,
                maxLength: 80,
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  color: Colors.white,
                  fontSize: 18,
                ),
                decoration: InputDecoration(
                  hintText: "I'm grateful for...",
                  hintStyle: const TextStyle(
                    fontFamily: 'Arcade',
                    color: Colors.white54,
                  ),
                  filled: true,
                  fillColor: Colors.deepPurple.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  counterStyle: const TextStyle(
                    color: Colors.amberAccent,
                    fontFamily: 'Arcade',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save, color: Colors.black),
                label: const Text(
                  "Save",
                  style: TextStyle(
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
              if (_todayGratitude != null && _todayGratitude!.isNotEmpty) ...[
                const SizedBox(height: 32),
                const Divider(color: Colors.amberAccent, thickness: 2),
                const Text(
                  "Today’s gratitude:",
                  style: TextStyle(
                    fontFamily: 'Arcade',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.amberAccent,
                    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _todayGratitude!,
                  style: const TextStyle(
                    fontFamily: 'Arcade',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
