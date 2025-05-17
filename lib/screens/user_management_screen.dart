import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/add_edit_user_screen.dart';
import 'package:nhap/screens/main_screen.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  List<Map<String, String>> allUsers = [
    {
      "name": "Dr. Kwame Mensah",
      "email": "kwame@example.com",
      "role": "Doctor",
      "status": "Active"
    },
    {
      "name": "Ama Boateng",
      "email": "ama@example.com",
      "role": "Admin",
      "status": "Inactive"
    },
    {
      "name": "Kojo Addo",
      "email": "kojo@example.com",
      "role": "Nurse",
      "status": "Active"
    },
  ];

  String searchQuery = '';
  String selectedRole = 'All';

  List<String> roles = ['All', 'Admin', 'Doctor', 'Nurse'];

  List<Map<String, String>> get filteredUsers {
    return allUsers.where((user) {
      final matchesSearch = user['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
      final matchesRole =
          selectedRole == 'All' || user['role'] == selectedRole;
      return matchesSearch && matchesRole;
    }).toList();
  }

  void deleteUser(int index) {
    final userToDelete = filteredUsers[index];
    setState(() {
      allUsers.removeWhere((user) => user == userToDelete);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User deleted")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
                        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 0)))
          },
        ),
        title: const Text('User Management'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by name...",
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedRole,
                  items: roles.map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: filteredUsers.isEmpty
                  ? const Center(child: Text("No users found."))
                  : ListView.separated(
                      itemCount: filteredUsers.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Material(
                          borderRadius: BorderRadius.circular(15),
                          elevation: 1,
                          color: Colors.white,
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.primaryLight,
                              child: Text(
                                user["name"]![0],
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              user["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(user["email"]!),
                                Text("Role: ${user["role"]}"),
                                Text(
                                  "Status: ${user["status"]}",
                                  style: TextStyle(
                                    color: user["status"] == "Active"
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () async {
  final updatedUser = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AddEditUserScreen(userData: user),
    ),
  );

  if (updatedUser != null) {
    setState(() {
      allUsers[index] = updatedUser;
    });
  }
},

                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => deleteUser(index),
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
      floatingActionButton: FloatingActionButton(
onPressed: () async {
  final newUser = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AddEditUserScreen(),
    ),
  );

  if (newUser != null) {
    setState(() {
      allUsers.add(newUser);
    });
  }
},

        backgroundColor: AppColors.primaryDark,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
