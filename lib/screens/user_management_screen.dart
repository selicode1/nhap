import 'package:flutter/material.dart';
import 'package:nhap/core/constants/app_colors.dart';
import 'package:nhap/screens/add_edit_user_screen.dart';
import 'package:nhap/screens/main_screen.dart';
import 'package:nhap/widgets/users_card.dart'; // Assume this is where your bottom sheet lives

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

void showAssignCredentialsSheet(BuildContext context, String userName) {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Assign Credentials to $userName",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                labelStyle: const TextStyle(color: AppColors.neutral500),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Temporary Password",
                labelStyle: const TextStyle(color: AppColors.neutral500),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    foregroundColor: Colors.white, // Sets text color
  ),
                onPressed: () {
                  final username = usernameController.text.trim();
                  final password = passwordController.text.trim();
                  if (username.isEmpty || password.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill in both fields")),
                    );
                    return;
                  }

                  Navigator.pop(context); // Close sheet
                  // TODO: Save credentials logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Credentials assigned to $userName")),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text("Assign"),
              ),
            ),
          ],
        ),
      );
    },
  );
}


class _UserManagementScreenState extends State<UserManagementScreen> {
  final List<Map<String, String>> users = [
    {
      'name': 'John Doe',
      'email': 'john@example.com',
      'role': 'Admin',
      'contact': '123-456-7890',
    },
    {
      'name': 'Dr. Mary Jane',
      'email': 'mary@example.com',
      'role': 'Doctor',
      'contact': '321-654-0987',
    },
    {
      'name': 'Nancy Nurse',
      'email': 'nancy@example.com',
      'role': 'Nurse',
      'contact': '555-555-5555',
    },
  ];

  String searchQuery = '';
  String selectedRole = 'All';
  final List<String> roles = ['All', 'Admin', 'Doctor', 'Nurse'];

  List<Map<String, String>> get filteredUsers {
    return users.where((user) {
      final matchesSearch = user['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user['email']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRole = selectedRole == 'All' || user['role'] == selectedRole;
      return matchesSearch && matchesRole;
    }).toList();
  }

    void deleteUser(int index) {
    final userToDelete = filteredUsers[index];
    setState(() {
      users.removeWhere((user) => user == userToDelete);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User deleted")),
    );
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
        title: const Text('User Management'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search by name or email',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
            const SizedBox(height: 16),
            // Role Filter
            Row(
              children: [
                const Text('Filter by Role:'),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: selectedRole,
                  items: roles
                      .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedRole = value);
                    }
                  },
                  style: const TextStyle(color: Color(0xFF0277BD)),
                  dropdownColor: Colors.white,
                  underline: Container(
                    height: 2,
                    color: const Color(0xFF0277BD),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // User list
            Expanded(
              child: ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return UserCard(
                    name: user['name']!,
                    email: user['email']!,
                    role: user['role']!,
                    contact: user['contact']!,
                    onAssignCredentials: () =>
                        showAssignCredentialsSheet(context, user['name']!),
                    onEdit: () async {
                        final updatedUser = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => AddEditUserScreen(userData: user),
    ),
  );

  if (updatedUser != null) {
    setState(() {
      users[index] = updatedUser;
    });
  }
                    },
                    onDelete: () => deleteUser(index),
                    onBlock: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Block ${user['name']}'))),
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
      users.add(newUser);
    });
  }
},

        backgroundColor: AppColors.primaryDark,
        child: const Icon(Icons.person_add, color: Colors.white),
      ),
    );
  }
}
