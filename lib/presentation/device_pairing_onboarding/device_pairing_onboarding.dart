import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/appliance_illustration_widget.dart';
import './widgets/device_list_widget.dart';
import './widgets/pairing_instructions_widget.dart';
import './widgets/qr_scanner_widget.dart';
import './widgets/troubleshooting_widget.dart';

class DevicePairingOnboarding extends StatefulWidget {
  const DevicePairingOnboarding({Key? key}) : super(key: key);

  @override
  State<DevicePairingOnboarding> createState() =>
      _DevicePairingOnboardingState();
}

class _DevicePairingOnboardingState extends State<DevicePairingOnboarding>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  int _currentStep = 0;
  bool _isScanning = false;
  bool _isConnecting = false;
  bool _showQRScanner = false;
  bool _showDeviceList = false;
  bool _showTroubleshooting = false;
  Map<String, dynamic>? _selectedDevice;

  final List<String> _stepTitles = [
    'Добро пожаловать',
    'Подключение устройства',
    'Поиск устройств',
    'Успешное подключение',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _showQRScanner = false;
        _showDeviceList = false;
        _showTroubleshooting = false;
      });
      _pageController.animateToPage(
        _currentStep,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _startPairing() {
    setState(() {
      _isScanning = true;
      _showDeviceList = true;
    });
    _nextStep();

    // Simulate device discovery
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isScanning = false;
        });
      }
    });
  }

  void _openQRScanner() {
    setState(() {
      _showQRScanner = true;
    });
  }

  void _closeQRScanner() {
    setState(() {
      _showQRScanner = false;
    });
  }

  void _onQRDetected(String qrCode) {
    _closeQRScanner();

    // Simulate device connection from QR code
    final mockDevice = {
      'id': 'gfgril_qr_001',
      'name': 'GFGRIL Устройство',
      'model': 'Обнаружено по QR-коду',
      'type': 'multicooker',
      'qrCode': qrCode,
    };

    _connectToDevice(mockDevice);
  }

  void _onDeviceSelected(Map<String, dynamic> device) {
    _connectToDevice(device);
  }

  void _connectToDevice(Map<String, dynamic> device) {
    setState(() {
      _selectedDevice = device;
      _isConnecting = true;
      _showDeviceList = false;
      _showQRScanner = false;
    });

    // Simulate connection process
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isConnecting = false;
        });
        _nextStep(); // Go to success step

        // Haptic feedback for successful connection
        HapticFeedback.mediumImpact();
      }
    });
  }

  void _skipPairing() {
    Navigator.pushReplacementNamed(context, '/home-dashboard');
  }

  void _completePairing() {
    Navigator.pushReplacementNamed(context, '/home-dashboard');
  }

  void _toggleTroubleshooting() {
    setState(() {
      _showTroubleshooting = !_showTroubleshooting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.backgroundLight.withValues(alpha: 0.5),
                    AppTheme.lightTheme.scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),

            // Main content
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  // Header
                  _buildHeader(),

                  // Progress indicator
                  _buildProgressIndicator(),

                  // Content
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        _buildWelcomeStep(),
                        _buildPairingStep(),
                        _buildScanningStep(),
                        _buildSuccessStep(),
                      ],
                    ),
                  ),

                  // Bottom actions
                  _buildBottomActions(),
                ],
              ),
            ),

            // QR Scanner overlay
            if (_showQRScanner)
              QRScannerWidget(
                onQRDetected: _onQRDetected,
                onClose: _closeQRScanner,
              ),

            // Loading overlay
            if (_isConnecting) _buildLoadingOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Row(
        children: [
          if (_currentStep > 0)
            GestureDetector(
              onTap: _previousStep,
              child: Container(
                width: 10.w,
                height: 10.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.shadowLight,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.primaryLight,
                  size: 5.w,
                ),
              ),
            ),
          Expanded(
            child: Text(
              _stepTitles[_currentStep],
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.primaryLight,
                fontWeight: FontWeight.w700,
              ),
              textAlign: _currentStep > 0 ? TextAlign.center : TextAlign.left,
            ),
          ),
          if (_currentStep > 0) SizedBox(width: 10.w),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      margin: EdgeInsets.only(bottom: 3.h),
      child: Row(
        children: List.generate(_stepTitles.length, (index) {
          final isActive = index <= _currentStep;
          final isCurrent = index == _currentStep;

          return Expanded(
            child: Container(
              height: 0.5.h,
              margin: EdgeInsets.symmetric(horizontal: 1.w),
              decoration: BoxDecoration(
                color:
                    isActive ? AppTheme.secondaryLight : AppTheme.borderLight,
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: isCurrent
                  ? AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryLight,
                        borderRadius: BorderRadius.circular(2.0),
                        boxShadow: [
                          BoxShadow(
                            color:
                                AppTheme.secondaryLight.withValues(alpha: 0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    )
                  : null,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWelcomeStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          ApplianceIllustrationWidget(),
          SizedBox(height: 4.h),
          Text(
            'Подключите ваши устройства GFGRIL',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryLight,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2.h),
          Text(
            'Управляйте кухонными приборами прямо с телефона. Получайте уведомления о готовности блюд и следите за процессом приготовления.',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          PairingInstructionsWidget(),
        ],
      ),
    );
  }

  Widget _buildPairingStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          SizedBox(height: 2.h),

          ApplianceIllustrationWidget(isConnecting: _isScanning),

          SizedBox(height: 4.h),

          Text(
            'Выберите способ подключения',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryLight,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 4.h),

          // QR Code scanning option
          GestureDetector(
            onTap: _openQRScanner,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: AppTheme.getGlassMorphismDecoration(
                isLight: true,
                borderRadius: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CustomIconWidget(
                      iconName: 'qr_code_scanner',
                      color: AppTheme.secondaryLight,
                      size: 6.w,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Сканировать QR-код',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          'Быстрое подключение через камеру',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: AppTheme.textSecondary,
                    size: 4.w,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 3.h),

          // Manual pairing option
          GestureDetector(
            onTap: _startPairing,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: AppTheme.getGlassMorphismDecoration(
                isLight: true,
                borderRadius: 16.0,
              ),
              child: Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: CustomIconWidget(
                      iconName: 'bluetooth_searching',
                      color: AppTheme.primaryLight,
                      size: 6.w,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Поиск устройств',
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                            color: AppTheme.primaryLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          'Найти устройства поблизости',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: AppTheme.textSecondary,
                    size: 4.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanningStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          SizedBox(height: 2.h),
          if (_showDeviceList) ...[
            DeviceListWidget(
              onDeviceSelected: _onDeviceSelected,
              isScanning: _isScanning,
            ),

            SizedBox(height: 3.h),

            // Troubleshooting toggle
            GestureDetector(
              onTap: _toggleTroubleshooting,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.warningColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: AppTheme.warningColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'help_outline',
                      color: AppTheme.warningColor,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        'Проблемы с подключением?',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    CustomIconWidget(
                      iconName: _showTroubleshooting
                          ? 'keyboard_arrow_up'
                          : 'keyboard_arrow_down',
                      color: AppTheme.warningColor,
                      size: 5.w,
                    ),
                  ],
                ),
              ),
            ),

            if (_showTroubleshooting) ...[
              SizedBox(height: 2.h),
              TroubleshootingWidget(),
            ],
          ] else ...[
            ApplianceIllustrationWidget(isConnecting: true),
            SizedBox(height: 4.h),
            Text(
              'Поиск устройств...',
              style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
                color: AppTheme.primaryLight,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              'Убедитесь, что устройство включено и находится рядом',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSuccessStep() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          SizedBox(height: 4.h),

          // Success animation
          Container(
            width: 30.w,
            height: 30.w,
            decoration: BoxDecoration(
              color: AppTheme.successColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: CustomIconWidget(
              iconName: 'check_circle',
              color: AppTheme.successColor,
              size: 15.w,
            ),
          ),

          SizedBox(height: 4.h),

          Text(
            'Устройство подключено!',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              color: AppTheme.primaryLight,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 2.h),

          if (_selectedDevice != null) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(4.w),
              decoration: AppTheme.getGlassMorphismDecoration(
                isLight: true,
                borderRadius: 16.0,
              ),
              child: Column(
                children: [
                  Text(
                    _selectedDevice!['name'] as String,
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: AppTheme.primaryLight,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    _selectedDevice!['model'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomIconWidget(
                        iconName: 'bluetooth_connected',
                        color: AppTheme.successColor,
                        size: 5.w,
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        'Подключено',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.successColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
          ],

          Text(
            'Теперь вы можете управлять устройством через приложение, получать уведомления и следить за процессом приготовления.',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _currentStep == 0
                  ? _nextStep
                  : _currentStep == 1
                      ? null // Handled by individual options
                      : _currentStep == 2
                          ? null // Handled by device selection
                          : _completePairing,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryLight,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text(
                _currentStep == 0
                    ? 'Начать подключение'
                    : _currentStep == 3
                        ? 'Перейти к приложению'
                        : 'Продолжить',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Secondary action
          TextButton(
            onPressed: _skipPairing,
            child: Text(
              _currentStep == 3 ? 'Готово' : 'Пропустить пока',
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withValues(alpha: 0.5),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(6.w),
          decoration: AppTheme.getGlassMorphismDecoration(
            isLight: true,
            borderRadius: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppTheme.secondaryLight,
                strokeWidth: 3,
              ),
              SizedBox(height: 3.h),
              Text(
                'Подключение к устройству...',
                style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                  color: AppTheme.primaryLight,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                'Пожалуйста, подождите',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}