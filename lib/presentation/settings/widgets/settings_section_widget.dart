import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsSectionWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool isCollapsible;
  final bool isExpanded;
  final VoidCallback? onToggle;

  const SettingsSectionWidget({
    Key? key,
    required this.title,
    required this.children,
    this.isCollapsible = false,
    this.isExpanded = true,
    this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: true,
        borderRadius: 16,
        opacity: 0.9,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isCollapsible ? onToggle : null,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
                bottom: isExpanded ? Radius.zero : Radius.circular(16),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryLight,
                        ),
                      ),
                    ),
                    if (isCollapsible)
                      CustomIconWidget(
                        iconName: isExpanded ? 'expand_less' : 'expand_more',
                        color: AppTheme.textSecondary,
                        size: 24,
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Section Content
          if (isExpanded) ...[
            Container(
              width: double.infinity,
              height: 1,
              color: AppTheme.borderLight,
            ),
            ...children.map((child) => child).toList(),
          ],
        ],
      ),
    );
  }
}