import 'package:flutter/material.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_tokens.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.onTap,
    this.subtitle,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final VoidCallback? onTap;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primaryBlue;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxWidth < 160;
        final padding = isCompact ? AppTokens.space2 : AppTokens.space3;
        final sectionGap = isCompact ? AppTokens.space1 : AppTokens.space2;

        return Card(
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppTokens.radiusLarge),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          isCompact ? AppTokens.space1 : AppTokens.space2,
                        ),
                        decoration: BoxDecoration(
                          color: cardColor.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(AppTokens.radiusSmall),
                        ),
                        child: Icon(
                          icon,
                          color: cardColor,
                          size: isCompact ? 16 : 20,
                        ),
                      ),
                      const Spacer(),
                      if (onTap != null)
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: AppColors.textHint,
                        ),
                    ],
                  ),
                  SizedBox(height: sectionGap),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                  ),
                  const SizedBox(height: AppTokens.space1),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: AppTokens.space1),
                    Text(
                      subtitle!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
