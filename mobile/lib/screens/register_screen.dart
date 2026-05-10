import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  UserRole _selectedRole = UserRole.customer;
  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _register() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      _showError('Please fill in all required fields');
      return;
    }

    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthService>(context, listen: false).register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _selectedRole,
      );
    } catch (e) {
      if (mounted) {
        _showError(e.toString().replaceAll('Exception: ', '').replaceAll('Exception', ''));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              auth.setRegistrationView(false);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Create Account',
                style: theme.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join thousands of users using LOKL Link.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
              
              const SizedBox(height: 40),
              
              Text(
                'I want to join as a...',
                style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _RoleSelectionCard(
                      title: 'Customer',
                      icon: LucideIcons.user,
                      isSelected: _selectedRole == UserRole.customer,
                      onTap: () => setState(() => _selectedRole = UserRole.customer),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _RoleSelectionCard(
                      title: 'Rider',
                      icon: LucideIcons.bike,
                      isSelected: _selectedRole == UserRole.rider,
                      onTap: () => setState(() => _selectedRole = UserRole.rider),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),
              
              _buildInputField(
                context,
                label: 'Full Name',
                controller: _nameController,
                icon: LucideIcons.userCircle,
                hint: 'John Doe',
              ),
              const SizedBox(height: 24),
              _buildInputField(
                context,
                label: 'Email Address',
                controller: _emailController,
                icon: LucideIcons.mail,
                keyboardType: TextInputType.emailAddress,
                hint: 'name@company.com',
              ),
              const SizedBox(height: 24),
              _buildInputField(
                context,
                label: 'Password',
                controller: _passwordController,
                icon: LucideIcons.lock,
                isPassword: true,
                obscureText: _obscurePassword,
                onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                hint: 'Min. 8 characters',
              ),
              
              const SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: _isLoading 
                  ? const SizedBox(
                      height: 24, 
                      width: 24, 
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white)
                    )
                  : const Text('Create My Account'),
              ),
              
              const SizedBox(height: 32),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
                  ),
                  TextButton(
                    onPressed: () => auth.setRegistrationView(false),
                    child: Text(
                      'Sign In',
                      style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required IconData icon,
    String? hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleObscure,
    TextInputType? keyboardType,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: theme.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: theme.colorScheme.surface,
            prefixIcon: Icon(icon, size: 20, color: theme.colorScheme.onSurface.withValues(alpha: 0.3)),
            suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(
                    obscureText ? LucideIcons.eye : LucideIcons.eyeOff, 
                    size: 20, 
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3)
                  ),
                  onPressed: onToggleObscure,
                ) 
              : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          ),
        ),
      ],
    );
  }
}

class _RoleSelectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleSelectionCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Column(
          children: [
            Icon(
              icon, 
              size: 32, 
              color: isSelected ? Colors.white : theme.colorScheme.onSurface.withValues(alpha: 0.3)
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: isSelected ? Colors.white : theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
