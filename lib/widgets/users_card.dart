import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String contact;
  final VoidCallback onAssignCredentials;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onBlock;

  const UserCard({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    required this.contact,
    required this.onAssignCredentials,
    required this.onEdit,
    required this.onDelete,
    required this.onBlock,
  });

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.red.shade600;
      case 'doctor':
        return Colors.green.shade700;
      case 'nurse':
        return Colors.orange.shade700;
      case 'receptionist':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color roleColor = _getRoleColor(role);
    const Color textColor = Color(0xFF212121);
    const Color subTextColor = Color(0xFF757575);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left info section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: subTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text("Role: ",
                        style: TextStyle(fontSize: 14, color: subTextColor)),
                    Text(
                      role,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: roleColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "Contact: $contact",
                  style: const TextStyle(fontSize: 14, color: subTextColor),
                ),
              ],
            ),
          ),

          // Actions menu
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'assign':
                  onAssignCredentials();
                  break;
                case 'edit':
                  onEdit();
                  break;
                case 'delete':
                  onDelete();
                  break;
                case 'block':
                  onBlock();
                  break;
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'assign', child: Text('Assign Credentials')),
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'delete', child: Text('Delete')),
              const PopupMenuItem(value: 'block', child: Text('Block')),
            ],
          ),
        ],
      ),
    );
  }
}
