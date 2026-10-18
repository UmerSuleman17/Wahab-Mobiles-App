import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/providers/repository_providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _storageError = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    try {
      final businessRepo = ref.read(businessRepositoryProvider);
      final authRepo = ref.read(authRepositoryProvider);

      final isSetup = await businessRepo.isSetupComplete();
      if (!isSetup) {
        if (mounted) context.go('/setup');
        return;
      }

      final admin = await authRepo.getAdmin();
      if (admin == null) {
        if (mounted) context.go('/setup');
        return;
      }

      if (mounted) context.go('/login');
    } catch (_) {
      if (mounted) setState(() => _storageError = true);
    }
  }

  void _retryInitialization() {
    setState(() => _storageError = false);
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryNavy,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.business_center,
                size: 72,
                color: AppColors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'WM Business',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your Business, Simplified',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 48),
            if (_storageError) ...[
              const Icon(Icons.storage_rounded,
                  color: AppColors.white, size: 28),
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    Text(
                      'Local business storage is unavailable',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'WM Business needs persistent browser storage. Try a '
                      'regular browser window with site storage enabled. '
                      'Private windows may not retain your data.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _retryInitialization,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
              ),
            ] else
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(AppColors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
