import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/main_screen.dart';

class AddHospitalScreen extends StatefulWidget {
  const AddHospitalScreen({super.key});

  @override
  State<AddHospitalScreen> createState() => _AddHospitalScreenState();
}



class _AddHospitalScreenState extends State<AddHospitalScreen>  {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();


  String? _selectedType;
  DateTime? _establishedDate;

  final List<String> _hospitalTypes = [
    'Public',
    'Private',
    'Teaching',
    'Clinic',
    'Other',
  ];

  Future<void> _pickEstablishedDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _establishedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _establishedDate = picked;
    }
  }

  void _submitForm(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _locationController.text.isNotEmpty &&
        _contactController.text.isNotEmpty &&
        _selectedType != null &&
        _establishedDate != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hospital added successfully!")),
      );

      // TODO: Send data to backend

      // Reset form
      _nameController.clear();
      _locationController.clear();
      _contactController.clear();
      _selectedType = null;
      _establishedDate = null;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields")),
      );
    }
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
        title: const Text("Add Hospital"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      backgroundColor: Colors.grey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: [
              const Text(
                "Fill in the details of the hospital to add it to the system.",
                style: TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.left, // Left align text
              ),
              const SizedBox(height: 30),

              // Hospital Name TextField
              Material(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Enter hospital name",
                    prefixIcon: Icon(Icons.local_hospital, color: AppColors.primary),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Location TextField
              Material(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    hintText: "Enter location",
                    prefixIcon: Icon(Icons.location_on, color: AppColors.primary),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Contact Number TextField
              Material(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: _contactController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "Enter contact number",
                    prefixIcon: Icon(Icons.phone, color: AppColors.primary),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Hospital Type Dropdown
              const Text(
                "Hospital Type",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.left, // Align the label to the left
              ),
              const SizedBox(height: 6),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  items: _hospitalTypes
                      .map((type) =>
                          DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (val) => _selectedType = val,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Established Date Picker
              const Text(
                "Established Date",
                style: TextStyle(fontWeight: FontWeight.w600),
                textAlign: TextAlign.left, // Align the label to the left
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () => _pickEstablishedDate(context),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    child: Text(
                      _establishedDate == null
                          ? "Select date"
                          : "${_establishedDate!.year}-${_establishedDate!.month.toString().padLeft(2, '0')}-${_establishedDate!.day.toString().padLeft(2, '0')}",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submitForm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                  ),
                  child: const Text("Add Hospital", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
