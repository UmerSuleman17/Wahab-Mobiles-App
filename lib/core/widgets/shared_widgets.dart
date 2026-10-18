import 'package:flutter/material.dart';
import 'package:wm_app/core/theme/app_colors.dart';
import 'package:wm_app/core/theme/app_tokens.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTokens.space8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: AppColors.infoLight,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Icon(icon, size: 32, color: AppColors.primaryBlue),
            ),
            const SizedBox(height: AppTokens.space4),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: AppTokens.space2),
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppTokens.space6),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PreviewDataBanner extends StatelessWidget {
  const PreviewDataBanner({
    super.key,
    this.description =
        'Examples only. This screen is not connected to saved business data.',
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTokens.space3),
      decoration: BoxDecoration(
        color: AppColors.infoLight,
        borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.16)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.visibility_outlined,
            size: 20,
            color: AppColors.primaryBlue,
          ),
          const SizedBox(width: AppTokens.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Preview data',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.primaryNavy,
                      ),
                ),
                const SizedBox(height: AppTokens.space1),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.darkGray,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            semanticsLabel: message ?? 'Loading',
            strokeWidth: 2.5,
            color: Theme.of(context).colorScheme.primary,
          ),
          if (message != null) ...[
            const SizedBox(height: AppTokens.space4),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.message,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.error_outline,
                  size: 32,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: AppTokens.space4),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppTokens.space6),
                OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(cancelLabel),
        ),
        ElevatedButton(
          style: isDestructive
              ? ElevatedButton.styleFrom(
                  backgroundColor: AppColors.error,
                  foregroundColor: Theme.of(context).colorScheme.onError,
                )
              : null,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}

class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  factory StatusChip.inStock() =>
      const StatusChip(label: 'In Stock', color: AppColors.success);

  factory StatusChip.lowStock() =>
      const StatusChip(label: 'Low Stock', color: AppColors.warning);

  factory StatusChip.outOfStock() =>
      const StatusChip(label: 'Out of Stock', color: AppColors.error);

  factory StatusChip.paid() =>
      const StatusChip(label: 'Paid', color: AppColors.success);

  factory StatusChip.pending() =>
      const StatusChip(label: 'Pending', color: AppColors.warning);

  factory StatusChip.overdue() =>
      const StatusChip(label: 'Overdue', color: AppColors.error);

  factory StatusChip.partiallyPaid() =>
      const StatusChip(label: 'Partially Paid', color: AppColors.info);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTokens.space3,
        vertical: AppTokens.space1,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTokens.radiusPill),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          height: 1.2,
        ),
      ),
    );
  }
}

class QuickActionButton extends StatelessWidget {
  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primaryBlue;

    return Semantics(
      button: true,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppTokens.space2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: AppTokens.minimumTapTarget,
                height: AppTokens.minimumTapTarget,
                decoration: BoxDecoration(
                  color: buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTokens.radiusMedium),
                ),
                child: Icon(icon, color: buttonColor, size: 24),
              ),
              const SizedBox(height: AppTokens.space2),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.textPrimary,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
