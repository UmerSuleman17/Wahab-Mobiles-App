import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportDetailScreen extends ConsumerWidget {
  final String reportType;
  const ReportDetailScreen({super.key, required this.reportType});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = reportType.toUpperCase() + ' REPORT';
    
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.date_range),
                    label: const Text('This Month'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(icon: const Icon(Icons.print), onPressed: () {}),
                IconButton(icon: const Icon(Icons.download), onPressed: () {}),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: const [
                          Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('PKR 50,000', style: TextStyle(fontSize: 20, color: Colors.blue)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Amount')),
                ],
                rows: List.generate(
                  5,
                  (index) => DataRow(cells: [
                    const DataCell(Text('2023-10-25')),
                    DataCell(Text('Item $index')),
                    DataCell(Text('PKR 10,000')),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
