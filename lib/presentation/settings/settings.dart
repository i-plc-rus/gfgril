import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/account_settings_widget.dart';
import './widgets/advanced_settings_widget.dart';
import './widgets/app_preferences_widget.dart';
import './widgets/device_card_widget.dart';
import './widgets/notification_settings_widget.dart';
import './widgets/settings_section_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  
  // Section expansion states
  bool _devicesExpanded = true;
  bool _notificationsExpanded = true;
  bool _accountExpanded = true;
  bool _appExpanded = true;
  bool _advancedExpanded = false;

  // Mock connected devices data
  final List<Map<String, dynamic>> _connectedDevices = [
{ 'id': 1,
'name': 'Кухонный комбайн GFGRIL Pro',
'type': 'Кухонный комбайн',
'isConnected': true,
'lastSeen': '2025-10-24 05:45',
'batteryLevel': 85,
},
{ 'id': 2,
'name': 'Мультиварка GFGRIL Smart',
'type': 'Мультиварка',
'isConnected': false,
'lastSeen': '2025-10-23 18:30',
'batteryLevel': 42,
},
{ 'id': 3,
'name': 'Духовка GFGRIL Elite',
'type': 'Духовка',
'isConnected': true,
'lastSeen': '2025-10-24 06:00',
'batteryLevel': 100,
},
];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(
              child: _buildSettingsContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: true,
        borderRadius: 0,
        opacity: 0.95,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.primaryLight,
                  size: 24,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Text(
              'Настройки',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryLight,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              _showHelpDialog();
            },
            child: Container(
              width: 10.w,
              height: 10.w,
              decoration: BoxDecoration(
                color: AppTheme.secondaryLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: 'help_outline',
                  color: AppTheme.secondaryLight,
                  size: 24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(4.w),
      decoration: AppTheme.getGlassMorphismDecoration(
        isLight: true,
        borderRadius: 16,
        opacity: 0.9,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Поиск настроек...',
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'clear',
                      color: AppTheme.textSecondary,
                      size: 20,
                    ),
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        ),
      ),
    );
  }

  Widget _buildSettingsContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        children: [
          // Devices Section
          if (_shouldShowSection(['устройства', 'подключение', 'bluetooth'])) ...[
            SettingsSectionWidget(
              title: 'Устройства',
              isCollapsible: true,
              isExpanded: _devicesExpanded,
              onToggle: () {
                setState(() {
                  _devicesExpanded = !_devicesExpanded;
                });
              },
              children: [
                ..._connectedDevices.map((device) {
                  return DeviceCardWidget(
                    device: device,
                    onTap: () {
                      _showDeviceDetails(device);
                    },
                    onDelete: () {
                      _removeDevice(device);
                    },
                  );
                }).toList(),
                Container(
                  margin: EdgeInsets.all(2.w),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/device-pairing-onboarding');
                    },
                    icon: CustomIconWidget(
                      iconName: 'add',
                      color: Colors.white,
                      size: 20,
                    ),
                    label: Text('Добавить устройство'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 6.h),
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Notifications Section
          if (_shouldShowSection(['уведомления', 'звук', 'оповещения'])) ...[
            SettingsSectionWidget(
              title: 'Уведомления',
              isCollapsible: true,
              isExpanded: _notificationsExpanded,
              onToggle: () {
                setState(() {
                  _notificationsExpanded = !_notificationsExpanded;
                });
              },
              children: [
                NotificationSettingsWidget(),
              ],
            ),
          ],

          // Account Section
          if (_shouldShowSection(['аккаунт', 'профиль', 'синхронизация', 'безопасность'])) ...[
            SettingsSectionWidget(
              title: 'Аккаунт',
              isCollapsible: true,
              isExpanded: _accountExpanded,
              onToggle: () {
                setState(() {
                  _accountExpanded = !_accountExpanded;
                });
              },
              children: [
                AccountSettingsWidget(),
              ],
            ),
          ],

          // App Preferences Section
          if (_shouldShowSection(['приложение', 'язык', 'тема', 'единицы'])) ...[
            SettingsSectionWidget(
              title: 'Приложение',
              isCollapsible: true,
              isExpanded: _appExpanded,
              onToggle: () {
                setState(() {
                  _appExpanded = !_appExpanded;
                });
              },
              children: [
                AppPreferencesWidget(),
              ],
            ),
          ],

          // Advanced Section
          if (_shouldShowSection(['дополнительно', 'диагностика', 'версия', 'сброс', 'поддержка'])) ...[
            SettingsSectionWidget(
              title: 'Дополнительно',
              isCollapsible: true,
              isExpanded: _advancedExpanded,
              onToggle: () {
                setState(() {
                  _advancedExpanded = !_advancedExpanded;
                });
              },
              children: [
                AdvancedSettingsWidget(),
              ],
            ),
          ],

          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  bool _shouldShowSection(List<String> keywords) {
    if (_searchQuery.isEmpty) return true;
    
    for (String keyword in keywords) {
      if (keyword.contains(_searchQuery)) {
        return true;
      }
    }
    return false;
  }

  void _showDeviceDetails(Map<String, dynamic> device) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 70.h,
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: EdgeInsets.only(top: 2.h),
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
              // Header
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        device['name'] ?? 'Устройство',
                        style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: AppTheme.textSecondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: AppTheme.textSecondary,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Device Status Card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(4.w),
                        decoration: AppTheme.getGlassMorphismDecoration(
                          isLight: true,
                          borderRadius: 16,
                          opacity: 0.9,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 3.w,
                                  height: 3.w,
                                  decoration: BoxDecoration(
                                    color: (device['isConnected'] ?? false)
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Text(
                                  (device['isConnected'] ?? false) ? 'Подключено' : 'Отключено',
                                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                                    color: (device['isConnected'] ?? false)
                                        ? AppTheme.successColor
                                        : AppTheme.errorColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Тип: ${device['type'] ?? 'Неизвестно'}',
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Последняя активность: ${device['lastSeen'] ?? 'Никогда'}',
                              style: AppTheme.lightTheme.textTheme.bodyMedium,
                            ),
                            if (device['batteryLevel'] != null) ...[
                              SizedBox(height: 1.h),
                              Row(
                                children: [
                                  Text(
                                    'Заряд батареи: ',
                                    style: AppTheme.lightTheme.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    '${device['batteryLevel']}%',
                                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: _getBatteryColor(device['batteryLevel']),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 2.h),
                      
                      // Actions
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/device-control');
                        },
                        icon: CustomIconWidget(
                          iconName: 'settings_remote',
                          color: Colors.white,
                          size: 20,
                        ),
                        label: Text('Управление устройством'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 6.h),
                        ),
                      ),
                      
                      SizedBox(height: 1.h),
                      
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          _showRenameDialog(device);
                        },
                        icon: CustomIconWidget(
                          iconName: 'edit',
                          color: AppTheme.primaryLight,
                          size: 20,
                        ),
                        label: Text('Переименовать'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(double.infinity, 6.h),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getBatteryColor(int batteryLevel) {
    if (batteryLevel > 50) return AppTheme.successColor;
    if (batteryLevel > 20) return AppTheme.warningColor;
    return AppTheme.errorColor;
  }

  void _showRenameDialog(Map<String, dynamic> device) {
    final TextEditingController nameController = TextEditingController(text: device['name']);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Переименовать устройство',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Название устройства',
              prefixIcon: CustomIconWidget(
                iconName: 'device_hub',
                color: AppTheme.textSecondary,
                size: 20,
              ),
            ),
            maxLength: 50,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isNotEmpty) {
                  setState(() {
                    device['name'] = nameController.text.trim();
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Устройство переименовано'),
                      backgroundColor: AppTheme.successColor,
                    ),
                  );
                }
              },
              child: Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }

  void _removeDevice(Map<String, dynamic> device) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Удалить устройство',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.errorColor,
            ),
          ),
          content: Text(
            'Вы уверены, что хотите удалить "${device['name']}" из списка подключенных устройств?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _connectedDevices.removeWhere((d) => d['id'] == device['id']);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Устройство удалено'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
              ),
              child: Text('Удалить'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Справка по настройкам',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Основные разделы:',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 1.h),
                _buildHelpItem('Устройства', 'Управление подключенными приборами GFGRIL'),
                _buildHelpItem('Уведомления', 'Настройка оповещений о готовке'),
                _buildHelpItem('Аккаунт', 'Профиль и синхронизация данных'),
                _buildHelpItem('Приложение', 'Язык, тема и единицы измерения'),
                _buildHelpItem('Дополнительно', 'Диагностика и техническая информация'),
                SizedBox(height: 2.h),
                Text(
                  'Используйте поиск для быстрого нахождения нужной настройки.',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Понятно'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHelpItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.w,
            height: 1.w,
            margin: EdgeInsets.only(top: 1.h, right: 2.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryLight,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}