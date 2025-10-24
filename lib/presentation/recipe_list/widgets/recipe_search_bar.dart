import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/app_export.dart';

class RecipeSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final VoidCallback onFilterTap;

  const RecipeSearchBar({
    Key? key,
    required this.onSearchChanged,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  State<RecipeSearchBar> createState() => _RecipeSearchBarState();
}

class _RecipeSearchBarState extends State<RecipeSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  bool _speechEnabled = false;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _startListening() async {
    if (!_speechEnabled) return;

    final permission = await Permission.microphone.request();
    if (!permission.isGranted) return;

    await _speechToText.listen(
      onResult: (result) {
        setState(() {
          _searchController.text = result.recognizedWords;
          widget.onSearchChanged(result.recognizedWords);
        });
      },
      localeId: 'ru_RU',
    );
    setState(() {
      _isListening = true;
    });
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              style: AppTheme.lightTheme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Поиск рецептов...',
                hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary.withValues(alpha: 0.7),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.textSecondary,
                    size: 5.w,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 2.h,
                ),
              ),
            ),
          ),
          if (_speechEnabled)
            GestureDetector(
              onTap: _isListening ? _stopListening : _startListening,
              child: Container(
                padding: EdgeInsets.all(3.w),
                child: CustomIconWidget(
                  iconName: _isListening ? 'mic' : 'mic_none',
                  color: _isListening
                      ? AppTheme.secondaryLight
                      : AppTheme.textSecondary,
                  size: 5.w,
                ),
              ),
            ),
          GestureDetector(
            onTap: widget.onFilterTap,
            child: Container(
              padding: EdgeInsets.all(3.w),
              margin: EdgeInsets.only(right: 2.w),
              child: CustomIconWidget(
                iconName: 'tune',
                color: AppTheme.textSecondary,
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
