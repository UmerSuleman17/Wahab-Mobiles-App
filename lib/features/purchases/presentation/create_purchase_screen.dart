import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreatePurchaseScreen extends ConsumerStatefulWidget {
  const CreatePurchaseScreen({super.key});

  @override
  ConsumerState<CreatePurchaseScreen> createState() => _CreatePurchaseScreenState();
}

class _CreatePurchaseScreenState extends ConsumerState<CreatePurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Purchase')),
      body: Stepper(
        currentStep: 0,
        onStepContinue: () {},
        onStepCancel: () {},
        steps: [
          Step(
            title: const Text('Select Supplier'),
            content: DropdownButtonFormField<String>(
              items: const [DropdownMenuItem(value: '1', child: Text('Supplier A'))],
              onChanged: (val) {},
            ),
          ),
          Step(
            title: const Text('Add Products'),
            content: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Add Item'),
                ),
                const ListTile(
                  title: Text('Product A'),
                  subtitle: Text('2 x PKR 100'),
                  trailing: Text('PKR 200'),
                )
              ],
            ),
          ),
          Step(
            title: const Text('Payment'),
            content: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Discount'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Payment Method'),
                  items: const [DropdownMenuItem(value: 'cash', child: Text('Cash'))],
                  onChanged: (val) {},
                ),
                const SizedBox(height: 20),
                const Text('Total: PKR 200.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
