import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_row_widget.dart';

class AccountSettingsWidget extends StatefulWidget {
  const AccountSettingsWidget({Key? key}) : super(key: key);

  @override
  State<AccountSettingsWidget> createState() => _AccountSettingsWidgetState();
}

class _AccountSettingsWidgetState extends State<AccountSettingsWidget> {
  bool _biometricAuth = false;
  bool _autoSync = true;
  bool _dataCollection = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsRowWidget(
          title: 'Профиль',
          subtitle: 'Редактировать личную информацию',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'person',
                color: AppTheme.primaryLight,
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
            _showProfileDialog();
          },
        ),
        SettingsRowWidget(
          title: 'Биометрическая аутентификация',
          subtitle: 'Использовать отпечаток пальца или Face ID',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'fingerprint',
                color: AppTheme.successColor,
                size: 20,
              ),
            ),
          ),
          trailing: Switch(
            value: _biometricAuth,
            onChanged: (value) {
              setState(() {
                _biometricAuth = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _biometricAuth = !_biometricAuth;
            });
          },
        ),
        SettingsRowWidget(
          title: 'Автосинхронизация',
          subtitle: 'Синхронизировать данные между устройствами',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'sync',
                color: AppTheme.secondaryLight,
                size: 20,
              ),
            ),
          ),
          trailing: Switch(
            value: _autoSync,
            onChanged: (value) {
              setState(() {
                _autoSync = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _autoSync = !_autoSync;
            });
          },
        ),
        SettingsRowWidget(
          title: 'Сбор данных',
          subtitle: 'Разрешить сбор анонимных данных для улучшения сервиса',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'analytics',
                color: AppTheme.warningColor,
                size: 20,
              ),
            ),
          ),
          trailing: Switch(
            value: _dataCollection,
            onChanged: (value) {
              setState(() {
                _dataCollection = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _dataCollection = !_dataCollection;
            });
          },
        ),
        SettingsRowWidget(
          title: 'Экспорт данных',
          subtitle: 'Скачать копию ваших данных',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.textSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'download',
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
            _exportUserData();
          },
          showDivider: false,
        ),
      ],
    );
  }

  void _showProfileDialog() {
    final TextEditingController nameController =
        TextEditingController(text: 'Анна Петрова');
    final TextEditingController emailController =
        TextEditingController(text: 'anna.petrova@example.com');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Редактировать профиль',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Имя',
                  prefixIcon: CustomIconWidget(
                    iconName: 'person',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: CustomIconWidget(
                    iconName: 'email',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Профиль обновлен'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _exportUserData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Экспорт данных',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Ваши данные будут экспортированы в формате JSON и сохранены в папку загрузок.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Данные экспортированы'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              child: Text('Экспортировать'),
            ),
          ],
        );
      },
    );
  }
}
