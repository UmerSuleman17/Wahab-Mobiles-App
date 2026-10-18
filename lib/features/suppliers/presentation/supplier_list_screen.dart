import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SupplierListScreen extends ConsumerWidget {
  const SupplierListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Suppliers')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search suppliers...',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final balance = index == 0 ? 10000.0 : 0.0;
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.local_shipping)),
                  title: Text('Supplier Name $index'),
                  subtitle: const Text('0300-9876543'),
                  trailing: Text(
                    'PKR $balance', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: balance > 0 ? Colors.red : Colors.green
                    )
                  ),
                  onTap: () => context.push('/suppliers/$index'),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/suppliers/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
