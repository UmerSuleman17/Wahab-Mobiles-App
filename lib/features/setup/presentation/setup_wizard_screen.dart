import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/theme/app_colors.dart';

class SetupWizardScreen extends ConsumerStatefulWidget {
  const SetupWizardScreen({super.key});

  @override
  ConsumerState<SetupWizardScreen> createState() => _SetupWizardScreenState();
}

class _SetupWizardScreenState extends ConsumerState<SetupWizardScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  // Form keys and controllers
  final _businessFormKey = GlobalKey<FormState>();
  final _businessNameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _currencyCtrl = TextEditingController(text: 'PKR');
  final _cashBalanceCtrl = TextEditingController(text: '0.0');
  final _pinCtrl = TextEditingController();
  final _confirmPinCtrl = TextEditingController();

  void _nextStep() {
    if (_currentStep == 1 && !_businessFormKey.currentState!.validate()) return;
    if (_currentStep == 4) {
      if (_pinCtrl.text.length < 4 || _pinCtrl.text != _confirmPinCtrl.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid PIN or mismatch')),
        );
        return;
      }
    }

    if (_currentStep < 5) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeSetup();
    }
  }

  void _completeSetup() {
    // In a real app, call repository providers here
    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Business'),
        actions: [
          TextButton(
            onPressed: () => context.go('/dashboard'),
            child: const Text('Skip'),
          )
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(value: (_currentStep + 1) / 6),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (idx) => setState(() => _currentStep = idx),
              children: [
                _buildStep0(),
                _buildStep1(),
                _buildStep2(),
                _buildStep3(),
                _buildStep4(),
                _buildStep5(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentStep > 0)
                  TextButton(
                    onPressed: () => _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut),
                    child: const Text('Back'),
                  )
                else
                  const SizedBox.shrink(),
                ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(_currentStep == 5 ? 'Done' : 'Next'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStep0() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.store, size: 80, color: AppColors.primaryBlue),
            const SizedBox(height: 20),
            const Text('Let\'s set up your business',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget _buildStep1() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _businessFormKey,
          child: Column(
            children: [
              const Text('Business Information', style: TextStyle(fontSize: 20)),
              TextFormField(
                controller: _businessNameCtrl,
                decoration: const InputDecoration(labelText: 'Business Name *'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _addressCtrl,
                decoration: const InputDecoration(labelText: 'Address'),
              ),
            ],
          ),
        ),
      );

  Widget _buildStep2() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Currency Settings', style: TextStyle(fontSize: 20)),
            TextFormField(
              controller: _currencyCtrl,
              decoration: const InputDecoration(labelText: 'Default Currency'),
            ),
          ],
        ),
      );

  Widget _buildStep3() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Opening Cash Balance', style: TextStyle(fontSize: 20)),
            TextFormField(
              controller: _cashBalanceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Initial Cash in Drawer'),
            ),
          ],
        ),
      );

  Widget _buildStep4() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Create Admin PIN', style: TextStyle(fontSize: 20)),
            TextFormField(
              controller: _pinCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '4-6 Digit PIN'),
            ),
            TextFormField(
              controller: _confirmPinCtrl,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Confirm PIN'),
            ),
          ],
        ),
      );

  Widget _buildStep5() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text('You\'re all set!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      );
}
