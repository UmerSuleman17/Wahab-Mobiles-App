import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:wm_app/core/theme/app_colors.dart';

/// Screen for adding stock to a product (PRD §9).
class StockInScreen extends ConsumerStatefulWidget {
  const StockInScreen({super.key, this.productId});

  final String? productId;

  @override
  ConsumerState<StockInScreen> createState() => _StockInScreenState();
}

class _StockInScreenState extends ConsumerState<StockInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();
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
    _unitPriceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock In')),
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
                      // Product selector placeholder — will be wired to product provider
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
                  hintText: 'Enter quantity to add',
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
                controller: _unitPriceController,
                decoration: const InputDecoration(
                  labelText: 'Unit Price',
                  hintText: 'Purchase price per unit',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  hintText: 'Optional notes',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add Stock'),
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
    // Will call InventoryService.stockIn via provider
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Stock added successfully')),
    );
    if (mounted) Navigator.of(context).pop();
  }
}
