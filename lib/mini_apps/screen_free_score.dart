import 'package:flutter/material.dart';
import 'dart:async';

class ScreenFreeScore extends StatefulWidget {
  @override
  _ScreenFreeScoreState createState() => _ScreenFreeScoreState();
}

class _ScreenFreeScoreState extends State<ScreenFreeScore> {
  Duration _screenFreeTime = Duration();
  Timer? _timer;
  bool _tracking = false;
  DateTime? _lastStarted;

  void _toggle() {
    if (_tracking) {
      _timer?.cancel();
      setState(() {
        _screenFreeTime += DateTime.now().difference(_lastStarted!);
        _tracking = false;
      });
    } else {
      _lastStarted = DateTime.now();
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        setState(() {});
      });
      setState(() => _tracking = true);
    }
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _screenFreeTime = Duration();
      _tracking = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _displayTime {
    final total =
        _screenFreeTime +
        (_tracking && _lastStarted != null
            ? DateTime.now().difference(_lastStarted!)
            : Duration());
    return total.toString().split('.').first.padLeft(8, "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Screen-Free Score'),
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
                      Colors.greenAccent.withOpacity(0.8),
                      Colors.teal.withOpacity(0.5),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  _displayTime,
                  style: const TextStyle(
                    fontFamily: 'Arcade',
                    fontSize: 56,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(color: Colors.greenAccent, blurRadius: 8),
                      Shadow(color: Colors.black, blurRadius: 2),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _tracking
                  ? ElevatedButton.icon(
                      onPressed: _toggle,
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
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: Colors.greenAccent,
                      ),
                    )
                  : ElevatedButton.icon(
                      onPressed: _toggle,
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
                        backgroundColor: Colors.greenAccent,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: Colors.greenAccent,
                      ),
                    ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: _reset,
                icon: const Icon(Icons.refresh, color: Colors.black),
                label: const Text(
                  'Reset',
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
            ],
          ),
        ),
      ),
    );
  }
}
