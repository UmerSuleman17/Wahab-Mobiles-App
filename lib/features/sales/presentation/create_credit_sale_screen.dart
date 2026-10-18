import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateCreditSaleScreen extends ConsumerStatefulWidget {
  const CreateCreditSaleScreen({super.key});

  @override
  ConsumerState<CreateCreditSaleScreen> createState() => _CreateCreditSaleScreenState();
}

class _CreateCreditSaleScreenState extends ConsumerState<CreateCreditSaleScreen> {
  bool _whatsappReminder = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Credit Sale')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Customer *'),
              items: const [DropdownMenuItem(value: '1', child: Text('Customer A'))],
              onChanged: (val) {},
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add Products'),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, index) => const ListTile(
                title: Text('Product A'),
                subtitle: Text('Qty: 2 @ PKR 500'),
                trailing: Text('PKR 1000'),
              ),
            ),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('PKR 1000.00'),
              ],
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Amount Received'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Balance Due:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                Text('PKR 1000.00', style: TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Expanded(child: Text('Due Date: ')),
                TextButton.icon(
                  onPressed: () {}, // Date picker
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Select Date'),
                )
              ],
            ),
            SwitchListTile(
              title: const Text('WhatsApp Reminder'),
              value: _whatsappReminder,
              onChanged: (val) => setState(() => _whatsappReminder = val),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Confirm Credit Sale'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
