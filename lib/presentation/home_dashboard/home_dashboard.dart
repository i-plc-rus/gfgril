import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/active_cooking_widget.dart';
import './widgets/appliance_card_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/quick_action_chip_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isRefreshing = false;
  int _notificationCount = 3;

  // Mock data for connected appliances
  final List<Map<String, dynamic>> _connectedAppliances = [
    {
      "id": 1,
      "name": "GFGRIL Мультиварка Pro",
      "icon": "kitchen",
      "isActive": true,
      "status": "Готовка риса",
      "temperature": 85,
      "remainingTime": 12,
      "progress": 0.75,
      "mode": "Рис",
    },
    {
      "id": 2,
      "name": "GFGRIL Кухонный комбайн",
      "icon": "blender",
      "isActive": false,
      "status": "Готов к работе",
      "temperature": 22,
      "remainingTime": 0,
      "progress": 0.0,
      "mode": "Ожидание",
    },
    {
      "id": 3,
      "name": "GFGRIL Пароварка Smart",
      "icon": "soup_kitchen",
      "isActive": true,
      "status": "Приготовление овощей",
      "temperature": 100,
      "remainingTime": 8,
      "progress": 0.60,
      "mode": "Пар",
    },
  ];

  // Mock data for active cooking
  Map<String, dynamic>? _activeCooking = {
    "recipeName": "Плов с курицей",
    "remainingTime": 15,
    "totalTime": 45,
    "currentStep":
        "Добавьте рис и перемешайте. Убедитесь, что все ингредиенты равномерно распределены.",
    "isPaused": false,
    "applianceId": 1,
  };

  // Mock data for quick actions
  final List<Map<String, dynamic>> _quickActions = [
    {
      "title": "Избранные рецепты",
      "icon": "favorite",
      "isActive": false,
    },
    {
      "title": "Недавние",
      "icon": "history",
      "isActive": true,
    },
    {
      "title": "Поддержка",
      "icon": "support_agent",
      "isActive": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
      // Update notification count
      _notificationCount = (_notificationCount + 1) % 10;
    });
  }

  void _handleApplianceSwipeRight(Map<String, dynamic> appliance) {
    // Quick start cooking
    setState(() {
      final applianceId = appliance['id'] as int;
      final index = _connectedAppliances
          .indexWhere((a) => (a['id'] as int) == applianceId);
      if (index != -1) {
        _connectedAppliances[index]['isActive'] = true;
        _connectedAppliances[index]['status'] = 'Быстрый старт';
        _connectedAppliances[index]['progress'] = 0.1;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Быстрый старт для ${appliance['name']}'),
        backgroundColor: AppTheme.successColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleApplianceSwipeLeft(Map<String, dynamic> appliance) {
    // Open device settings
    Navigator.pushNamed(context, '/device-control');
  }

  void _handleApplianceTap(Map<String, dynamic> appliance) {
    Navigator.pushNamed(context, '/device-control');
  }

  void _handleQuickActionTap(String title) {
    switch (title) {
      case 'Избранные рецепты':
        Navigator.pushNamed(context, '/recipe-list');
        break;
      case 'Недавние':
        Navigator.pushNamed(context, '/recipe-list');
        break;
      case 'Поддержка':
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }

  void _pauseActiveCooking() {
    setState(() {
      if (_activeCooking != null) {
        _activeCooking!['isPaused'] = !(_activeCooking!['isPaused'] as bool);
      }
    });
  }

  void _stopActiveCooking() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Остановить готовку?'),
          content: const Text(
              'Вы уверены, что хотите остановить текущий процесс готовки?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _activeCooking = null;
                  // Update appliance status
                  final activeAppliance = _connectedAppliances.firstWhere(
                    (a) => (a['id'] as int) == 1,
                    orElse: () => <String, dynamic>{},
                  );
                  if (activeAppliance.isNotEmpty) {
                    activeAppliance['isActive'] = false;
                    activeAppliance['status'] = 'Готов к работе';
                    activeAppliance['progress'] = 0.0;
                  }
                });
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
              ),
              child: const Text('Остановить'),
            ),
          ],
        );
      },
    );
  }

  void _pairNewDevice() {
    Navigator.pushNamed(context, '/device-pairing-onboarding');
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Доброе утро!';
    } else if (hour < 17) {
      return 'Добрый день!';
    } else {
      return 'Добрый вечер!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool hasConnectedDevices = _connectedAppliances.isNotEmpty;

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header with greeting and notifications
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.surfaceLight.withValues(alpha: 0.95),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getGreeting(),
                          style: AppTheme.lightTheme.textTheme.headlineSmall
                              ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryLight,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          hasConnectedDevices
                              ? 'У вас ${_connectedAppliances.length} подключенных устройств'
                              : 'Подключите ваши GFGRIL устройства',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _notificationCount = 0;
                          });
                        },
                        icon: CustomIconWidget(
                          iconName: 'notifications',
                          color: AppTheme.primaryLight,
                          size: 6.w,
                        ),
                      ),
                      if (_notificationCount > 0)
                        Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: EdgeInsets.all(0.5.w),
                            decoration: BoxDecoration(
                              color: AppTheme.errorColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 4.w,
                              minHeight: 4.w,
                            ),
                            child: Text(
                              _notificationCount > 9
                                  ? '9+'
                                  : _notificationCount.toString(),
                              style: AppTheme.lightTheme.textTheme.labelSmall
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 8.sp,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Main content
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshData,
                color: AppTheme.secondaryLight,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h),

                      // Quick actions
                      if (hasConnectedDevices) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            'Быстрые действия',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        SizedBox(
                          height: 6.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            itemCount: _quickActions.length,
                            itemBuilder: (context, index) {
                              final action = _quickActions[index];
                              return QuickActionChipWidget(
                                title: action['title'] as String,
                                iconName: action['icon'] as String,
                                isActive: action['isActive'] as bool,
                                onTap: () => _handleQuickActionTap(
                                    action['title'] as String),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],

                      // Active cooking section
                      if (_activeCooking != null) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(
                            'Активная готовка',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryLight,
                            ),
                          ),
                        ),
                        ActiveCookingWidget(
                          activeCooking: _activeCooking,
                          onPause: _pauseActiveCooking,
                          onStop: _stopActiveCooking,
                        ),
                        SizedBox(height: 2.h),
                      ],

                      // Connected devices section
                      if (hasConnectedDevices) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Подключенные устройства',
                                  style: AppTheme
                                      .lightTheme.textTheme.titleMedium
                                      ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.primaryLight,
                                  ),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: _pairNewDevice,
                                icon: CustomIconWidget(
                                  iconName: 'add',
                                  color: AppTheme.secondaryLight,
                                  size: 4.w,
                                ),
                                label: const Text('Добавить'),
                                style: TextButton.styleFrom(
                                  foregroundColor: AppTheme.secondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _connectedAppliances.length,
                          itemBuilder: (context, index) {
                            final appliance = _connectedAppliances[index];
                            return ApplianceCardWidget(
                              appliance: appliance,
                              onTap: () => _handleApplianceTap(appliance),
                              onSwipeRight: () =>
                                  _handleApplianceSwipeRight(appliance),
                              onSwipeLeft: () =>
                                  _handleApplianceSwipeLeft(appliance),
                            );
                          },
                        ),
                      ] else ...[
                        // Empty state
                        EmptyStateWidget(
                          onPairDevice: _pairNewDevice,
                        ),
                      ],

                      SizedBox(height: 10.h), // Bottom padding for FAB
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceLight.withValues(alpha: 0.95),
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: CustomIconWidget(
                iconName: 'home',
                color: AppTheme.secondaryLight,
                size: 6.w,
              ),
              text: 'Главная',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'menu_book',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              text: 'Рецепты',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'devices',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              text: 'Устройства',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.textSecondary,
                size: 6.w,
              ),
              text: 'Настройки',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                // Already on home
                break;
              case 1:
                Navigator.pushNamed(context, '/recipe-list');
                break;
              case 2:
                Navigator.pushNamed(context, '/device-control');
                break;
              case 3:
                Navigator.pushNamed(context, '/settings');
                break;
            }
          },
          labelColor: AppTheme.secondaryLight,
          unselectedLabelColor: AppTheme.textSecondary,
          indicatorColor: AppTheme.secondaryLight,
          labelStyle: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle:
              AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),

      // Floating action button for adding recipes
      floatingActionButton: hasConnectedDevices
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/recipe-list');
              },
              icon: CustomIconWidget(
                iconName: 'add',
                color: Colors.white,
                size: 5.w,
              ),
              label: const Text('Рецепт'),
              backgroundColor: AppTheme.secondaryLight,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}