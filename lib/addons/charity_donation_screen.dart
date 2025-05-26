import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/main_screen.dart';

class CharityDonationScreen extends StatefulWidget {
  const CharityDonationScreen({super.key});

  @override
  State<CharityDonationScreen> createState() => _CharityDonationScreenState();
}

class _CharityDonationScreenState extends State<CharityDonationScreen> {
  int donationTokens = 5;

  final List<Map<String, String>> charities = [
    {
      'name': 'Clean Water Ghana',
      'cause': 'Water & Sanitation',
      'description': 'Providing clean drinking water to rural villages.'
    },
    {
      'name': 'Health Access Foundation',
      'cause': 'Medical Aid',
      'description': 'Supplying malaria medication to underserved communities.'
    },
    {
      'name': 'School Kits for Kids',
      'cause': 'Education',
      'description': 'Distributing school supplies to low-income children.'
    },
  ];

  final List<Map<String, String>> impactStories = [
    {
      'title': 'You helped build a well!',
      'story': 'Thanks to donations, 3 new wells were completed last month in Northern Ghana.',
    },
    {
      'title': 'Medical supplies delivered',
      'story': 'Over 200 families received malaria kits and fever medication.',
    },
  ];

  void _donateToCharity(String charityName) {
    if (donationTokens <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have no tokens left to donate.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Donation"),
        content: Text("Donate 1 token to '$charityName'?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  donationTokens--;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Thank you! You donated to $charityName.')),
                );
              },
              child: const Text("Donate")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text("Donate to a Cause"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 1,
      ),
      // backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Icon(Icons.card_giftcard, color: Colors.blue[700], size: 28),
              const SizedBox(width: 8),
              Text(
                "Your Tokens: $donationTokens",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Text("Available Charities",
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),

          ...charities.map((charity) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(charity['name']!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(charity['cause']!,
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.primary)),
                        const SizedBox(height: 8),
                        Text(charity['description']!),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () =>
                              _donateToCharity(charity['name']!),
                          icon: const Icon(Icons.volunteer_activism),
                          label: const Text("Donate Token"),
                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue[700],
                                  foregroundColor: Colors.white,
                        ),
                )]),
                ),
              )),

          const SizedBox(height: 32),

          Text("Recent Impact Stories",
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 12),

          ...impactStories.map((story) => Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                color: Colors.blue.shade50,
                child: ListTile(
                  title: Text(story['title']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(story['story']!),
                  leading: Icon(Icons.check_circle, color: Colors.blue[700]),
                ),
              )),
        ]),
      ),
    );
  }
}

extension on TextTheme {
  get headline6 => null;
}
