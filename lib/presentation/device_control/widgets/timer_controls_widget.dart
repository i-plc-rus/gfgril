import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TimerControlsWidget extends StatefulWidget {
  final int totalSeconds;
  final int remainingSeconds;
  final bool isRunning;
  final Function() onStart;
  final Function() onPause;
  final Function() onStop;
  final Function(int) onTimeChanged;

  const TimerControlsWidget({
    Key? key,
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isRunning,
    required this.onStart,
    required this.onPause,
    required this.onStop,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  State<TimerControlsWidget> createState() => _TimerControlsWidgetState();
}

class _TimerControlsWidgetState extends State<TimerControlsWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    if (widget.isRunning) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(TimerControlsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRunning && !oldWidget.isRunning) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isRunning && oldWidget.isRunning) {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = widget.totalSeconds > 0
        ? (widget.totalSeconds - widget.remainingSeconds) / widget.totalSeconds
        : 0.0;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: Theme.of(context).brightness == Brightness.light,
        borderRadius: 4.w,
      ),
      child: Column(
        children: [
          // Timer display
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.isRunning ? _pulseAnimation.value : 1.0,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.surface,
                    border: Border.all(
                      color: widget.isRunning
                          ? AppTheme.secondaryLight
                          : Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.3),
                      width: 3,
                    ),
                    boxShadow: widget.isRunning
                        ? [
                            BoxShadow(
                              color: AppTheme.secondaryLight
                                  .withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Stack(
                    children: [
                      // Progress indicator
                      Positioned.fill(
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 4,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.2),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            widget.isRunning
                                ? AppTheme.secondaryLight
                                : AppTheme.successColor,
                          ),
                        ),
                      ),
                      // Time display
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _formatTime(widget.remainingSeconds),
                              style: AppTheme.getMonospaceStyle(
                                isLight: Theme.of(context).brightness ==
                                    Brightness.light,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: widget.isRunning
                                    ? AppTheme.secondaryLight
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'осталось',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 8.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 3.h),

          // Time adjustment controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeButton(
                icon: 'remove',
                onTap: () {
                  final newTime = (widget.totalSeconds - 300).clamp(0, 7200);
                  widget.onTimeChanged(newTime);
                },
                label: '-5м',
              ),
              _buildTimeButton(
                icon: 'remove',
                onTap: () {
                  final newTime = (widget.totalSeconds - 60).clamp(0, 7200);
                  widget.onTimeChanged(newTime);
                },
                label: '-1м',
              ),
              _buildTimeButton(
                icon: 'add',
                onTap: () {
                  final newTime = (widget.totalSeconds + 60).clamp(0, 7200);
                  widget.onTimeChanged(newTime);
                },
                label: '+1м',
              ),
              _buildTimeButton(
                icon: 'add',
                onTap: () {
                  final newTime = (widget.totalSeconds + 300).clamp(0, 7200);
                  widget.onTimeChanged(newTime);
                },
                label: '+5м',
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Control buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Start/Pause button
              GestureDetector(
                onTap: widget.isRunning ? widget.onPause : widget.onStart,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.isRunning
                        ? AppTheme.warningColor
                        : AppTheme.successColor,
                    boxShadow: [
                      BoxShadow(
                        color: (widget.isRunning
                                ? AppTheme.warningColor
                                : AppTheme.successColor)
                            .withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomIconWidget(
                    iconName: widget.isRunning ? 'pause' : 'play_arrow',
                    color: Colors.white,
                    size: 8.w,
                  ),
                ),
              ),

              // Stop button
              GestureDetector(
                onTap: widget.onStop,
                child: Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.errorColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.errorColor.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: CustomIconWidget(
                    iconName: 'stop',
                    color: Colors.white,
                    size: 8.w,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeButton({
    required String icon,
    required VoidCallback onTap,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: Theme.of(context).colorScheme.primary,
              size: 4.w,
            ),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 6.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
