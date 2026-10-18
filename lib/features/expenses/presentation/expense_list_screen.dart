import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/widgets/summary_card.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SummaryCard(
              title: 'Total Expenses (This Month)',
              value: 'PKR 15,000',
              icon: Icons.money_off,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(Icons.receipt, color: Colors.white),
                  ),
                  title: const Text('Electricity Bill'),
                  subtitle: const Text('Utilities • 2023-10-25'),
                  trailing: const Text('PKR 5000', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/expenses/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
