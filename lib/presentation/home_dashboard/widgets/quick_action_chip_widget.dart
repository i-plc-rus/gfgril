import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionChipWidget extends StatelessWidget {
  final String title;
  final String iconName;
  final VoidCallback onTap;
  final bool isActive;

  const QuickActionChipWidget({
    Key? key,
    required this.title,
    required this.iconName,
    required this.onTap,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: 3.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.secondaryLight.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? AppTheme.secondaryLight.withValues(alpha: 0.3)
                : AppTheme.borderLight.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: iconName,
              color:
                  isActive ? AppTheme.secondaryLight : AppTheme.textSecondary,
              size: 4.w,
            ),
            SizedBox(width: 2.w),
            Text(
              title,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                color:
                    isActive ? AppTheme.secondaryLight : AppTheme.textPrimary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}