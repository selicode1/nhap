import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/user_management_screen.dart';

class AddEditUserScreen extends StatefulWidget {
  final Map<String, String>? userData; // Pass null for adding, data for editing

  const AddEditUserScreen({super.key, this.userData});

  @override
  State<AddEditUserScreen> createState() => _AddEditUserScreenState();
}

class _AddEditUserScreenState extends State<AddEditUserScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _role = 'Admin';
  String _status = 'Active';

  final List<String> roles = ['Admin', 'Doctor', 'Nurse'];
  final List<String> statuses = ['Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData?['name'] ?? '');
    _emailController = TextEditingController(text: widget.userData?['email'] ?? '');
    _role = widget.userData?['role'] ?? 'Admin';
    _status = widget.userData?['status'] ?? 'Active';
  }

  void _saveUser() {
    if (_formKey.currentState!.validate()) {
      final newUser = {
        'name': _nameController.text,
        'email': _emailController.text,
        'role': _role,
        'status': _status,
      };

      Navigator.pop(context, newUser); // Pass back to parent
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.userData != null;

    return Scaffold(
      appBar: AppBar(
                               leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => UserManagementScreen()))
          },
        ),
        title: Text(isEdit ? 'Edit User' : 'Add User'),
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
              const Text(
                "User Details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration("Full Name"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter full name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration("Email Address"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter email" : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _role,
                decoration: _inputDecoration("Role"),
                items: roles.map((role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _role = value!);
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: _inputDecoration("Status"),
                items: statuses.map((status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _status = value!);
                },
              ),
              const SizedBox(height: 24),
ElevatedButton(
  onPressed: _saveUser,
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    foregroundColor: Colors.white, // Sets text color
  ),
  child: Text(
    isEdit ? "Update User" : "Add User",
    style: const TextStyle(
      color: Colors.white, // Just in case to enforce white text
      fontWeight: FontWeight.bold,
    ),
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
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
                        floatingLabelStyle: const TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w600,
    ),
    );
  }
}
