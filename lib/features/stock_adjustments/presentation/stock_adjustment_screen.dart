import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StockAdjustmentScreen extends ConsumerStatefulWidget {
  final String? productId;
  const StockAdjustmentScreen({super.key, this.productId});

  @override
  ConsumerState<StockAdjustmentScreen> createState() => _StockAdjustmentScreenState();
}

class _StockAdjustmentScreenState extends ConsumerState<StockAdjustmentScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isIncrease = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stock Adjustment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Product *'),
                items: const [DropdownMenuItem(value: '1', child: Text('Product A'))],
                onChanged: (val) {},
              ),
              const SizedBox(height: 10),
              const Text('Current Stock: 50', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Direction: '),
                  ChoiceChip(
                    label: const Text('Increase'),
                    selected: _isIncrease,
                    onSelected: (val) => setState(() => _isIncrease = true),
                    selectedColor: Colors.green.shade200,
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text('Decrease'),
                    selected: !_isIncrease,
                    onSelected: (val) => setState(() => _isIncrease = false),
                    selectedColor: Colors.red.shade200,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Quantity *'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Reason'),
                items: const [
                  DropdownMenuItem(value: 'damage', child: Text('Damage / Loss')),
                  DropdownMenuItem(value: 'count', child: Text('Inventory Count')),
                  DropdownMenuItem(value: 'return', child: Text('Return')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Confirm Adjustment'),
                          content: Text('Are you sure you want to ${_isIncrease ? "increase" : "decrease"} stock?'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(ctx); // Close dialog
                                Navigator.pop(context); // Close screen
                              }, 
                              child: const Text('Confirm')
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Submit Adjustment'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
