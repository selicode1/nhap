import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/view_records_screen.dart';

class AddEditPatientScreen extends StatefulWidget {
  final Map<String, String>? existingData;

  const AddEditPatientScreen({super.key, this.existingData});

  @override
  State<AddEditPatientScreen> createState() => _AddEditPatientScreenState();
}

class _AddEditPatientScreenState extends State<AddEditPatientScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController heightController;
  late TextEditingController weightController;
  late TextEditingController bpController;
  late TextEditingController tempController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.existingData?["name"] ?? "");
    heightController = TextEditingController(text: widget.existingData?["height"] ?? "");
    weightController = TextEditingController(text: widget.existingData?["weight"] ?? "");
    bpController = TextEditingController(text: widget.existingData?["bp"] ?? "");
    tempController = TextEditingController(text: widget.existingData?["temperature"] ?? "");
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final updatedData = {
        "name": nameController.text,
        "height": heightController.text,
        "weight": weightController.text,
        "bp": bpController.text,
        "temperature": tempController.text,
        "date": widget.existingData?["date"] ?? DateTime.now().toString().split(' ')[0],
      };
      Navigator.pop(context, updatedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingData != null;
    return Scaffold(
      appBar: AppBar(
                               leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => PatientRecordsScreen()))
          },
        ),
        title: Text(isEdit ? "Edit Patient" : "Add Patient"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField("Full Name", nameController),
              buildField("Height (cm)", heightController),
              buildField("Weight (kg)", weightController),
              buildField("Blood Pressure", bpController),
              buildField("Temperature (°C)", tempController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(isEdit ? "Update" : "Add", style: const TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
                                   enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                        floatingLabelStyle: const TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    ),
        ),
        validator: (value) => value == null || value.isEmpty ? "Required" : null,
      ),
    );
  }
}
