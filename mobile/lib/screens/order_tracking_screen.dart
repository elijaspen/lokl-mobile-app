import 'package:flutter/material.dart';
import '../core/theme/colors.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

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
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&q=80&w=100',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Map Section
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=1000',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
              child: const Stack(
                children: [
                  // Destination Pin
                  Positioned(
                    top: 100,
                    right: 60,
                    child: Icon(
                      Icons.home,
                      color: SwiftDropColors.accentBlue,
                      size: 32,
                    ),
                  ),
                  // Rider Pin
                  Positioned(
                    top: 200,
                    left: 150,
                    child: Icon(
                      Icons.local_shipping,
                      color: SwiftDropColors.primary,
                      size: 28,
                    ),
                  ),
                  // Origin Pin
                  Positioned(
                    bottom: 120,
                    left: 80,
                    child: Icon(
                      Icons.restaurant,
                      color: SwiftDropColors.textMuted,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tracking Details Card
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: SwiftDropColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              border: Border(top: BorderSide(color: SwiftDropColors.border)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'In Transit',
                          style: TextStyle(
                            color: SwiftDropColors.textMain,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Arriving in 12–18 mins',
                          style: TextStyle(
                            color: SwiftDropColors.textMuted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: SwiftDropColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: SwiftDropColors.border),
                      ),
                      child: const Text(
                        '#ORD-8821',
                        style: TextStyle(
                          color: SwiftDropColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Progress Indicator
                const _ProgressIndicator(),

                const SizedBox(height: 32),

                // Rider Profile
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: SwiftDropColors.border),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: SwiftDropColors.surfaceContainer,
                        child: Icon(
                          Icons.person,
                          color: SwiftDropColors.textMuted,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eli Jaspen',
                              style: TextStyle(
                                color: SwiftDropColors.textMain,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '4.9 • Electric Bike',
                              style: TextStyle(
                                color: SwiftDropColors.textMuted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.phone,
                          color: SwiftDropColors.textMain,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: SwiftDropColors.surfaceContainer,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Actions
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SwiftDropColors.primary,
                      foregroundColor: SwiftDropColors.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Contact Rider',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Cancel Order',
                      style: TextStyle(color: SwiftDropColors.textMuted),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  const _ProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStep(Icons.check, 'Placed', isCompleted: true),
        _buildConnector(isCompleted: true),
        _buildStep(Icons.check, 'Assigned', isCompleted: true),
        _buildConnector(isCompleted: false),
        _buildStep(Icons.local_shipping, 'Transit', isActive: true),
        _buildConnector(isCompleted: false),
        _buildStep(Icons.inventory_2, 'Arrived', isInactive: true),
      ],
    );
  }

  Widget _buildStep(
    IconData icon,
    String label, {
    bool isCompleted = false,
    bool isActive = false,
    bool isInactive = false,
  }) {
    Color color = isInactive
        ? SwiftDropColors.textMuted
        : SwiftDropColors.textMain;
    if (isCompleted || isActive) color = SwiftDropColors.textMain;

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(
              color: isInactive
                  ? SwiftDropColors.border
                  : SwiftDropColors.textMain,
              width: 1.5,
            ),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isInactive
                ? SwiftDropColors.textMuted
                : SwiftDropColors.textMain,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector({required bool isCompleted}) {
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.only(bottom: 24),
        color: isCompleted ? SwiftDropColors.textMain : SwiftDropColors.border,
      ),
    );
  }
}
