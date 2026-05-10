import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(LucideIcons.menu),
        title: const Text(
          'LOKL',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1),
        ),
        centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.surface,
            child: Icon(LucideIcons.user, size: 16, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
          ),
        ),
      ],
      ),
      body: Column(
        children: [
          // Map Section (Placeholder)
          Expanded(
            flex: 6,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1524661135-423995f22d0b?auto=format&fit=crop&q=80&w=1000',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.2,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 100,
                    right: 60,
                    child: Icon(LucideIcons.home, color: theme.colorScheme.primary, size: 32),
                  ),
                  const Positioned(
                    top: 200,
                    left: 150,
                    child: Icon(LucideIcons.bike, color: Colors.amber, size: 28),
                  ),
                ],
              ),
            ),
          ),

          // Tracking Details Card
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
              border: Border(top: BorderSide(color: theme.colorScheme.outline)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'In Transit',
                          style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Arriving in 12–18 mins',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme.colorScheme.outline),
                      ),
                      child: Text(
                        '#ORD-8821',
                        style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                const _ProgressIndicator(),
                const SizedBox(height: 32),

                // Rider Profile
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colorScheme.outline),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: theme.colorScheme.surface,
                        child: Icon(LucideIcons.user, color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Eli Jaspen',
                              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '4.9 • Electric Bike',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(LucideIcons.phone),
                        style: IconButton.styleFrom(
                          backgroundColor: theme.colorScheme.surface,
                          side: BorderSide(color: theme.colorScheme.outline),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Contact Rider'),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel Order',
                      style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
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
        _buildStep(context, LucideIcons.check, 'Placed', isCompleted: true),
        _buildConnector(context, isCompleted: true),
        _buildStep(context, LucideIcons.check, 'Assigned', isCompleted: true),
        _buildConnector(context, isCompleted: false),
        _buildStep(context, LucideIcons.bike, 'Transit', isActive: true),
        _buildConnector(context, isCompleted: false),
        _buildStep(context, LucideIcons.package, 'Arrived', isInactive: true),
      ],
    );
  }

  Widget _buildStep(
    BuildContext context,
    IconData icon,
    String label, {
    bool isCompleted = false,
    bool isActive = false,
    bool isInactive = false,
  }) {
    final theme = Theme.of(context);
    Color color = isInactive ? theme.colorScheme.outline : theme.colorScheme.onSurface;
    if (isCompleted || isActive) color = theme.colorScheme.primary;

    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? theme.colorScheme.primary.withValues(alpha: 0.1) : Colors.transparent,
            border: Border.all(
              color: isInactive ? theme.colorScheme.outline : (isActive ? theme.colorScheme.primary : theme.colorScheme.outline),
              width: 1.5,
            ),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: isInactive ? theme.colorScheme.onSurface.withValues(alpha: 0.4) : theme.colorScheme.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildConnector(BuildContext context, {required bool isCompleted}) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.only(bottom: 24),
        color: isCompleted ? theme.colorScheme.primary : theme.colorScheme.outline,
      ),
    );
  }
}
