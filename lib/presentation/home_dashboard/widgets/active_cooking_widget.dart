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
        padding: EdgeInsets.all(3.w), // Уменьшили отступы
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Первая строка: иконка, название и таймер
            Row(
              children: [
                Container(
                  width: 10.w, // Уменьшили размер иконки
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomIconWidget(
                    iconName: 'restaurant',
                    color: Colors.white,
                    size: 5.w, // Уменьшили размер иконки
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipeName,
                        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1, // Ограничили в одну строку
                      ),
                      SizedBox(height: 0.3.h), // Уменьшили отступ
                      Text(
                        isPaused ? 'Приостановлено' : 'Готовится',
                        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: isPaused
                              ? AppTheme.warningColor
                              : AppTheme.successColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
                // Компактный таймер
                Container(
                  width: 14.w, // Уменьшили размер
                  height: 14.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 3, // Уменьшили толщину линии
                        backgroundColor: AppTheme.borderLight,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.secondaryLight),
                      ),
                      Text(
                        '$remainingTime',
                        style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primaryLight,
                          fontSize: 9.sp, // Уменьшили размер шрифта
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 1.5.h), // Уменьшили отступ
            
            // Текущий шаг
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.2.h),
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
            
            SizedBox(height: 1.5.h), // Уменьшили отступ
            
            // Кнопки управления
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onPause,
                    icon: CustomIconWidget(
                      iconName: isPaused ? 'play_arrow' : 'pause',
                      color: Colors.white,
                      size: 3.5.w, // Уменьшили размер иконки
                    ),
                    label: Text(
                      isPaused ? 'Продолжить' : 'Пауза',
                      style: TextStyle(fontSize: 9.sp), // Уменьшили шрифт
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPaused
                          ? AppTheme.successColor
                          : AppTheme.warningColor,
                      padding: EdgeInsets.symmetric(vertical: 1.2.h), // Уменьшили отступы
                    ),
                  ),
                ),
                SizedBox(width: 2.w), // Уменьшили отступ между кнопками
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onStop,
                    icon: CustomIconWidget(
                      iconName: 'stop',
                      color: AppTheme.errorColor,
                      size: 3.5.w, // Уменьшили размер иконки
                    ),
                    label: Text(
                      'Стоп',
                      style: TextStyle(fontSize: 9.sp), // Уменьшили шрифт
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.errorColor,
                      side: BorderSide(color: AppTheme.errorColor),
                      padding: EdgeInsets.symmetric(vertical: 1.2.h), // Уменьшили отступы
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