import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/database/app_database.dart';
import 'package:wm_app/core/providers/repository_providers.dart';
import 'package:wm_app/data/repositories/auth_repository.dart';
import 'package:wm_app/data/repositories/business_repository.dart';
import 'package:wm_app/features/splash/presentation/splash_screen.dart';

void main() {
  testWidgets('storage initialization failure shows retry instead of setup',
      (tester) async {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
        GoRoute(
          path: '/setup',
          builder: (_, __) => const Scaffold(body: Text('Setup destination')),
        ),
        GoRoute(
          path: '/login',
          builder: (_, __) => const Scaffold(body: Text('Login destination')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          businessRepositoryProvider.overrideWithValue(
            _FailingBusinessRepository(),
          ),
          authRepositoryProvider.overrideWithValue(_UnusedAuthRepository()),
        ],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('Local business storage is unavailable'), findsOneWidget);
    expect(find.text('Setup destination'), findsNothing);
    expect(find.text('Retry'), findsOneWidget);

    await tester.tap(find.text('Retry'));
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();

    expect(find.text('Local business storage is unavailable'), findsOneWidget);
    expect(find.text('Setup destination'), findsNothing);
  });
}

class _FailingBusinessRepository extends BusinessRepository {
  _FailingBusinessRepository() : super(_UnusedDatabase());

  @override
  Future<bool> isSetupComplete() =>
      Future<bool>.error(StateError('local storage unavailable'));
}

class _UnusedAuthRepository extends AuthRepository {
  _UnusedAuthRepository() : super(_UnusedDatabase());
}

class _UnusedDatabase implements AppDatabase {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
