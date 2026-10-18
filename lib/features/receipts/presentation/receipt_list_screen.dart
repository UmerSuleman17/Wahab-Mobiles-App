import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReceiptListScreen extends ConsumerWidget {
  const ReceiptListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Receipts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: SearchBar(
                    leading: Icon(Icons.search),
                    hintText: 'Search receipt number...',
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.receipt_long),
                  title: Text('Receipt #00$index'),
                  subtitle: const Text('2023-10-25 14:30'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('PKR 1500', style: TextStyle(fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text('Sale', style: TextStyle(fontSize: 10, color: Colors.blue)),
                      )
                    ],
                  ),
                  onTap: () => context.push('/receipts/$index'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
