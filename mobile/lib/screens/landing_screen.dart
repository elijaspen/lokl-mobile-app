import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(child: _buildSophisticatedBackground(context)),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                // Full Screen Hero Section
                SizedBox(height: screenSize.height, child: _buildHero(context)),
                _buildSocialProof(context),
                _buildValueProp(context),
                _buildRiderCTA(context),
                _buildFinalCTA(context),
                _buildFooter(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSophisticatedBackground(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  theme.colorScheme.primary.withValues(
                    alpha: isDark ? 0.15 : 0.08,
                  ),
                  theme.colorScheme.primary.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  theme.colorScheme.secondary.withValues(
                    alpha: isDark ? 0.1 : 0.05,
                  ),
                  theme.colorScheme.secondary.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHero(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // App Logo/Branding
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  LucideIcons.truck,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'LOKL LINK',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),

          Text(
            'The Modern Way to\nGet Things Done.',
            textAlign: TextAlign.center,
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              height: 1.05,
              letterSpacing: -2,
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'LOKL Link connects you with local experts to deliver items, shop for groceries, or run complex errands in minutes.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                height: 1.6,
                fontSize: 18,
              ),
            ),
          ),

          const SizedBox(height: 48),

          ElevatedButton(
            onPressed: () {
              final auth = Provider.of<AuthService>(context, listen: false);
              auth.setRegistrationView(true);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Get Started for Free'),
                SizedBox(width: 12),
                Icon(LucideIcons.arrowRight, size: 20),
              ],
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton(
            onPressed: () {
              final auth = Provider.of<AuthService>(context, listen: false);
              auth.setRegistrationView(false);
            },
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              side: BorderSide(color: theme.colorScheme.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'Sign In to Your Account',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Spacer(),
          // Scroll Indicator
          Icon(
            LucideIcons.chevronDown,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 8),
          Text(
            'Scroll for more',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialProof(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          Text(
            'TRUSTED BY 5,000+ LOCAL USERS',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 24),
                _buildLogo('7-Eleven'),
                _buildLogo('SM Markets'),
                _buildLogo('Lawson'),
                _buildLogo('Starbucks'),
                _buildLogo('GrabFood'),
                const SizedBox(width: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Opacity(
        opacity: 0.2,
        child: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildValueProp(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          _buildServiceCard(
            context,
            icon: LucideIcons.truck,
            title: 'Express Delivery',
            description:
                'Need something moved? Our riders handle documents, parcels, and food with high-speed precision.',
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 24),
          _buildServiceCard(
            context,
            icon: LucideIcons.shoppingBag,
            title: 'Personal Shopping',
            description:
                'Ran out of milk? Need a specific item from the mall? We buy and deliver exactly what you need.',
            color: theme.colorScheme.secondary,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiderCTA(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          children: [
            Text(
              'Drive & Earn with LOKL',
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: theme.colorScheme.surface,
                fontWeight: FontWeight.w900,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Turn your bike into a paycheck. Join the most flexible delivery fleet in the city.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.surface.withValues(alpha: 0.6),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.surface,
                foregroundColor: theme.colorScheme.onSurface,
              ),
              child: const Text('Become a Rider'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinalCTA(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: Column(
        children: [
          Text(
            'Ready to simplify your life?',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).setRegistrationView(true);
            },
            child: const Text('Create Free Account'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 60),
      child: Column(
        children: [
          Divider(color: theme.colorScheme.outline),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.truck, size: 18),
              const SizedBox(width: 8),
              Text(
                'LOKL LINK',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFooterLink('Privacy'),
              _buildFooterLink('Terms'),
              _buildFooterLink('Contact'),
              _buildFooterLink('Careers'),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            '© 2026 LOKL Link Inc. All rights reserved.',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
