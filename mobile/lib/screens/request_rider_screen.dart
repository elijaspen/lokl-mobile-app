import 'package:flutter/material.dart';
import '../core/theme/colors.dart';
import '../services/api_service.dart';

class RequestRiderScreen extends StatelessWidget {
  const RequestRiderScreen({super.key});

  Future<void> _handleRequestRider(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(color: SwiftDropColors.accentBlue)),
      );

      final orderData = {
        'origin': {'lat': 14.5547, 'lng': 121.0244},
        'destination': {'lat': 14.5794, 'lng': 121.0359},
        'category': 'Food',
        'fee': 150.0,
      };

      await ApiService().createOrder(orderData);

      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order requested successfully!')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SwiftDropColors.background,
      appBar: AppBar(
        backgroundColor: SwiftDropColors.background,
        elevation: 0,
        leading: const Icon(Icons.menu, color: SwiftDropColors.textMain),
        title: const Text(
          'LokalLink',
          style: TextStyle(
            color: SwiftDropColors.textMain,
            fontWeight: FontWeight.bold,
            letterSpacing: -1,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: SwiftDropColors.border,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=80&w=100'),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Map Section (60%)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.55,
            child: Container(
              color: Colors.black, // Placeholder for Map
              child: const Center(
                child: Icon(
                  Icons.location_on,
                  color: SwiftDropColors.accentBlue,
                  size: 48,
                ),
              ),
            ),
          ),
          
          // Request Card (40%)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: SwiftDropColors.cardBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                border: Border(
                  top: BorderSide(color: SwiftDropColors.border),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Inputs
                  _buildInput(Icons.radio_button_checked, "128 Tech Avenue, Innovation District", isSource: true),
                  const SizedBox(height: 12),
                  _buildInput(Icons.location_on, "Drop-off destination"),
                  
                  const SizedBox(height: 24),
                  
                  // Categories
                  Row(
                    children: [
                      _buildChip("Food", isSelected: true),
                      const SizedBox(width: 8),
                      _buildChip("Document"),
                      const SizedBox(width: 8),
                      _buildChip("Parcel"),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _handleRequestRider(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: SwiftDropColors.primary,
                        foregroundColor: SwiftDropColors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Request Rider',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(IconData icon, String text, {bool isSource = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SwiftDropColors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSource ? SwiftDropColors.accentBlue : SwiftDropColors.textMuted, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isSource ? SwiftDropColors.textMain : SwiftDropColors.textMuted,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? SwiftDropColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? SwiftDropColors.primary : SwiftDropColors.border,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? SwiftDropColors.onPrimary : SwiftDropColors.textMain,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}
