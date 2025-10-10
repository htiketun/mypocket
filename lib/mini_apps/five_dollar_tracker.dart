import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FiveDollarTracker extends StatefulWidget {
  @override
  _FiveDollarTrackerState createState() => _FiveDollarTrackerState();
}

class _FiveDollarTrackerState extends State<FiveDollarTracker> {
  final List<Map<String, dynamic>> _purchases = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  Future<void> _loadPurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('five_dollar_purchases');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      _purchases.clear();
      _purchases.addAll(
        decoded.map(
          (e) => {'amount': e['amount'], 'time': DateTime.parse(e['time'])},
        ),
      );
      setState(() {});
    }
  }

  Future<void> _savePurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(
      _purchases
          .map(
            (e) => {'amount': e['amount'], 'time': e['time'].toIso8601String()},
          )
          .toList(),
    );
    await prefs.setString('five_dollar_purchases', data);
  }

  void _addPurchase() {
    double? val = double.tryParse(_controller.text);
    if (val != null && val <= 5) {
      setState(() {
        _purchases.add({'amount': val, 'time': DateTime.now()});
        _controller.clear();
      });
      _savePurchases();
    }
  }

  double get _total => _purchases.fold(0.0, (sum, p) => sum + p['amount']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('\$5 Daily Tracker'),
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
                  labelText: "Amount (\$)",
                  labelStyle: const TextStyle(
                    fontFamily: 'Arcade',
                    color: Colors.amberAccent,
                  ),
                  hintText: "Under \$5",
                  hintStyle: const TextStyle(
                    fontFamily: 'Arcade',
                    color: Colors.white54,
                  ),
                  filled: true,
                  fillColor: Colors.deepPurple.withOpacity(0.7),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _addPurchase,
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
              Text(
                'Total: \$${_total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontFamily: 'Arcade',
                  fontSize: 22,
                  color: Colors.amberAccent,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _purchases.isEmpty
                    ? const Center(
                        child: Text(
                          'No purchases yet!',
                          style: TextStyle(
                            fontFamily: 'Arcade',
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _purchases.length,
                        itemBuilder: (_, i) {
                          return Card(
                            color: Colors.deepPurple.withOpacity(0.85),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: ListTile(
                              leading: const Icon(
                                Icons.attach_money,
                                color: Colors.amberAccent,
                              ),
                              title: Text(
                                '\$${_purchases[i]['amount'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontFamily: 'Arcade',
                                  color: Colors.amberAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              subtitle: Text(
                                _purchases[i]['time'].toString(),
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
