import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends ConsumerWidget {
  final String productId;
  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () => context.push('/products/edit/$productId')),
          IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Product Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Category: Electronics', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('SKU'), Text('PRD-123')]),
                    Divider(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Barcode'), Text('123456789012')]),
                    Divider(),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Supplier'), Text('Supplier A')]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(child: _buildInfoCard('Purchase Price', 'PKR 1000')),
                const SizedBox(width: 10),
                Expanded(child: _buildInfoCard('Selling Price', 'PKR 1500')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildInfoCard('Current Stock', '50')),
                const SizedBox(width: 10),
                Expanded(child: _buildInfoCard('Min Stock', '10')),
              ],
            ),
            const SizedBox(height: 20),
            
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/inventory/stock-in?productId=$productId'),
                    icon: const Icon(Icons.add),
                    label: const Text('Stock In'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/inventory/stock-out?productId=$productId'),
                    icon: const Icon(Icons.remove),
                    label: const Text('Stock Out'),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            const Text('Notes', style: TextStyle(fontWeight: FontWeight.bold)),
            const Text('Sample product notes go here.'),
            
            const SizedBox(height: 20),
            const Text('Stock History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(index == 0 ? Icons.arrow_upward : Icons.arrow_downward, 
                    color: index == 0 ? Colors.green : Colors.red),
                  title: Text(index == 0 ? 'Stock In' : 'Sale'),
                  subtitle: const Text('2023-10-25 14:00'),
                  trailing: Text(index == 0 ? '+10' : '-1', style: const TextStyle(fontWeight: FontWeight.bold)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
