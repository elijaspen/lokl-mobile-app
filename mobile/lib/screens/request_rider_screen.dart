import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';

class RequestRiderScreen extends StatefulWidget {
  const RequestRiderScreen({super.key});

  @override
  State<RequestRiderScreen> createState() => _RequestRiderScreenState();
}

class _RequestRiderScreenState extends State<RequestRiderScreen> {
  final TextEditingController _pickupController = TextEditingController(text: "SM North EDSA, Quezon City");
  final TextEditingController _dropoffController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedType = "delivery";
  String _selectedCategory = "Food";
  bool _isRequesting = false;

  Future<void> _handleRequestRider(BuildContext context) async {
    if (_dropoffController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a destination'), behavior: SnackBarBehavior.floating),
      );
      return;
    }

    final apiService = Provider.of<ApiService>(context, listen: false);

    setState(() => _isRequesting = true);

    try {
      final orderData = {
        'type': _selectedType,
        'category': _selectedCategory,
        'description': _descriptionController.text,
        'origin_lat': 14.5547,
        'origin_lng': 121.0244,
        'origin_address': _pickupController.text,
        'dest_lat': 14.5794,
        'dest_lng': 121.0359,
        'dest_address': _dropoffController.text,
        'fee': _selectedType == 'errand' ? 200.0 : 150.0,
        'distance': 1.2,
      };

      await apiService.createOrder(orderData);

      if (context.mounted) {
        _dropoffController.clear();
        _descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Request sent successfully!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send request: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isRequesting = false);
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Map Placeholder
            Container(
              height: 200,
              width: double.infinity,
              color: theme.colorScheme.surface,
              child: Center(
                child: Icon(
                  LucideIcons.mapPin,
                  color: theme.colorScheme.primary,
                  size: 48,
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Service Type Selector
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outline),
                    ),
                    child: Row(
                      children: [
                        _buildTypeButton('delivery', 'Deliver', LucideIcons.truck),
                        _buildTypeButton('errand', 'Buy Something', LucideIcons.shoppingBag),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  _buildInput(
                    context, 
                    LucideIcons.circleDot, 
                    _selectedType == 'errand' ? "Where to buy?" : "Pickup Location", 
                    _pickupController,
                    isSource: true
                  ),
                  const SizedBox(height: 12),
                  _buildInput(
                    context, 
                    LucideIcons.mapPin, 
                    _selectedType == 'errand' ? "Deliver to where?" : "Where to deliver?", 
                    _dropoffController
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Description Input
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: theme.colorScheme.outline),
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 2,
                      decoration: InputDecoration(
                        icon: Icon(LucideIcons.pencil, color: theme.colorScheme.onSurface.withValues(alpha: 0.4), size: 18),
                        hintText: _selectedType == 'errand' ? "What do you need me to buy?" : "Notes for the rider (optional)",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  Row(
                    children: [
                      _buildChip("Food"),
                      const SizedBox(width: 8),
                      _buildChip("Document"),
                      const SizedBox(width: 8),
                      _buildChip("Parcel"),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  ElevatedButton(
                    onPressed: _isRequesting ? null : () => _handleRequestRider(context),
                    child: _isRequesting 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_selectedType == 'errand' ? 'Find a Personal Shopper' : 'Request Delivery'),
                            const SizedBox(width: 8),
                            const Icon(LucideIcons.arrowRight, size: 18),
                          ],
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeButton(String type, String label, IconData icon) {
    final theme = Theme.of(context);
    final isSelected = _selectedType == type;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedType = type),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon, 
                size: 16, 
                color: isSelected ? Colors.white : theme.colorScheme.onSurface.withValues(alpha: 0.6)
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: isSelected ? Colors.white : theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(
    BuildContext context, 
    IconData icon, 
    String hint, 
    TextEditingController controller,
    {bool isSource = false}
  ) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: TextField(
        controller: controller,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          icon: Icon(icon, color: isSource ? theme.colorScheme.primary : theme.colorScheme.onSurface.withValues(alpha: 0.4), size: 18),
          hintText: hint,
          border: InputBorder.none,
          hintStyle: TextStyle(color: theme.colorScheme.onSurface.withValues(alpha: 0.4)),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    final theme = Theme.of(context);
    final isSelected = _selectedCategory == label;
    
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
