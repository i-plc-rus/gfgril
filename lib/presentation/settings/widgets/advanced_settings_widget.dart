import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_row_widget.dart';

class AdvancedSettingsWidget extends StatelessWidget {
  const AdvancedSettingsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsRowWidget(
          title: 'Диагностика',
          subtitle: 'Информация о состоянии приложения',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'bug_report',
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
            _showDiagnosticsDialog(context);
          },
        ),
        SettingsRowWidget(
          title: 'Версия приложения',
          subtitle: '1.2.3 (Build 456)',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'info',
                color: AppTheme.successColor,
                size: 20,
              ),
            ),
          ),
          onTap: () {
            _showVersionDialog(context);
          },
        ),
        SettingsRowWidget(
          title: 'Связаться с поддержкой',
          subtitle: 'Получить помощь от службы поддержки',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'support_agent',
                color: AppTheme.secondaryLight,
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
            Navigator.pushNamed(context, '/support');
          },
        ),
        SettingsRowWidget(
          title: 'Сброс настроек',
          subtitle: 'Восстановить заводские настройки',
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.errorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'restore',
                color: AppTheme.errorColor,
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
            _showFactoryResetDialog(context);
          },
          showDivider: false,
        ),
      ],
    );
  }

  void _showDiagnosticsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Диагностическая информация',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDiagnosticRow('Версия приложения:', '1.2.3'),
                _buildDiagnosticRow('Номер сборки:', '456'),
                _buildDiagnosticRow('Версия Flutter:', '3.16.0'),
                _buildDiagnosticRow('Платформа:', 'Android 13'),
                _buildDiagnosticRow('Устройство:', 'Samsung Galaxy S23'),
                _buildDiagnosticRow('Подключенных устройств:', '2'),
                _buildDiagnosticRow(
                    'Последняя синхронизация:', '24.10.2025 05:45'),
                _buildDiagnosticRow('Использование памяти:', '45.2 МБ'),
                _buildDiagnosticRow('Кэш рецептов:', '12.8 МБ'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Диагностические данные скопированы'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              child: Text('Копировать'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDiagnosticRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  void _showVersionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'О приложении',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'kitchen',
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'GFGRIL Smart Kitchen',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Версия 1.2.3 (Build 456)',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Умное управление кухонными приборами GFGRIL. Готовьте с удовольствием!',
                style: AppTheme.lightTheme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Закрыть'),
            ),
          ],
        );
      },
    );
  }

  void _showFactoryResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Сброс настроек',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.errorColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.errorColor,
                size: 48,
              ),
              SizedBox(height: 2.h),
              Text(
                'Это действие удалит все настройки приложения и отключит все устройства. Данное действие нельзя отменить.',
                style: AppTheme.lightTheme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                'Вы уверены, что хотите продолжить?',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
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
                    content: Text('Настройки сброшены'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
              ),
              child: Text('Сбросить'),
            ),
          ],
        );
      },
    );
  }
}
