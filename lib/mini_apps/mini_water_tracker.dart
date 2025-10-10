import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiniWaterTracker extends StatefulWidget {
  @override
  _MiniWaterTrackerState createState() => _MiniWaterTrackerState();
}

class _MiniWaterTrackerState extends State<MiniWaterTracker> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    _loadCount();
  }

  Future<void> _loadCount() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _count = prefs.getInt('water_count') ?? 0;
    });
  }

  Future<void> _saveCount() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('water_count', _count);
  }

  void _increment() {
    setState(() {
      _count++;
    });
    _saveCount();
  }

  void _reset() {
    setState(() {
      _count = 0;
    });
    _saveCount();
  }

  @override
  Widget build(BuildContext context) {
    double percent = (_count % 10) / 10.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Mini Water Tracker'),
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Glasses/Bottles: $_count',
                  style: const TextStyle(
                    fontFamily: 'Arcade',
                    fontSize: 28,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 220,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.amberAccent, width: 4),
                      borderRadius: BorderRadius.circular(32),
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          width: double.infinity,
                          height: 220 * percent,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.85),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(32),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent.withOpacity(0.4),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 12,
                          left: 0,
                          right: 0,
                          child: Icon(
                            Icons.water_drop,
                            color: Colors.white.withOpacity(0.7),
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _increment,
                      icon: const Icon(Icons.water_drop, color: Colors.black),
                      label: const Text(
                        'Add Glass',
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
                    const SizedBox(width: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
