import 'package:flutter/material.dart';

class RecentActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData iconData;
  final Color iconColor;

  const RecentActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.iconData,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.brightness == Brightness.light
                        ? Colors.black87
                        : Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.brightness == Brightness.light
                        ? Colors.black54
                        : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Text(
            timeAgo,
            style: TextStyle(
              fontSize: 12,
              color: theme.brightness == Brightness.light
                  ? Colors.black45
                  : Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}