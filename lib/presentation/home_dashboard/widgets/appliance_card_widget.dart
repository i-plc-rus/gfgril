import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ApplianceCardWidget extends StatelessWidget {
  final Map<String, dynamic> appliance;
  final VoidCallback onTap;
  final VoidCallback onSwipeRight;
  final VoidCallback onSwipeLeft;

  const ApplianceCardWidget({
    Key? key,
    required this.appliance,
    required this.onTap,
    required this.onSwipeRight,
    required this.onSwipeLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isActive = appliance['isActive'] as bool? ?? false;
    final String status = appliance['status'] as String? ?? 'Отключено';
    final int temperature = appliance['temperature'] as int? ?? 0;
    final int remainingTime = appliance['remainingTime'] as int? ?? 0;
    final double progress = appliance['progress'] as double? ?? 0.0;

    return GestureDetector(
      onTap: onTap,
      onPanEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx > 300) {
          onSwipeRight();
        } else if (details.velocity.pixelsPerSecond.dx < -300) {
          onSwipeLeft();
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color:
              AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.borderLight.withValues(alpha: 0.2),
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
                      color: isActive
                          ? AppTheme.successColor
                          : AppTheme.textSecondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: CustomIconWidget(
                      iconName: appliance['icon'] as String? ?? 'kitchen',
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
                          appliance['name'] as String? ??
                              'Неизвестное устройство',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          status,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: isActive
                                ? AppTheme.successColor
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isActive)
                    Container(
                      width: 15.w,
                      height: 15.w,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 3,
                            backgroundColor: AppTheme.borderLight,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                AppTheme.secondaryLight),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: AppTheme.lightTheme.textTheme.labelSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 8.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (isActive) ...[
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppTheme.warningColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'thermostat',
                              color: AppTheme.warningColor,
                              size: 4.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${temperature}°C',
                              style: AppTheme.lightTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: AppTheme.warningColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryLight.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'timer',
                              color: AppTheme.primaryLight,
                              size: 4.w,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${remainingTime}м',
                              style: AppTheme.lightTheme.textTheme.labelMedium
                                  ?.copyWith(
                                color: AppTheme.primaryLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}