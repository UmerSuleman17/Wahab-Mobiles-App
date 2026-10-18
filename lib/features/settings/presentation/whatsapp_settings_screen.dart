import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WhatsappSettingsScreen extends ConsumerStatefulWidget {
  const WhatsappSettingsScreen({super.key});

  @override
  ConsumerState<WhatsappSettingsScreen> createState() => _WhatsappSettingsScreenState();
}

class _WhatsappSettingsScreenState extends ConsumerState<WhatsappSettingsScreen> {
  bool _isEnabled = true;
  final _templateCtrl = TextEditingController(text: 'Dear [Customer Name], your payment of [Amount] is due on [Date]. Please arrange payment. Thank you.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhatsApp Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Enable Automated Reminders'),
              subtitle: const Text('Send payment reminders for credit sales'),
              value: _isEnabled,
              onChanged: (val) => setState(() => _isEnabled = val),
            ),
            const Divider(),
            if (_isEnabled) ...[
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Send Reminder Before Due Date'),
                value: '24',
                items: const [
                  DropdownMenuItem(value: '12', child: Text('12 Hours')),
                  DropdownMenuItem(value: '24', child: Text('24 Hours')),
                  DropdownMenuItem(value: '48', child: Text('48 Hours')),
                  DropdownMenuItem(value: '72', child: Text('72 Hours')),
                ],
                onChanged: (val) {},
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _templateCtrl,
                decoration: const InputDecoration(
                  labelText: 'Message Template',
                  helperText: 'Available tags: [Customer Name], [Amount], [Date], [Invoice No]',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.send),
                  label: const Text('Send Test Message'),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Save Settings'),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
