import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomerDetailScreen extends ConsumerWidget {
  final String customerId;
  const CustomerDetailScreen({super.key, required this.customerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTile(
              leading: CircleAvatar(radius: 30, child: Icon(Icons.person, size: 30)),
              title: Text('Customer Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              subtitle: Text('0300-1234567\ncustomer@example.com'),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildStatCard('Outstanding Balance', 'PKR 5000', Colors.red)),
                const SizedBox(width: 10),
                Expanded(child: _buildStatCard('Total Sales', 'PKR 15000', Colors.green)),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => context.push('/customers/payment/$customerId'),
                    icon: const Icon(Icons.payment),
                    label: const Text('Record Payment'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {}, // Send WhatsApp reminder
                    icon: const Icon(Icons.message),
                    label: const Text('Send Reminder'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Credit Sales', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => ListTile(
                title: const Text('Invoice #001'),
                subtitle: const Text('2023-10-20'),
                trailing: const Text('PKR 2500'),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Payment History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Payment Received'),
                subtitle: const Text('2023-10-22'),
                trailing: const Text('PKR 1000'),
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
