import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui';

import '../../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _backgroundAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _backgroundOpacityAnimation;
  late Animation<Offset> _logoSlideAnimation;

  bool _isInitializing = true;
  String _initializationStatus = 'Инициализация...';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startInitialization();
  }

  void _setupAnimations() {
    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Background animation controller
    _backgroundAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo scale animation
    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    // Logo opacity animation
    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    // Logo slide animation
    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeOutCubic,
    ));

    // Background opacity animation
    _backgroundOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _backgroundAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _logoAnimationController.forward();
    });
  }

  Future<void> _startInitialization() async {
    try {
      // Set system UI overlay style
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: AppTheme.primaryLight,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );

      // Simulate initialization steps
      await _performInitializationSteps();

      // Navigate based on user state
      await _navigateToNextScreen();
    } catch (e) {
      _handleInitializationError(e);
    }
  }

  Future<void> _performInitializationSteps() async {
    final List<Map<String, dynamic>> initSteps = [
      {
        'message': 'Проверка разрешений устройства...',
        'duration': 400,
      },
      {
        'message': 'Загрузка пользовательских настроек...',
        'duration': 500,
      },
      {
        'message': 'Поиск подключенных устройств...',
        'duration': 600,
      },
      {
        'message': 'Подготовка рецептов для офлайн доступа...',
        'duration': 700,
      },
      {
        'message': 'Инициализация Bluetooth сервисов...',
        'duration': 500,
      },
    ];

    for (final step in initSteps) {
      if (mounted) {
        setState(() {
          _initializationStatus = step['message'] as String;
        });
        await Future.delayed(Duration(milliseconds: step['duration'] as int));
      }
    }

    if (mounted) {
      setState(() {
        _isInitializing = false;
        _initializationStatus = 'Готово!';
      });
    }

    // Wait a bit more to show completion
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _navigateToNextScreen() async {
    if (!mounted) return;

    // Simulate checking user state
    final bool hasConnectedDevices = _checkConnectedDevices();
    final bool isFirstTimeUser = _checkFirstTimeUser();

    // Add haptic feedback
    HapticFeedback.lightImpact();

    // Navigate based on user state
    if (isFirstTimeUser) {
      Navigator.pushReplacementNamed(context, '/device-pairing-onboarding');
    } else if (hasConnectedDevices) {
      Navigator.pushReplacementNamed(context, '/home-dashboard');
    } else {
      Navigator.pushReplacementNamed(context, '/device-control');
    }
  }

  bool _checkConnectedDevices() {
    // Simulate checking for connected GFGRIL devices
    // In real implementation, this would check Bluetooth connections
    return DateTime.now().millisecond % 2 == 0;
  }

  bool _checkFirstTimeUser() {
    // Simulate checking if user is first time
    // In real implementation, this would check SharedPreferences
    return DateTime.now().millisecond % 3 == 0;
  }

  void _handleInitializationError(dynamic error) {
    if (mounted) {
      setState(() {
        _isInitializing = false;
        _initializationStatus = 'Ошибка инициализации';
      });

      // Show retry option after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          _showRetryDialog();
        }
      });
    }
  }

  void _showRetryDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: Text(
            'Ошибка подключения',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          content: Text(
            'Не удалось инициализировать приложение. Проверьте подключение к интернету и разрешения устройства.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, '/settings');
              },
              child: Text(
                'Настройки',
                style:
                    TextStyle(color: AppTheme.lightTheme.colorScheme.primary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _retryInitialization();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondaryLight,
                foregroundColor: Colors.white,
              ),
              child: const Text('Повторить'),
            ),
          ],
        );
      },
    );
  }

  void _retryInitialization() {
    setState(() {
      _isInitializing = true;
      _initializationStatus = 'Повторная инициализация...';
    });
    _startInitialization();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimationController,
        builder: (context, child) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryLight
                      .withValues(alpha: _backgroundOpacityAnimation.value),
                  AppTheme.primaryDark
                      .withValues(alpha: _backgroundOpacityAnimation.value),
                  AppTheme.secondaryLight.withValues(
                      alpha: _backgroundOpacityAnimation.value * 0.3),
                ],
                stops: const [0.0, 0.7, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Glass morphism overlay
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _backgroundAnimationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _backgroundOpacityAnimation.value * 0.1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Safe area content
                SafeArea(
                  child: Column(
                    children: [
                      // Main content area
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo section
                              AnimatedBuilder(
                                animation: _logoAnimationController,
                                builder: (context, child) {
                                  return SlideTransition(
                                    position: _logoSlideAnimation,
                                    child: FadeTransition(
                                      opacity: _logoOpacityAnimation,
                                      child: ScaleTransition(
                                        scale: _logoScaleAnimation,
                                        child: _buildLogo(),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              SizedBox(height: 8.h),

                              // Loading indicator and status
                              _buildLoadingSection(),
                            ],
                          ),
                        ),
                      ),

                      // Bottom branding
                      _buildBottomBranding(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 35.w,
      height: 35.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.2),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'kitchen',
                    color: Colors.white,
                    size: 12.w,
                  ),
                  SizedBox(height: 1.h),
                  Text(
                    'GFGRIL',
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingSection() {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _logoOpacityAnimation,
          child: Column(
            children: [
              // Loading indicator
              if (_isInitializing) ...[
                SizedBox(
                  width: 8.w,
                  height: 8.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ] else ...[
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.successColor,
                  ),
                  child: CustomIconWidget(
                    iconName: 'check',
                    color: Colors.white,
                    size: 5.w,
                  ),
                ),
                SizedBox(height: 3.h),
              ],

              // Status text
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Text(
                  _initializationStatus,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomBranding() {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _logoOpacityAnimation,
          child: Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Column(
              children: [
                Text(
                  'Умная кухня',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'v1.0.0',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}