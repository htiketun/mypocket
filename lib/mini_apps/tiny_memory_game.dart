import 'package:flutter/material.dart';
import 'dart:math';

class TinyMemoryGame extends StatefulWidget {
  @override
  _TinyMemoryGameState createState() => _TinyMemoryGameState();
}

class _TinyMemoryGameState extends State<TinyMemoryGame> {
  List<int> _cards = [];
  List<bool> _revealed = [];
  int? _first, _second;
  bool _busy = false;
  int _matches = 0;

  void _startGame() {
    _cards = List.generate(4, (i) => i ~/ 2)..shuffle();
    _revealed = List.filled(4, false);
    _first = _second = null;
    _matches = 0;
    setState(() {});
  }

  void _reveal(int i) async {
    if (_revealed[i] || _busy || _first == i) return;
    setState(() => _revealed[i] = true);
    if (_first == null) {
      _first = i;
    } else if (_second == null) {
      _second = i;
      _busy = true;
      await Future.delayed(Duration(milliseconds: 700));
      if (_cards[_first!] == _cards[_second!]) {
        _matches++;
        if (_matches == 2) {
          await Future.delayed(Duration(milliseconds: 500));
          _startGame();
        }
      } else {
        setState(() {
          _revealed[_first!] = false;
          _revealed[_second!] = false;
        });
      }
      _first = _second = null;
      _busy = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tiny Memory Game')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Find pairs! (30s game)', style: TextStyle(fontSize: 18)),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () => _reveal(i),
                  child: Card(
                    color: _revealed[i] ? Colors.blue[100] : Colors.grey[300],
                    child: Center(
                      child: Text(
                        _revealed[i] ? '${_cards[i] + 1}' : '?',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(onPressed: _startGame, child: Text('Restart')),
          ],
        ),
      ),
    );
  }
}
