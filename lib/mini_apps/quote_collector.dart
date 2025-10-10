import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class QuoteCollector extends StatefulWidget {
  @override
  _QuoteCollectorState createState() => _QuoteCollectorState();
}

class _QuoteCollectorState extends State<QuoteCollector> {
  final List<String> _quotes = [];
  final TextEditingController _controller = TextEditingController();
  String? _random;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  Future<void> _loadQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _quotes.clear();
      _quotes.addAll(prefs.getStringList('quotes_list') ?? []);
    });
  }

  Future<void> _saveQuotes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('quotes_list', _quotes);
  }

  void _addQuote() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _quotes.add(_controller.text);
        _controller.clear();
      });
      _saveQuotes();
    }
  }

  void _removeQuote(int i) async {
    setState(() {
      _quotes.removeAt(i);
    });
    _saveQuotes();
  }

  void _shuffle() {
    if (_quotes.isNotEmpty) {
      setState(() {
        _random = (_quotes..shuffle()).first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Quote Collector'),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            children: [
              const SizedBox(height: 50),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Add a quote",
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
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _addQuote,
                      icon: const Icon(Icons.add, color: Colors.black),
                      label: const Text(
                        'Add',
                        style: TextStyle(
                          fontFamily: 'Arcade',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: Colors.amberAccent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: _shuffle,
                    icon: const Icon(Icons.shuffle, color: Colors.black),
                    label: const Text(
                      'Random',
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
                        vertical: 16,
                        horizontal: 24,
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
              if (_random != null) ...[
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
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
                    _random!,
                    style: const TextStyle(
                      fontFamily: 'Arcade',
                      fontSize: 20,
                      color: Colors.amberAccent,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 18),
              Expanded(
                child: _quotes.isEmpty
                    ? const Center(
                        child: Text(
                          'No quotes yet!',
                          style: TextStyle(
                            fontFamily: 'Arcade',
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _quotes.length,
                        itemBuilder: (_, i) => Card(
                          color: Colors.deepPurple.withOpacity(0.85),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            title: Text(
                              _quotes[i],
                              style: const TextStyle(
                                fontFamily: 'Arcade',
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.amberAccent,
                              ),
                              onPressed: () => _removeQuote(i),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
