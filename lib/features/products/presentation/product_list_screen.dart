import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_tokens.dart';
import 'package:wm_app/core/widgets/shared_widgets.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            tooltip: 'Add product',
            onPressed: () => context.push('/products/add'),
            icon: const Icon(Icons.add_rounded),
          ),
          const SizedBox(width: AppTokens.space2),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(
              AppTokens.space4,
              AppTokens.space4,
              AppTokens.space4,
              AppTokens.space3,
            ),
            child: PreviewDataBanner(
              description:
                  'Example products only. Changes on this screen are not saved to the business database.',
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTokens.space4,
              0,
              AppTokens.space4,
              AppTokens.space3,
            ),
            child: SearchBar(
              leading: const Icon(Icons.search_rounded),
              hintText: 'Search preview products',
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: const WidgetStatePropertyAll(AppColors.surface),
              side: const WidgetStatePropertyAll(
                BorderSide(color: AppColors.lightGray),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppTokens.space4,
                0,
                AppTokens.space4,
                AppTokens.space8,
              ),
              itemCount: 5,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppTokens.space2),
              itemBuilder: (context, index) =>
                  _ProductPreviewTile(index: index),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductPreviewTile extends StatelessWidget {
  const _ProductPreviewTile({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = index == 0;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => context.push('/products/$index'),
        borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      'Product Name ${index + 1}',
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTokens.space1),
                    Text(
                      'SKU: PRD-00$index',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppTokens.space2),
                    StatusChip(
                      label: isOutOfStock ? 'Out of stock' : 'In stock',
                      color: isOutOfStock ? AppColors.error : AppColors.success,
                    ),
                    const SizedBox(height: AppTokens.space3),
                    Wrap(
                      spacing: AppTokens.space6,
                      runSpacing: AppTokens.space2,
                      children: [
                        _ProductMeta(
                          label: 'Stock',
                          value: '${10 * index} units',
                        ),
                        const _ProductMeta(
                          label: 'Selling price',
                          value: 'PKR —',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.mediumGray),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductMeta extends StatelessWidget {
  const _ProductMeta({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: AppColors.textPrimary,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
