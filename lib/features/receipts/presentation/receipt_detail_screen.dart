import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceiptDetailScreen extends ConsumerWidget {
  final String receiptId;
  const ReceiptDetailScreen({super.key, required this.receiptId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt Preview'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 2, blurRadius: 5),
              ],
            ),
            child: Column(
              children: [
                const Text('WM BUSINESS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text('123 Main Street, City'),
                const Text('Phone: 0300-1234567'),
                const SizedBox(height: 20),
                const Text('RECEIPT', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2)),
                const Divider(thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Receipt #001'),
                    const Text('Date: 25-Oct-2023'),
                  ],
                ),
                const Divider(thickness: 2),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Item', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Qty', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                _buildReceiptLine('Product A', '2', '1000'),
                _buildReceiptLine('Product B', '1', '500'),
                const Divider(thickness: 2),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('PKR 1500', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Payment Method: Cash'),
                const SizedBox(height: 30),
                const Text('Thank you for your business!', style: TextStyle(fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptLine(String item, String qty, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(item)),
          Expanded(flex: 1, child: Text(qty, textAlign: TextAlign.center)),
          Expanded(flex: 1, child: Text(amount, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
