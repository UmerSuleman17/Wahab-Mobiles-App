import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wm_app/core/theme/app_colors.dart';

/// Screen for removing stock from a product (PRD §10).
class StockOutScreen extends ConsumerStatefulWidget {
  const StockOutScreen({super.key, this.productId});

  final String? productId;

  @override
  ConsumerState<StockOutScreen> createState() => _StockOutScreenState();
}

class _StockOutScreenState extends ConsumerState<StockOutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _notesController = TextEditingController();
  String? _selectedProductId;

  @override
  void initState() {
    super.initState();
    _selectedProductId = widget.productId;
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Out')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        _selectedProductId ?? 'Select a product',
                        style: TextStyle(
                          color: _selectedProductId != null
                              ? AppColors.textPrimary
                              : AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity *',
                  hintText: 'Enter quantity to remove',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Required';
                  final n = double.tryParse(v);
                  if (n == null || n <= 0) return 'Must be > 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Reason / Notes',
                  hintText: 'e.g. Damaged, Expired, Sample',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.remove_circle_outline),
                label: const Text('Remove Stock'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.warning,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProductId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a product')),
      );
      return;
    }
    // Will call InventoryService.stockOut via provider
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stock removed successfully')),
    );
    if (mounted) Navigator.of(context).pop();
  }
}
