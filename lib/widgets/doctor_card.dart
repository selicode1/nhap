import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String contactNumber;
  final String experience;
  final String profileImageUrl;
  final String availability;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.doctorName,
    required this.specialty,
    required this.contactNumber,
    required this.experience,
    required this.profileImageUrl,
    required this.availability,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF0277BD);
    const Color darkText = Color(0xFF212121);
    const Color lightText = Color(0xFF616161);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                profileImageUrl,
                height: 64,
                width: 64,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 64),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: darkText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 15,
                      color: primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Experience: $experience",
                    style: const TextStyle(
                      fontSize: 14,
                      color: lightText,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        contactNumber,
                        style: TextStyle(
                          fontSize: 14,
                          color: lightText,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Availability: $availability",
                    style: const TextStyle(
                      fontSize: 14,
                      color: lightText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
