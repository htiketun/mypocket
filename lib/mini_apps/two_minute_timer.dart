import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class TwoMinuteTimer extends StatefulWidget {
  @override
  _TwoMinuteTimerState createState() => _TwoMinuteTimerState();
}

class _TwoMinuteTimerState extends State<TwoMinuteTimer> {
  int _secondsLeft = 120;
  Timer? _timer;
  bool _isRunning = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> _playBeep() async {
    await _audioPlayer.play(AssetSource('sounds/beep.mp3'), volume: 0.5);
  }

  Future<void> _playFinish() async {
    await _audioPlayer.play(AssetSource('sounds/finish.mp3'), volume: 1.0);
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsLeft = 120;
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_secondsLeft == 0) {
        timer.cancel();
        setState(() => _isRunning = false);
        await _playFinish();
      } else {
        setState(() => _secondsLeft--);
        await _playBeep();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final min = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final sec = (_secondsLeft % 60).toString().padLeft(2, '0');
    return Scaffold(
      appBar: AppBar(
        title: const Text('2-Minute Timer'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Arcade', // Make sure you have this font in pubspec.yaml
          fontSize: 28,
          color: Colors.amberAccent,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF2C5364), Color(0xFFFC466B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    colors: [
                      Colors.amberAccent.withOpacity(0.8),
                      Colors.deepOrange.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  '$min:$sec',
                  style: const TextStyle(
                    fontFamily: 'Arcade', // Arcade font for timer
                    fontSize: 64,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(color: Colors.amber, blurRadius: 8),
                      Shadow(color: Colors.black, blurRadius: 2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _isRunning
                  ? ElevatedButton.icon(
                      onPressed: _stopTimer,
                      icon: const Icon(Icons.stop, color: Colors.black),
                      label: const Text(
                        'Stop',
                        style: TextStyle(
                          fontFamily: 'Arcade',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                    )
                  : ElevatedButton.icon(
                      onPressed: _startTimer,
                      icon: const Icon(Icons.play_arrow, color: Colors.black),
                      label: const Text(
                        'Start',
                        style: TextStyle(
                          fontFamily: 'Arcade',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
            ],
          ),
        ),
      ),
    );
  }
}
