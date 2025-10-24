import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_row_widget.dart';

class NotificationSettingsWidget extends StatefulWidget {
  const NotificationSettingsWidget({Key? key}) : super(key: key);

  @override
  State<NotificationSettingsWidget> createState() =>
      _NotificationSettingsWidgetState();
}

class _NotificationSettingsWidgetState
    extends State<NotificationSettingsWidget> {
  bool _cookingAlerts = true;
  bool _recipeUpdates = false;
  bool _supportMessages = true;
  String _quietHoursStart = '22:00';
  String _quietHoursEnd = '08:00';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsRowWidget(
          title: 'Уведомления о готовке',
          subtitle: 'Получать уведомления о завершении приготовления',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'notifications',
                color: AppTheme.successColor,
                size: 20,
              ),
            ),
          ),
          trailing: Switch(
            value: _cookingAlerts,
            onChanged: (value) {
              setState(() {
                _cookingAlerts = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _cookingAlerts = !_cookingAlerts;
            });
          },
        ),
        SettingsRowWidget(
          title: 'Обновления рецептов',
          subtitle: 'Новые рецепты и рекомендации',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'restaurant',
                color: AppTheme.secondaryLight,
                size: 20,
              ),
            ),
          ),
          trailing: Switch(
            value: _recipeUpdates,
            onChanged: (value) {
              setState(() {
                _recipeUpdates = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _recipeUpdates = !_recipeUpdates;
            });
          },
        ),
        SettingsRowWidget(
          title: 'Сообщения поддержки',
          subtitle: 'Ответы от службы поддержки',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'support_agent',
                color: AppTheme.primaryLight,
                size: 20,
              ),
            ),
          ),
          trailing: Switch(
            value: _supportMessages,
            onChanged: (value) {
              setState(() {
                _supportMessages = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _supportMessages = !_supportMessages;
            });
          },
        ),
        SettingsRowWidget(
          title: 'Тихие часы',
          subtitle: 'С $_quietHoursStart до $_quietHoursEnd',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.textSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'bedtime',
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
          ),
          trailing: CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.textSecondary,
            size: 20,
          ),
          onTap: () {
            _showQuietHoursDialog();
          },
          showDivider: false,
        ),
      ],
    );
  }

  void _showQuietHoursDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Тихие часы',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Выберите время, когда уведомления будут отключены',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Начало',
                          style: AppTheme.lightTheme.textTheme.labelMedium,
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.borderLight),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _quietHoursStart,
                            style: AppTheme.lightTheme.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Конец',
                          style: AppTheme.lightTheme.textTheme.labelMedium,
                        ),
                        SizedBox(height: 1.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 3.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppTheme.borderLight),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _quietHoursEnd,
                            style: AppTheme.lightTheme.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }
}