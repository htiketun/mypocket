import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SubscriptionWatcher extends StatefulWidget {
  @override
  _SubscriptionWatcherState createState() => _SubscriptionWatcherState();
}

class _SubscriptionWatcherState extends State<SubscriptionWatcher> {
  final List<Map<String, dynamic>> _subs = [];
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSubs();
  }

  Future<void> _loadSubs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('subs_list');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      _subs.clear();
      _subs.addAll(decoded.map((e) => {'name': e['name'], 'date': e['date']}));
      setState(() {});
    }
  }

  Future<void> _saveSubs() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_subs);
    await prefs.setString('subs_list', data);
  }

  void _add() {
    if (_nameController.text.isNotEmpty && _dateController.text.isNotEmpty) {
      setState(() {
        _subs.add({'name': _nameController.text, 'date': _dateController.text});
        _nameController.clear();
        _dateController.clear();
      });
      _saveSubs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Subscription Watcher'),
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Subscription Name",
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
              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    builder: (context, child) => Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: Colors.deepPurple,
                          onPrimary: Colors.amberAccent,
                          surface: Colors.deepPurple,
                          onSurface: Colors.amberAccent,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.amberAccent,
                            textStyle: const TextStyle(fontFamily: 'Arcade'),
                          ),
                        ),
                      ),
                      child: child!,
                    ),
                  );
                  if (picked != null) {
                    _dateController.text =
                        "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                  }
                },
                decoration: InputDecoration(
                  labelText: "Renewal Date (YYYY-MM-DD)",
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
                onPressed: _add,
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
                child: _subs.isEmpty
                    ? const Center(
                        child: Text(
                          'No subscriptions yet!',
                          style: TextStyle(
                            fontFamily: 'Arcade',
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _subs.length,
                        itemBuilder: (_, i) {
                          return Card(
                            color: Colors.deepPurple.withOpacity(0.85),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.subscriptions,
                                color: Colors.amberAccent,
                              ),
                              title: Text(
                                _subs[i]['name'],
                                style: const TextStyle(
                                  fontFamily: 'Arcade',
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                'Renews: ${_subs[i]['date']}',
                                style: const TextStyle(
                                  fontFamily: 'Arcade',
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
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
