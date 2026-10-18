import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateSaleScreen extends ConsumerStatefulWidget {
  const CreateSaleScreen({super.key});

  @override
  ConsumerState<CreateSaleScreen> createState() => _CreateSaleScreenState();
}

class _CreateSaleScreenState extends ConsumerState<CreateSaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Sale')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {}, // Add product via search/scan
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add Products'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Product $index'),
                  subtitle: Text('Qty: 1 @ PKR 500'),
                  trailing: const Text('PKR 500'),
                ),
              ),
            ),
            const Divider(),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Discount'),
              keyboardType: TextInputType.number,
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Payment Method'),
              items: const [DropdownMenuItem(value: 'cash', child: Text('Cash'))],
              onChanged: (val) {},
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('PKR 1000.00', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Confirm Sale'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
