import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/database/web_storage_policy.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_tokens.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    _ShellDestination(
      path: '/dashboard',
      label: 'Dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
    ),
    _ShellDestination(
      path: '/inventory',
      label: 'Inventory',
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
    ),
    _ShellDestination(
      path: '/transactions',
      label: 'Transactions',
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long,
    ),
    _ShellDestination(
      path: '/cash',
      label: 'Cash',
      icon: Icons.account_balance_wallet_outlined,
      selectedIcon: Icons.account_balance_wallet,
    ),
    _ShellDestination(
      path: '/more',
      label: 'More',
      icon: Icons.more_horiz,
      selectedIcon: Icons.more_horiz,
    ),
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    for (var i = 0; i < _destinations.length; i++) {
      final path = _destinations[i].path;
      if (location == path || location.startsWith('$path/')) return i;
    }
    return 0;
  }

  void _navigate(BuildContext context, int index, int currentIndex) {
    if (index != currentIndex) {
      context.go(_destinations[index].path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final useNavigationRail =
            constraints.maxWidth >= AppTokens.navigationRailBreakpoint;
        final storageNotice = activeWebStoragePolicy?.notice;
        Widget withStorageNotice(Widget page) => Column(
              children: [
                if (storageNotice != null)
                  Material(
                    color: const Color(0xFFFFF2CC),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTokens.space4,
                          vertical: AppTokens.space2,
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.info_outline, size: 18),
                            const SizedBox(width: AppTokens.space2),
                            Expanded(child: Text(storageNotice)),
                          ],
                        ),
                      ),
                    ),
                  ),
                Expanded(child: page),
              ],
            );

        return Scaffold(
          body: useNavigationRail
              ? Row(
                  children: [
                    SafeArea(
                      child: NavigationRail(
                        selectedIndex: currentIndex,
                        onDestinationSelected: (index) =>
                            _navigate(context, index, currentIndex),
                        labelType: NavigationRailLabelType.all,
                        destinations: [
                          for (final destination in _destinations)
                            NavigationRailDestination(
                              icon: Icon(destination.icon),
                              selectedIcon: Icon(destination.selectedIcon),
                              label: Text(destination.label),
                            ),
                        ],
                        leading: Padding(
                          padding: const EdgeInsets.only(
                            top: AppTokens.space4,
                            bottom: AppTokens.space6,
                          ),
                          child: Container(
                            width: AppTokens.minimumTapTarget,
                            height: AppTokens.minimumTapTarget,
                            decoration: BoxDecoration(
                              color: AppColors.primaryNavy,
                              borderRadius: BorderRadius.circular(
                                AppTokens.radiusMedium,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.storefront_outlined,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: AppColors.lightGray,
                    ),
                    Expanded(
                      child: withStorageNotice(
                        Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: AppTokens.contentMaxWidth,
                            ),
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : withStorageNotice(child),
          bottomNavigationBar: useNavigationRail
              ? null
              : NavigationBar(
                  selectedIndex: currentIndex,
                  onDestinationSelected: (index) =>
                      _navigate(context, index, currentIndex),
                  destinations: [
                    for (final destination in _destinations)
                      NavigationDestination(
                        icon: Icon(destination.icon),
                        selectedIcon: Icon(destination.selectedIcon),
                        label: destination.label,
                        tooltip: destination.label,
                      ),
                  ],
                ),
        );
      },
    );
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}
