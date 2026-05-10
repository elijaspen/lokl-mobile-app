import 'package:flutter/material.dart';
import 'request_rider_screen.dart';
import 'order_tracking_screen.dart';
import 'rider_job_feed_screen.dart';
import '../core/theme/colors.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const RequestRiderScreen(),
    const OrderTrackingScreen(),
    const RiderJobFeedScreen(),
    const Center(child: Text('Profile', style: TextStyle(color: SwiftDropColors.textMain))),
  ];

  @override
  Widget build(BuildContext context) {
    // We remove the Scaffold here if the individual screens already have one,
    // but the Stitch screens have their own Scaffold and BottomNavigationBar.
    // To make it a unified experience, I should refactor the Stitch screens
    // to be "Views" or handle the BottomNav here.
    
    // For now, let's just show the selected screen.
    // Since each screen has its own BottomNavigationBar in the Stitch code,
    // I will replace them with a single one here for a "Senior" architecture.
    
    return Scaffold(
      backgroundColor: SwiftDropColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: SwiftDropColors.background,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: SwiftDropColors.accentBlue,
        unselectedItemColor: SwiftDropColors.textMuted,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'Request'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Activity'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
