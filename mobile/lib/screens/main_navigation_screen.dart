import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/user.dart';
import 'request_rider_screen.dart';
import 'order_list_screen.dart';
import 'account_screen.dart';
import 'rider_job_feed_screen.dart';
import 'admin_dashboard_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  List<Widget> _getCustomerScreens() => [
    const RequestRiderScreen(),
    const OrderListScreen(),
    const AccountScreen(),
  ];

  List<Widget> _getRiderScreens() => [
    const RiderJobFeedScreen(),
    const OrderListScreen(),
    const AccountScreen(),
  ];

  List<Widget> _getAdminScreens() => [
    const AdminDashboardScreen(),
    const OrderListScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    // Defensive check: If authenticated but user profile isn't loaded yet
    if (user == null && authService.isAuthenticated) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final bool isRider = user?.role == UserRole.rider;
    final bool isAdmin = user?.role == UserRole.admin;

    List<Widget> screens;
    if (isAdmin) {
      screens = _getAdminScreens();
    } else if (isRider) {
      screens = _getRiderScreens();
    } else {
      screens = _getCustomerScreens();
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(isAdmin ? LucideIcons.shield : (isRider ? LucideIcons.layoutGrid : LucideIcons.send)),
            label: isAdmin ? 'Admin' : (isRider ? 'Jobs' : 'Request'),
          ),
          const BottomNavigationBarItem(
            icon: Icon(LucideIcons.clipboardList),
            label: 'Activity',
          ),
          const BottomNavigationBarItem(
            icon: Icon(LucideIcons.user),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
