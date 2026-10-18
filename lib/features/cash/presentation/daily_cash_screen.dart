import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DailyCashScreen extends ConsumerStatefulWidget {
  const DailyCashScreen({super.key});

  @override
  ConsumerState<DailyCashScreen> createState() => _DailyCashScreenState();
}

class _DailyCashScreenState extends ConsumerState<DailyCashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Cash'),
        actions: [
          IconButton(icon: const Icon(Icons.calendar_month), onPressed: () {})
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildRow('Opening Balance', 'PKR 10,000'),
                    const Divider(),
                    _buildRow('Cash Sales (+)', 'PKR 5,000', Colors.green),
                    _buildRow('Other Income (+)', 'PKR 0', Colors.green),
                    const Divider(),
                    _buildRow('Purchases (-)', 'PKR 2,000', Colors.red),
                    _buildRow('Supplier Payments (-)', 'PKR 1,000', Colors.red),
                    _buildRow('Expenses (-)', 'PKR 500', Colors.red),
                    const Divider(thickness: 2),
                    _buildRow('Expected Closing', 'PKR 11,500', Colors.blue, true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Cash Entries', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.money),
                  title: const Text('Cash Sale #001'),
                  subtitle: const Text('10:30 AM'),
                  trailing: const Text('+ PKR 1000', style: TextStyle(color: Colors.green)),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => context.push('/cash/close'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text('Close Day'),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, [Color color = Colors.black, bool isBold = false]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
        ],
      ),
    );
  }
}
