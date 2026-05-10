import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authService = Provider.of<AuthService>(context);
    final user = authService.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: [
          IconButton(
            onPressed: () => authService.logout(),
            icon: const Icon(LucideIcons.logOut, size: 20, color: Colors.red),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(LucideIcons.user, size: 50),
            ),
            const SizedBox(height: 24),
            Text(
              user?.name ?? 'Guest User',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              user?.email ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                user?.role.name.toUpperCase() ?? '',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 48),
            _buildMenuItem(context, LucideIcons.settings, 'Settings'),
            _buildMenuItem(context, LucideIcons.creditCard, 'Payment Methods'),
            _buildMenuItem(context, LucideIcons.helpCircle, 'Help & Support'),
            const SizedBox(height: 24),
            ListTile(
              onTap: () => authService.logout(),
              leading: const Icon(LucideIcons.logOut, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, size: 20),
      title: Text(title),
      trailing: const Icon(LucideIcons.chevronRight, size: 16),
      onTap: () {},
    );
  }
}
