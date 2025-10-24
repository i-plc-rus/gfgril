import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/advanced_settings_widget.dart';
import './widgets/cooking_mode_selector_widget.dart';
import './widgets/device_status_card_widget.dart';
import './widgets/quick_presets_widget.dart';
import './widgets/temperature_dial_widget.dart';
import './widgets/timer_controls_widget.dart';

class DeviceControl extends StatefulWidget {
  const DeviceControl({Key? key}) : super(key: key);

  @override
  State<DeviceControl> createState() => _DeviceControlState();
}

class _DeviceControlState extends State<DeviceControl>
    with TickerProviderStateMixin {
  late TabController _tabController;

  // Device data
  final Map<String, dynamic> _deviceData = {
    "id": "gfgril_001",
    "name": "GFGRIL Smart Мультиварка",
    "model": "GSM-2024 Pro",
    "type": "multi_cooker",
    "currentMode": "Варка",
    "currentTemperature": 85,
    "targetTemperature": 100.0,
    "workingTime": "15:32",
    "signalStrength": 87,
    "isConnected": true,
    "lastError": null,
  };

  // Control states
  double _targetTemperature = 100.0;
  String _selectedMode = "Варка";
  String _selectedPreset = "";
  int _totalSeconds = 1800; // 30 minutes
  int _remainingSeconds = 1800;
  bool _isTimerRunning = false;
  bool _isAdvancedExpanded = false;

  // Advanced settings
  final Map<String, dynamic> _advancedSettings = {
    "cookingIntensity": 5.0,
    "autoShutOff": true,
    "keepWarm": false,
    "notificationLevel": "Все",
    "childLock": false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _targetTemperature = (_deviceData['targetTemperature'] as double);
    _selectedMode = _deviceData['currentMode'] as String;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showEmergencyStopDialog() {
    HapticFeedback.heavyImpact();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.w),
          ),
          title: Row(
            children: [
              CustomIconWidget(
                iconName: 'warning',
                color: AppTheme.errorColor,
                size: 6.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Экстренная остановка',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.errorColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Text(
            'Вы уверены, что хотите экстренно остановить приготовление? Это действие нельзя отменить.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 12.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Отмена',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _emergencyStop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Остановить',
                style: TextStyle(fontSize: 12.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  void _emergencyStop() {
    HapticFeedback.heavyImpact();
    setState(() {
      _isTimerRunning = false;
      _remainingSeconds = 0;
      _selectedMode = "Остановлено";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Устройство экстренно остановлено',
          style: TextStyle(fontSize: 12.sp),
        ),
        backgroundColor: AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom app bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: AppTheme.getGlassMorphismDecoration(
                isLight: Theme.of(context).brightness == Brightness.light,
                borderRadius: 0,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'arrow_back',
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 5.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Управление устройством',
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          _deviceData['name'] as String,
                          style:
                              AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Emergency stop button
                  GestureDetector(
                    onTap: _showEmergencyStopDialog,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
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
                        iconName: 'power_settings_new',
                        color: Colors.white,
                        size: 6.w,
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/settings'),
                    child: Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: Theme.of(context)
                              .colorScheme
                              .outline
                              .withValues(alpha: 0.2),
                        ),
                      ),
                      child: CustomIconWidget(
                        iconName: 'more_vert',
                        color: Theme.of(context).colorScheme.onSurface,
                        size: 5.w,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tab bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              decoration: AppTheme.getGlassMorphismDecoration(
                isLight: Theme.of(context).brightness == Brightness.light,
                borderRadius: 3.w,
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppTheme.secondaryLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(3.w),
                ),
                labelColor: AppTheme.secondaryLight,
                unselectedLabelColor:
                    Theme.of(context).colorScheme.onSurfaceVariant,
                labelStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle:
                    AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
                tabs: const [
                  Tab(text: 'Управление'),
                  Tab(text: 'Статус'),
                  Tab(text: 'История'),
                ],
              ),
            ),

            // Tab content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Control tab
                  _buildControlTab(),
                  // Status tab
                  _buildStatusTab(),
                  // History tab
                  _buildHistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Temperature dial
          TemperatureDialWidget(
            currentTemperature: _deviceData['currentTemperature'] as double,
            targetTemperature: _targetTemperature,
            minTemperature: 40,
            maxTemperature: 200,
            onTemperatureChanged: (temperature) {
              setState(() {
                _targetTemperature = temperature;
              });
              HapticFeedback.lightImpact();
            },
          ),

          SizedBox(height: 3.h),

          // Cooking mode selector
          CookingModeSelectorWidget(
            selectedMode: _selectedMode,
            onModeChanged: (mode) {
              setState(() {
                _selectedMode = mode;
                // Auto-adjust temperature based on mode
                switch (mode) {
                  case 'Варка':
                    _targetTemperature = 100;
                    break;
                  case 'Жарка':
                    _targetTemperature = 180;
                    break;
                  case 'Тушение':
                    _targetTemperature = 120;
                    break;
                  case 'Пар':
                    _targetTemperature = 100;
                    break;
                  case 'Разогрев':
                    _targetTemperature = 60;
                    break;
                }
              });
              HapticFeedback.selectionClick();
            },
          ),

          SizedBox(height: 3.h),

          // Timer controls
          TimerControlsWidget(
            totalSeconds: _totalSeconds,
            remainingSeconds: _remainingSeconds,
            isRunning: _isTimerRunning,
            onStart: () {
              setState(() {
                _isTimerRunning = true;
              });
              HapticFeedback.mediumImpact();
            },
            onPause: () {
              setState(() {
                _isTimerRunning = false;
              });
              HapticFeedback.lightImpact();
            },
            onStop: () {
              setState(() {
                _isTimerRunning = false;
                _remainingSeconds = _totalSeconds;
              });
              HapticFeedback.heavyImpact();
            },
            onTimeChanged: (seconds) {
              setState(() {
                _totalSeconds = seconds;
                if (!_isTimerRunning) {
                  _remainingSeconds = seconds;
                }
              });
            },
          ),

          SizedBox(height: 3.h),

          // Quick presets
          QuickPresetsWidget(
            selectedPreset: _selectedPreset,
            onPresetSelected: (preset) {
              setState(() {
                _selectedPreset = preset;
                _selectedMode = preset;
                // Apply preset settings
                switch (preset) {
                  case 'Варка':
                    _targetTemperature = 100;
                    _totalSeconds = 1800;
                    break;
                  case 'Жарка':
                    _targetTemperature = 180;
                    _totalSeconds = 900;
                    break;
                  case 'Тушение':
                    _targetTemperature = 120;
                    _totalSeconds = 2700;
                    break;
                  case 'Пар':
                    _targetTemperature = 100;
                    _totalSeconds = 1200;
                    break;
                }
                if (!_isTimerRunning) {
                  _remainingSeconds = _totalSeconds;
                }
              });
              HapticFeedback.selectionClick();
            },
          ),

          SizedBox(height: 3.h),

          // Advanced settings
          AdvancedSettingsWidget(
            isExpanded: _isAdvancedExpanded,
            onToggleExpanded: () {
              setState(() {
                _isAdvancedExpanded = !_isAdvancedExpanded;
              });
              HapticFeedback.lightImpact();
            },
            settings: _advancedSettings,
            onSettingChanged: (key, value) {
              setState(() {
                _advancedSettings[key] = value;
              });
              HapticFeedback.selectionClick();
            },
          ),

          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildStatusTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Device status card
          DeviceStatusCardWidget(
            deviceData: _deviceData,
            isConnected: _deviceData['isConnected'] as bool,
          ),

          SizedBox(height: 3.h),

          // Real-time monitoring
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: AppTheme.getGlassMorphismDecoration(
              isLight: Theme.of(context).brightness == Brightness.light,
              borderRadius: 4.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Мониторинг в реальном времени',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 3.h),

                // Progress indicators
                Row(
                  children: [
                    Expanded(
                      child: _buildProgressIndicator(
                        'Температура',
                        _deviceData['currentTemperature'] as double,
                        _targetTemperature,
                        '°C',
                        AppTheme.warningColor,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: _buildProgressIndicator(
                        'Время',
                        (_totalSeconds - _remainingSeconds).toDouble(),
                        _totalSeconds.toDouble(),
                        'сек',
                        AppTheme.secondaryLight,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Energy consumption
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.successColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'bolt',
                        color: AppTheme.successColor,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Потребление энергии',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                                fontSize: 10.sp,
                              ),
                            ),
                            Text(
                              '1.2 кВт/ч',
                              style: AppTheme.getMonospaceStyle(
                                isLight: Theme.of(context).brightness ==
                                    Brightness.light,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.successColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    final cookingHistory = [
      {
        'date': '24.10.2024',
        'time': '14:30',
        'mode': 'Варка',
        'duration': '25 мин',
        'temperature': '100°C',
        'status': 'Завершено',
        'energy': '0.8 кВт/ч',
      },
      {
        'date': '24.10.2024',
        'time': '12:15',
        'mode': 'Жарка',
        'duration': '15 мин',
        'temperature': '180°C',
        'status': 'Завершено',
        'energy': '1.2 кВт/ч',
      },
      {
        'date': '23.10.2024',
        'time': '19:45',
        'mode': 'Тушение',
        'duration': '45 мин',
        'temperature': '120°C',
        'status': 'Завершено',
        'energy': '1.5 кВт/ч',
      },
      {
        'date': '23.10.2024',
        'time': '18:20',
        'mode': 'Пар',
        'duration': '20 мин',
        'temperature': '100°C',
        'status': 'Прервано',
        'energy': '0.6 кВт/ч',
      },
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'История приготовления',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cookingHistory.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final session = cookingHistory[index];
              final isCompleted = session['status'] == 'Завершено';

              return Container(
                padding: EdgeInsets.all(4.w),
                decoration: AppTheme.getGlassMorphismDecoration(
                  isLight: Theme.of(context).brightness == Brightness.light,
                  borderRadius: 3.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10.w,
                          height: 10.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? AppTheme.successColor.withValues(alpha: 0.1)
                                : AppTheme.warningColor.withValues(alpha: 0.1),
                          ),
                          child: CustomIconWidget(
                            iconName: isCompleted ? 'check_circle' : 'cancel',
                            color: isCompleted
                                ? AppTheme.successColor
                                : AppTheme.warningColor,
                            size: 5.w,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                session['mode'] as String,
                                style: AppTheme.lightTheme.textTheme.titleSmall
                                    ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${session['date']} в ${session['time']}',
                                style: AppTheme.lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 0.5.h),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppTheme.successColor.withValues(alpha: 0.1)
                                : AppTheme.warningColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Text(
                            session['status'] as String,
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: isCompleted
                                  ? AppTheme.successColor
                                  : AppTheme.warningColor,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildHistoryDetail(
                              'Длительность', session['duration'] as String),
                        ),
                        Expanded(
                          child: _buildHistoryDetail(
                              'Температура', session['temperature'] as String),
                        ),
                        Expanded(
                          child: _buildHistoryDetail(
                              'Энергия', session['energy'] as String),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(
    String label,
    double current,
    double target,
    String unit,
    Color color,
  ) {
    final progress = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 10.sp,
          ),
        ),
        SizedBox(height: 1.h),
        LinearProgressIndicator(
          value: progress,
          backgroundColor:
              Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        SizedBox(height: 1.h),
        Text(
          '${current.round()} / ${target.round()} $unit',
          style: AppTheme.getMonospaceStyle(
            isLight: Theme.of(context).brightness == Brightness.light,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 8.sp,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.getMonospaceStyle(
            isLight: Theme.of(context).brightness == Brightness.light,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
