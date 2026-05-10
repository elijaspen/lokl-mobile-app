import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../models/order.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final apiService = Provider.of<ApiService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(LucideIcons.bell, size: 20)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              children: [
                _buildStatCard(context, 'Total Orders', '1,284', LucideIcons.shoppingBag, theme.colorScheme.primary),
                const SizedBox(width: 16),
                _buildStatCard(context, 'Active Riders', '42', LucideIcons.bike, theme.colorScheme.secondary),
              ],
            ),
            const SizedBox(height: 32),
            
            Text(
              'Live System Monitor',
              style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            
            // System Log / Order List
            FutureBuilder<List<Order>>(
              future: apiService.fetchOrders(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ));
                }
                
                final orders = snapshot.data ?? [];
                
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: orders.length > 5 ? 5 : orders.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    final bool isErrand = order.type == 'errand';
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: (isErrand ? theme.colorScheme.secondary : theme.colorScheme.primary).withValues(alpha: 0.1),
                          child: Icon(
                            isErrand ? LucideIcons.shoppingBag : LucideIcons.truck, 
                            size: 16, 
                            color: isErrand ? theme.colorScheme.secondary : theme.colorScheme.primary
                          ),
                        ),
                        title: Row(
                          children: [
                            Text(order.trackingCode, style: const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 8),
                            Text(
                              '• ${order.category}',
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          '${order.type.toUpperCase()} • ${order.status.toUpperCase()}', 
                          style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5)
                        ),
                        trailing: const Icon(LucideIcons.chevronRight, size: 16),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 16),
            Text(value, style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w900, color: color)),
            Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }
}
