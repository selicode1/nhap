import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/main_screen.dart';

class GamifiedNudgesScreen extends StatefulWidget {
  const GamifiedNudgesScreen({super.key});

  @override
  State<GamifiedNudgesScreen> createState() => _GamifiedNudgesScreenState();
}

class _GamifiedNudgesScreenState extends State<GamifiedNudgesScreen> {
  int healthPoints = 1200; // User's current health points
  int donationTokens = 5;  // User's current donation tokens

  // Dummy leaderboard data
  final List<Map<String, dynamic>> leaderboard = [
    {'name': 'Alice', 'points': 3500},
    {'name': 'Bob', 'points': 2800},
    {'name': 'You', 'points': 1200},
    {'name': 'Diana', 'points': 900},
  ];

  // Conversion rate: 100 points = 1 token
  static const int conversionRate = 100;

  void _convertPointsToTokens() {
    if (healthPoints >= conversionRate) {
      setState(() {
        int tokensToAdd = healthPoints ~/ conversionRate;
        donationTokens += tokensToAdd;
        healthPoints = healthPoints % conversionRate;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Converted points to $donationTokens donation tokens!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough points to convert. Earn more health points!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Calculate weekly goal progress (dummy example)
    int weeklyGoal = 1500;
    double progress = (healthPoints / weeklyGoal).clamp(0, 1);

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
        title: const Text("Health Points & Donations"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 1,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current health points
            Text("Your Health Points",
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.favorite, color: Colors.redAccent, size: 32),
                const SizedBox(width: 10),
                Text("$healthPoints",
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),

            // Weekly goal progress bar
            Text("Weekly Goal Progress"),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15),
            ),
            const SizedBox(height: 20),

            // Convert points button
            ElevatedButton.icon(
              onPressed: _convertPointsToTokens,
              icon: const Icon(Icons.redeem),
              label: Text("Convert to Donation Tokens"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
              ),
            ),

            const SizedBox(height: 12),

            // Show current donation tokens
            Row(
              children: [
                Icon(Icons.card_giftcard, color: Colors.blue[700], size: 28),
                const SizedBox(width: 8),
                Text(
                  "Donation Tokens: $donationTokens",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Leaderboard section
            Text("Leaderboard",
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 12),

            Expanded(
              child: ListView.separated(
                itemCount: leaderboard.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final user = leaderboard[index];
                  bool isCurrentUser = user['name'] == 'You';
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          isCurrentUser ? Colors.blueAccent : Colors.grey[400],
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      user['name'],
                      style: TextStyle(
                          fontWeight:
                              isCurrentUser ? FontWeight.bold : FontWeight.normal),
                    ),
                    trailing: Text(
                      "${user['points']} pts",
                      style: TextStyle(
                          color: isCurrentUser ? Colors.blueAccent : Colors.black54,
                          fontWeight:
                              isCurrentUser ? FontWeight.bold : FontWeight.normal),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on TextTheme {
  get headline6 => null;
}
