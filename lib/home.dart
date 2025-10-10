import 'dart:ui'; // <-- Add this import for BackdropFilter
import 'package:flutter/material.dart';
import 'mini_apps/two_minute_timer.dart';
import 'mini_apps/daily_3_task_planner.dart';
import 'mini_apps/screen_free_score.dart';
import 'mini_apps/micro_gratitude_journal.dart';
import 'mini_apps/breath_coach.dart';
import 'mini_apps/mini_water_tracker.dart';
import 'mini_apps/five_dollar_tracker.dart';
import 'mini_apps/subscription_watcher.dart';
import 'mini_apps/impulse_delay.dart';
import 'mini_apps/quote_collector.dart';
import 'mini_apps/random_decision_maker.dart';
import 'mini_apps/tiny_memory_game.dart';
import 'mini_apps/clipboard_history.dart';
import 'mini_apps/voice_to_note.dart';
import 'mini_apps/daily_algorithm_gen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> apps = [
    {
      'name': '2-Minute Timer',
      'widget': TwoMinuteTimer(),
      'icon': Icons.timer,
      'color': Colors.orange,
    },
    {
      'name': 'Daily 3-Task Planner',
      'widget': Daily3TaskPlanner(),
      'icon': Icons.check_circle,
      'color': Colors.blue,
    },
    {
      'name': 'Screen-Free Score',
      'widget': ScreenFreeScore(),
      'icon': Icons.devices_sharp,
      'color': Colors.green,
    },
    {
      'name': 'Micro Gratitude Journal',
      'widget': MicroGratitudeJournal(),
      'icon': Icons.favorite,
      'color': Colors.pink,
    },
    {
      'name': 'Breath Coach',
      'widget': BreathCoach(),
      'icon': Icons.self_improvement,
      'color': Colors.teal,
    },
    {
      'name': 'Mini Water Tracker',
      'widget': MiniWaterTracker(),
      'icon': Icons.water_drop,
      'color': Colors.lightBlue,
    },
    {
      'name': '\$5 Daily Tracker',
      'widget': FiveDollarTracker(),
      'icon': Icons.attach_money,
      'color': Colors.amber,
    },
    {
      'name': 'Subscription Watcher',
      'widget': SubscriptionWatcher(),
      'icon': Icons.subscriptions,
      'color': Colors.deepPurple,
    },
    {
      'name': 'Impulse Delay',
      'widget': ImpulseDelay(),
      'icon': Icons.hourglass_empty,
      'color': Colors.indigo,
    },
    {
      'name': 'Quote Collector',
      'widget': QuoteCollector(),
      'icon': Icons.format_quote,
      'color': Colors.deepOrange,
    },
    {
      'name': 'Random Decision Maker',
      'widget': RandomDecisionMaker(),
      'icon': Icons.casino,
      'color': Colors.cyan,
    },
    {
      'name': 'Tiny Memory Game',
      'widget': TinyMemoryGame(),
      'icon': Icons.memory,
      'color': Colors.redAccent,
    },
    {
      'name': 'Clipboard History',
      'widget': ClipboardHistory(),
      'icon': Icons.content_paste,
      'color': Colors.brown,
    },
    {
      'name': 'Voice-to-Note',
      'widget': VoiceToNote(),
      'icon': Icons.mic,
      'color': Colors.purple,
    },
    {
      'name': 'Daily Algorithm Gen.',
      'widget': DailyAlgorithmGen(),
      'icon': Icons.code,
      'color': Colors.lime,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/icons/app_icon.png', // <-- Your app icon path
            width: 32,
            height: 32,
          ),
        ),
        title: const Text('MyPocket Arcade'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Arcade',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.2,
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: apps.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 cards per row
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.95, // slightly taller for better fit
              ),
              itemBuilder: (context, i) {
                final app = apps[i];
                return _MiniAppCard(
                  name: app['name'],
                  icon: app['icon'],
                  color: app['color'],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => app['widget']),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniAppCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MiniAppCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<_MiniAppCard> createState() => _MiniAppCardState();
}

class _MiniAppCardState extends State<_MiniAppCard>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  late final AnimationController _controller;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 90),
        child: AnimatedBuilder(
          animation: _glowAnimation,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    widget.color.withOpacity(0.98),
                    Colors.black.withOpacity(0.18),
                    widget.color.withOpacity(0.65),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(_glowAnimation.value * 0.7),
                    blurRadius: 24 * _glowAnimation.value,
                    spreadRadius: 2 * _glowAnimation.value,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(
                  color: widget.color.withOpacity(
                    (0.7 + 0.3 * _glowAnimation.value).clamp(0.0, 1.0),
                  ),
                  width: 2.5 + 1.5 * _glowAnimation.value,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.color.withOpacity(
                                0.8 * _glowAnimation.value,
                              ),
                              blurRadius: 28 * _glowAnimation.value,
                              spreadRadius: 2,
                            ),
                            const BoxShadow(
                              color: Colors.black54,
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(widget.icon, size: 44, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          widget.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(color: Colors.black54, blurRadius: 4),
                              Shadow(color: Colors.amberAccent, blurRadius: 2),
                            ],
                            // fontFamily: 'Arcade', // Uncomment if you have an arcade font
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
