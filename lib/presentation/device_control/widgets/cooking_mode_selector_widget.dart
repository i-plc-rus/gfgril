import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CookingModeSelectorWidget extends StatelessWidget {
  final String selectedMode;
  final Function(String) onModeChanged;

  const CookingModeSelectorWidget({
    Key? key,
    required this.selectedMode,
    required this.onModeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cookingModes = [
      {'name': 'Варка', 'icon': 'water_drop', 'temp': '100°C'},
      {'name': 'Жарка', 'icon': 'local_fire_department', 'temp': '180°C'},
      {'name': 'Тушение', 'icon': 'soup_kitchen', 'temp': '120°C'},
      {'name': 'Пар', 'icon': 'cloud', 'temp': '100°C'},
      {'name': 'Разогрев', 'icon': 'microwave', 'temp': '60°C'},
      {'name': 'Автоматический', 'icon': 'auto_mode', 'temp': 'Авто'},
    ];

    return Container(
      height: 12.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: cookingModes.length,
        separatorBuilder: (context, index) => SizedBox(width: 3.w),
        itemBuilder: (context, index) {
          final mode = cookingModes[index];
          final isSelected = selectedMode == mode['name'];

          return GestureDetector(
            onTap: () => onModeChanged(mode['name'] as String),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.secondaryLight.withValues(alpha: 0.1)
                    : AppTheme.getGlassMorphismDecoration(
                        isLight:
                            Theme.of(context).brightness == Brightness.light,
                        borderRadius: 4.w,
                      ).color,
                borderRadius: BorderRadius.circular(4.w),
                border: Border.all(
                  color: isSelected
                      ? AppTheme.secondaryLight
                      : Theme.of(context)
                          .colorScheme
                          .outline
                          .withValues(alpha: 0.2),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.secondaryLight.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: mode['icon'] as String,
                    color: isSelected
                        ? AppTheme.secondaryLight
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    mode['name'] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? AppTheme.secondaryLight
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 8.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    mode['temp'] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: isSelected
                          ? AppTheme.secondaryLight.withValues(alpha: 0.8)
                          : Theme.of(context)
                              .colorScheme
                              .onSurfaceVariant
                              .withValues(alpha: 0.7),
                      fontSize: 7.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
