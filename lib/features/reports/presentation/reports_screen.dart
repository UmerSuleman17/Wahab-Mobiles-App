import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildReportCard(context, 'Daily Sales', 'View sales trends', Icons.trending_up, Colors.blue, 'sales'),
          _buildReportCard(context, 'Daily Purchases', 'View purchase trends', Icons.shopping_cart, Colors.orange, 'purchases'),
          _buildReportCard(context, 'Expenses', 'Track business costs', Icons.money_off, Colors.red, 'expenses'),
          _buildReportCard(context, 'Cash Flow', 'Inflow vs Outflow', Icons.account_balance_wallet, Colors.green, 'cashflow'),
          _buildReportCard(context, 'Inventory', 'Stock levels & value', Icons.inventory, Colors.purple, 'inventory'),
          _buildReportCard(context, 'Supplier Balances', 'Payables overview', Icons.local_shipping, Colors.teal, 'suppliers'),
          _buildReportCard(context, 'Customer Receivables', 'Receivables overview', Icons.group, Colors.indigo, 'customers'),
          _buildReportCard(context, 'Stock Summary', 'Movement summary', Icons.sync_alt, Colors.brown, 'stock'),
        ],
      ),
    );
  }

  Widget _buildReportCard(BuildContext context, String title, String desc, IconData icon, Color color, String type) {
    return InkWell(
      onTap: () => context.push('/reports/$type'),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center),
              const SizedBox(height: 5),
              Text(desc, style: const TextStyle(fontSize: 10, color: Colors.grey), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
