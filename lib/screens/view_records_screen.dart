import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/add_edit_records_screen.dart';
import 'package:nhap/screens/main_screen.dart';
import 'package:nhap/widgets/record_card.dart';

class PatientRecordsScreen extends StatefulWidget {
  const PatientRecordsScreen({super.key});

  @override
  State<PatientRecordsScreen> createState() => _PatientRecordsScreenState();
}

class _PatientRecordsScreenState extends State<PatientRecordsScreen> {
  void _showRecordDetails(BuildContext context, Map<String, String> record) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                record["name"]!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text("Date: ${record["date"]}"),
              Text("Height: ${record["height"]}"),
              Text("Weight: ${record["weight"]}"),
              Text("Blood Pressure: ${record["bp"]}"),
              Text("Temperature: ${record["temperature"]}"),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.pop(context); // Close bottom sheet first
                      final updatedRecord = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => AddEditPatientScreen(existingData: record),
                        ),
                      );

                      if (updatedRecord != null) {
                        // TODO: Update the record in your state
                        print("Updated Record: $updatedRecord");
                      }
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.edit, color: Colors.white),
                    label: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      // TODO: Show confirmation and delete record
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.delete, color: Colors.white),
                    label: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _exportPDF,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    icon: const Icon(Icons.download, color: Colors.white),
                    label: const Text(
                      "Export",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  final List<Map<String, String>> allRecords = List.generate(50, (index) {
    return {
      "name": "Patient $index",
      "date": "2025-05-${(index % 30) + 1}",
      "height": "${150 + (index % 30)} cm",
      "weight": "${60 + (index % 20)} kg",
      "bp": "${110 + (index % 10)}/${70 + (index % 5)} mmHg",
      "temperature": "${36 + (index % 3)}°C",
    };
  });

  List<Map<String, String>> filteredRecords = [];
  int currentPage = 0;
  final int pageSize = 10;

  @override
  void initState() {
    super.initState();
    filteredRecords = allRecords;
  }

  void _search(String query) {
    setState(() {
      currentPage = 0;
      filteredRecords =
          allRecords
              .where(
                (r) => r["name"]!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void _exportPDF() {
    // TODO: Use pdf package to generate and download file
    print("Exporting records as PDF...");
  }

  List<Map<String, String>> get paginatedRecords {
    final start = currentPage * pageSize;
    final end = (start + pageSize).clamp(0, filteredRecords.length);
    return filteredRecords.sublist(start, end);
  }

  void _nextPage() {
    if ((currentPage + 1) * pageSize < filteredRecords.length) {
      setState(() {
        currentPage++;
      });
    }
  }

  void _previousPage() {
    if (currentPage > 0) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 0)),
                ),
              },
        ),
        title: const Text("Patient Records"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: _exportPDF,
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search by name...",
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: _search,
            ),
            const SizedBox(height: 16),
Expanded(
  child: ListView.builder(
    itemCount: paginatedRecords.length,
    itemBuilder: (context, index) {
      final record = paginatedRecords[index];
      return Padding(
        padding: const EdgeInsets.only(bottom: 16), // spacing between cards
        child: InkWell(
          child: PatientRecordCard(
            patientName: record["name"]!,
            date: record["date"]!,
            height: record["height"]!,
            weight: record["weight"]!,
            bp: record["bp"]!,
            temperature: record["temperature"]!,
            backgroundColor: Colors.blue.shade100,
            onTap: () {
              _showRecordDetails(context, record);
            },
          ),
        ),
      );
    },
  ),
),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _previousPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Previous",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                Text("Page ${currentPage + 1}"),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    "Next",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //             floatingActionButton: FloatingActionButton(
      // onPressed: () async {
      //   final newPatient = await Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (_) => const AddEditPatientScreen(),
      //     ),
      //   );

      //   if (newPatient != null) {
      //     setState(() {
      //       allRecords.add(newPatient);
      //     });
      //   }
      // },

      //         backgroundColor: Colors.green,
      //         child: const Icon(Icons.person_add, color: Colors.white),
      //       ),
    );
  }
}
