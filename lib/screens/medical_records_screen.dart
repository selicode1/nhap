// screens/medical_records_screen.dart
import 'package:flutter/material.dart';

class MedicalRecordsScreen extends StatelessWidget {
  final List<String> records = ["Blood Test - 2023-08-10", "X-Ray - 2023-07-05"];

  // const MedicalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Medical Records")),
      body: ListView.builder(
        itemCount: records.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(records[index]),
            trailing: IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                // placeholder for download/export
              },
            ),
          );
        },
      ),
    );
  }
}
