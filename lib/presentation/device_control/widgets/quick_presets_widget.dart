import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickPresetsWidget extends StatelessWidget {
  final String selectedPreset;
  final Function(String) onPresetSelected;

  const QuickPresetsWidget({
    Key? key,
    required this.selectedPreset,
    required this.onPresetSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presets = [
      {
        'name': 'Варка',
        'icon': 'water_drop',
        'temperature': 100,
        'time': 1800, // 30 minutes
        'description': 'Стандартная варка',
        'color': Colors.blue,
      },
      {
        'name': 'Жарка',
        'icon': 'local_fire_department',
        'temperature': 180,
        'time': 900, // 15 minutes
        'description': 'Быстрая жарка',
        'color': Colors.orange,
      },
      {
        'name': 'Тушение',
        'icon': 'soup_kitchen',
        'temperature': 120,
        'time': 2700, // 45 minutes
        'description': 'Медленное тушение',
        'color': Colors.brown,
      },
      {
        'name': 'Пар',
        'icon': 'cloud',
        'temperature': 100,
        'time': 1200, // 20 minutes
        'description': 'Приготовление на пару',
        'color': Colors.lightBlue,
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 4.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Быстрые настройки',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.w,
              mainAxisSpacing: 2.h,
              childAspectRatio: 1.2,
            ),
            itemCount: presets.length,
            itemBuilder: (context, index) {
              final preset = presets[index];
              final isSelected = selectedPreset == preset['name'];

              return GestureDetector(
                onTap: () => onPresetSelected(preset['name'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (preset['color'] as Color).withValues(alpha: 0.1)
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(3.w),
                    border: Border.all(
                      color: isSelected
                          ? preset['color'] as Color
                          : Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.2),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: (preset['color'] as Color)
                                  .withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (preset['color'] as Color)
                                .withValues(alpha: 0.2),
                          ),
                          child: CustomIconWidget(
                            iconName: preset['icon'] as String,
                            color: preset['color'] as Color,
                            size: 6.w,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          preset['name'] as String,
                          style: AppTheme.lightTheme.textTheme.titleSmall
                              ?.copyWith(
                            color: isSelected
                                ? preset['color'] as Color
                                : Theme.of(context).colorScheme.onSurface,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          preset['description'] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 8.sp,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '${preset['temperature']}°',
                                  style: AppTheme.getMonospaceStyle(
                                    isLight: Theme.of(context).brightness ==
                                        Brightness.light,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                    color: preset['color'] as Color,
                                  ),
                                ),
                                Text(
                                  'темп',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 7.sp,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${(preset['time'] as int) ~/ 60}м',
                                  style: AppTheme.getMonospaceStyle(
                                    isLight: Theme.of(context).brightness ==
                                        Brightness.light,
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.w600,
                                    color: preset['color'] as Color,
                                  ),
                                ),
                                Text(
                                  'время',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 7.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
