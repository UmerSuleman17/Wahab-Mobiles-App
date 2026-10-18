import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionDetailScreen extends ConsumerWidget {
  final String transactionId;
  const TransactionDetailScreen({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Column(
                children: [
                  Icon(Icons.check_circle, size: 60, color: Colors.green),
                  SizedBox(height: 10),
                  Text('PKR 1500.00', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  Text('Cash Sale', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Divider(),
            _buildDetailRow('Date', '25-Oct-2023 14:30'),
            _buildDetailRow('Transaction ID', transactionId),
            _buildDetailRow('Payment Method', 'Cash'),
            _buildDetailRow('Status', 'Completed'),
            const Divider(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.receipt_long),
                label: const Text('View Related Record'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
