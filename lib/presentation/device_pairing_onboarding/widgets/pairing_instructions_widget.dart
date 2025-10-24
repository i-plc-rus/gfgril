import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class PairingInstructionsWidget extends StatelessWidget {
  const PairingInstructionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> instructions = [
      {
        'icon': 'power_settings_new',
        'title': 'Включите устройство',
        'description':
            'Убедитесь, что ваше устройство GFGRIL включено и готово к подключению',
      },
      {
        'icon': 'bluetooth',
        'title': 'Активируйте Bluetooth',
        'description':
            'Включите Bluetooth на вашем телефоне для поиска устройств',
      },
      {
        'icon': 'qr_code_scanner',
        'title': 'Сканируйте QR-код',
        'description': 'Найдите QR-код на корпусе устройства или в инструкции',
      },
      {
        'icon': 'check_circle',
        'title': 'Завершите настройку',
        'description':
            'Следуйте инструкциям на экране для завершения подключения',
      },
    ];

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
          Text(
            'Как подключить устройство',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.primaryLight,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 3.h),
          ...instructions.asMap().entries.map((entry) {
            final int index = entry.key;
            final Map<String, dynamic> instruction = entry.value;

            return Container(
              margin: EdgeInsets.only(bottom: 3.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step number and icon
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: AppTheme.secondaryLight.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: instruction['icon'] as String,
                          color: AppTheme.secondaryLight,
                          size: 6.w,
                        ),
                        Positioned(
                          top: 0.5.w,
                          right: 0.5.w,
                          child: Container(
                            width: 4.w,
                            height: 4.w,
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 4.w),

                  // Instruction content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          instruction['title'] as String,
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          instruction['description'] as String,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
