import 'package:flutter/material.dart';
import 'dart:math';

class RandomDecisionMaker extends StatefulWidget {
  @override
  _RandomDecisionMakerState createState() => _RandomDecisionMakerState();
}

class _RandomDecisionMakerState extends State<RandomDecisionMaker> {
  String _result = "";
  final TextEditingController _controller = TextEditingController();
  final List<String> _choices = [];

  void _coinFlip() {
    setState(() => _result = Random().nextBool() ? "Heads" : "Tails");
  }

  void _diceRoll() {
    setState(() => _result = "Dice: ${Random().nextInt(6) + 1}");
  }

  void _spinWheel() {
    if (_choices.isNotEmpty) {
      setState(() => _result = _choices[Random().nextInt(_choices.length)]);
    }
  }

  void _addChoice() {
    if (_controller.text.isNotEmpty) {
      setState(() => _choices.add(_controller.text));
      _controller.clear();
    }
  }

  void _removeChoice(int i) {
    setState(() => _choices.removeAt(i));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 700;
    final isTablet = size.width > 500 && size.width <= 700;
    final padding = isWide
        ? EdgeInsets.symmetric(horizontal: size.width * 0.18, vertical: 32)
        : isTablet
        ? EdgeInsets.symmetric(horizontal: size.width * 0.10, vertical: 28)
        : EdgeInsets.symmetric(horizontal: 16, vertical: 16);
    final buttonPadding = isWide
        ? EdgeInsets.symmetric(horizontal: 40, vertical: 20)
        : isTablet
        ? EdgeInsets.symmetric(horizontal: 28, vertical: 16)
        : EdgeInsets.symmetric(horizontal: 12, vertical: 12);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Random Decision Maker'),
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
          padding: padding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final showRow = constraints.maxWidth > 500;
              return Column(
                children: [
                  const SizedBox(height: 40),
                  showRow
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: _ArcadeGameButton(
                                icon: Icons.monetization_on,
                                label: 'Flip Coin',
                                onTap: _coinFlip,
                                buttonPadding: buttonPadding,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: _ArcadeGameButton(
                                icon: Icons.casino,
                                label: 'Roll Dice',
                                onTap: _diceRoll,
                                buttonPadding: buttonPadding,
                              ),
                            ),
                            const SizedBox(width: 18),
                            Expanded(
                              child: _ArcadeGameButton(
                                icon: Icons.sports_soccer_outlined,
                                label: 'Spin Wheel',
                                onTap: _spinWheel,
                                buttonPadding: buttonPadding,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            _ArcadeGameButton(
                              icon: Icons.monetization_on,
                              label: 'Flip Coin',
                              onTap: _coinFlip,
                              buttonPadding: buttonPadding,
                            ),
                            const SizedBox(height: 12),
                            _ArcadeGameButton(
                              icon: Icons.casino,
                              label: 'Roll Dice',
                              onTap: _diceRoll,
                              buttonPadding: buttonPadding,
                            ),
                            const SizedBox(height: 12),
                            _ArcadeGameButton(
                              icon: Icons.sports_soccer_outlined,
                              label: 'Spin Wheel',
                              onTap: _spinWheel,
                              buttonPadding: buttonPadding,
                            ),
                          ],
                        ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Add wheel choice',
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
                          style: const TextStyle(
                            fontFamily: 'Arcade',
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _addChoice,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amberAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: Colors.amberAccent,
                          padding: const EdgeInsets.all(14),
                        ),
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                    ],
                  ),
                  if (_result.isNotEmpty) ...[
                    const SizedBox(height: 28),
                    Container(
                      padding: const EdgeInsets.all(18),
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
                        _result,
                        style: const TextStyle(
                          fontFamily: 'Arcade',
                          fontSize: 32,
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  Expanded(
                    child: _choices.isEmpty
                        ? const Center(
                            child: Text(
                              'No wheel choices yet!',
                              style: TextStyle(
                                fontFamily: 'Arcade',
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _choices.length,
                            itemBuilder: (_, i) => Card(
                              color: Colors.deepPurple.withOpacity(0.85),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.circle,
                                  color: Colors.amberAccent,
                                ),
                                title: Text(
                                  _choices[i],
                                  style: const TextStyle(
                                    fontFamily: 'Arcade',
                                    color: Colors.amberAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.amberAccent,
                                  ),
                                  onPressed: () => _removeChoice(i),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ArcadeGameButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final EdgeInsetsGeometry buttonPadding;

  const _ArcadeGameButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.buttonPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.black, size: 28),
      label: Text(
        label,
        style: const TextStyle(
          fontFamily: 'Arcade',
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amberAccent,
        padding: buttonPadding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 8,
        shadowColor: Colors.amberAccent,
      ),
    );
  }
}
