import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SupplierDetailScreen extends ConsumerWidget {
  final String supplierId;
  const SupplierDetailScreen({super.key, required this.supplierId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Details'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => context.push('/suppliers/edit/$supplierId')),
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(radius: 30, child: Icon(Icons.local_shipping, size: 30)),
              title: Text('Supplier Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              subtitle: Text('0300-9876543\nsupplier@example.com'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildStatCard('Payable Balance', 'PKR 10000', Colors.red)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard('Total Purchases', 'PKR 50000', Colors.blue)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.push('/suppliers/payment?supplierId=$supplierId'),
                icon: const Icon(Icons.payment),
                label: const Text('Pay Supplier'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Purchase History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => ListTile(
                title: const Text('PO #001'),
                subtitle: const Text('2023-10-15'),
                trailing: const Text('PKR 5000'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color valueColor) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: valueColor)),
            Text(title, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
