import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/widgets/doctor_card.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final List<Map<String, String>> allDoctors = [
    {
      "name": "Dr. Jane Smith",
      "specialty": "Cardiologist",
      "contact": "+233 123 456 789",
      "experience": "12 years",
      "image": "https://via.placeholder.com/150",
      "availability": "Mon-Fri, 9am - 4pm",
    },
    {
      "name": "Dr. Kwame Mensah",
      "specialty": "Dermatologist",
      "contact": "+233 234 567 890",
      "experience": "8 years",
      "image": "https://via.placeholder.com/150",
      "availability": "Mon-Thurs, 10am - 3pm",
    },
    // Add more doctors as needed
  ];

  String selectedSpecialty = "All";
  String searchQuery = "";

  List<String> get specialties => [
        "All",
        ...{
          for (var doc in allDoctors) doc["specialty"]!,
        }
      ];

  List<Map<String, String>> get filteredDoctors {
    return allDoctors.where((doc) {
      final matchesSpecialty = selectedSpecialty == "All" || doc["specialty"] == selectedSpecialty;
      final matchesSearch = doc["name"]!.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesSpecialty && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF0277BD);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: Colors.white,
        foregroundColor: primary,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search Field
            TextField(
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: 'Search doctors...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.primary),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                ),
              ),
              onChanged: (value) {
                setState(() => searchQuery = value);
              },
            ),
            const SizedBox(height: 12),

            // ⏳ Filter Dropdown
            Row(
              children: [
                const Text('Filter by Specialty:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedSpecialty,
                  borderRadius: BorderRadius.circular(8),
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: primary),
                  underline: Container(
                    height: 2,
                    color: primary,
                  ),
                  items: specialties
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedSpecialty = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 🩺 Doctor List
            Expanded(
              child: filteredDoctors.isEmpty
                  ? const Center(child: Text("No doctors found."))
                  : ListView.builder(
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doc = filteredDoctors[index];
                        return DoctorCard(
                          doctorName: doc["name"]!,
                          specialty: doc["specialty"]!,
                          contactNumber: doc["contact"]!,
                          experience: doc["experience"]!,
                          profileImageUrl: doc["image"]!,
                          availability: doc["availability"]!,
                          onTap: () {
                            // Handle tap or navigate to detail
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
