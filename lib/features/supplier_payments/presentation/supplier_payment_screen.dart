import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupplierPaymentScreen extends ConsumerStatefulWidget {
  final String? supplierId;
  const SupplierPaymentScreen({super.key, this.supplierId});

  @override
  ConsumerState<SupplierPaymentScreen> createState() => _SupplierPaymentScreenState();
}

class _SupplierPaymentScreenState extends ConsumerState<SupplierPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pay Supplier')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Select Supplier *'),
                items: const [DropdownMenuItem(value: '1', child: Text('Supplier A'))],
                onChanged: (val) {},
              ),
              const SizedBox(height: 10),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Payable Balance:'),
                      Text('PKR 10000.00', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount to Pay *'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: const [
                  DropdownMenuItem(value: 'cash', child: Text('Cash')),
                  DropdownMenuItem(value: 'bank', child: Text('Bank Transfer')),
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Reference / Notes'),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Confirm Payment'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
