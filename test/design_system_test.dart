import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/routing/app_router.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_theme.dart';
import 'package:wm_app/core/widgets/app_scaffold.dart';
import 'package:wm_app/core/widgets/summary_card.dart';
import 'package:wm_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:wm_app/features/inventory/presentation/inventory_screen.dart';
import 'package:wm_app/features/products/presentation/product_list_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('app design foundation', () {
    test('uses the approved accessible brand palette with Material 3', () {
      final theme = AppTheme.lightTheme;

      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.primary, const Color(0xFF2563EB));
      expect(theme.scaffoldBackgroundColor, const Color(0xFFF6F8FC));
      expect(theme.appBarTheme.shape, isA<Border>());
      expect(AppColors.primaryNavy, const Color(0xFF0B1220));
      expect(AppColors.success, const Color(0xFF059669));
    });

    testWidgets('keeps financial amounts readable with colored accents', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: SummaryCard(
              title: 'Sales',
              value: 'PKR 42',
              icon: Icons.trending_up,
              color: Colors.green,
            ),
          ),
        ),
      );

      final amount = tester.widget<Text>(find.text('PKR 42'));
      expect(amount.style?.color, AppColors.textPrimary);
    });

    testWidgets('does not scale compact amounts below system text size', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const MediaQuery(
            data: MediaQueryData(textScaler: TextScaler.linear(2)),
            child: Scaffold(
              body: Center(
                child: SizedBox(
                  width: 140,
                  height: 310,
                  child: SummaryCard(
                    title: 'Balance',
                    value: 'PKR 42',
                    icon: Icons.account_balance_wallet,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(
        find.ancestor(
          of: find.text('PKR 42'),
          matching: find.byType(FittedBox),
        ),
        findsNothing,
      );
    });

    testWidgets('dashboard content has no layout overflow at target widths', (
      tester,
    ) async {
      for (final size in [
        const Size(390, 844),
        const Size(320, 700),
        const Size(1024, 900),
      ]) {
        _setViewport(tester, size);
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.lightTheme,
              home: const DashboardScreen(),
            ),
          ),
        );

        expect(tester.takeException(), isNull, reason: 'at $size');
      }
    });

    testWidgets('dashboard content has no overflow with enlarged text', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const MediaQuery(
              data: MediaQueryData(textScaler: TextScaler.linear(2)),
              child: DashboardScreen(),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('dashboard labels disconnected data and avoids fake totals', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const DashboardScreen(),
          ),
        ),
      );

      expect(find.text('Preview data'), findsOneWidget);
      expect(find.text('PKR 0'), findsNothing);
      expect(find.textContaining('Activity Item'), findsNothing);
      expect(find.text('No recent activity yet'), findsOneWidget);
    });

    testWidgets('dashboard quick actions navigate to registered routes', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      const actionRoutes = {
        'New sale': '/sales/create',
        'Purchase': '/purchases/create',
        'Add product': '/products/add',
        'Stock in': '/stock-in',
        'Stock out': '/stock-out',
        'Expense': '/expenses/add',
      };
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final productionRouter = container.read(appRouterProvider);
      addTearDown(productionRouter.dispose);
      for (final path in actionRoutes.values) {
        expect(
          productionRouter.configuration.findMatch(Uri.parse(path)).isError,
          isFalse,
          reason: '$path must remain registered in production',
        );
      }

      final router = GoRouter(
        initialLocation: '/dashboard',
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          for (final path in actionRoutes.values)
            GoRoute(
              path: path,
              builder: (context, state) => Scaffold(
                body: Center(child: Text(state.matchedLocation)),
              ),
            ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(theme: AppTheme.lightTheme, routerConfig: router),
      );
      await tester.pumpAndSettle();

      for (final action in actionRoutes.entries) {
        await tester.tap(find.text(action.key));
        await tester.pumpAndSettle();
        expect(_currentPath(router), action.value);
        router.go('/dashboard');
        await tester.pumpAndSettle();
      }
    });

    testWidgets('dashboard scanner action navigates from the header', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final productionRouter = container.read(appRouterProvider);
      addTearDown(productionRouter.dispose);
      expect(
        productionRouter.configuration.findMatch(Uri.parse('/scanner')).isError,
        isFalse,
      );

      final router = GoRouter(
        initialLocation: '/dashboard',
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/scanner',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('/scanner')),
            ),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(theme: AppTheme.lightTheme, routerConfig: router),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byTooltip('Scan barcode'));
      await tester.pumpAndSettle();

      expect(_currentPath(router), '/scanner');
    });

    testWidgets('inventory and products identify illustrative rows as preview',
        (
      tester,
    ) async {
      for (final size in [
        const Size(390, 844),
        const Size(320, 700),
        const Size(1024, 900),
      ]) {
        for (final screen in const [InventoryScreen(), ProductListScreen()]) {
          _setViewport(tester, size);
          await tester.pumpWidget(
            ProviderScope(
              child: MaterialApp(
                theme: AppTheme.lightTheme,
                home: screen,
              ),
            ),
          );

          expect(find.text('Preview data'), findsOneWidget, reason: '$size');
          expect(tester.takeException(), isNull, reason: '$size');
        }
      }

      for (final screen in const [InventoryScreen(), ProductListScreen()]) {
        _setViewport(tester, const Size(390, 844));
        await tester.pumpWidget(
          ProviderScope(
            child: MaterialApp(
              theme: AppTheme.lightTheme,
              home: MediaQuery(
                data: const MediaQueryData(textScaler: TextScaler.linear(2)),
                child: screen,
              ),
            ),
          ),
        );

        expect(tester.takeException(), isNull, reason: 'with 2x text');
      }
    });

    testWidgets('inventory exposes a labeled scanner action', (tester) async {
      _setViewport(tester, const Size(390, 844));
      final router = GoRouter(
        initialLocation: '/inventory',
        routes: [
          ShellRoute(
            builder: (context, state, child) => AppScaffold(child: child),
            routes: [
              GoRoute(
                path: '/inventory',
                builder: (context, state) => const InventoryScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/scanner',
            builder: (context, state) => const Scaffold(),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(theme: AppTheme.lightTheme, routerConfig: router),
      );
      await tester.pumpAndSettle();
      expect(find.byTooltip('Scan product'), findsOneWidget);
      await tester.tap(find.byTooltip('Scan product'));
      await tester.pumpAndSettle();
      expect(_currentPath(router), '/scanner');
    });

    testWidgets('product add action is in the app bar, not over the list', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      final router = GoRouter(
        initialLocation: '/products',
        routes: [
          GoRoute(
            path: '/products',
            builder: (context, state) => const ProductListScreen(),
          ),
          GoRoute(
            path: '/products/:id',
            builder: (context, state) => const Scaffold(),
          ),
          GoRoute(
            path: '/products/add',
            builder: (context, state) => const Scaffold(),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        MaterialApp.router(theme: AppTheme.lightTheme, routerConfig: router),
      );
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsNothing);
      await tester.tap(find.byTooltip('Add product'));
      await tester.pumpAndSettle();
      expect(_currentPath(router), '/products/add');
    });

    testWidgets('low-stock placeholder uses the readable warning color', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const DashboardScreen(),
          ),
        ),
      );

      final count = tester.widget<Text>(find.byKey(
        const ValueKey('low-stock-value'),
      ));
      expect(count.data, '—');
      expect(count.style?.color, AppColors.warning);
    });

    testWidgets('uses bottom navigation and production routes on a phone', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final productionRouter = container.read(appRouterProvider);
      addTearDown(productionRouter.dispose);
      final shellPaths = _registeredShellPaths(productionRouter);
      final scannerPath = _registeredScannerPath(productionRouter);
      final router = _createShellHarness(shellPaths, scannerPath);
      addTearDown(router.dispose);

      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.lightTheme,
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);

      final destinations =
          tester.widget<NavigationBar>(find.byType(NavigationBar)).destinations;
      expect(shellPaths, hasLength(destinations.length));
      for (var i = 0; i < destinations.length; i++) {
        final destination = destinations[i] as NavigationDestination;
        await tester.tap(find.byTooltip(destination.tooltip!));
        await tester.pumpAndSettle();
        expect(_currentPath(router), shellPaths[i]);
      }
    });

    testWidgets('uses a navigation rail on a wide layout', (tester) async {
      _setViewport(tester, const Size(1024, 900));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final productionRouter = container.read(appRouterProvider);
      addTearDown(productionRouter.dispose);
      final shellPaths = _registeredShellPaths(productionRouter);
      final scannerPath = _registeredScannerPath(productionRouter);
      final router = _createShellHarness(shellPaths, scannerPath);
      addTearDown(router.dispose);

      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.lightTheme,
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NavigationRail), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(_currentPath(router), shellPaths.first);
    });

    testWidgets('shell navigation keeps the scanner off scrollable content', (
      tester,
    ) async {
      _setViewport(tester, const Size(390, 844));
      final container = ProviderContainer();
      addTearDown(container.dispose);
      final productionRouter = container.read(appRouterProvider);
      addTearDown(productionRouter.dispose);
      final shellPaths = _registeredShellPaths(productionRouter);
      final scannerPath = _registeredScannerPath(productionRouter);
      final router = _createShellHarness(shellPaths, scannerPath);
      addTearDown(router.dispose);

      await tester.pumpWidget(
        MaterialApp.router(
          theme: AppTheme.lightTheme,
          routerConfig: router,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsNothing);
      expect(
          productionRouter.configuration
              .findMatch(Uri.parse(scannerPath))
              .isError,
          isFalse);
    });
  });
}

List<String> _registeredShellPaths(GoRouter router) {
  final shell = router.configuration.routes.whereType<ShellRoute>().single;
  final paths =
      shell.routes.whereType<GoRoute>().map((route) => route.path).toList();
  for (final path in paths) {
    expect(router.configuration.findMatch(Uri.parse(path)).isError, isFalse);
  }
  return paths;
}

String _registeredScannerPath(GoRouter router) {
  final scanner = router.configuration.routes
      .whereType<GoRoute>()
      .singleWhere((route) => route.path == '/scanner');
  expect(
    router.configuration.findMatch(Uri.parse(scanner.path)).isError,
    isFalse,
  );
  return scanner.path;
}

GoRouter _createShellHarness(List<String> shellPaths, String scannerPath) {
  return GoRouter(
    initialLocation: shellPaths.first,
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          for (final path in shellPaths)
            GoRoute(
              path: path,
              builder: (context, state) => _DestinationPage(label: path),
            ),
        ],
      ),
      GoRoute(
        path: scannerPath,
        builder: (context, state) => const _DestinationPage(label: 'Scanner'),
      ),
    ],
  );
}

String _currentPath(GoRouter router) =>
    router.routerDelegate.currentConfiguration.last.matchedLocation;

void _setViewport(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}

class _DestinationPage extends StatelessWidget {
  const _DestinationPage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(child: Text('$label page')),
      );
}
