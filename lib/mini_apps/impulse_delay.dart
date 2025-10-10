import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ImpulseDelay extends StatefulWidget {
  @override
  _ImpulseDelayState createState() => _ImpulseDelayState();
}

class _ImpulseDelayState extends State<ImpulseDelay> {
  final List<Map<String, dynamic>> _items = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('impulse_items');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      _items.clear();
      _items.addAll(
        decoded.map(
          (e) => {
            'item': e['item'],
            'added': DateTime.parse(e['added']),
            'status': e['status'],
          },
        ),
      );
      setState(() {});
    }
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(
      _items
          .map(
            (e) => {
              'item': e['item'],
              'added': (e['added'] as DateTime).toIso8601String(),
              'status': e['status'],
            },
          )
          .toList(),
    );
    await prefs.setString('impulse_items', data);
  }

  void _addImpulse() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _items.add({
          'item': _controller.text,
          'added': DateTime.now(),
          'status': 'waiting',
        });
        _controller.clear();
      });
      _saveItems();
    }
  }

  void _mark(String status, int i) {
    setState(() {
      _items[i]['status'] = status;
    });
    _saveItems();
  }

  void _remove(int i) {
    setState(() {
      _items.removeAt(i);
    });
    _saveItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Impulse Delay'),
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
            children: [
              const SizedBox(height: 50),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "What do you want to buy?",
                  labelStyle: const TextStyle(
                    fontFamily: 'Arcade',
                    color: Colors.amberAccent,
                  ),
                  filled: true,
                  fillColor: Colors.deepPurple.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _addImpulse,
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  'Log Impulse',
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
              const SizedBox(height: 20),
              Expanded(
                child: _items.isEmpty
                    ? const Center(
                        child: Text(
                          'No impulses yet!',
                          style: TextStyle(
                            fontFamily: 'Arcade',
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _items.length,
                        itemBuilder: (_, i) {
                          Duration diff = DateTime.now().difference(
                            _items[i]['added'],
                          );
                          bool canMark =
                              diff.inHours >= 24 &&
                              _items[i]['status'] == 'waiting';
                          return Card(
                            color: Colors.deepPurple.withOpacity(0.85),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              title: Text(
                                _items[i]['item'],
                                style: const TextStyle(
                                  fontFamily: 'Arcade',
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                'Status: ${_items[i]['status']} - Added: ${_items[i]['added'].toString().substring(0, 16)}',
                                style: const TextStyle(
                                  fontFamily: 'Arcade',
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (canMark) ...[
                                    IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.greenAccent,
                                      ),
                                      onPressed: () => _mark('bought', i),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.redAccent,
                                      ),
                                      onPressed: () => _mark('skipped', i),
                                    ),
                                  ],
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.amberAccent,
                                    ),
                                    onPressed: () => _remove(i),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
