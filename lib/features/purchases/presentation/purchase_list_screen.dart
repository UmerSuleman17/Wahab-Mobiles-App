import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PurchaseListScreen extends ConsumerWidget {
  const PurchaseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Purchases')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
            title: const Text('Supplier Name'),
            subtitle: const Text('2023-10-25'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('PKR 5000.00', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: index == 0 ? Colors.orange.shade100 : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(index == 0 ? 'Pending' : 'Paid', 
                    style: TextStyle(fontSize: 10, color: index == 0 ? Colors.orange : Colors.green)),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/purchases/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
