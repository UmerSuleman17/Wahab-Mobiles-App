import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEditSupplierScreen extends ConsumerStatefulWidget {
  final String? supplierId;
  const AddEditSupplierScreen({super.key, this.supplierId});

  @override
  ConsumerState<AddEditSupplierScreen> createState() => _AddEditSupplierScreenState();
}

class _AddEditSupplierScreenState extends ConsumerState<AddEditSupplierScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.supplierId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Supplier' : 'Add Supplier')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Supplier Name *'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Notes'),
                maxLines: 3,
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
                  child: const Text('Save Supplier'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
