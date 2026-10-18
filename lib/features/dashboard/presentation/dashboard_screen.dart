import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_tokens.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final greeting = now.hour < 12
        ? 'Good morning'
        : now.hour < 17
            ? 'Good afternoon'
            : 'Good evening';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                AppTokens.space4,
                AppTokens.space4,
                AppTokens.space4,
                AppTokens.space8 + 88,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DashboardHeader(
                        greeting: greeting,
                        date: MaterialLocalizations.of(context)
                            .formatMediumDate(now),
                      ),
                      const SizedBox(height: AppTokens.space6),
                      const _FinancialOverviewCard(),
                      const SizedBox(height: AppTokens.space6),
                      const _DashboardSectionHeading(
                        title: 'Quick actions',
                        subtitle: 'The things you do most, one tap away',
                      ),
                      const SizedBox(height: AppTokens.space3),
                      LayoutBuilder(
                        builder: (context, actionConstraints) {
                          const gap = AppTokens.space3;
                          final width = (actionConstraints.maxWidth - gap) / 2;
                          return Wrap(
                            spacing: gap,
                            runSpacing: gap,
                            children: [
                              for (final action in _dashboardActions)
                                SizedBox(
                                  width: width,
                                  child: _DashboardActionTile(action: action),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppTokens.space6),
                      _DashboardSectionHeading(
                        title: 'Stock snapshot',
                        actionLabel: 'View inventory',
                        onAction: () => context.go('/inventory'),
                      ),
                      const SizedBox(height: AppTokens.space3),
                      LayoutBuilder(
                        builder: (context, metricConstraints) {
                          const gap = AppTokens.space3;
                          final width = (metricConstraints.maxWidth - gap) / 2;
                          return Wrap(
                            spacing: gap,
                            runSpacing: gap,
                            children: [
                              for (final metric in _stockMetrics)
                                SizedBox(
                                  width: width,
                                  child: _StockMetricTile(metric: metric),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: AppTokens.space6),
                      _DashboardSectionHeading(
                        title: 'Recent activity',
                        actionLabel: 'Transactions',
                        onAction: () => context.go('/transactions'),
                      ),
                      const SizedBox(height: AppTokens.space3),
                      const _RecentActivityEmptyState(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.greeting, required this.date});

  final String greeting;
  final String date;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: AppTokens.space1),
              Text(
                date,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 48,
              height: 48,
              child: IconButton(
                tooltip: 'Scan barcode',
                onPressed: () => context.push('/scanner'),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.primaryNavy,
                  side: const BorderSide(color: AppColors.lightGray),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                  ),
                  padding: EdgeInsets.zero,
                ),
                icon: const Icon(Icons.qr_code_scanner),
              ),
            ),
            const SizedBox(width: AppTokens.space2),
            Semantics(
              label: 'Business workspace',
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                  border: Border.all(color: AppColors.lightGray),
                ),
                child: const Icon(
                  Icons.storefront_outlined,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _FinancialOverviewCard extends StatelessWidget {
  const _FinancialOverviewCard();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTokens.space6),
      decoration: BoxDecoration(
        color: AppColors.primaryNavy,
        borderRadius: BorderRadius.circular(AppTokens.radiusExtraLarge),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppTokens.space2,
            runSpacing: AppTokens.space2,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                'TODAY AT A GLANCE',
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.white.withOpacity(0.72),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTokens.space2,
                  vertical: AppTokens.space1,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTokens.radiusPill),
                  border: Border.all(color: AppColors.white.withOpacity(0.16)),
                ),
                child: Text(
                  'Preview data',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTokens.space6),
          Text(
            '—',
            semanticsLabel: 'Sales today unavailable',
            style: textTheme.displaySmall?.copyWith(
              color: AppColors.white,
              fontSize: 40,
              height: 1.05,
            ),
          ),
          const SizedBox(height: AppTokens.space1),
          Text(
            'Sales today',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withOpacity(0.78),
            ),
          ),
          const SizedBox(height: AppTokens.space4),
          Divider(color: AppColors.white.withOpacity(0.16), height: 1),
          const SizedBox(height: AppTokens.space4),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = AppTokens.space2;
              final width = (constraints.maxWidth - (gap * 2)) / 3;
              return Wrap(
                spacing: gap,
                runSpacing: AppTokens.space2,
                children: [
                  for (final metric in _financialMetrics)
                    SizedBox(
                      width: width,
                      child: _HeroMetric(metric: metric),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: AppTokens.space4),
          Text(
            'Live totals are not connected yet.',
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.white.withOpacity(0.65),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.metric});

  final _MetricData metric;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '—',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: AppTokens.space1),
        Text(
          metric.label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.white.withOpacity(0.7),
              ),
        ),
      ],
    );
  }
}

class _DashboardSectionHeading extends StatelessWidget {
  const _DashboardSectionHeading({
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (subtitle != null) ...[
          const SizedBox(height: AppTokens.space1),
          Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    );

    if (actionLabel == null || onAction == null) return heading;

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: AppTokens.space1,
      children: [
        heading,
        TextButton(
          onPressed: onAction,
          style: TextButton.styleFrom(
            minimumSize: const Size(48, AppTokens.minimumTapTarget),
            padding: const EdgeInsets.symmetric(horizontal: AppTokens.space2),
          ),
          child: Text(actionLabel!),
        ),
      ],
    );
  }
}

class _DashboardActionTile extends StatelessWidget {
  const _DashboardActionTile({required this.action});

  final _DashboardAction action;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: action.label,
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        child: InkWell(
          onTap: () => context.push(action.route),
          borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
          child: Container(
            constraints: const BoxConstraints(minHeight: 76),
            padding: const EdgeInsets.all(AppTokens.space3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
              border: Border.all(color: AppColors.lightGray),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: action.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                  ),
                  child: Icon(action.icon, color: action.color, size: 22),
                ),
                const SizedBox(width: AppTokens.space2),
                Expanded(
                  child: Text(
                    action.label,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontSize: 13,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StockMetricTile extends StatelessWidget {
  const _StockMetricTile({required this.metric});

  final _MetricData metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 82),
      padding: const EdgeInsets.all(AppTokens.space3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: metric.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
            ),
            child: Icon(metric.icon, size: 20, color: metric.color),
          ),
          const SizedBox(width: AppTokens.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '—',
                  key: metric.key,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: metric.color,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Text(
                  metric.label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentActivityEmptyState extends StatelessWidget {
  const _RecentActivityEmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppTokens.space4),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
            ),
            child: const Icon(Icons.history, color: AppColors.mediumGray),
          ),
          const SizedBox(width: AppTokens.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No recent activity yet',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: AppTokens.space1),
                Text(
                  'Transaction history will appear here when live business data is connected.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardAction {
  const _DashboardAction({
    required this.label,
    required this.icon,
    required this.route,
    required this.color,
  });

  final String label;
  final IconData icon;
  final String route;
  final Color color;
}

class _MetricData {
  const _MetricData({
    required this.label,
    required this.icon,
    required this.color,
    this.key,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Key? key;
}

const _dashboardActions = [
  _DashboardAction(
    label: 'New sale',
    icon: Icons.point_of_sale_outlined,
    route: '/sales/create',
    color: AppColors.primaryBlue,
  ),
  _DashboardAction(
    label: 'Purchase',
    icon: Icons.shopping_bag_outlined,
    route: '/purchases/create',
    color: AppColors.accentTeal,
  ),
  _DashboardAction(
    label: 'Add product',
    icon: Icons.add_box_outlined,
    route: '/products/add',
    color: AppColors.primaryBlue,
  ),
  _DashboardAction(
    label: 'Stock in',
    icon: Icons.move_to_inbox_outlined,
    route: '/stock-in',
    color: AppColors.success,
  ),
  _DashboardAction(
    label: 'Stock out',
    icon: Icons.outbox_outlined,
    route: '/stock-out',
    color: AppColors.warning,
  ),
  _DashboardAction(
    label: 'Expense',
    icon: Icons.receipt_long_outlined,
    route: '/expenses/add',
    color: AppColors.error,
  ),
];

const _financialMetrics = [
  _MetricData(
    label: 'Cash balance',
    icon: Icons.account_balance_wallet_outlined,
    color: AppColors.white,
  ),
  _MetricData(
    label: 'Receivables',
    icon: Icons.call_received_outlined,
    color: AppColors.white,
  ),
  _MetricData(
    label: 'Supplier due',
    icon: Icons.payments_outlined,
    color: AppColors.white,
  ),
];

const _stockMetrics = [
  _MetricData(
    label: 'Products',
    icon: Icons.inventory_2_outlined,
    color: AppColors.primaryBlue,
  ),
  _MetricData(
    label: 'Units on hand',
    icon: Icons.warehouse_outlined,
    color: AppColors.accentTeal,
  ),
  _MetricData(
    label: 'Low stock',
    icon: Icons.warning_amber_rounded,
    color: AppColors.warning,
    key: ValueKey('low-stock-value'),
  ),
  _MetricData(
    label: 'Out of stock',
    icon: Icons.remove_shopping_cart_outlined,
    color: AppColors.error,
  ),
];
