import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class BreathCoach extends StatefulWidget {
  @override
  _BreathCoachState createState() => _BreathCoachState();
}

class _BreathCoachState extends State<BreathCoach>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _inhale = 4, _hold = 4, _exhale = 4, _pause = 4;
  String _phase = "Inhale";
  int _phaseTime = 0;
  List<String> _patterns = ["Box (4-4-4-4)", "4-7-8"];
  String _selectedPattern = "Box (4-4-4-4)";
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _lastPhase;

  Future<void> _playSound(String phase) async {
    String asset;
    switch (phase) {
      case "Inhale":
        asset = 'sounds/inhale.mp3';
        break;
      case "Hold":
        asset = 'sounds/hold.mp3';
        break;
      case "Exhale":
        asset = 'sounds/exhale.mp3';
        break;
      case "Pause":
        asset = 'sounds/pause.mp3';
        break;
      default:
        asset = 'sounds/inhale.mp3';
    }
    await _audioPlayer.play(AssetSource(asset), volume: 0.7);
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            vsync: this,
            duration: Duration(seconds: _inhale + _hold + _exhale + _pause),
          )
          ..addListener(() {
            setState(() {
              int t = (_controller.value * (_inhale + _hold + _exhale + _pause))
                  .toInt();
              String newPhase;
              if (t < _inhale) {
                newPhase = "Inhale";
                _phaseTime = _inhale - t;
              } else if (t < _inhale + _hold) {
                newPhase = "Hold";
                _phaseTime = _inhale + _hold - t;
              } else if (t < _inhale + _hold + _exhale) {
                newPhase = "Exhale";
                _phaseTime = _inhale + _hold + _exhale - t;
              } else {
                newPhase = "Pause";
                _phaseTime = _inhale + _hold + _exhale + _pause - t;
              }
              if (_lastPhase != newPhase) {
                _lastPhase = newPhase;
                _playSound(newPhase);
              }
              _phase = newPhase;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              _controller.forward(from: 0);
          });
    _setPattern("Box (4-4-4-4)");
    _controller.forward();
  }

  void _setPattern(String p) {
    setState(() {
      _selectedPattern = p;
      if (p == "Box (4-4-4-4)") {
        _inhale = _hold = _exhale = _pause = 4;
      } else if (p == "4-7-8") {
        _inhale = 4;
        _hold = 7;
        _exhale = 8;
        _pause = 0;
      }
    });
    _controller.duration = Duration(
      seconds: _inhale + _hold + _exhale + _pause,
    );
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double t = _controller.value;
    double size = 80 + 120 * sin(pi * t);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Breath Coach'),
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
              DropdownButton<String>(
                value: _selectedPattern,
                dropdownColor: Colors.deepPurple[700],
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                ),
                items: _patterns
                    .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                    .toList(),
                onChanged: (v) => _setPattern(v!),
              ),
              const SizedBox(height: 40),
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.amberAccent.withOpacity(0.9),
                      Colors.deepPurple.withOpacity(0.7),
                      Colors.black.withOpacity(0.3),
                    ],
                    stops: const [0.2, 0.7, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amberAccent.withOpacity(0.3),
                      blurRadius: 32,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    _phase == "Inhale"
                        ? Icons.arrow_upward
                        : _phase == "Exhale"
                        ? Icons.arrow_downward
                        : Icons.pause,
                    size: 48,
                    color: Colors.white,
                    shadows: const [Shadow(color: Colors.amber, blurRadius: 8)],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _phase,
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  fontSize: 32,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
              ),
              Text(
                '$_phaseTime s',
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 2)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
