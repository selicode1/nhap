import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  final String hospitalName;
  final String location;
  final String contactNumber;
  final String establishedDate;
  final String hospitalImage; // URL or asset path
  final String hospitalType;
  final VoidCallback onTap;

  const HospitalCard({
    super.key,
    required this.hospitalName,
    required this.location,
    required this.contactNumber,
    required this.establishedDate,
    required this.hospitalImage,
    required this.hospitalType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.brightness == Brightness.light
              ? Colors.white
              : Colors.grey.shade800,
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
          children: [
            // Hospital Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                hospitalImage,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.local_hospital, size: 40, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospitalName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.brightness == Brightness.light
                          ? Colors.black87
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hospitalType,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.brightness == Brightness.light
                          ? Colors.blueGrey
                          : Colors.blue.shade200,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.brightness == Brightness.light
                          ? Colors.black54
                          : Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Established: $establishedDate',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.brightness == Brightness.light
                          ? Colors.black45
                          : Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16, color: Colors.green),
                      const SizedBox(width: 6),
                      Text(
                        contactNumber,
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.brightness == Brightness.light
                              ? Colors.black87
                              : Colors.white,
                        ),
                      ),
                    ],
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
