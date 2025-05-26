import 'package:flutter/material.dart';

class LocalPharmacyScreen extends StatefulWidget {
  const LocalPharmacyScreen({super.key});

  @override
  State<LocalPharmacyScreen> createState() => _LocalPharmacyScreenState();
}

class _LocalPharmacyScreenState extends State<LocalPharmacyScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool filterDeliveryOnly = false;

  List<Map<String, dynamic>> pharmacies = [
    {
      'name': 'HopeMed Pharmacy',
      'location': 'Osu',
      'distance': '1.2 km',
      'medications': ['Paracetamol', 'Amoxicillin', 'Vitamin C'],
      'delivery': true,
      'contact': '024 111 2233',
    },
    {
      'name': 'Green Cross Chemist',
      'location': 'Adenta',
      'distance': '5.5 km',
      'medications': ['Ibuprofen', 'Cough Syrup'],
      'delivery': false,
      'contact': '020 444 5678',
    },
    {
      'name': 'LifeAid Drugs',
      'location': 'Madina',
      'distance': '3.0 km',
      'medications': ['Hydroxychloroquine', 'Zinc Tablets'],
      'delivery': true,
      'contact': '026 333 7799',
    },
  ];

  void _toggleDeliveryFilter(bool value) {
    setState(() {
      filterDeliveryOnly = value;
    });
  }

  void _requestDelivery(String pharmacy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Delivery request sent to $pharmacy')),
    );
  }

  void _reserveItem(String pharmacy) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Medication reserved at $pharmacy')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPharmacies = pharmacies.where((pharmacy) {
      final matchesSearch = pharmacy['name']
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      final matchesDelivery = !filterDeliveryOnly || pharmacy['delivery'];
      return matchesSearch && matchesDelivery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nearby Pharmacies"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search and filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      hintText: "Search by name or location...",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    const Text("Delivery"),
                    Switch(
                      value: filterDeliveryOnly,
                      onChanged: _toggleDeliveryFilter,
                      activeColor: Colors.indigo,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Pharmacy list
            Expanded(
              child: filteredPharmacies.isEmpty
                  ? const Center(child: Text("No pharmacies found."))
                  : ListView.builder(
                      itemCount: filteredPharmacies.length,
                      itemBuilder: (context, index) {
                        final pharmacy = filteredPharmacies[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(pharmacy['name'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                Text("${pharmacy['location']} • ${pharmacy['distance']}"),
                                const SizedBox(height: 8),
                                Text("Medications: ${pharmacy['medications'].join(', ')}"),
                                const SizedBox(height: 8),
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Row(
    children: [
      ElevatedButton.icon(
        onPressed: () => _reserveItem(pharmacy['name']),
        icon: const Icon(Icons.bookmark_outline),
        label: const Text("Reserve"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
      ),
      const SizedBox(width: 8),
      ElevatedButton.icon(
        onPressed: pharmacy['delivery']
            ? () => _requestDelivery(pharmacy['name'])
            : null,
        icon: const Icon(Icons.delivery_dining),
        label: const Text("Request Delivery"),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
      ),
      const SizedBox(width: 8),
      IconButton(
        icon: const Icon(Icons.phone),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Calling ${pharmacy['contact']}...')),
          );
        },
      ),
    ],
  ),
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
    );
  }
}
