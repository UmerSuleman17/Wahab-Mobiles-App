import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerPaymentScreen extends ConsumerStatefulWidget {
  final String customerId;
  const CustomerPaymentScreen({super.key, required this.customerId});

  @override
  ConsumerState<CustomerPaymentScreen> createState() => _CustomerPaymentScreenState();
}

class _CustomerPaymentScreenState extends ConsumerState<CustomerPaymentScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Record Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Outstanding Balance:', style: TextStyle(fontSize: 16)),
                      Text('PKR 5000.00', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount Received *'),
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
