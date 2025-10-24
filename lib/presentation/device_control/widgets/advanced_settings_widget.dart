import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AdvancedSettingsWidget extends StatefulWidget {
  final bool isExpanded;
  final Function() onToggleExpanded;
  final Map<String, dynamic> settings;
  final Function(String, dynamic) onSettingChanged;

  const AdvancedSettingsWidget({
    Key? key,
    required this.isExpanded,
    required this.onToggleExpanded,
    required this.settings,
    required this.onSettingChanged,
  }) : super(key: key);

  @override
  State<AdvancedSettingsWidget> createState() => _AdvancedSettingsWidgetState();
}

class _AdvancedSettingsWidgetState extends State<AdvancedSettingsWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(_expandAnimation);

    if (widget.isExpanded) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(AdvancedSettingsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 4.w,
      ),
      child: Column(
        children: [
          // Header
          GestureDetector(
            onTap: widget.onToggleExpanded,
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'settings',
                    color: Theme.of(context).colorScheme.primary,
                    size: 6.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      'Дополнительные настройки',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 3.14159,
                        child: CustomIconWidget(
                          iconName: 'expand_more',
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          size: 6.w,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Container(
              padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
              child: Column(
                children: [
                  Divider(
                    color: Theme.of(context)
                        .colorScheme
                        .outline
                        .withValues(alpha: 0.2),
                    height: 1,
                  ),
                  SizedBox(height: 3.h),

                  // Cooking intensity
                  _buildSliderSetting(
                    context,
                    'Интенсивность приготовления',
                    'cookingIntensity',
                    widget.settings['cookingIntensity'] as double,
                    0.0,
                    10.0,
                    'local_fire_department',
                    AppTheme.secondaryLight,
                  ),

                  SizedBox(height: 3.h),

                  // Auto shut-off
                  _buildSwitchSetting(
                    context,
                    'Автоматическое отключение',
                    'autoShutOff',
                    widget.settings['autoShutOff'] as bool,
                    'power_settings_new',
                    AppTheme.warningColor,
                  ),

                  SizedBox(height: 3.h),

                  // Keep warm
                  _buildSwitchSetting(
                    context,
                    'Поддержание тепла',
                    'keepWarm',
                    widget.settings['keepWarm'] as bool,
                    'thermostat',
                    AppTheme.successColor,
                  ),

                  SizedBox(height: 3.h),

                  // Notification preferences
                  _buildDropdownSetting(
                    context,
                    'Уведомления',
                    'notificationLevel',
                    widget.settings['notificationLevel'] as String,
                    ['Отключены', 'Только важные', 'Все'],
                    'notifications',
                    AppTheme.primaryLight,
                  ),

                  SizedBox(height: 3.h),

                  // Safety lock
                  _buildSwitchSetting(
                    context,
                    'Блокировка от детей',
                    'childLock',
                    widget.settings['childLock'] as bool,
                    'child_care',
                    AppTheme.errorColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSetting(
    BuildContext context,
    String title,
    String key,
    double value,
    double min,
    double max,
    String iconName,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: color,
              size: 5.w,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                title,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              value.toStringAsFixed(1),
              style: AppTheme.getMonospaceStyle(
                isLight: Theme.of(context).brightness == Brightness.light,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: color,
            thumbColor: color,
            overlayColor: color.withValues(alpha: 0.2),
            inactiveTrackColor:
                Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) * 2).round(),
            onChanged: (newValue) {
              widget.onSettingChanged(key, newValue);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchSetting(
    BuildContext context,
    String title,
    String key,
    bool value,
    String iconName,
    Color color,
  ) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: color,
          size: 5.w,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Switch(
          value: value,
          onChanged: (newValue) {
            widget.onSettingChanged(key, newValue);
          },
          activeColor: color,
        ),
      ],
    );
  }

  Widget _buildDropdownSetting(
    BuildContext context,
    String title,
    String key,
    String value,
    List<String> options,
    String iconName,
    Color color,
  ) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: color,
          size: 5.w,
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            title,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(2.w),
            border: Border.all(
              color: color.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: color,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  widget.onSettingChanged(key, newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
