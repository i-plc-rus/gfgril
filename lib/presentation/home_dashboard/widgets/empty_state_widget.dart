import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onPairDevice;

  const EmptyStateWidget({
    Key? key,
    required this.onPairDevice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.borderLight.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageWidget(
            imageUrl:
                "https://images.pexels.com/photos/4226769/pexels-photo-4226769.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            width: 40.w,
            height: 25.h,
            fit: BoxFit.cover,
            semanticLabel:
                "Modern smart kitchen with stainless steel appliances and digital displays on marble countertop",
          ),
          SizedBox(height: 3.h),
          Text(
            'Добро пожаловать в GFGRIL',
            style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryLight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Подключите ваше первое умное устройство для начала готовки',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 3.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onPairDevice,
              icon: CustomIconWidget(
                iconName: 'add_circle_outline',
                color: Colors.white,
                size: 5.w,
              ),
              label: const Text('Подключить устройство'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryLight,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, '/recipe-list');
            },
            icon: CustomIconWidget(
              iconName: 'menu_book',
              color: AppTheme.primaryLight,
              size: 4.w,
            ),
            label: const Text('Просмотреть рецепты'),
            style: TextButton.styleFrom(
              foregroundColor: AppTheme.primaryLight,
            ),
          ),
        ],
      ),
    );
  }
}