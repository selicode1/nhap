import 'package:flutter/material.dart';
import 'package:nhap/screens/department_form_screen.dart';
import 'package:nhap/screens/hospital_form_screen.dart';
import 'package:nhap/screens/main_screen.dart';
import 'package:nhap/screens/user_management_screen.dart';
import 'package:nhap/screens/view_records_screen.dart';
import '../../../../core/constants/app_colors.dart';
import '../widgets/stat_card.dart';
import '../widgets/recent_activity_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(

        backgroundColor: Colors.white,
        title: const Text("Dashboard", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            // Row(
            //   children: [
            //     const CircleAvatar(
            //       radius: 28,
            //       backgroundColor: Colors.green,
            //       child: Icon(Icons.person, size: 32, color: Colors.white),
            //     ),
            //     const SizedBox(width: 12),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: const [
            //         Text("Welcome Back", style: TextStyle(fontSize: 16, color: Colors.black54)),
            //         Text("Admin", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            //       ],
            //     )
            //   ],
            // ),
            // const SizedBox(height: 24),

            // Summary Title
            const Text("Overview", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

                                    Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Hospitals',
                                value: '12',
                                icon: Icons.local_hospital,
                                iconColor: AppColors.primary,
                                backgroundColor: AppColors.primary.withOpacity(0.1),
                                onTap: () {
                                                                            Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 1)));
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Departments',
                                value: '48',
                                icon: Icons.medical_services,
                                iconColor: AppColors.secondary,
                                backgroundColor: AppColors.secondary.withOpacity(0.1),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: StatCard(
                                title: 'Doctors',
                                value: '124',
                                icon: Icons.person,
                                iconColor: AppColors.accent,
                                backgroundColor: AppColors.accent.withOpacity(0.1),
                                onTap: () {
                                                                                                              Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 2)));
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: StatCard(
                                title: 'Medical Records',
                                value: '2,541',
                                icon: Icons.folder,
                                iconColor: AppColors.error,
                                backgroundColor: AppColors.error.withOpacity(0.1),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),


            // Quick Actions
            const Text("Quick Actions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildActionButton(context, "Add Hospital", Icons.add_business_outlined, Colors.green.shade600, () {
                                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => AddHospitalScreen()));
                }),
                _buildActionButton(context, "Add Department", Icons.domain_add_outlined, Colors.teal, () {
                                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => AddDepartmentScreen()));
                }),
                _buildActionButton(context, "Manage Users", Icons.manage_accounts_outlined, Colors.orange.shade700, () {
                                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => UserManagementScreen()));
                }),
                _buildActionButton(context, "View Records", Icons.folder_shared_outlined, Colors.blue.shade600, () {
                                          Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => PatientRecordsScreen()));
                }),
              ],
            ),

            const SizedBox(height: 30),

            // Recent Activity Section
            const Text("Recent Activity", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
                        const RecentActivityCard(
                          title: 'New patient registered',
                          subtitle: 'John Smith was registered by Dr. Johnson',
                          timeAgo: '5 min ago',
                          iconData: Icons.person_add,
                          iconColor: AppColors.accent,
                        ),
                        const SizedBox(height: 12),
                        const RecentActivityCard(
                          title: 'Medical record updated',
                          subtitle: 'Dr. Sarah updated medical records for Patient #2845',
                          timeAgo: '25 min ago',
                          iconData: Icons.edit_document,
                          iconColor: AppColors.secondary,
                        ),
                        const SizedBox(height: 12),
                        const RecentActivityCard(
                          title: 'Department added',
                          subtitle: 'New Cardiology department added to Central Hospital',
                          timeAgo: '1 hour ago',
                          iconData: Icons.add_business,
                          iconColor: AppColors.primary,
                        ),
                        const SizedBox(height: 12),
                        const RecentActivityCard(
                          title: 'Staff account blocked',
                          subtitle: 'Nurse account #ID4582 was temporarily blocked',
                          timeAgo: '2 hours ago',
                          iconData: Icons.block,
                          iconColor: AppColors.error,
                        ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }



  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color, VoidCallback onTap) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 16 * 3) / 2;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
