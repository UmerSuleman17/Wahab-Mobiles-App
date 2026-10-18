import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SaleListScreen extends ConsumerWidget {
  const SaleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sales')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final isCredit = index % 2 == 0;
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isCredit ? Colors.orange.shade100 : Colors.green.shade100,
              child: Icon(isCredit ? Icons.schedule : Icons.check_circle, color: isCredit ? Colors.orange : Colors.green),
            ),
            title: Text(isCredit ? 'Credit Sale' : 'Cash Sale'),
            subtitle: const Text('2023-10-25 14:30'),
            trailing: const Text('PKR 1500.00', style: TextStyle(fontWeight: FontWeight.bold)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.point_of_sale),
                  title: const Text('Cash Sale'),
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/sales/create');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: const Text('Credit Sale'),
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/sales/create-credit');
                  },
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
