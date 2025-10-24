import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class TemperatureDialWidget extends StatefulWidget {
  final double currentTemperature;
  final double targetTemperature;
  final double minTemperature;
  final double maxTemperature;
  final Function(double) onTemperatureChanged;

  const TemperatureDialWidget({
    Key? key,
    required this.currentTemperature,
    required this.targetTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.onTemperatureChanged,
  }) : super(key: key);

  @override
  State<TemperatureDialWidget> createState() => _TemperatureDialWidgetState();
}

class _TemperatureDialWidgetState extends State<TemperatureDialWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  double _dragTemperature = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();
    _dragTemperature = widget.targetTemperature;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.w,
      height: 70.w,
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 35.w,
      ),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return GestureDetector(
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
            child: CustomPaint(
              size: Size(70.w, 70.w),
              painter: TemperatureDialPainter(
                currentTemperature: widget.currentTemperature,
                targetTemperature:
                    _isDragging ? _dragTemperature : widget.targetTemperature,
                minTemperature: widget.minTemperature,
                maxTemperature: widget.maxTemperature,
                animationValue: _animation.value,
                isDragging: _isDragging,
                theme: Theme.of(context),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${(_isDragging ? _dragTemperature : widget.targetTemperature).round()}°',
                      style:
                          AppTheme.lightTheme.textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      'Целевая температура',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 10.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: AppTheme.successColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(2.w),
                      ),
                      child: Text(
                        'Текущая: ${widget.currentTemperature.round()}°',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.successColor,
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final center = Offset(35.w, 35.w);
    final angle = math.atan2(
      details.localPosition.dy - center.dy,
      details.localPosition.dx - center.dx,
    );

    final normalizedAngle = (angle + math.pi * 2) % (math.pi * 2);
    final progress = (normalizedAngle - math.pi / 2) / (math.pi * 1.5);
    final clampedProgress = progress.clamp(0.0, 1.0);

    final newTemperature = widget.minTemperature +
        (widget.maxTemperature - widget.minTemperature) * clampedProgress;

    setState(() {
      _dragTemperature =
          newTemperature.clamp(widget.minTemperature, widget.maxTemperature);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
    widget.onTemperatureChanged(_dragTemperature);
  }
}

class TemperatureDialPainter extends CustomPainter {
  final double currentTemperature;
  final double targetTemperature;
  final double minTemperature;
  final double maxTemperature;
  final double animationValue;
  final bool isDragging;
  final ThemeData theme;

  TemperatureDialPainter({
    required this.currentTemperature,
    required this.targetTemperature,
    required this.minTemperature,
    required this.maxTemperature,
    required this.animationValue,
    required this.isDragging,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Background circle
    final backgroundPaint = Paint()
      ..color = theme.colorScheme.outline.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc for target temperature
    final targetProgress = (targetTemperature - minTemperature) /
        (maxTemperature - minTemperature);
    final targetSweepAngle = targetProgress * math.pi * 1.5 * animationValue;

    final targetPaint = Paint()
      ..color = isDragging ? AppTheme.warningColor : AppTheme.secondaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      targetSweepAngle,
      false,
      targetPaint,
    );

    // Progress arc for current temperature
    final currentProgress = (currentTemperature - minTemperature) /
        (maxTemperature - minTemperature);
    final currentSweepAngle = currentProgress * math.pi * 1.5 * animationValue;

    final currentPaint = Paint()
      ..color = AppTheme.successColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 10),
      -math.pi / 2,
      currentSweepAngle,
      false,
      currentPaint,
    );

    // Target temperature indicator
    final targetAngle = -math.pi / 2 + targetSweepAngle;
    final targetIndicatorX = center.dx + radius * math.cos(targetAngle);
    final targetIndicatorY = center.dy + radius * math.sin(targetAngle);

    final indicatorPaint = Paint()
      ..color = isDragging ? AppTheme.warningColor : AppTheme.secondaryLight
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(targetIndicatorX, targetIndicatorY),
      isDragging ? 8 : 6,
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
