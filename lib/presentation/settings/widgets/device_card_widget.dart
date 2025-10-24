import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeviceCardWidget extends StatelessWidget {
  final Map<String, dynamic> device;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const DeviceCardWidget({
    Key? key,
    required this.device,
    this.onTap,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isConnected = device['isConnected'] ?? false;
    final String deviceName = device['name'] ?? 'Неизвестное устройство';
    final String deviceType = device['type'] ?? 'Устройство';
    final String lastSeen = device['lastSeen'] ?? 'Никогда';

    return Dismissible(
      key: Key(device['id'].toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (onDelete != null) {
          onDelete!();
        }
      },
      background: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.errorColor,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'delete',
              color: Colors.white,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Удалить',
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 1.h),
        decoration: AppTheme.getGlassMorphismDecoration(
          isLight: true,
          borderRadius: 16,
          opacity: 0.9,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  // Device Icon
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: isConnected
                          ? AppTheme.successColor.withValues(alpha: 0.1)
                          : AppTheme.textSecondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: _getDeviceIcon(deviceType),
                        color: isConnected
                            ? AppTheme.successColor
                            : AppTheme.textSecondary,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),

                  // Device Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          deviceName,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          deviceType,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isConnected) ...[
                          SizedBox(height: 0.5.h),
                          Text(
                            'Последний раз: $lastSeen',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color:
                                  AppTheme.textSecondary.withValues(alpha: 0.7),
                              fontSize: 10.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),

                  // Connection Status
                  Column(
                    children: [
                      Container(
                        width: 2.w,
                        height: 2.w,
                        decoration: BoxDecoration(
                          color: isConnected
                              ? AppTheme.successColor
                              : AppTheme.textSecondary.withValues(alpha: 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        isConnected ? 'Подключено' : 'Отключено',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: isConnected
                              ? AppTheme.successColor
                              : AppTheme.textSecondary,
                          fontSize: 9.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 2.w),
                  CustomIconWidget(
                    iconName: 'chevron_right',
                    color: AppTheme.textSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getDeviceIcon(String deviceType) {
    switch (deviceType.toLowerCase()) {
      case 'кухонный робот':
      case 'food processor':
        return 'blender';
      case 'мультиварка':
      case 'multi-cooker':
        return 'rice_bowl';
      case 'аэрогриль':
      case 'oven':
        return 'oven';
      default:
        return 'kitchen';
    }
  }
}
