import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClipboardHistory extends StatefulWidget {
  const ClipboardHistory({Key? key}) : super(key: key);

  @override
  _ClipboardHistoryState createState() => _ClipboardHistoryState();
}

class _ClipboardHistoryState extends State<ClipboardHistory> {
  final List<String> _history = [];

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Copied!')));
  }

  void _getClipboard() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null && data.text!.isNotEmpty) {
      setState(() {
        _history.remove(data.text); // Prevent duplicates
        _history.insert(0, data.text!);
        if (_history.length > 10) _history.removeLast();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Clipboard History'),
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
              ElevatedButton.icon(
                onPressed: _getClipboard,
                icon: const Icon(Icons.save, color: Colors.black),
                label: const Text(
                  'Save Clipboard',
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
                child: _history.isEmpty
                    ? const Center(
                        child: Text(
                          'No clipboard history yet.',
                          style: TextStyle(
                            fontFamily: 'Arcade',
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _history.length,
                        itemBuilder: (_, i) => Card(
                          color: Colors.deepPurple.withOpacity(0.85),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            title: Text(
                              _history[i],
                              style: const TextStyle(
                                fontFamily: 'Arcade',
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.copy,
                                color: Colors.amberAccent,
                              ),
                              onPressed: () => _copyToClipboard(_history[i]),
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
