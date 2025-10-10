import 'package:flutter/material.dart';
import 'dart:math';

class DailyAlgorithmGen extends StatefulWidget {
  @override
  _DailyAlgorithmGenState createState() => _DailyAlgorithmGenState();
}

class _DailyAlgorithmGenState extends State<DailyAlgorithmGen> {
  static final List<String> _challenges = [
    "Take a photo of something blue",
    "Do 10 jumping jacks",
    "Write a kind message to a friend",
    "Draw a smiley face",
    "Spend 5 minutes outside",
    "Drink a glass of water",
    "Organize one thing on your desk",
    "Read a random Wikipedia article",
    "Compliment yourself",
    "Do a breathing exercise",
    // More challenges:
    "Solve a simple coding puzzle",
    "Try a new stretch",
    "List 3 things you're grateful for",
    "Write a haiku",
    "Meditate for 2 minutes",
    "Sketch a quick doodle",
    "Say hello to someone new",
    "Try a tongue twister",
    "Do 5 push-ups",
    "Share a fun fact",
    "Plan a healthy meal",
    "Try to balance on one foot for 30 seconds",
    "Organize your phone apps",
    "Read a poem",
    "Make a paper airplane",
    "Try a new fruit or snack",
    "Write down a dream goal",
    "Compliment a stranger",
    "Do a random act of kindness",
    "Try to whistle a song",
    "Take 10 deep breaths",
    "Write a short story (3 sentences)",
    "Draw your favorite animal",
    "Try to say the alphabet backwards",
    "Do a silly dance",
    "Send a thank you message",
    "Try a new app feature",
    "Take a creative photo",
    "Make a list of your favorite movies",
    "Try to memorize a quote",
    "Write a joke",
    "Do 10 squats",
    "Try a new hobby for 5 minutes",
    "Make a mini origami",
    "Share a positive memory",
    "Try to learn a word in another language",
    "Write a letter to your future self",
  ];

  String _todaysChallenge = "";

  @override
  void initState() {
    super.initState();
    int getDayOfYear(DateTime date) {
      return int.parse(
            DateTime(
              date.year,
              date.month,
              date.day,
            ).difference(DateTime(date.year, 1, 1)).inDays.toString(),
          ) +
          1;
    }

    int day = getDayOfYear(DateTime.now());
    _todaysChallenge = _challenges[day % _challenges.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Daily Algorithm Gen'),
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Today's challenge:",
                  style: TextStyle(
                    fontFamily: 'Arcade',
                    fontSize: 22,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24),
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
                    _todaysChallenge,
                    style: const TextStyle(
                      fontFamily: 'Arcade',
                      fontSize: 24,
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
      ),
    );
  }
}
