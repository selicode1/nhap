import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/widgets/hospital_card.dart'; // Import the card widget here

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  final List<Map<String, String>> hospitals = const [
    {
      "hospitalName": "City Hospital",
      "hospitalType": "General Hospital",
      "location": "123 Main St, Springfield",
      "contactNumber": "+1 555-123-4567",
      "establishedDate": "1985",
      "hospitalImage": "https://example.com/hospital1.jpg",
    },
    {
      "hospitalName": "Green Valley Clinic",
      "hospitalType": "Specialty Clinic",
      "location": "456 Elm St, Springfield",
      "contactNumber": "+1 555-987-6543",
      "establishedDate": "1992",
      "hospitalImage": "https://example.com/hospital2.jpg",
    },
    {
      "hospitalName": "Sunrise Health Center",
      "hospitalType": "Clinic",
      "location": "789 Oak Ave, Springfield",
      "contactNumber": "+1 555-246-8100",
      "establishedDate": "2005",
      "hospitalImage": "",
    },
  ];

  String searchQuery = '';
  String selectedType = 'All';

  late final List<String> hospitalTypes;

  @override
  void initState() {
    super.initState();
    hospitalTypes = ['All'] + hospitals
        .map((h) => h['hospitalType'] ?? '')
        .toSet()
        .where((type) => type.isNotEmpty)
        .toList();
  }

  List<Map<String, String>> get filteredHospitals {
    return hospitals.where((hospital) {
      final matchesSearch = hospital['hospitalName']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      final matchesType = selectedType == 'All' ||
          hospital['hospitalType'] == selectedType;
      return matchesSearch && matchesType;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Hospitals", style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search field
            TextField(
              decoration: InputDecoration(
                labelText: 'Search Hospitals',
                prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 12),

            // Filter dropdown
Row(
  children: [
    const Text('Filter by Type:'),
    const SizedBox(width: 12),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral500), // Use your primary color here
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selectedType,
        underline: SizedBox(), // Remove the default underline
        items: hospitalTypes
            .map((type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => selectedType = value);
          }
        },
      ),
    ),
  ],
),


            const SizedBox(height: 16),

            // Hospital list
            Expanded(
              child: filteredHospitals.isEmpty
                  ? const Center(child: Text('No hospitals found'))
                  : ListView.separated(
                      itemCount: filteredHospitals.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final hospital = filteredHospitals[index];
                        return HospitalCard(
                          hospitalName: hospital["hospitalName"] ?? '',
                          hospitalType: hospital["hospitalType"] ?? '',
                          location: hospital["location"] ?? '',
                          contactNumber: hospital["contactNumber"] ?? '',
                          establishedDate: hospital["establishedDate"] ?? '',
                          hospitalImage: hospital["hospitalImage"] ?? '',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Tapped on ${hospital["hospitalName"]}')),
                            );
                          },
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
