import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_tokens.dart';
import 'package:wm_app/core/widgets/shared_widgets.dart';

class InventoryScreen extends ConsumerWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Inventory'),
        actions: [
          IconButton(
            tooltip: 'Scan product',
            onPressed: () => context.push('/scanner'),
            icon: const Icon(Icons.qr_code_scanner),
          ),
          IconButton(
            tooltip: 'Add product',
            onPressed: () => context.push('/products/add'),
            icon: const Icon(Icons.add_rounded),
          ),
          const SizedBox(width: AppTokens.space2),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.space4,
              AppTokens.space4,
              AppTokens.space4,
              AppTokens.space3,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PreviewDataBanner(
                    description:
                        'Example counts and products only. Inventory is not connected to saved business data.',
                  ),
                  const SizedBox(height: AppTokens.space6),
                  Text(
                    'Stock overview',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTokens.space3),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const gap = AppTokens.space3;
                      final tileWidth = (constraints.maxWidth - gap) / 2;
                      const overview = [
                        _InventoryMetric('150', 'Products',
                            Icons.inventory_2_outlined, AppColors.primaryBlue),
                        _InventoryMetric('2,300', 'Units on hand',
                            Icons.warehouse_outlined, AppColors.accentTeal),
                        _InventoryMetric('12', 'Low stock',
                            Icons.warning_amber_rounded, AppColors.warning),
                        _InventoryMetric(
                            '3',
                            'Out of stock',
                            Icons.remove_shopping_cart_outlined,
                            AppColors.error),
                      ];

                      return Wrap(
                        spacing: gap,
                        runSpacing: gap,
                        children: [
                          for (final metric in overview)
                            SizedBox(
                              width: tileWidth,
                              child: _InventoryMetricTile(metric: metric),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: AppTokens.space6),
                  Text(
                    'Products',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTokens.space3),
                  SearchBar(
                    leading: const Icon(Icons.search_rounded),
                    hintText: 'Search preview products',
                    elevation: const WidgetStatePropertyAll(0),
                    backgroundColor:
                        const WidgetStatePropertyAll(AppColors.surface),
                    side: const WidgetStatePropertyAll(
                      BorderSide(color: AppColors.lightGray),
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTokens.radiusMedium),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppTokens.space3),
                  const SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Chip(label: Text('All')),
                        SizedBox(width: AppTokens.space2),
                        Chip(label: Text('Low stock')),
                        SizedBox(width: AppTokens.space2),
                        Chip(label: Text('Out of stock')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.space4,
              0,
              AppTokens.space4,
              AppTokens.space8,
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppTokens.space2),
                  child: _InventoryProductTile(index: index),
                ),
                childCount: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryMetricTile extends StatelessWidget {
  const _InventoryMetricTile({required this.metric});

  final _InventoryMetric metric;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 86),
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
          const SizedBox(width: AppTokens.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  metric.value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: metric.color,
                    fontWeight: FontWeight.w700,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
                Text(metric.label,
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InventoryProductTile extends StatelessWidget {
  const _InventoryProductTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.push('/products/$index'),
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space3),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.infoLight,
                  borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: AppTokens.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product ${index + 1}',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTokens.space1),
                    Text(
                      'SKU: PRD-123',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTokens.space2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '50',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  Text('units', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(width: AppTokens.space1),
              const Icon(Icons.chevron_right, color: AppColors.mediumGray),
            ],
          ),
        ),
      ),
    );
  }
}

class _InventoryMetric {
  const _InventoryMetric(this.value, this.label, this.icon, this.color);

  final String value;
  final String label;
  final IconData icon;
  final Color color;
}
