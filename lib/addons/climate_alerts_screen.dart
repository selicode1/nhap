import 'package:flutter/material.dart';
import 'package:nhap/screens/main_screen.dart';

class ClimateAlertsScreen extends StatefulWidget {
  const ClimateAlertsScreen({super.key});

  @override
  State<ClimateAlertsScreen> createState() => _ClimateAlertsScreenState();
}

class _ClimateAlertsScreenState extends State<ClimateAlertsScreen>
    with SingleTickerProviderStateMixin {
  final Color primary = const Color(0xFF0277BD);

  // Animation controller for fade-in
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final List<String> healthTips = [
    "Sleep under insecticide-treated mosquito nets.",
    "Avoid stagnant water around your home.",
    "Wear long-sleeved clothing in the evening.",
    "Consult a health facility if you feel feverish."
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegion = "Greater Accra";
    final climateCondition = "Rainy Season";
    final diseaseAlert = "High risk of malaria in your region.";

    return Scaffold(
      appBar: AppBar(
                         leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 0)))
          },
        ),
        title: const Text("Climate Disease Alerts"),
        backgroundColor: Colors.white,
        foregroundColor: primary,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            // Using ListView to handle overflow better on small screens
            children: [
              Row(
                children: [
                  Icon(Icons.cloud_queue, size: 36, color: primary),
                  const SizedBox(width: 12),
                  Text(
                    "Your Region: $userRegion",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Current Season: $climateCondition",
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 3,
                shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded,
                          color: Colors.red.shade700, size: 28),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          diseaseAlert,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                "Preventive Health Tips",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primary,
                    letterSpacing: 0.5),
              ),
              const SizedBox(height: 16),
              ...healthTips.map(
                (tip) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: _AnimatedTipRow(
                    tip: tip,
                    iconColor: primary,
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

class _AnimatedTipRow extends StatefulWidget {
  final String tip;
  final Color iconColor;

  const _AnimatedTipRow({
    required this.tip,
    required this.iconColor,
  });

  @override
  State<_AnimatedTipRow> createState() => __AnimatedTipRowState();
}

class __AnimatedTipRowState extends State<_AnimatedTipRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: Row(
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Icon(Icons.check_circle_outline, size: 24, color: widget.iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(widget.tip, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }
}
