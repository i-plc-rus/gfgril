import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QRScannerWidget extends StatefulWidget {
  final Function(String) onQRDetected;
  final VoidCallback onClose;

  const QRScannerWidget({
    Key? key,
    required this.onQRDetected,
    required this.onClose,
  }) : super(key: key);

  @override
  State<QRScannerWidget> createState() => _QRScannerWidgetState();
}

class _QRScannerWidgetState extends State<QRScannerWidget> {
  MobileScannerController? _controller;
  bool _isScanning = true;
  bool _hasPermission = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeScanner();
  }

  Future<void> _initializeScanner() async {
    if (kIsWeb) {
      // Web implementation - simplified scanner
      setState(() {
        _hasPermission = true;
        _controller = MobileScannerController();
      });
      return;
    }

    // Mobile implementation with permission handling
    final permission = await Permission.camera.request();
    if (permission.isGranted) {
      setState(() {
        _hasPermission = true;
        _controller = MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          facing: CameraFacing.back,
          torchEnabled: false,
        );
      });
    } else {
      setState(() {
        _errorMessage = 'Необходимо разрешение на использование камеры';
      });
    }
  }

  void _onDetect(BarcodeCapture capture) {
    if (!_isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null && code.isNotEmpty) {
        setState(() {
          _isScanning = false;
        });

        // Haptic feedback
        HapticFeedback.mediumImpact();

        // Simulate GFGRIL device detection
        if (code.contains('GFGRIL') || code.length > 10) {
          widget.onQRDetected(code);
        } else {
          // Show error for invalid QR codes
          _showInvalidQRError();
          setState(() {
            _isScanning = true;
          });
        }
      }
    }
  }

  void _showInvalidQRError() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Неверный QR-код. Используйте QR-код устройства GFGRIL.'),
        backgroundColor: AppTheme.errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return _buildErrorView();
    }

    if (!_hasPermission || _controller == null) {
      return _buildLoadingView();
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Stack(
        children: [
          // Scanner view
          MobileScanner(
            controller: _controller!,
            onDetect: _onDetect,
          ),

          // Overlay with scanning frame
          _buildScannerOverlay(),

          // Top controls
          _buildTopControls(),

          // Bottom instructions
          _buildBottomInstructions(),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(6.w),
          padding: EdgeInsets.all(6.w),
          decoration: AppTheme.getGlassMorphismDecoration(
            isLight: false,
            borderRadius: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'error_outline',
                color: AppTheme.errorColor,
                size: 15.w,
              ),
              SizedBox(height: 2.h),
              Text(
                'Ошибка камеры',
                style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h),
              Text(
                _errorMessage!,
                style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 3.h),
              ElevatedButton(
                onPressed: widget.onClose,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryLight,
                  foregroundColor: Colors.white,
                ),
                child: Text('Закрыть'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: AppTheme.secondaryLight,
            ),
            SizedBox(height: 2.h),
            Text(
              'Инициализация камеры...',
              style: AppTheme.darkTheme.textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerOverlay() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: ScannerOverlayPainter(),
      ),
    );
  }

  Widget _buildTopControls() {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 2.h,
      left: 4.w,
      right: 4.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Close button
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              width: 12.w,
              height: 12.w,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CustomIconWidget(
                iconName: 'close',
                color: Colors.white,
                size: 6.w,
              ),
            ),
          ),

          // Flash toggle (mobile only)
          if (!kIsWeb)
            GestureDetector(
              onTap: () {
                _controller?.toggleTorch();
              },
              child: Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: CustomIconWidget(
                  iconName: 'flash_on',
                  color: Colors.white,
                  size: 6.w,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomInstructions() {
    return Positioned(
      bottom: MediaQuery.of(context).padding.bottom + 4.h,
      left: 4.w,
      right: 4.w,
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'qr_code_scanner',
              color: AppTheme.secondaryLight,
              size: 8.w,
            ),
            SizedBox(height: 1.h),
            Text(
              'Наведите камеру на QR-код',
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'QR-код находится на корпусе устройства GFGRIL',
              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;

    final scanAreaSize = size.width * 0.7;
    final scanAreaLeft = (size.width - scanAreaSize) / 2;
    final scanAreaTop = (size.height - scanAreaSize) / 2;

    // Draw overlay with transparent scanning area
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRect(Rect.fromLTWH(
        scanAreaLeft,
        scanAreaTop,
        scanAreaSize,
        scanAreaSize,
      ))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);

    // Draw scanning frame corners
    final cornerPaint = Paint()
      ..color = AppTheme.secondaryLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final cornerLength = 30.0;

    // Top-left corner
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop),
      Offset(scanAreaLeft + cornerLength, scanAreaTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop),
      Offset(scanAreaLeft, scanAreaTop + cornerLength),
      cornerPaint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize - cornerLength, scanAreaTop),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + cornerLength),
      cornerPaint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize - cornerLength),
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft, scanAreaTop + scanAreaSize),
      Offset(scanAreaLeft + cornerLength, scanAreaTop + scanAreaSize),
      cornerPaint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize - cornerLength,
          scanAreaTop + scanAreaSize),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
    canvas.drawLine(
      Offset(scanAreaLeft + scanAreaSize,
          scanAreaTop + scanAreaSize - cornerLength),
      Offset(scanAreaLeft + scanAreaSize, scanAreaTop + scanAreaSize),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
