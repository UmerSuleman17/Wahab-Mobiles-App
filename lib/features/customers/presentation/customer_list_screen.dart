import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomerListScreen extends ConsumerWidget {
  const CustomerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SearchBar(
              leading: Icon(Icons.search),
              hintText: 'Search customers...',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final balance = index == 0 ? 5000.0 : 0.0;
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Customer Name $index'),
                  subtitle: const Text('0300-1234567'),
                  trailing: Text(
                    'PKR $balance', 
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      color: balance > 0 ? Colors.red : Colors.green
                    )
                  ),
                  onTap: () => context.push('/customers/$index'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
