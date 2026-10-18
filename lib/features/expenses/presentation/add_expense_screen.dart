import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Category *'),
                items: const [
                  DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                  DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
                  DropdownMenuItem(value: 'Transport', child: Text('Transport')),
                  DropdownMenuItem(value: 'Salaries', child: Text('Salaries')),
                  DropdownMenuItem(value: 'Maintenance', child: Text('Maintenance')),
                  DropdownMenuItem(value: 'Misc', child: Text('Misc')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (val) {},
                validator: (val) => val == null ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount *'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description *'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: const [DropdownMenuItem(value: 'cash', child: Text('Cash'))],
                onChanged: (val) {},
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(child: Text('Date: 2023-10-25')),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.calendar_today),
                    label: const Text('Change'),
                  )
                ],
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
                  child: const Text('Save Expense'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
