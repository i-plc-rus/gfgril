import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeviceStatusCardWidget extends StatelessWidget {
  final Map<String, dynamic> deviceData;
  final bool isConnected;

  const DeviceStatusCardWidget({
    Key? key,
    required this.deviceData,
    required this.isConnected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 4.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Device header
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isConnected
                      ? AppTheme.successColor.withValues(alpha: 0.1)
                      : AppTheme.errorColor.withValues(alpha: 0.1),
                ),
                child: CustomIconWidget(
                  iconName: deviceData['type'] == 'food_processor'
                      ? 'blender'
                      : 'soup_kitchen',
                  color:
                      isConnected ? AppTheme.successColor : AppTheme.errorColor,
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deviceData['name'] as String,
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      deviceData['model'] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Connection status
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: isConnected
                      ? AppTheme.successColor.withValues(alpha: 0.1)
                      : AppTheme.errorColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 2.w,
                      height: 2.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isConnected
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      isConnected ? 'Подключено' : 'Отключено',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: isConnected
                            ? AppTheme.successColor
                            : AppTheme.errorColor,
                        fontSize: 8.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Status indicators
          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  context,
                  'Режим',
                  deviceData['currentMode'] as String,
                  'auto_mode',
                  AppTheme.secondaryLight,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatusItem(
                  context,
                  'Температура',
                  '${deviceData['currentTemperature']}°C',
                  'thermostat',
                  AppTheme.warningColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          Row(
            children: [
              Expanded(
                child: _buildStatusItem(
                  context,
                  'Время работы',
                  deviceData['workingTime'] as String,
                  'schedule',
                  AppTheme.primaryLight,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildStatusItem(
                  context,
                  'Сигнал',
                  '${deviceData['signalStrength']}%',
                  'signal_cellular_alt',
                  _getSignalColor(deviceData['signalStrength'] as int),
                ),
              ),
            ],
          ),

          if (deviceData['lastError'] != null) ...[
            SizedBox(height: 3.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: AppTheme.errorColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'warning',
                    color: AppTheme.errorColor,
                    size: 5.w,
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Text(
                      deviceData['lastError'] as String,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.errorColor,
                        fontSize: 9.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusItem(
    BuildContext context,
    String label,
    String value,
    String iconName,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: iconName,
                color: color,
                size: 4.w,
              ),
              SizedBox(width: 1.w),
              Text(
                label,
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 8.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSignalColor(int strength) {
    if (strength >= 80) return AppTheme.successColor;
    if (strength >= 50) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }
}
