import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DeviceListWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onDeviceSelected;
  final bool isScanning;

  const DeviceListWidget({
    Key? key,
    required this.onDeviceSelected,
    this.isScanning = false,
  }) : super(key: key);

  @override
  State<DeviceListWidget> createState() => _DeviceListWidgetState();
}

class _DeviceListWidgetState extends State<DeviceListWidget> {
  List<Map<String, dynamic>> _discoveredDevices = [];

  @override
  void initState() {
    super.initState();
    _loadMockDevices();
  }

  void _loadMockDevices() {
    // Mock GFGRIL devices for demonstration
    _discoveredDevices = [
      {
        'id': 'gfgril_001',
        'name': 'GFGRIL Мультиварка Pro',
        'model': 'GF-MC-2024',
        'type': 'multicooker',
        'signalStrength': -45,
        'isConnectable': true,
        'batteryLevel': 85,
        'lastSeen': DateTime.now().subtract(Duration(seconds: 30)),
        'image':
            'https://images.unsplash.com/photo-1722650271178-9f340c11fc3b',
        'semanticLabel':
            'Modern electric multicooker with digital display and stainless steel finish on white background',
      },
      {
        'id': 'gfgril_002',
        'name': 'GFGRIL Кухонный комбайн',
        'model': 'GF-FP-2024',
        'type': 'food_processor',
        'signalStrength': -62,
        'isConnectable': true,
        'batteryLevel': 92,
        'lastSeen': DateTime.now().subtract(Duration(minutes: 2)),
        'image':
            'https://images.unsplash.com/photo-1651732898760-c9b17e3b019e',
        'semanticLabel':
            'Professional food processor with multiple attachments and clear mixing bowl on kitchen counter',
      },
      {
        'id': 'gfgril_003',
        'name': 'GFGRIL Блендер Smart',
        'model': 'GF-BL-2024',
        'type': 'blender',
        'signalStrength': -78,
        'isConnectable': false,
        'batteryLevel': 23,
        'lastSeen': DateTime.now().subtract(Duration(minutes: 15)),
        'image':
            'https://images.unsplash.com/photo-1649065709781-02a3b9dc3226',
        'semanticLabel':
            'High-speed blender with glass pitcher and touch control panel on marble kitchen surface',
      },
    ];
  }

  String _getSignalStrengthText(int signalStrength) {
    if (signalStrength > -50) return 'Отличный';
    if (signalStrength > -70) return 'Хороший';
    return 'Слабый';
  }

  Color _getSignalStrengthColor(int signalStrength) {
    if (signalStrength > -50) return AppTheme.successColor;
    if (signalStrength > -70) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  IconData _getDeviceIcon(String type) {
    switch (type) {
      case 'multicooker':
        return Icons.kitchen;
      case 'food_processor':
        return Icons.blender;
      case 'blender':
        return Icons.local_drink;
      default:
        return Icons.device_unknown;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: 50.h,
      ),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'bluetooth_searching',
                  color: AppTheme.secondaryLight,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Найденные устройства',
                        style:
                            AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          color: AppTheme.primaryLight,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (widget.isScanning)
                        Text(
                          'Поиск устройств...',
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.secondaryLight,
                          ),
                        ),
                    ],
                  ),
                ),
                if (widget.isScanning)
                  SizedBox(
                    width: 5.w,
                    height: 5.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppTheme.secondaryLight,
                    ),
                  ),
              ],
            ),
          ),

          // Device list
          Expanded(
            child: _discoveredDevices.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: _discoveredDevices.length,
                    separatorBuilder: (context, index) => SizedBox(height: 2.h),
                    itemBuilder: (context, index) {
                      final device = _discoveredDevices[index];
                      return _buildDeviceCard(device);
                    },
                  ),
          ),

          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'bluetooth_disabled',
              color: AppTheme.textSecondary,
              size: 15.w,
            ),
            SizedBox(height: 2.h),
            Text(
              'Устройства не найдены',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),
            Text(
              'Убедитесь, что устройство включено и находится рядом',
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(Map<String, dynamic> device) {
    final bool isConnectable = device['isConnectable'] as bool;
    final int signalStrength = device['signalStrength'] as int;
    final int batteryLevel = device['batteryLevel'] as int;

    return GestureDetector(
      onTap: isConnectable ? () => widget.onDeviceSelected(device) : null,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: isConnectable
              ? AppTheme.lightTheme.colorScheme.surface
              : AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isConnectable
                ? AppTheme.secondaryLight.withValues(alpha: 0.2)
                : AppTheme.textSecondary.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Device image
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppTheme.secondaryLight.withValues(alpha: 0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: CustomImageWidget(
                  imageUrl: device['image'] as String,
                  width: 15.w,
                  height: 15.w,
                  fit: BoxFit.cover,
                  semanticLabel: device['semanticLabel'] as String,
                ),
              ),
            ),

            SizedBox(width: 4.w),

            // Device info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    device['name'] as String,
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: isConnectable
                          ? AppTheme.primaryLight
                          : AppTheme.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    device['model'] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    children: [
                      // Signal strength
                      CustomIconWidget(
                        iconName: 'signal_cellular_alt',
                        color: _getSignalStrengthColor(signalStrength),
                        size: 4.w,
                      ),

                      SizedBox(width: 1.w),

                      Text(
                        _getSignalStrengthText(signalStrength),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: _getSignalStrengthColor(signalStrength),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(width: 3.w),

                      // Battery level
                      CustomIconWidget(
                        iconName: batteryLevel > 20
                            ? 'battery_full'
                            : 'battery_alert',
                        color: batteryLevel > 20
                            ? AppTheme.successColor
                            : AppTheme.warningColor,
                        size: 4.w,
                      ),

                      SizedBox(width: 1.w),

                      Text(
                        '$batteryLevel%',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: batteryLevel > 20
                              ? AppTheme.successColor
                              : AppTheme.warningColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Connection status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: isConnectable
                    ? AppTheme.successColor.withValues(alpha: 0.1)
                    : AppTheme.errorColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: isConnectable ? 'check_circle' : 'error',
                    color: isConnectable
                        ? AppTheme.successColor
                        : AppTheme.errorColor,
                    size: 4.w,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    isConnectable ? 'Готов' : 'Недоступен',
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: isConnectable
                          ? AppTheme.successColor
                          : AppTheme.errorColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
