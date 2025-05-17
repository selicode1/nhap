import 'package:flutter/material.dart';

class PatientRecordCard extends StatelessWidget {
  final String patientName;
  final String date;
  final String height;
  final String weight;
  final String bp;
  final String temperature;
  final Color backgroundColor;
  final VoidCallback onTap;

  const PatientRecordCard({
    super.key,
    required this.patientName,
    required this.date,
    required this.height,
    required this.weight,
    required this.bp,
    required this.temperature,
    required this.backgroundColor,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: theme.brightness == Brightness.light
                      ? Colors.black45
                      : Colors.white70,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Patient Name
            Text(
              patientName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.brightness == Brightness.light
                    ? Colors.black87
                    : Colors.white,
              ),
            ),

            const SizedBox(height: 8),

            /// Date
            Text(
              'Date: $date',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.brightness == Brightness.light
                    ? Colors.black54
                    : Colors.white70,
              ),
            ),

            const SizedBox(height: 12),

            /// Medical stats
            _buildRecordRow('Height', height, theme),
            _buildRecordRow('Weight', weight, theme),
            _buildRecordRow('Blood Pressure', bp, theme),
            _buildRecordRow('Temperature', temperature, theme),
          ],
        ),
      ),
    );
    
  }
  

  Widget _buildRecordRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: theme.brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white70,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: theme.brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
    
  }
  
}
