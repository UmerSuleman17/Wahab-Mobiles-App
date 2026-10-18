import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CashCloseScreen extends ConsumerStatefulWidget {
  const CashCloseScreen({super.key});

  @override
  ConsumerState<CashCloseScreen> createState() => _CashCloseScreenState();
}

class _CashCloseScreenState extends ConsumerState<CashCloseScreen> {
  final _actualAmountCtrl = TextEditingController();
  double _expectedAmount = 11500.0;
  
  @override
  Widget build(BuildContext context) {
    double actualAmount = double.tryParse(_actualAmountCtrl.text) ?? 0.0;
    double difference = actualAmount - _expectedAmount;
    Color diffColor = difference == 0 ? Colors.green : Colors.red;

    return Scaffold(
      appBar: AppBar(title: const Text('Close Day')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text('Expected Closing Balance', style: TextStyle(fontSize: 16)),
                    Text('PKR $_expectedAmount', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _actualAmountCtrl,
              decoration: const InputDecoration(labelText: 'Actual Cash in Drawer *'),
              keyboardType: TextInputType.number,
              onChanged: (val) => setState(() {}),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Difference:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('PKR $difference', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: diffColor)),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Notes (Reason for difference if any)'),
              maxLines: 2,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Confirm
                  Navigator.pop(context);
                },
                child: const Text('Confirm Cash Close'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
