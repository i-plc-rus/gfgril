import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_row_widget.dart';

class AppPreferencesWidget extends StatefulWidget {
  const AppPreferencesWidget({Key? key}) : super(key: key);

  @override
  State<AppPreferencesWidget> createState() => _AppPreferencesWidgetState();
}

class _AppPreferencesWidgetState extends State<AppPreferencesWidget> {
  String _selectedLanguage = 'Русский';
  String _selectedTemperatureUnit = 'Цельсий';
  String _selectedMeasurementSystem = 'Метрическая';
  String _selectedTheme = 'Светлая';

  final List<String> _languages = ['Русский', 'English'];
  final List<String> _temperatureUnits = ['Цельсий', 'Фаренгейт'];
  final List<String> _measurementSystems = ['Метрическая', 'Имперская'];
  final List<String> _themes = ['Светлая', 'Темная', 'Системная'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsRowWidget(
          title: 'Язык',
          subtitle: _selectedLanguage,
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'language',
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
            _showSelectionDialog(
              'Выберите язык',
              _languages,
              _selectedLanguage,
              (value) {
                setState(() {
                  _selectedLanguage = value;
                });
              },
            );
          },
        ),
        SettingsRowWidget(
          title: 'Единицы температуры',
          subtitle: _selectedTemperatureUnit,
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'thermostat',
                color: AppTheme.warningColor,
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
            _showSelectionDialog(
              'Единицы температуры',
              _temperatureUnits,
              _selectedTemperatureUnit,
              (value) {
                setState(() {
                  _selectedTemperatureUnit = value;
                });
              },
            );
          },
        ),
        SettingsRowWidget(
          title: 'Система измерений',
          subtitle: _selectedMeasurementSystem,
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.secondaryLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'straighten',
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
            _showSelectionDialog(
              'Система измерений',
              _measurementSystems,
              _selectedMeasurementSystem,
              (value) {
                setState(() {
                  _selectedMeasurementSystem = value;
                });
              },
            );
          },
        ),
        SettingsRowWidget(
          title: 'Тема оформления',
          subtitle: _selectedTheme,
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'palette',
                color: AppTheme.successColor,
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
            _showSelectionDialog(
              'Тема оформления',
              _themes,
              _selectedTheme,
              (value) {
                setState(() {
                  _selectedTheme = value;
                });
              },
            );
          },
          showDivider: false,
        ),
      ],
    );
  }

  void _showSelectionDialog(
    String title,
    List<String> options,
    String currentValue,
    Function(String) onChanged,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              final bool isSelected = option == currentValue;
              return ListTile(
                title: Text(
                  option,
                  style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? AppTheme.primaryLight
                        : AppTheme.textPrimary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                leading: Radio<String>(
                  value: option,
                  groupValue: currentValue,
                  onChanged: (value) {
                    if (value != null) {
                      onChanged(value);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                onTap: () {
                  onChanged(option);
                  Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}
