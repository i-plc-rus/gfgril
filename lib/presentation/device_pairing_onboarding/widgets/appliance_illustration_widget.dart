import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ApplianceIllustrationWidget extends StatefulWidget {
  final bool isConnecting;

  const ApplianceIllustrationWidget({
    Key? key,
    this.isConnecting = false,
  }) : super(key: key);

  @override
  State<ApplianceIllustrationWidget> createState() =>
      _ApplianceIllustrationWidgetState();
}

class _ApplianceIllustrationWidgetState
    extends State<ApplianceIllustrationWidget> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    if (widget.isConnecting) {
      _pulseController.repeat(reverse: true);
      _rotationController.repeat();
    }
  }

  @override
  void didUpdateWidget(ApplianceIllustrationWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isConnecting != oldWidget.isConnecting) {
      if (widget.isConnecting) {
        _pulseController.repeat(reverse: true);
        _rotationController.repeat();
      } else {
        _pulseController.stop();
        _rotationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.w,
      height: 25.h,
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 24.0,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.secondaryLight.withValues(alpha: 0.1),
                  AppTheme.primaryLight.withValues(alpha: 0.05),
                ],
              ),
            ),
          ),

          // Main appliance illustration
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Appliance device illustration
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: widget.isConnecting ? _pulseAnimation.value : 1.0,
                    child: Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryLight.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: AppTheme.secondaryLight.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'kitchen',
                        color: AppTheme.secondaryLight,
                        size: 8.w,
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: 2.h),

              // Connection indicators
              if (widget.isConnecting) ...[
                AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value * 2 * 3.14159,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 1.w),
                            width: 2.w,
                            height: 2.w,
                            decoration: BoxDecoration(
                              color: AppTheme.secondaryLight.withValues(
                                alpha: 0.7 - (index * 0.2),
                              ),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'bluetooth',
                      color: AppTheme.primaryLight.withValues(alpha: 0.6),
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: 'wifi',
                      color: AppTheme.primaryLight.withValues(alpha: 0.6),
                      size: 5.w,
                    ),
                  ],
                ),
              ],

              SizedBox(height: 1.h),

              // Status text
              Text(
                widget.isConnecting ? 'Подключение...' : 'GFGRIL Устройство',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryLight,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
