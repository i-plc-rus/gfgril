import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ActiveCookingWidget extends StatelessWidget {
  final Map<String, dynamic>? activeCooking;
  final VoidCallback? onPause;
  final VoidCallback? onStop;

  const ActiveCookingWidget({
    Key? key,
    this.activeCooking,
    this.onPause,
    this.onStop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (activeCooking == null) return const SizedBox.shrink();

    final String recipeName =
        activeCooking!['recipeName'] as String? ?? 'Неизвестный рецепт';
    final int remainingTime = activeCooking!['remainingTime'] as int? ?? 0;
    final int totalTime = activeCooking!['totalTime'] as int? ?? 1;
    final String currentStep =
        activeCooking!['currentStep'] as String? ?? 'Готовка...';
    final bool isPaused = activeCooking!['isPaused'] as bool? ?? false;
    final double progress =
        remainingTime > 0 ? (totalTime - remainingTime) / totalTime : 1.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.secondaryLight.withValues(alpha: 0.1),
            AppTheme.primaryLight.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.secondaryLight.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'restaurant',
                    color: Colors.white,
                    size: 6.w,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipeName,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        isPaused ? 'Приостановлено' : 'Готовится',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: isPaused
                              ? AppTheme.warningColor
                              : AppTheme.successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 18.w,
                  height: 18.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 4,
                        backgroundColor: AppTheme.borderLight,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.secondaryLight),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${remainingTime}',
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                          Text(
                            'мин',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface
                    .withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                currentStep,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textPrimary,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onPause,
                    icon: CustomIconWidget(
                      iconName: isPaused ? 'play_arrow' : 'pause',
                      color: Colors.white,
                      size: 4.w,
                    ),
                    label: Text(isPaused ? 'Продолжить' : 'Пауза'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPaused
                          ? AppTheme.successColor
                          : AppTheme.warningColor,
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onStop,
                    icon: CustomIconWidget(
                      iconName: 'stop',
                      color: AppTheme.errorColor,
                      size: 4.w,
                    ),
                    label: const Text('Стоп'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.errorColor,
                      side: BorderSide(color: AppTheme.errorColor),
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}