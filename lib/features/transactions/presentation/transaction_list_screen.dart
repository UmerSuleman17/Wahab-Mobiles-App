import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TransactionListScreen extends ConsumerWidget {
  const TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(child: SearchBar(leading: Icon(Icons.search), hintText: 'Search...')),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.filter_alt), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final isCredit = index % 2 == 0;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isCredit ? Colors.green.shade100 : Colors.red.shade100,
                    child: Icon(isCredit ? Icons.arrow_downward : Icons.arrow_upward, 
                      color: isCredit ? Colors.green : Colors.red),
                  ),
                  title: Text(isCredit ? 'Cash Sale' : 'Expense'),
                  subtitle: const Text('2023-10-25 14:30'),
                  trailing: Text(
                    '${isCredit ? "+" : "-"} PKR 1500', 
                    style: TextStyle(fontWeight: FontWeight.bold, color: isCredit ? Colors.green : Colors.red)
                  ),
                  onTap: () => context.push('/transactions/$index'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
