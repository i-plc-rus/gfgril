import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TroubleshootingWidget extends StatefulWidget {
  const TroubleshootingWidget({Key? key}) : super(key: key);

  @override
  State<TroubleshootingWidget> createState() => _TroubleshootingWidgetState();
}

class _TroubleshootingWidgetState extends State<TroubleshootingWidget> {
  final List<Map<String, dynamic>> _troubleshootingItems = [
    {
      'title': 'Устройство не найдено',
      'icon': 'bluetooth_disabled',
      'solutions': [
        'Убедитесь, что устройство включено',
        'Проверьте, что Bluetooth активирован на телефоне',
        'Поднесите телефон ближе к устройству (до 2 метров)',
        'Перезапустите поиск устройств',
      ],
    },
    {
      'title': 'Ошибка подключения',
      'icon': 'error_outline',
      'solutions': [
        'Убедитесь, что устройство не подключено к другому телефону',
        'Очистите кэш Bluetooth в настройках телефона',
        'Перезагрузите устройство GFGRIL',
        'Попробуйте подключиться через QR-код',
      ],
    },
    {
      'title': 'Тайм-аут подключения',
      'icon': 'timer_off',
      'solutions': [
        'Проверьте стабильность интернет-соединения',
        'Убедитесь, что устройство находится в режиме сопряжения',
        'Попробуйте подключиться позже',
        'Обратитесь в службу поддержки, если проблема повторяется',
      ],
    },
  ];

  final Set<int> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CustomIconWidget(
                iconName: 'help_outline',
                color: AppTheme.warningColor,
                size: 6.w,
              ),
              SizedBox(width: 3.w),
              Text(
                'Устранение неполадок',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: AppTheme.primaryLight,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Troubleshooting items
          ...List.generate(_troubleshootingItems.length, (index) {
            final item = _troubleshootingItems[index];
            final isExpanded = _expandedItems.contains(index);

            return Container(
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: AppTheme.borderLight,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  // Header
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isExpanded) {
                          _expandedItems.remove(index);
                        } else {
                          _expandedItems.add(index);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      child: Row(
                        children: [
                          CustomIconWidget(
                            iconName: item['icon'] as String,
                            color: AppTheme.warningColor,
                            size: 5.w,
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Text(
                              item['title'] as String,
                              style: AppTheme.lightTheme.textTheme.titleMedium
                                  ?.copyWith(
                                color: AppTheme.primaryLight,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          AnimatedRotation(
                            turns: isExpanded ? 0.5 : 0.0,
                            duration: Duration(milliseconds: 200),
                            child: CustomIconWidget(
                              iconName: 'keyboard_arrow_down',
                              color: AppTheme.textSecondary,
                              size: 5.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Solutions
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    height: isExpanded ? null : 0,
                    child: isExpanded
                        ? Container(
                            padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 1,
                                  color: AppTheme.borderLight,
                                  margin: EdgeInsets.only(bottom: 3.w),
                                ),
                                ...(item['solutions'] as List<String>)
                                    .map((solution) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 2.w),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 1.5.w,
                                          height: 1.5.w,
                                          margin: EdgeInsets.only(top: 1.w),
                                          decoration: BoxDecoration(
                                            color: AppTheme.secondaryLight,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        SizedBox(width: 3.w),
                                        Expanded(
                                          child: Text(
                                            solution,
                                            style: AppTheme
                                                .lightTheme.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: AppTheme.textSecondary,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
            );
          }),

          // Contact support
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: AppTheme.secondaryLight.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                CustomIconWidget(
                  iconName: 'support_agent',
                  color: AppTheme.secondaryLight,
                  size: 8.w,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Нужна дополнительная помощь?',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.primaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Свяжитесь с нашей службой поддержки для получения персональной помощи',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to support screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Переход в службу поддержки...'),
                        backgroundColor: AppTheme.secondaryLight,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.secondaryLight,
                    foregroundColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.5.h),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'chat',
                        color: Colors.white,
                        size: 4.w,
                      ),
                      SizedBox(width: 2.w),
                      Text('Связаться с поддержкой'),
                    ],
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