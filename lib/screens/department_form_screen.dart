import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/main_screen.dart';


class AddDepartmentScreen extends StatefulWidget {
  const AddDepartmentScreen({super.key});

  @override
  State<AddDepartmentScreen> createState() => _AddDepartmentScreenState();
}


class _AddDepartmentScreenState extends State<AddDepartmentScreen> {
  final TextEditingController _departmentNameController = TextEditingController();
  final TextEditingController _departmentHeadController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  String? _selectedType;

  final List<String> _departmentTypes = [
    'Cardiology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Emergency',
    'Other',
  ];

    final List<String> _hospital = [
    'Narh-Bita',
    '37-Military',
    'Tema General',
    'KNUST Hospital',
    'Korle-Bu',
  ];

  void _submitForm(BuildContext context) {
    if (_departmentNameController.text.isNotEmpty &&
        _departmentHeadController.text.isNotEmpty &&
        _contactController.text.isNotEmpty &&
        _selectedType != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Department added successfully!")),
      );

      // TODO: Send data to backend

      // Reset form
      _departmentNameController.clear();
      _departmentHeadController.clear();
      _contactController.clear();
      _selectedType = null;
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
        title: const Text("Add Department"),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      backgroundColor: Colors.grey[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Fill in the details of the department to add it to the system.",
                style: TextStyle(fontSize: 15, color: Colors.black87),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),

              // Department Name TextField
              const Text("Department Name", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: _departmentNameController,
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    hintText: "Enter department name",
                    prefixIcon: Icon(Icons.business, color: AppColors.primary),
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
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),

              // Department Head TextField
              const Text("Department Head", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: _departmentHeadController,
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    hintText: "Enter department head",
                    prefixIcon: Icon(Icons.person, color: AppColors.primary),
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
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),

              // Contact Number TextField
              const Text("Contact Number", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: TextField(
                  controller: _contactController,
                  cursorColor: AppColors.primary,
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
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),

              const Text("Hospital", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  items: _hospital
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
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
              const SizedBox(height: 30),

              // Department Type Dropdown
              const Text("Department Service", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Material(
                borderRadius: BorderRadius.circular(15),
                child: DropdownButtonFormField<String>(
                  value: _selectedType,
                  items: _departmentTypes
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
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
                  child: const Text("Add Department", style: TextStyle(fontSize: 16, color: Colors.white)),
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
